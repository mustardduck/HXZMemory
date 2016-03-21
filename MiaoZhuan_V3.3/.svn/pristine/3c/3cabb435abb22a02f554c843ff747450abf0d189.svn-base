//
//  DelegatorManager.h

//
//  Created by Yang G on 14-5-16.
//  Copyright (c) 2014年 .C . All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Delegator.h"

@interface DelegatorManager : NSObject

// The selector must be
// 1: id methodName:(DelegatorArguments*)arguments;
// 2: void methodName:(DelegatorArguments*)arguments;
- (DelegatorID) addDelegator:(id) subject selector:(SEL) selector;
- (DelegatorID) addDelegator:(id) subject selector:(SEL) selector weakUserData:(id)userData;
- (DelegatorID) addDelegator:(id) subject selector:(SEL) selector strongUserData:(id)userData;
- (void) removeDelegators:(id) subject;
//- (void) removeDelegator:(id) subject selector:(SEL) selector;
- (void) removeDelegator:(DelegatorID) delegatorID;
//- (DelegatorID) getDelegator:(id) subject selector:(SEL) selector;
- (id) performDelegator:(DelegatorID) delegatorID arguments:(DelegatorArguments*) arguments;

+ (instancetype) globalDelegatorManager;
@end

#define GLOBAL_DELEGATOR_MANAGER [DelegatorManager globalDelegatorManager]

// Support auto remove delegators for class want to use global delegator manager
#define DECL_DELEGATOR_FEATURE_CLASS(clsName, superClsName)\
@interface clsName : superClsName\
- (DelegatorID) genDelegatorID:(SEL)selector;\
- (DelegatorID) genDelegatorID:(SEL)selector weakData:(id)data;\
- (DelegatorID) genDelegatorID:(SEL)selector strongData:(id)data;\
@end

#define IMPL_DELEGATOR_FEATURE_CLASS(clsName, superClsName)\
@implementation clsName\
- (void) dealloc\
{\
[GLOBAL_DELEGATOR_MANAGER removeDelegators:self];\
[super dealloc];\
}\
\
- (DelegatorID) genDelegatorID:(SEL)selector\
{\
return [GLOBAL_DELEGATOR_MANAGER addDelegator:self selector:selector];\
}\
\
- (DelegatorID) genDelegatorID:(SEL)selector weakData:(id)data\
{\
return [GLOBAL_DELEGATOR_MANAGER addDelegator:self selector:selector weakUserData:data];\
}\
\
- (DelegatorID) genDelegatorID:(SEL)selector strongData:(id)data\
{\
return [GLOBAL_DELEGATOR_MANAGER addDelegator:self selector:selector strongUserData:data];\
}\
@end