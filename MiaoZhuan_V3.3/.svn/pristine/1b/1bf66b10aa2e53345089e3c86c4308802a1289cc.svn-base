//
//  Module.h
//  DotC
//
//  Created by Yang G on 14-7-9.
//  Copyright (c) 2014年 BIN. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ServerRequest;

@interface Module : NSObject

- (NSString*) moduleName;
- (BOOL) handleRequest:(ServerRequest*)request arguments:(DelegatorArguments*)arguments;
- (void) registeDelegator:(id) subject selector:(SEL)selector forOperation:(NSString*)operation;
- (void) removeDelegator:(NSString*)operation;
@end
