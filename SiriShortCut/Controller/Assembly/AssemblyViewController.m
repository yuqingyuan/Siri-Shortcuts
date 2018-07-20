//
//  AssemblyViewController.m
//  SiriShortCut
//
//  Created by yuqingyuan on 2018/7/20.
//  Copyright © 2018年 yuqingyuan. All rights reserved.
//

#import "AssemblyViewController.h"
#import "LabelViewController.h"

@interface AssemblyViewController ()

@property(nonatomic,strong) UIStackView *mainStackView;

@end

@implementation AssemblyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.whiteColor;
    self.title = @"集合页";
    
    for (int i = 0; i < 6; i++) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectZero];
        [button setTitle:[NSString stringWithFormat:@"页面%d",i] forState:UIControlStateNormal];
        button.tag = i;
        [button addTarget:self action:@selector(pushToCorrespondingController:) forControlEvents:UIControlEventTouchUpInside];
        button.backgroundColor = UIColor.grayColor;
        [self.mainStackView addArrangedSubview:button];
    }
}

#pragma mark - button

-(void)pushToCorrespondingController:(UIButton *)button
{
    LabelViewController *correspondingVC = [[LabelViewController alloc] init];
    correspondingVC.view.backgroundColor = UIColor.whiteColor;
    correspondingVC.title = [NSString stringWithFormat:@"页面%ld",button.tag];
    [self.navigationController pushViewController:correspondingVC animated:YES];
}

#pragma mark - lazy

-(UIStackView *)mainStackView
{
    if(!_mainStackView)
    {
        CGRect frame = CGRectMake(0, self.navigationController.navigationBar.frame.size.height+44, self.view.bounds.size.width, 60);
        _mainStackView = [[UIStackView alloc] initWithFrame:frame];
        _mainStackView.alignment = UIStackViewAlignmentFill;
        _mainStackView.distribution = UIStackViewDistributionFillEqually;
        _mainStackView.axis = UILayoutConstraintAxisHorizontal;
        _mainStackView.spacing = 10;
        [self.view addSubview:_mainStackView];
    }
    return _mainStackView;
}

@end
