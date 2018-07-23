//
//  AssemblyButton.m
//  SiriShortCut
//
//  Created by yuqingyuan on 2018/7/23.
//  Copyright © 2018年 yuqingyuan. All rights reserved.
//

#import "AssemblyButton.h"

@interface AssemblyButton ()

@property(nonatomic,strong) UIImageView *shortcutIcon;

@end

@implementation AssemblyButton

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        [self addSubview:self.shortcutIcon];
        [self.shortcutIcon setHidden:YES];
    }
    return self;
}

#pragma mark - public

-(void)showIcon
{
    [self.shortcutIcon setHidden:NO];
}

-(void)hideIcon
{
    [self.shortcutIcon setHidden:YES];
}

#pragma mark - lazy

-(UIImageView *)shortcutIcon
{
    if(!_shortcutIcon)
    {
        _shortcutIcon = [[UIImageView alloc] initWithFrame:CGRectMake(-2, 51, 30, 30)];
        [_shortcutIcon setImage:[UIImage imageNamed:@"shortcut"]];
    }
    return _shortcutIcon;
}

@end
