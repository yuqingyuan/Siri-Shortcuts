//
//  AssemblyModel.h
//  SiriShortCut
//
//  Created by yuqingyuan on 2018/7/23.
//  Copyright © 2018年 yuqingyuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Intents/Intents.h>

NS_ASSUME_NONNULL_BEGIN

@interface AssemblyModel : NSObject

-(instancetype)initWithName:(NSString *)name websitePath:(NSURL *)url;

@property(nonatomic,copy) NSString *iconName;
@property(nonatomic,strong) NSURL *websiteUrl;
@property(nonatomic,strong) INVoiceShortcut *voiceShortcut;
@property(nonatomic,assign) BOOL hasBeenEdited;

@end

NS_ASSUME_NONNULL_END
