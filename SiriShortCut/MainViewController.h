//
//  MainTableViewController.h
//  SiriShortCut
//
//  Created by yuqingyuan on 2018/7/17.
//  Copyright © 2018年 yuqingyuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Intents/Intents.h>
#import <IntentsUI/IntentsUI.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MainViewControlDelegate <NSObject>

-(id)fetchDataSource;

-(void)reloadTableView;

-(void)tableView:(UITableView *)tableView didSelectAtIndexPath:(NSIndexPath *)indexPath withObject:(id)object;

@end

@interface MainViewController : UIViewController<MainViewControlDelegate>

@end

NS_ASSUME_NONNULL_END
