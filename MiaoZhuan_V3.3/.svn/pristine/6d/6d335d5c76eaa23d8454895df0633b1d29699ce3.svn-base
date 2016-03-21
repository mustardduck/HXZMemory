//
//  GaoDeMapViewController.h
//  miaozhuan
//
//  Created by Santiago on 14-11-6.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GetMapInformation <NSObject>
@optional

- (void)getLocation:(NSString*)string;
- (void)getLongitude:(double)longitude andLatitude:(double)latitude;
- (void)getDataArray:(NSArray*)array;
@end

@interface GaoDeMapViewController : DotCViewController
@property(nonatomic, copy) NSString *chooseLocation;
@property(nonatomic, assign) id<GetMapInformation> delegate;

@property(nonatomic, assign) double longitude;
@property(nonatomic, assign) double latidiute;
- (void)bd_decrypt:(double)bd_lat andLon:(double) bd_lon;
@property(nonatomic, strong) NSString* typeName;
@property (assign, nonatomic)int markScrollWithMap;//等于1是mark随着地图滑动，否则mark一直处于屏幕中间
@property (nonatomic ,assign) BOOL hiddenRightItem;
@end
