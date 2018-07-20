//
//  ShoppingTableViewCell.m
//  SiriShortCut
//
//  Created by yuqingyuan on 2018/7/18.
//  Copyright © 2018年 yuqingyuan. All rights reserved.
//

#import "ShoppingTableViewCell.h"
#import "ShoppingListModel.h"

@implementation ShoppingTableViewCell

-(void)setObject:(id)object
{
    self.textLabel.text = ((ShoppingListModel *)object).productName;
    self.detailTextLabel.text = [NSString stringWithFormat:@"%ld",((ShoppingListModel *)object).productNum];
}

@end
