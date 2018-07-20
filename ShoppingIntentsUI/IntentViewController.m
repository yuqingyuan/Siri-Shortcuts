//
//  IntentViewController.m
//  ShoppingIntentsUI
//
//  Created by yuqingyuan on 2018/7/18.
//  Copyright © 2018年 yuqingyuan. All rights reserved.
//

#import "IntentViewController.h"
#import <Intents/Intents.h>

// 用户点击Shortcut后展示UI
// Shortcut时间完成后也会再调用一次

@interface IntentViewController ()

@property (weak, nonatomic) IBOutlet UILabel *alertLabel;

@end

@implementation IntentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - INUIHostedViewControlling

// Prepare your view controller for the interaction to handle.
- (void)configureViewForParameters:(NSSet <INParameter *> *)parameters ofInteraction:(INInteraction *)interaction interactiveBehavior:(INUIInteractiveBehavior)interactiveBehavior context:(INUIHostedViewContext)context completion:(void (^)(BOOL success, NSSet <INParameter *> *configuredParameters, CGSize desiredSize))completion {
    // Do configuration here, including preparing views and calculating a desired size for presentation.
    
    if (completion) {
        completion(YES, parameters, [self desiredSize]);
    }
    
    if(interaction.intentHandlingStatus == INIntentHandlingStatusSuccess)
    {
        self.alertLabel.text = @"下单成功";
    }
}

-(void)configureWithInteraction:(INInteraction *)interaction context:(INUIHostedViewContext)context completion:(void (^)(CGSize))completion
{
    
}

- (CGSize)desiredSize {
    CGSize customSize = [self extensionContext].hostedViewMaximumAllowedSize;
    customSize.height = 200.0;
    return customSize;
}

@end
