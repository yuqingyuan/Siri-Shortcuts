//
//  MainTableViewCell.h
//  SiriShortCut
//
//  Created by yuqingyuan on 2018/7/17.
//  Copyright © 2018年 yuqingyuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainBasicModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol MainTableViewCellDelegate <NSObject>

-(void)setObject:(id)object;

@end

@interface MainTableViewCell : UITableViewCell<MainTableViewCellDelegate>

@end

NS_ASSUME_NONNULL_END
