//
//  SiriShortcutDataSource.m
//  SiriShortCut
//
//  Created by yuqingyuan on 2018/7/20.
//  Copyright © 2018年 yuqingyuan. All rights reserved.
//

#import "SiriShortcutDataSource.h"

@implementation SiriShortcutDataSource

-(instancetype)init
{
    self = [super init];
    if(self)
    {
        self.rowArray = [@[] mutableCopy];
        [INVoiceShortcutCenter.sharedCenter getAllVoiceShortcutsWithCompletion:^(NSArray<INVoiceShortcut *> * _Nullable voiceShortcuts, NSError * _Nullable error) {
            for (INVoiceShortcut *shortcut in voiceShortcuts) {
                SiriBasicModel *model = [[SiriBasicModel alloc] initWithINVoiceShortcut:shortcut];
                [self.rowArray addObject:model];
            }
        }];
    }
    return self;
}

-(Class)fetchCellClass
{
    return [SiriShortcutTableViewCell class];
}

@end
