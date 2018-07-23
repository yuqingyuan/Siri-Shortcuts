//
//  AssemblyViewController.m
//  SiriShortCut
//
//  Created by yuqingyuan on 2018/7/20.
//  Copyright © 2018年 yuqingyuan. All rights reserved.
//

#import "AssemblyViewController.h"
#import "AssemblyStackView.h"
#import "WKWebViewController.h"
#import "AssemblyButton.h"
#import "AssemblyModel.h"

#import <Intents/Intents.h>
#import <IntentsUI/IntentsUI.h>

@interface AssemblyViewController ()<INUIAddVoiceShortcutViewControllerDelegate,INUIEditVoiceShortcutViewControllerDelegate,NSUserActivityDelegate>

@property(nonatomic,strong) AssemblyStackView *mainStackView;
@property(nonatomic,strong) WKWebViewController *webViewController;
@property(nonatomic,strong) INUIAddVoiceShortcutViewController *addShortcutViewController;
@property(nonatomic,strong) INUIEditVoiceShortcutViewController *editShortcutViewController;

@property(nonatomic,strong) NSArray *voiceArray;
@property(nonatomic,strong) NSUserActivity *activity;
@property(nonatomic,strong) NSDictionary *currentIndex;
@property(nonatomic,strong) NSArray<AssemblyModel *> *modelArray;
@property(nonatomic,strong) NSMutableArray<AssemblyButton *> *buttonArray;

@end

@implementation AssemblyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"网站集合页";
    self.view.backgroundColor = UIColor.whiteColor;
    
    self.modelArray = @[[[AssemblyModel alloc] initWithName:@"百度" websitePath:[NSURL URLWithString:@"https://www.baidu.com"]],
                        [[AssemblyModel alloc] initWithName:@"掘金" websitePath:[NSURL URLWithString:@"https://juejin.im"]],
                        [[AssemblyModel alloc] initWithName:@"新浪" websitePath:[NSURL URLWithString:@"https://www.sina.com.cn"]],
                        [[AssemblyModel alloc] initWithName:@"腾讯" websitePath:[NSURL URLWithString:@"http://www.qq.com"]]];
    self.buttonArray = [@[] mutableCopy];
    
    for (int i = 0; i < self.modelArray.count; i++)
    {
        AssemblyButton *button = [[AssemblyButton alloc] initWithFrame:CGRectZero];
        button.tag = i;
        [button setTitle:[NSString stringWithFormat:@"%@",self.modelArray[i].iconName] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(pushToCorrespondingController:) forControlEvents:UIControlEventTouchUpInside];
        button.backgroundColor = UIColor.grayColor;
        [self.buttonArray addObject:button];
        
        UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressFromButton:)];
        longPressGesture.name = [NSString stringWithFormat:@"%d",i];    //记录当前操作的button
        [button addGestureRecognizer:longPressGesture];
        
        [self.mainStackView addArrangedSubview:button];
        if([NSUserDefaults.standardUserDefaults valueForKey:self.modelArray[i].iconName])
        {
            [button showIcon];
        }
    }
    
    UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 30)];
    tipLabel.center = self.view.center;
    tipLabel.text = @"长按按钮可进行编辑";
    tipLabel.textAlignment = NSTextAlignmentCenter;
    tipLabel.alpha = 0.0;
    [self.view addSubview:tipLabel];
    
    [UIView animateWithDuration:1 animations:^{
        tipLabel.alpha = 1.0;
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:1 animations:^{
            tipLabel.alpha = 0.0;
        }];
    });
}

-(void)viewDidAppear:(BOOL)animated
{
    [INVoiceShortcutCenter.sharedCenter getAllVoiceShortcutsWithCompletion:^(NSArray<INVoiceShortcut *> * _Nullable voiceShortcuts, NSError * _Nullable error) {
        if(error)
        {
            NSLog(@"%@",error);
        }
        else
        {
            self.voiceArray = voiceShortcuts;
        }
    }];
}

#pragma mark - button

-(void)pushToCorrespondingController:(UIButton *)button
{
    self.webViewController = [[WKWebViewController alloc] init];
    self.webViewController.loadUrl = self.modelArray[button.tag].websiteUrl;
    [self.navigationController pushViewController:self.webViewController animated:YES];
}

-(void)longPressFromButton:(UILongPressGestureRecognizer *)gesture
{
    //防止多次点击
    if(gesture.state != UIGestureRecognizerStateBegan)
    {
        return;
    }
    
    self.currentIndex = @{@"index":gesture.name};
    UIAlertController *alertViewController = [UIAlertController alertControllerWithTitle:@"编辑" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *shortcutAction;
    id value = [NSUserDefaults.standardUserDefaults valueForKey:self.modelArray[[gesture.name integerValue]].iconName];
    if(value)
    {
        shortcutAction = [UIAlertAction actionWithTitle:@"编辑快捷方式" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            INVoiceShortcut *voiceShortcut;
            for (INVoiceShortcut *shortcut in self.voiceArray) {
                if([shortcut.identifier.UUIDString isEqualToString:value])
                {
                    voiceShortcut = shortcut;
                    break;
                }
            }
            self.editShortcutViewController = [[INUIEditVoiceShortcutViewController alloc] initWithVoiceShortcut:voiceShortcut];
            self.editShortcutViewController.delegate = self;
            [self presentViewController:self.editShortcutViewController animated:YES completion:nil];
        }];
    }
    else
    {
        shortcutAction = [UIAlertAction actionWithTitle:@"添加快捷方式" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            self.activity = [[NSUserActivity alloc] initWithActivityType:@"Bobin.SiriShortCut"];
            self.activity.title = [NSString stringWithFormat:@"为 %@ 添加语音快捷方式",self.modelArray[[gesture.name integerValue]].iconName];
            self.activity.suggestedInvocationPhrase = self.modelArray[[gesture.name integerValue]].iconName;
            [self.activity setEligibleForPrediction:YES];
            [self.activity setEligibleForSearch:YES];
            self.activity.needsSave = YES;
            self.activity.delegate = self;
            self.userActivity = self.activity;
            INShortcut *shortcut = [[INShortcut alloc] initWithUserActivity:self.activity];
            self.addShortcutViewController = [[INUIAddVoiceShortcutViewController alloc] initWithShortcut:shortcut];
            self.addShortcutViewController.delegate = self;
            [self presentViewController:self.addShortcutViewController animated:YES completion:nil];
        }];
    }
    [alertViewController addAction:cancelAction];
    [alertViewController addAction:shortcutAction];
    [self presentViewController:alertViewController animated:YES completion:nil];
}

#pragma mark - delegate

-(void)addVoiceShortcutViewControllerDidCancel:(INUIAddVoiceShortcutViewController *)controller
{
    [controller dismissViewControllerAnimated:YES completion:nil];
}

-(void)addVoiceShortcutViewController:(INUIAddVoiceShortcutViewController *)controller didFinishWithVoiceShortcut:(INVoiceShortcut *)voiceShortcut error:(NSError *)error
{
    AssemblyModel *model = self.modelArray[[self.currentIndex[@"index"] integerValue]];
    model.hasBeenEdited = YES;
    model.voiceShortcut = voiceShortcut;
    AssemblyButton *button = self.mainStackView.arrangedSubviews[[self.currentIndex[@"index"] integerValue]];
    [NSUserDefaults.standardUserDefaults setValue:voiceShortcut.identifier.UUIDString forKey:model.iconName];
    [NSUserDefaults.standardUserDefaults synchronize];
    [button showIcon];
    [controller dismissViewControllerAnimated:YES completion:nil];
}

-(void)userActivityWillSave:(NSUserActivity *)userActivity
{
    NSURL *url = self.modelArray[[self.currentIndex[@"index"] integerValue]].websiteUrl;
    userActivity.userInfo = @{@"url":url};
}

- (void)editVoiceShortcutViewController:(INUIEditVoiceShortcutViewController *)controller didUpdateVoiceShortcut:(nullable INVoiceShortcut *)voiceShortcut error:(nullable NSError *)error
{
    AssemblyModel *model = self.modelArray[[self.currentIndex[@"index"] integerValue]];
    model.voiceShortcut = voiceShortcut;
    [controller dismissViewControllerAnimated:YES completion:nil];
}

- (void)editVoiceShortcutViewController:(INUIEditVoiceShortcutViewController *)controller didDeleteVoiceShortcutWithIdentifier:(NSUUID *)deletedVoiceShortcutIdentifier
{
    AssemblyModel *model = self.modelArray[[self.currentIndex[@"index"] integerValue]];
    model.hasBeenEdited = NO;
    AssemblyButton *button = self.mainStackView.arrangedSubviews[[self.currentIndex[@"index"] integerValue]];
    [controller dismissViewControllerAnimated:YES completion:nil];
    [button hideIcon];
    [NSUserDefaults.standardUserDefaults removeObjectForKey:model.iconName];
    [NSUserDefaults.standardUserDefaults synchronize];
}

- (void)editVoiceShortcutViewControllerDidCancel:(INUIEditVoiceShortcutViewController *)controller
{
    [controller dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - lazy

-(AssemblyStackView *)mainStackView
{
    if(!_mainStackView)
    {
        CGRect frame = CGRectMake(0, self.navigationController.navigationBar.frame.size.height+UIApplication.sharedApplication.statusBarFrame.size.height, self.view.bounds.size.width, 80);
        _mainStackView = [[AssemblyStackView alloc] initWithFrame:frame];
        [self.view addSubview:_mainStackView];
    }
    return _mainStackView;
}

@end
