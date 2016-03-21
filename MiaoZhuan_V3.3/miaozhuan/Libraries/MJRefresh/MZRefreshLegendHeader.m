//  代码地址: https://github.com/CoderMZLee/MZRefresh
//  代码地址: http://code4app.com/ios/%E5%BF%AB%E9%80%9F%E9%9B%86%E6%88%90%E4%B8%8B%E6%8B%89%E4%B8%8A%E6%8B%89%E5%88%B7%E6%96%B0/52326ce26803fabc46000000
//  MZRefreshLegendHeader.m
//  MZRefreshExample
//
//  Created by MZ Lee on 15/3/4.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "MZRefreshLegendHeader.h"
#import "MZRefreshConst.h"
#import "UIView+MZExtension.h"

@interface MZRefreshLegendHeader()
@property (nonatomic, weak) UIImageView *arrowImage;
@property (nonatomic, weak) UIActivityIndicatorView *activityView;
@end

@implementation MZRefreshLegendHeader
#pragma mark - 懒加载
- (UIImageView *)arrowImage
{
    if (!_arrowImage) {
        UIImageView *arrowImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:MZRefreshSrcName(@"arrow.png")]];
        [self addSubview:_arrowImage = arrowImage];
    }
    return _arrowImage;
}

- (UIActivityIndicatorView *)activityView
{
    if (!_activityView) {
        UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        activityView.bounds = self.arrowImage.bounds;
        [self addSubview:_activityView = activityView];
    }
    return _activityView;
}

#pragma mark - 初始化
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 箭头
    CGFloat arrowX = (self.stateHidden && self.updatedTimeHidden) ? self.MZ_w * 0.5 : (self.MZ_w * 0.5 - 100);
    self.arrowImage.center = CGPointMake(arrowX, self.MZ_h * 0.5);
    
    // 指示器
    self.activityView.center = self.arrowImage.center;
}

#pragma mark - 公共方法
#pragma mark 设置状态
- (void)setState:(MZRefreshHeaderState)state
{
    if (self.state == state) return;
    
    // 旧状态
    MZRefreshHeaderState oldState = self.state;
    
    switch (state) {
        case MZRefreshHeaderStateIdle: {
            if (oldState == MZRefreshHeaderStateRefreshing) {
                self.arrowImage.transform = CGAffineTransformIdentity;
                
                [UIView animateWithDuration:MZRefreshSlowAnimationDuration animations:^{
                    self.activityView.alpha = 0.0;
                } completion:^(BOOL finished) {
                    self.arrowImage.alpha = 1.0;
                    self.activityView.alpha = 1.0;
                    [self.activityView stopAnimating];
                }];
            } else {
                [UIView animateWithDuration:MZRefreshFastAnimationDuration animations:^{
                    self.arrowImage.transform = CGAffineTransformIdentity;
                }];
            }
            break;
        }
            
        case MZRefreshHeaderStatePulling: {
            [UIView animateWithDuration:MZRefreshFastAnimationDuration animations:^{
                self.arrowImage.transform = CGAffineTransformMakeRotation(0.000001 - M_PI);
            }];
            break;
        }
            
        case MZRefreshHeaderStateRefreshing: {
            [self.activityView startAnimating];
            self.arrowImage.alpha = 0.0;
            break;
        }
            
        default:
            break;
    }
    
    // super里面有回调，应该在最后面调用
    [super setState:state];
}

@end
