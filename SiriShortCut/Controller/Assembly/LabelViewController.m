//
//  LabelViewController.m
//  SiriShortCut
//
//  Created by yuqingyuan on 2018/7/20.
//  Copyright © 2018年 yuqingyuan. All rights reserved.
//

#import "LabelViewController.h"
#import <Intents/Intents.h>
#import <IntentsUI/IntentsUI.h>

@interface LabelViewController ()<INUIAddVoiceShortcutViewControllerDelegate>

@property(nonatomic,strong) UIButton *addSiriBtn;
@property(nonatomic,strong) INUIAddVoiceShortcutViewController *shortcutViewController;
@property(nonatomic,strong) INUIEditVoiceShortcutViewController *editShortcutViewController;

@end

@implementation LabelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:self.addSiriBtn];
}

-(void)buildShortcutInCurrentViewController
{
    NSUserActivity *userActivity = [[NSUserActivity alloc] initWithActivityType:@"AssemblyView"];
    [userActivity setEligibleForSearch:YES];
    [userActivity setEligibleForPrediction:YES];
    userActivity.title = @"创建Shortcut来快速访问当前页";
    userActivity.suggestedInvocationPhrase = self.title;
    userActivity.userInfo = @{@"page":self.title};
    INShortcut *shortcut = [[INShortcut alloc] initWithUserActivity:userActivity];
    self.shortcutViewController = [[INUIAddVoiceShortcutViewController alloc] initWithShortcut:shortcut];
    self.shortcutViewController.delegate = self;
    [self presentViewController:self.shortcutViewController animated:YES completion:nil];
}

#pragma mark - delegate

- (void)addVoiceShortcutViewController:(nonnull INUIAddVoiceShortcutViewController *)controller didFinishWithVoiceShortcut:(nullable INVoiceShortcut *)voiceShortcut error:(nullable NSError *)error {
    [controller dismissViewControllerAnimated:YES completion:nil];
}

- (void)addVoiceShortcutViewControllerDidCancel:(nonnull INUIAddVoiceShortcutViewController *)controller {
    [controller dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - lazy

-(UIButton *)addSiriBtn
{
    if(!_addSiriBtn)
    {
        _addSiriBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 200, 50)];
        _addSiriBtn.center = self.view.center;
        [_addSiriBtn setTitle:@"Add to Siri" forState:UIControlStateNormal];
        [_addSiriBtn setTitleColor:UIColor.blueColor forState:UIControlStateNormal];
        [_addSiriBtn addTarget:self action:@selector(buildShortcutInCurrentViewController) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addSiriBtn;
}

@end
