//
//  PlaySound.m
//  miaozhuan
//
//  Created by Santiago on 15-1-9.
//  Copyright (c) 2015年 zdit. All rights reserved.
//

#import "PlaySound.h"
#import <AudioToolbox/AudioToolbox.h>
#import "VoiceControl.h"
@implementation PlaySound

SystemSoundID audioEffect;

+ (void) playSound:(NSString*)name type:(NSString*)type {
 
    if ([VoiceControl isOpen]) {
        NSString *path  = [[NSBundle mainBundle] pathForResource:name ofType:type];
        NSURL *pathURL = [NSURL fileURLWithPath : path];
        AudioServicesCreateSystemSoundID((CFURLRef) pathURL, &audioEffect);
        AudioServicesPlaySystemSound(audioEffect);
    }
}

+ (void)endPlay
{
     AudioServicesDisposeSystemSoundID(audioEffect);
}

+ (void)playRefreshVoice
{
    [self playSound:@"DragDownV" type:@"mp3"];
}
@end
