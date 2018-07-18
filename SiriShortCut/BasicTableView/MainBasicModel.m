//
//  MainBasicModel.m
//  SiriShortCut
//
//  Created by yuqingyuan on 2018/7/17.
//  Copyright © 2018年 yuqingyuan. All rights reserved.
//

#import "MainBasicModel.h"

@implementation MainBasicModel

-(instancetype)init
{
    if(self)
    {
        self.title = @"未知";
    }
    return self;
}

-(instancetype)initWithTitle:(NSString *)title
{
    self = [super init];
    if(self)
    {
        self.title = title;
    }
    return self;
}

@end
