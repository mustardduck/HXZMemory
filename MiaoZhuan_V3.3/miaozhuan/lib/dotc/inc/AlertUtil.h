//
//  AlertUtil.h
//  DotC
//
//  Created by Yang G on 14-9-30.
//  Copyright (c) 2014年 DotC. All rights reserved.
//

extern NSString* ALERTVIEW_ARGUMENT_NAME;
extern NSString* ALERTVIEW_ARGUMENT_BUTTON_NAME;
extern NSString* ALERTVIEW_ARGUMENT_USERDATA;

@class DelegatorArguments;

typedef void (^ AlertViewDelegatorBlock)(DelegatorArguments* arg);

#define ALERT_VIEW_DELEGATOR_BLOCK(blockCode) __alertViewDelegatorBlock(^ void (DelegatorArguments* args)blockCode)

AlertViewDelegatorBlock __alertViewDelegatorBlock(AlertViewDelegatorBlock block);

@interface AlertUtil : NSObject

+ (void) showAlert:(NSString*)title message:(NSString*)message;

+ (void) showAlert:(NSString*)title message:(NSString*)message delegator:(id)delegator;

+ (void) showAlert:(NSString*)title message:(NSString*)message delegator:(id)delegator userData:(id)userData;

+ (void) showAlert:(NSString*)title message:(NSString*)message buttons:(NSArray*)buttons;

+ (void) showAlert:(NSString*)title message:(NSString*)message buttons:(NSArray*)buttons userData:(id)userData;

@end

