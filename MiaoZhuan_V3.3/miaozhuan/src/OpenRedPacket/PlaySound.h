//
//  PlaySound.h
//  miaozhuan
//
//  Created by Santiago on 15-1-9.
//  Copyright (c) 2015年 zdit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlaySound : NSObject
//播放传入文件名称和类型
+ (void) playSound:(NSString*)name type:(NSString*)type;

//停止并且释放
+ (void) endPlay;


/** 上下拉声音 */
+ (void)playRefreshVoice;
@end
