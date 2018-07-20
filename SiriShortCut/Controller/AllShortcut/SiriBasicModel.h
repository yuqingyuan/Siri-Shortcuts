//
//  SiriBasicModel.h
//  SiriShortCut
//
//  Created by yuqingyuan on 2018/7/20.
//  Copyright © 2018年 yuqingyuan. All rights reserved.
//

#import "MainBasicModel.h"
#import <Intents/Intents.h>

NS_ASSUME_NONNULL_BEGIN

@interface SiriBasicModel : MainBasicModel

@property(nonatomic,strong) INVoiceShortcut *voiceShortcut;

@property(nonatomic,strong) NSString *shortcutPhrase;

-(instancetype)initWithINVoiceShortcut:(INVoiceShortcut *)voiceShortcut;

@end

NS_ASSUME_NONNULL_END
