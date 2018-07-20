//
//  ShoppingListModel.m
//  SiriShortCut
//
//  Created by yuqingyuan on 2018/7/17.
//  Copyright © 2018年 yuqingyuan. All rights reserved.
//

#import "ShoppingListModel.h"

@implementation ShoppingListModel

-(instancetype)init
{
    self = [super init];
    if(self)
    {
        self.productNum = 0;
        self.productName = @"未知";
    }
    return self;
}

-(instancetype)initWithTitle:(NSString *)title quantity:(NSInteger)productQuantity
{
    self = [super init];
    if(self)
    {
        self.productName = title;
        self.productNum = productQuantity;
    }
    return self;
}

#pragma mark - public

-(void)addProductToCart:(Completion)completion
{
    self.productNum += 1;
    completion();
}

@end
