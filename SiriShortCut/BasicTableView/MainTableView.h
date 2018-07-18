//
//  MainTableView.h
//  SiriShortCut
//
//  Created by yuqingyuan on 2018/7/17.
//  Copyright © 2018年 yuqingyuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainDataSource.h"

NS_ASSUME_NONNULL_BEGIN

@protocol MainTableViewDelegate <NSObject>

-(void)tableView:(UITableView *)tableView didSelectAtIndexPath:(NSIndexPath *)indexPath withObject:(id)object;

@end

@interface MainTableView : UITableView<UITableViewDelegate>

@property(nonatomic,weak) id<MainTableViewDelegate> mainTableViewDelegate;

@end

NS_ASSUME_NONNULL_END
