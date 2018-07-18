//
//  MainDataSource.h
//  SiriShortCut
//
//  Created by yuqingyuan on 2018/7/17.
//  Copyright © 2018年 yuqingyuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MainBasicModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol MainDataSourceDelegate <NSObject>

@optional

-(Class)fetchCellClass;

-(id)tableView:(UITableView *)tableView objectForRowAtIndexPath:(NSIndexPath *)indexPath;

-(void)tableView:(UITableView *)tableView style:(UITableViewCellEditingStyle)editingStyle object:(id)object;

@end

@interface MainDataSource : NSObject<UITableViewDataSource,MainDataSourceDelegate>

@property(nonatomic,strong) NSMutableArray *rowArray;

@property(nonatomic,weak) id<MainDataSourceDelegate> mainDataSource;

@end

NS_ASSUME_NONNULL_END
