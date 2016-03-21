//
//  DotCDelegate.h
//  DotC
//
//  Created by Yang G on 14-7-2.
//  Copyright (c) 2014年 BIN. All rights reserved.
//
@class JSONConfig;
@class WDictionaryWrapper;
@class WPDictionaryWrapper;

extern NSString*    DOTC_EVENT_VERSION_CHANGED;

DECL_DELEGATOR_FEATURE_CLASS(__DFCAppDelegate, UIResponder);

@interface DotCDelegate : __DFCAppDelegate<UIApplicationDelegate>

@property (retain, nonatomic) UIWindow*     window;
@property (copy, nonatomic) NSString*       appVersion;
@property (nonatomic, readonly) JSONConfig*          versionConfig;
@property (nonatomic, readonly) WDictionaryWrapper*  runtimeConfig;
@property (nonatomic, readonly) WPDictionaryWrapper* persistConfig;

@property (nonatomic, readonly) BOOL isInstall; // Install app, Note. Not update app

- (void) on:(NSString*)event object:(id)object selector:(SEL)selector;
- (void) once:(NSString*)event object:(id)object selector:(SEL)selector;
- (void) remove:(NSString*)event object:(id)object selector:(SEL)selector;
- (void) fire:(NSString*)event arguments:(DelegatorArguments*)arguments;

- (void) clearCache:(float)daysAgo;
- (int)  getCacheSize;

@end
