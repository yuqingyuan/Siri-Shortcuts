//
//  UserActivityViewController.m
//  SiriShortCut
//
//  Created by yuqingyuan on 2018/7/20.
//  Copyright © 2018年 yuqingyuan. All rights reserved.
//

#import "UserActivityViewController.h"

@interface UserActivityViewController()<NSUserActivityDelegate>

@end

@implementation UserActivityViewController

#pragma mark - delegate

-(void)tableView:(UITableView *)tableView didSelectAtIndexPath:(NSIndexPath *)indexPath withObject:(id)object
{
    __weak ShoppingListModel *model = (ShoppingListModel *)object;
    [model addProductToCart:^{
        NSUserActivity *userActivity = [[NSUserActivity alloc] initWithActivityType:@"Bobin.SiriShortCut"];
        [userActivity setEligibleForSearch:YES];
        [userActivity setEligibleForPrediction:YES];
        userActivity.title = [NSString stringWithFormat:@"购买%ld个%@",model.productNum,model.productName];
        userActivity.suggestedInvocationPhrase = @"下单";
        userActivity.delegate = self;
        self.userActivity = userActivity;
    }];
    [self reloadTableView];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    NSLog(@"%@",change);
}

//不明原因，给self.userActivity赋值后userActivity被清空，只能在willSave中初始化
-(void)userActivityWillSave:(NSUserActivity *)userActivity
{
    userActivity.userInfo = @{@"key":@"value"};
}

-(void)userActivityWasContinued:(NSUserActivity *)userActivity
{
    
}

-(void)userActivity:(NSUserActivity *)userActivity didReceiveInputStream:(NSInputStream *)inputStream outputStream:(NSOutputStream *)outputStream
{
    
}

@end
