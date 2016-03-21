//
//  ModuleManager.h
//  DotC
//
//  Created by Yang G on 14-7-9.
//  Copyright (c) 2014年 BIN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Module.h"

@interface ModuleManager : NSObject

- (void) addModule:(Module*)module;
- (Module*) module:(NSString*)moduleName;

+ (instancetype) instance;
@end

#define MODULE_MANAGER [ModuleManager instance]
