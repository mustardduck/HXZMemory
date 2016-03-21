//
//  CRHttpAddedManager.h
//  miaozhuan
//
//  Created by abyss on 15/1/28.
//  Copyright (c) 2015年 zdit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CRHttpAddedManager : NSObject

/**
 * @brief  检查是否版本已过期,将提示更新信息。
 *         同时你应该检查tableView统一处理是否过滤回调。
 *         以及controller回调中是否处理错误。
 */
+ (void)checkDidshouldUpdate:(DictionaryWrapper *)ret;
+ (BOOL)shouldUpdate:(DictionaryWrapper *)ret;
+ (BOOL)shouldUpdateByCode:(int)code;

+ (void)mz_pushViewController:(UIViewController *)model;

#define CRLIMIT(_num,_after) \
[CRHttpAddedManager show_numbersLimitNum:_num toPoint:_after];
+ (NSString *)show_numbersLimitNum:(double)numbers toPoint:(int)afterNum;
@end
