//
//  ScrollerAdPageController.h
//  miaozhuan
//
//  Created by Santiago on 14-10-27.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ScrollerWithTimeDelegate <NSObject>

@optional
- (void)scrollerPictureClicked:(int)indexCount;
@end

@interface ScrollerViewWithTime : NSObject

- (void)addImageItems:(NSArray*)adImageArray;

-(void)setWidthSelf:(int)width;

+ (instancetype) controllerFromView:(UIScrollView*) view;

+ (instancetype) controllerFromView:(UIScrollView*) view pictureSize:(CGSize)size;

+ (instancetype) controllerFromView:(UIScrollView*) view andPSAsPictureSize:(CGSize)size;

@property (nonatomic , copy) void (^TapActionBlock)(NSInteger pageIndex);
@property (assign, nonatomic)id<ScrollerWithTimeDelegate>delegate;
@end
