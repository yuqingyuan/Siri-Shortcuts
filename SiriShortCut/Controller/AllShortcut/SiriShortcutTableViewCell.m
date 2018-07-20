//
//  SiriShortcutTableViewCell.m
//  SiriShortCut
//
//  Created by yuqingyuan on 2018/7/20.
//  Copyright © 2018年 yuqingyuan. All rights reserved.
//

#import "SiriShortcutTableViewCell.h"
#import "SiriBasicModel.h"

@implementation SiriShortcutTableViewCell

-(void)setObject:(id)object
{
    self.textLabel.text = ((SiriBasicModel *)object).shortcutPhrase;
}

@end
