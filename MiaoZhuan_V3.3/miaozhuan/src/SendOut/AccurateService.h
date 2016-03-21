//
//  AccurateService.h
//  miaozhuan
//
//  Created by 孙向前 on 14-11-25.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AccurateService : NSObject

+ (void)saveDraftBoxWithDelegator:(id)delegator selector:(SEL)selector;

+ (void)commitWithDelegator:(id)delegator selector:(SEL)selector;

+ (void)saveData:(DictionaryWrapper *)dic isYinyuan:(BOOL)flag;

+ (void)areaSetting:(NSArray *)areas;

+ (void)clearData;

@end
