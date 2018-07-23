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
                           [[ShoppingListModel alloc] initWithTitle:@"product one" quantity:0],
                           [[ShoppingListModel alloc] initWithTitle:@"product two" quantity:0],
                           [[ShoppingListModel alloc] initWithTitle:@"product three" quantity:0],
                           [[ShoppingListModel alloc] initWithTitle:@"product four" quantity:0],
                           [[ShoppingListModel alloc] initWithTitle:@"product five" quantity:0],
                           [[ShoppingListModel alloc] initWithTitle:@"product six" quantity:0]
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

