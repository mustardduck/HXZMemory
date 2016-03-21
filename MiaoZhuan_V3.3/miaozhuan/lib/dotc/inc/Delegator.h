//
//  Delegator.h

//
//  Created by Yang G on 14-5-17.
//  Copyright (c) 2014年 .C . All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NSString*   DelegatorID;

static DelegatorID INVALID_DELEGATOR = @"invalid";
#define DELEGATOR_ARGUMENT_USERDATA @"delegatorArgumentUserData"

@interface DelegatorArguments : NSObject

- (void) dealloc;

- (void) setArgument:(id) argument for:(NSString*) name;
- (void) cleanArgument:(NSString*) name;
- (id)   getArgument:(NSString*) name;

+(instancetype) argumentsFrom:(NSString*) name arg:(id)arg;
+(instancetype) argumentsFrom:(NSString*) name0 arg0:(id)arg0 name1:name1 arg1:arg1;
+(instancetype) argumentsFrom:(NSString*) name0 arg0:(id)arg0 name1:name1 arg1:arg1 name2:name2 arg2:arg2;
+(instancetype) argumentsFrom:(NSString*) name0 arg0:(id)arg0 name1:name1 arg1:arg1 name2:name2 arg2:arg2 name3:name3 arg3:arg3;

@end

@interface Delegator : NSObject

- (instancetype) init;
- (void) dealloc;
//- (void) setSubject:(id) subject;
- (id) subject;
//- (void) setSelector:(SEL) selector;
- (SEL) selector;
//- (void) setUserData:(id) userData isStrong:(BOOL)isStrong;
- (void) setSubject:(id) subject selector:(SEL) selector;
- (void) setSubject:(id) subject selector:(SEL) selector weakUserData:(id)userData;
- (void) setSubject:(id) subject selector:(SEL) selector strongUserData:(id)userData;
- (id) perform:(DelegatorArguments*) arguments;
- (DelegatorID) delegatorID;

+ (DelegatorID) generateDelegatorID:(id) subject selector:(SEL) selector;
+ (DelegatorID) generateDelegatorID:(id) subject selector:(SEL) selector userData:(id)userData;
@end


