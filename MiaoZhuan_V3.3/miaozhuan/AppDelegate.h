//
//  AppDelegate.h
//  miaozhuan
//
//  Created by Yang G on 14-10-21.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@class CRMTAManager;
@class CRPushManager;
@interface AppDelegate : DotCDelegate <CLLocationManagerDelegate>

@property (nonatomic, retain) WPDictionaryWrapper*      userConfig;
@property (nonatomic, retain) CLLocationManager*        locationManager;
@property (nonatomic, retain) CRPushManager*            pushManager;
@property (nonatomic, retain) CRMTAManager*             mtaManager;

@property (nonatomic, retain) ServerRequest *request;

@property (nonatomic, assign) BOOL isFinish;//首页动画是否完毕

@property(nonatomic, retain) id             lastController;

@end
