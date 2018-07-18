//
//  MainBasicModel.h
//  SiriShortCut
//
//  Created by yuqingyuan on 2018/7/17.
//  Copyright © 2018年 yuqingyuan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MainBasicModel : NSObject

@property(nonatomic,strong) NSString *title;

-(instancetype)initWithTitle:(NSString *)title;

@end

NS_ASSUME_NONNULL_END
