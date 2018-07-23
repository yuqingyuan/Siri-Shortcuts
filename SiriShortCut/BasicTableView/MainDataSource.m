//
//  MainDataSource.m
//  SiriShortCut
//
//  Created by yuqingyuan on 2018/7/17.
//  Copyright © 2018年 yuqingyuan. All rights reserved.
//

#import "MainDataSource.h"
#import "MainTableViewCell.h"
#import <objc/runtime.h>

@implementation MainDataSource

-(instancetype)init
{
    self = [super init];
    if(self)
    {
        self.rowArray = [@[
                          [[MainBasicModel alloc] initWithTitle:@"直接录入个性化语音"],
                          [[MainBasicModel alloc] initWithTitle:@"贡献shortcuts(Intent)"],
                          [[MainBasicModel alloc] initWithTitle:@"贡献shortcuts(NSUserActivity)"],
                          [[MainBasicModel alloc] initWithTitle:@"集合页"],
                          [[MainBasicModel alloc] initWithTitle:@"所有Siri Shortcut"]
                          ] mutableCopy];
    }
    return self;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.rowArray.count;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    Class cellCls = [self fetchCellClass];
    NSString *clsName = [NSString stringWithFormat:@"%s",class_getName(cellCls)];
    id cellInstance = [tableView dequeueReusableCellWithIdentifier:clsName];
    if(!cellInstance)
    {
        cellInstance = [[cellCls alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:clsName];
    }
    [cellInstance setObject:self.rowArray[indexPath.row]];
    return cellInstance;
}

-(id)tableView:(UITableView *)tableView objectForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.rowArray[indexPath.row];
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([self.mainDataSource respondsToSelector:@selector(tableView:style:object:)])
    {
        [self.mainDataSource tableView:tableView style:editingStyle object:self.rowArray[indexPath.row]];
    }
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

-(Class)fetchCellClass
{
    return [MainTableViewCell class];
}

@end
