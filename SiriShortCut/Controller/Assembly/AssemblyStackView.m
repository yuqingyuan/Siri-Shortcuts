//
//  AssemblyStackView.m
//  SiriShortCut
//
//  Created by yuqingyuan on 2018/7/23.
//  Copyright © 2018年 yuqingyuan. All rights reserved.
//

#import "AssemblyStackView.h"

@implementation AssemblyStackView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self.alignment = UIStackViewAlignmentFill;
        self.distribution = UIStackViewDistributionFillEqually;
        self.axis = UILayoutConstraintAxisHorizontal;
        self.spacing = 1;
    }
    return self;
}

@end
