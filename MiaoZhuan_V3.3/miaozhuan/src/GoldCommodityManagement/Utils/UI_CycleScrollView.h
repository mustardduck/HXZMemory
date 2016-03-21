//
//  UI_CycleScrollView.h
//  Demo
//
//  Created by Nick on 15/5/5.
//  Copyright (c) 2015年 Nick. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UI_CycleScrollViewDelegate <NSObject>

-(void)CycleImageTap:(int)page;

@end

@interface UI_CycleScrollView : UIView

/** 图片地址数组 */
@property(nonatomic, strong, setter=setPictureUrls:) NSMutableArray    *pictureUrls;

@property(nonatomic, assign) id<UI_CycleScrollViewDelegate>            delegate;

@end
