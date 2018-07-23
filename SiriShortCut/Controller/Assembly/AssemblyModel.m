//
//  AssemblyModel.m
//  SiriShortCut
//
//  Created by yuqingyuan on 2018/7/23.
//  Copyright © 2018年 yuqingyuan. All rights reserved.
//

#import "AssemblyModel.h"

@implementation AssemblyModel

-(instancetype)initWithName:(NSString *)name websitePath:(NSURL *)url
{
    self = [super init];
    if(self)
    {
        self.iconName = name;
        self.websiteUrl = url;
        self.hasBeenEdited = NO;
    }
    return self;
}

@end
