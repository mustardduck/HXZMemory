//
//  VoiceControl.m
//  miaozhuan
//
//  Created by 孙向前 on 15-1-10.
//  Copyright (c) 2015年 zdit. All rights reserved.
//

#import "VoiceControl.h"

@implementation VoiceControl

+ (BOOL)isOpen{
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"OpenSound"];
}

+ (void)openTheSound:(BOOL)open{
    [[NSUserDefaults standardUserDefaults] setBool:open forKey:@"OpenSound"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
