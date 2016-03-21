//
//  JSONConfig.h
//  LibDotC
//
//  Created by xm01 on 14-10-21.
//  Copyright (c) 2014年 DotC. All rights reserved.
//

#import "DictionaryWrapper.h"

@interface JSONConfig : DictionaryWrapper

- (JSONConfig*) getSubConfig:(NSString*)name;

+ (instancetype) configFromFile:(NSString*)filePath;

+ (instancetype) globalConfig;

@end

#define GLOBAL_CONFIG [JSONConfig globalConfig]

extern NSString* DEFAULT_NAVIGATION_BAR_IMAGE;
extern NSString* DEFAULT_NET_IMAGE_PLACE_HOLDER;
