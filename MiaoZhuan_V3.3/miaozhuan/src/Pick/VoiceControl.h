//
//  VoiceControl.h
//  miaozhuan
//
//  Created by 孙向前 on 15-1-10.
//  Copyright (c) 2015年 zdit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VoiceControl : NSObject

+ (BOOL)isOpen;

+ (void)openTheSound:(BOOL)open;

@end
