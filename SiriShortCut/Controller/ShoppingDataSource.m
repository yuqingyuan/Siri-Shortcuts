//
//  ShoppingDataSource.m
//  SiriShortCut
//
//  Created by yuqingyuan on 2018/7/17.
//  Copyright © 2018年 yuqingyuan. All rights reserved.
//

#import "ShoppingDataSource.h"
#import "ShoppingTableViewCell.h"

@implementation ShoppingDataSource

-(instancetype)init
{
    self = [super init];
    if(self)
    {
        self.rowArray = [@[
                           [[ShoppingListModel alloc] initWithTitle:@"商品1" quantity:0],
                           [[ShoppingListModel alloc] initWithTitle:@"商品2" quantity:0],
                           [[ShoppingListModel alloc] initWithTitle:@"商品3" quantity:0],
                           [[ShoppingListModel alloc] initWithTitle:@"商品4" quantity:0],
                           [[ShoppingListModel alloc] initWithTitle:@"商品5" quantity:0],
                           [[ShoppingListModel alloc] initWithTitle:@"商品6" quantity:0]
                           ] mutableCopy];
    }
    return self;
}

-(Class)fetchCellClass
{
    return [ShoppingTableViewCell class];
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

@end

