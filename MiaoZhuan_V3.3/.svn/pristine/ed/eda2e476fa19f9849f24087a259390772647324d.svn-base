//
//  CRArrowLayer.h
//  CRCoreUnit
//
//  Created by abyss on 14/12/17.
//  Copyright (c) 2014年 Abyss Roger. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, CRArrowLayerType)
{
    CRArrowLayerTypeFree    = 0,
    
    CRArrowLayerTypeLeft    = 1 << 0,
    CRArrowLayerTypeRight   = 1 << 1,
    CRArrowLayerTypeTop     = 1 << 2,
    CRArrowLayerTypeBottom  = 1 << 3,
};

extern NSString* arrowCustomImg;

@protocol CRArrowDelegate;
@interface CRArrow : UIControl
@property (assign)            BOOL arrowOpen;
@property (assign)            BOOL needTurnDown;
@property (assign)            CGRect realRect;
@property (assign, nonatomic) CRArrowLayerType type;
@property (assign) id<CRArrowDelegate> cr_delegate;

- (instancetype)initWithArrow:(NSString *)imgName delegate:(id<CRArrowDelegate>)delegate;
- (instancetype)initWithType:(CRArrowLayerType)type delegate:(id<CRArrowDelegate>)delegate;

- (void)turnAsEastern;
- (void)turnAsClockwise;
- (void)turnAsEasternUpsidedown;
- (void)turnAsClockwiseUpsidedown;

- (void)setUp;
- (void)setDown;
@end

@protocol CRArrowDelegate <NSObject>
@optional
- (void)arrow:(CRArrow *)arrow click:(BOOL)open;
@end