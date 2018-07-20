//
//  ShoppingViewController.m
//  SiriShortCut
//
//  Created by yuqingyuan on 2018/7/17.
//  Copyright © 2018年 yuqingyuan. All rights reserved.
//

#import "ShoppingViewController.h"
#import "ShoppingDataSource.h"
#import "PayIntent.h"
//#import <CoreSpotlight/CoreSpotlight.h>
//#import <CoreServices/CoreServices.h>

@interface ShoppingViewController ()<PayIntentHandling,MainDataSourceDelegate,INUIAddVoiceShortcutViewControllerDelegate>

@property(nonatomic,strong) ShoppingDataSource *shoppingDataSource;

@property(nonatomic,strong) PayIntent *payIntent;
@property(nonatomic,strong) PayIntentResponse *payResponse;
@property(nonatomic,strong) INInteraction *interaction;

@property(nonatomic,strong) INUIAddVoiceShortcutViewController *customShortCutViewController;

@end

@implementation ShoppingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Shopping Cart";
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Add all to Siri" style:UIBarButtonItemStylePlain target:self action:@selector(donateIntentToSiri)];
}

#pragma mark - button

-(void)donateIntentToSiri
{
    for (ShoppingListModel *model in self.shoppingDataSource.rowArray)
    {
        if(model.productNum == 0)
        {
            [self shoppingCartContentAlert];
            return;
        }
    }
    NSUserActivity *userActivity = [[NSUserActivity alloc] initWithActivityType:@"Bobin.SiriShortCut"];
    userActivity.title = @"Buy daily stuff for one week";
    userActivity.suggestedInvocationPhrase = @"Buy All";
    INShortcut *shortCut = [[INShortcut alloc] initWithUserActivity:userActivity];
    self.customShortCutViewController = [[INUIAddVoiceShortcutViewController alloc] initWithShortcut:shortCut];
    self.customShortCutViewController.delegate = self;
    [self.navigationController pushViewController:self.customShortCutViewController animated:YES];
}

#pragma mark - private

-(void)shoppingCartContentAlert
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"警告" message:@"请至少购入1件商品" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [alertController dismissViewControllerAnimated:YES completion:nil];
    }];
    [alertController addAction:alertAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - delegate

//添加商品数量并尝试donate给Siri
-(void)tableView:(UITableView *)tableView didSelectAtIndexPath:(NSIndexPath *)indexPath withObject:(nonnull id)object
{
    __weak ShoppingListModel *model = (ShoppingListModel *)object;
    [model addProductToCart:^{
        self.payIntent = [[PayIntent alloc] init];
        self.payIntent.productName = model.productName;
        self.payIntent.quantity = [NSNumber numberWithInteger:model.productNum];
        
        self.interaction = [[INInteraction alloc] initWithIntent:self.payIntent response:nil];
        [self.interaction donateInteractionWithCompletion:^(NSError * _Nullable error) {
            if(error)
            {
                NSLog(@"%@",error);
            }
            else
            {
                NSLog(@"donate success");
            }
        }];
    }];
    [self reloadTableView];
}

-(void)tableView:(UITableView *)tableView style:(UITableViewCellEditingStyle)editingStyle object:(id)object
{
    ShoppingListModel *model = (ShoppingListModel *)object;
    if(model.productNum == 0)
    {
        [self shoppingCartContentAlert];
        return;
    }
    if(editingStyle == UITableViewCellEditingStyleDelete)
    {
        NSUserActivity *userActivity = [[NSUserActivity alloc] initWithActivityType:@"Bobin.SiriShortCut"];
        userActivity.title = [NSString stringWithFormat:@"Buy %ld %@",model.productNum,model.productName];
        userActivity.suggestedInvocationPhrase = @"自定义短语";
        userActivity.userInfo = @{model.productName:@(model.productNum)};
        INShortcut *shortCut = [[INShortcut alloc] initWithUserActivity:userActivity];
        self.customShortCutViewController = [[INUIAddVoiceShortcutViewController alloc] initWithShortcut:shortCut];
        self.customShortCutViewController.delegate = self;
        [self presentViewController:self.customShortCutViewController animated:YES completion:nil];
    }
}

-(id)fetchDataSource
{
    return self.shoppingDataSource;
}

-(void)addVoiceShortcutViewController:(INUIAddVoiceShortcutViewController *)controller didFinishWithVoiceShortcut:(INVoiceShortcut *)voiceShortcut error:(NSError *)error
{
    [controller dismissViewControllerAnimated:YES completion:nil];
}

-(void)addVoiceShortcutViewControllerDidCancel:(INUIAddVoiceShortcutViewController *)controller
{
    [controller dismissViewControllerAnimated:YES completion:nil];
}

-(void)handleShopping:(PayIntent *)intent completion:(void (^)(PayIntentResponse * _Nonnull))completion
{
    NSString *productName = intent.productName;
    self.payResponse = [PayIntentResponse successIntentResponseWithProductName:productName];
    completion(self.payResponse);
}

-(void)confirmShopping:(PayIntent *)intent completion:(void (^)(PayIntentResponse * _Nonnull))completion
{
    NSString *productName = intent.productName;
    self.payResponse = [PayIntentResponse successIntentResponseWithProductName:productName];
    completion(self.payResponse);
}

#pragma mark - lazy

-(ShoppingDataSource *)shoppingDataSource
{
    if(!_shoppingDataSource)
    {
        _shoppingDataSource = [[ShoppingDataSource alloc] init];
        _shoppingDataSource.mainDataSource = self;
    }
    return _shoppingDataSource;
}

@end
