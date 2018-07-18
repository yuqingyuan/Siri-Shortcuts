//
//  ShoppingListModel.h
//  SiriShortCut
//
//  Created by yuqingyuan on 2018/7/17.
//  Copyright © 2018年 yuqingyuan. All rights reserved.
//

#import "MainBasicModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^Completion)(void);

@interface ShoppingListModel : MainBasicModel

-(instancetype)initWithTitle:(NSString *)title quantity:(NSInteger)productQuantity;

-(void)addProductToCart:(Completion)completion;

@property(nonatomic,strong) NSString *productName;
@property(nonatomic,assign) NSInteger productNum;

@end

NS_ASSUME_NONNULL_END
