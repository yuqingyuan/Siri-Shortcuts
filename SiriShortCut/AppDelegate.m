//
//  AppDelegate.m
//  SiriShortCut
//
//  Created by yuqingyuan on 2018/7/17.
//  Copyright © 2018年 yuqingyuan. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "ShoppingViewController.h"
#import "LabelViewController.h"
#import "UserActivityViewController.h"
#import "PayIntent.h"

@interface AppDelegate ()

@property(nonatomic,strong) MainViewController *mainViewController;
@property(nonatomic,strong) ShoppingViewController *shoppingViewController;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.mainViewController = [[MainViewController alloc] init];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:self.mainViewController];
    self.window.rootViewController = navigationController;
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - Siri

-(BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray<id<UIUserActivityRestoring>> * _Nullable))restorationHandler {
    if([userActivity.activityType isEqual: @"Bobin.SiriShortCut"])
    {
        NSLog(@"%@",userActivity.userInfo);
    }
    else if([userActivity.activityType isEqual:@"AssemblyView"])
    {
        LabelViewController *labelViewController = [[LabelViewController alloc] init];
        labelViewController.title = userActivity.userInfo[@"page"];
        [self.mainViewController.navigationController pushViewController:labelViewController animated:YES];
    }
    else
    {
        PayIntent *intent = (PayIntent *)userActivity.interaction.intent;
        if(intent)
        {
            self.mainViewController = [[MainViewController alloc] init];
            UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:self.mainViewController];
            self.window.rootViewController = navigationController;
            
            self.shoppingViewController = [[ShoppingViewController alloc] init];
            //跳转并根据Intent内容来更新购物车内容
            [self.mainViewController.navigationController pushViewController:self.shoppingViewController animated:YES];
        }
    }
    return YES;
}

@end
