//
//  SiriBasicModel.m
//  SiriShortCut
//
//  Created by yuqingyuan on 2018/7/20.
//  Copyright © 2018年 yuqingyuan. All rights reserved.
//

#import "SiriBasicModel.h"

@implementation SiriBasicModel

-(instancetype)initWithINVoiceShortcut:(INVoiceShortcut *)voiceShortcut
{
    self = [super init];
    if(self)
    {
        self.voiceShortcut = voiceShortcut;
        self.shortcutPhrase = voiceShortcut.invocationPhrase;
    }
    return self;
}

@end
