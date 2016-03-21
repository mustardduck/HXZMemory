//
//  RCButton.h
//  miaozhuan
//
//  Created by abyss on 14/11/12.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, RCButtonType)
{
    RCButtonTypeCountdown = 0,
    RCButtonTypeHighlight,
    RCButtonTypeNotify,
};

@interface RCButton : UIButton
@property (assign, nonatomic) RCButtonType type;
@property (assign, nonatomic, readonly) id abstractInstance;
- (instancetype)initWithFrame:(CGRect)frame type:(RCButtonType)type;
@end

@protocol CDButtonDelegate;
@interface CountdownButton : RCButton

@property (assign, nonatomic) id <CDButtonDelegate> delegate;
@property (assign, nonatomic) NSInteger secounds;
@property (retain, nonatomic) NSString *startTitle;
@property (retain, nonatomic) NSString *midTitle;
@property (retain, nonatomic) NSString *endTitle;

- (void)start;

@end

@protocol CDButtonDelegate <NSObject>
@optional
- (void)buttonCountWillBegin:(CountdownButton *)button;
- (void)buttonCountDidBegin:(CountdownButton *)button;
- (void)buttonCountEnd:(CountdownButton *)button;
@end

//button should be custom, wait to improve
@interface HightedButton : RCButton
@property (retain, nonatomic) UIImage *HightedImage;
@property (retain, nonatomic) UIImage *NormalImage;
@end

@protocol NBButtonDelegate;
@interface NotifyButton : RCButton
@property (assign, nonatomic) id <NBButtonDelegate> delegate;
@property (assign, nonatomic) int64_t num;
@property (retain, nonatomic) UIColor *color;
- (void)callUp;
@end

@protocol NBButtonDelegate <NSObject>
//懒惰的强迫症不需要红点
- (void)buttonShouldRemove:(NotifyButton *)button;
- (void)buttonShouldCallUp:(NotifyButton *)button;
@end