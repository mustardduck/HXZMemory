//  代码地址: https://github.com/CoderMZLee/MZRefresh
//  代码地址: http://code4app.com/ios/%E5%BF%AB%E9%80%9F%E9%9B%86%E6%88%90%E4%B8%8B%E6%8B%89%E4%B8%8A%E6%8B%89%E5%88%B7%E6%96%B0/52326ce26803fabc46000000
//  MZRefreshLegendFooter.m
//  MZRefreshExample
//
//  Created by MZ Lee on 15/3/5.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "MZRefreshLegendFooter.h"
#import "MZRefreshConst.h"
#import "UIView+MZExtension.h"
#import "UIScrollView+MZExtension.h"

@interface MZRefreshLegendFooter()
@property (nonatomic, weak) UIActivityIndicatorView *activityView;
@end

@implementation MZRefreshLegendFooter
#pragma mark - 懒加载
- (UIActivityIndicatorView *)activityView
{
    if (!_activityView) {
        UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [self addSubview:_activityView = activityView];
    }
    return _activityView;
}

#pragma mark - 初始化方法
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 指示器
    if (self.stateHidden) {
        self.activityView.center = CGPointMake(self.MZ_w * 0.5, self.MZ_h * 0.5);
    } else {
        self.activityView.center = CGPointMake(self.MZ_w * 0.5 - 100, self.MZ_h * 0.5);
    }
}

#pragma mark - 公共方法
- (void)setState:(MZRefreshFooterState)state
{
    if (self.state == state) return;
    
    switch (state) {
        case MZRefreshFooterStateIdle:
            [self.activityView stopAnimating];
            break;
            
        case MZRefreshFooterStateRefreshing:
            [self.activityView startAnimating];
            break;
            
        case MZRefreshFooterStateNoMoreData:
            [self.activityView stopAnimating];
            break;
            
        default:
            break;
    }
    
    // super里面有回调，应该在最后面调用
    [super setState:state];
}
@end
