//  代码地址: https://github.com/CoderMZLee/MZRefresh
//  代码地址: http://code4app.com/ios/%E5%BF%AB%E9%80%9F%E9%9B%86%E6%88%90%E4%B8%8B%E6%8B%89%E4%B8%8A%E6%8B%89%E5%88%B7%E6%96%B0/52326ce26803fabc46000000
//  MZRefreshHeader.m
//  MZRefreshExample
//
//  Created by MZ Lee on 15/3/4.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "MZRefreshHeader.h"
#import "MZRefreshConst.h"
#import "UIView+MZExtension.h"
#import <objc/message.h>
#import "UIScrollView+MZExtension.h"

@interface MZRefreshHeader()
/** 显示上次刷新时间的标签 */
@property (weak, nonatomic) UILabel *updatedTimeLabel;
/** 上次刷新时间 */
@property (strong, nonatomic) NSDate *updatedTime;
/** 显示状态文字的标签 */
@property (weak, nonatomic) UILabel *stateLabel;
/** 所有状态对应的文字 */
@property (strong, nonatomic) NSMutableDictionary *stateTitles;
@end

@implementation MZRefreshHeader
#pragma mark - 懒加载
- (NSMutableDictionary *)stateTitles
{
    if (!_stateTitles) {
        self.stateTitles = [NSMutableDictionary dictionary];
    }
    return _stateTitles;
}

- (UILabel *)stateLabel
{
    if (!_stateLabel) {
        UILabel *stateLabel = [[UILabel alloc] init];
        stateLabel.backgroundColor = [UIColor clearColor];
        stateLabel.textAlignment = NSTextAlignmentLeft;
        stateLabel.textColor = MZRefreshHeaderLabelTextColor;
        stateLabel.font = MZRefreshHeaderLabelFont;
        [self addSubview:_stateLabel = stateLabel];
    }
    return _stateLabel;
}

- (UILabel *)updatedTimeLabel
{
    if (!_updatedTimeLabel) {
        UILabel *updatedTimeLabel = [[UILabel alloc] init];
        updatedTimeLabel.backgroundColor = [UIColor clearColor];
        updatedTimeLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_updatedTimeLabel = updatedTimeLabel];
    }
    return _updatedTimeLabel;
}

#pragma mark - 初始化方法
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // 设置默认的dateKey
        self.dateKey = MZRefreshHeaderUpdatedTimeKey;
        
        // 设置为默认状态
        self.state = MZRefreshHeaderStateIdle;
        
        // 初始化文字
        [self setTitle:MZRefreshHeaderStateIdleText forState:MZRefreshHeaderStateIdle];
        [self setTitle:MZRefreshHeaderStatePullingText forState:MZRefreshHeaderStatePulling];
        [self setTitle:MZRefreshHeaderStateRefreshingText forState:MZRefreshHeaderStateRefreshing];
    }
    return self;
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    
    if (newSuperview) {
        self.MZ_h = MZRefreshHeaderHeight;
    }
}

- (void)drawRect:(CGRect)rect
{
    if (self.state == MZRefreshHeaderStateWillRefresh) {
        self.state = MZRefreshHeaderStateRefreshing;
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 设置自己的位置
    self.MZ_y = - self.MZ_h;
    
    // 2个标签都隐藏
    if (self.stateHidden && self.updatedTimeHidden) return;
    
    if (self.updatedTimeHidden) { // 显示状态
        _stateLabel.frame = self.bounds;
        _stateLabel.MZ_x = self.MZ_w * 0.5 - 10;
    } else if (self.stateHidden) { // 显示时间
        self.updatedTimeLabel.frame = self.bounds;
    } else { // 都显示
        CGFloat stateH = self.MZ_h * 0.55;
        CGFloat stateW = self.MZ_w;
        // 1.状态标签
        _stateLabel.frame = CGRectMake(0, 0, stateW, stateH);
        
        // 2.时间标签
        CGFloat updatedTimeY = stateH;
        CGFloat updatedTimeH = self.MZ_h - stateH;
        CGFloat updatedTimeW = stateW;
        self.updatedTimeLabel.frame = CGRectMake(0, updatedTimeY, updatedTimeW, updatedTimeH);
    }
}

#pragma mark - 私有方法
- (void)setDateKey:(NSString *)dateKey
{
    _dateKey = dateKey ? dateKey : MZRefreshHeaderUpdatedTimeKey;
    
    self.updatedTime = [[NSUserDefaults standardUserDefaults] objectForKey:_dateKey];
}

#pragma mark 设置最后的更新时间
- (void)setUpdatedTime:(NSDate *)updatedTime
{
    _updatedTime = updatedTime;
    
    if (updatedTime) {
        [[NSUserDefaults standardUserDefaults] setObject:updatedTime forKey:self.dateKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    if (self.updatedTimeTitle) {
        self.updatedTimeLabel.text = self.updatedTimeTitle(updatedTime);
        return;
    }
    
    if (updatedTime) {
        // 1.获得年月日
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSUInteger unitFlags = NSCalendarUnitYear| NSCalendarUnitMonth | NSCalendarUnitDay |NSCalendarUnitHour |NSCalendarUnitMinute;
        NSDateComponents *cmp1 = [calendar components:unitFlags fromDate:updatedTime];
        NSDateComponents *cmp2 = [calendar components:unitFlags fromDate:[NSDate date]];
        
        // 2.格式化日期
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        if ([cmp1 day] == [cmp2 day]) { // 今天
            formatter.dateFormat = @"今天 HH:mm";
        } else if ([cmp1 year] == [cmp2 year]) { // 今年
            formatter.dateFormat = @"MM-dd HH:mm";
        } else {
            formatter.dateFormat = @"yyyy-MM-dd HH:mm";
        }
        NSString *time = [formatter stringFromDate:updatedTime];
        
        // 3.显示日期
        self.updatedTimeLabel.text = [NSString stringWithFormat:@"最后更新：%@", time];
    } else {
        self.updatedTimeLabel.text = @"最后更新：无记录";
    }
}

#pragma mark KVO属性监听
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    // 遇到这些情况就直接返回
    if (!self.userInteractionEnabled || self.alpha <= 0.01 || self.hidden || self.state == MZRefreshHeaderStateRefreshing) return;
    
    // 根据contentOffset调整state
    if ([keyPath isEqualToString:MZRefreshContentOffset]) {
        [self adjustStateWithContentOffset];
    }
}

#pragma mark 根据contentOffset调整state
- (void)adjustStateWithContentOffset
{
    if (self.state != MZRefreshHeaderStateRefreshing) {
        // 在刷新过程中，跳转到下一个控制器时，contentInset可能会变
        _scrollViewOriginalInset = _scrollView.contentInset;
    }
    
    // 在刷新的 refreshing 状态，动态设置 content inset
    if (self.state == MZRefreshHeaderStateRefreshing ) {
        if(_scrollView.contentOffset.y >= -_scrollViewOriginalInset.top ) {
            _scrollView.MZ_insetT = _scrollViewOriginalInset.top;
        } else {
            _scrollView.MZ_insetT = MIN(_scrollViewOriginalInset.top + self.MZ_h,
                                        _scrollViewOriginalInset.top - _scrollView.contentOffset.y);
        }
        return;
    }
    
    // 当前的contentOffset
    CGFloat offsetY = _scrollView.MZ_offsetY;
    // 头部控件刚好出现的offsetY
    CGFloat happenOffsetY = - _scrollViewOriginalInset.top;
    
    // 如果是向上滚动到看不见头部控件，直接返回
    if (offsetY >= happenOffsetY) return;
    
    // 普通 和 即将刷新 的临界点
    CGFloat normal2pullingOffsetY = happenOffsetY - self.MZ_h;
    if (_scrollView.isDragging) {
        self.pullingPercent = (happenOffsetY - offsetY) / self.MZ_h;
        
        if (self.state == MZRefreshHeaderStateIdle && offsetY < normal2pullingOffsetY) {
            // 转为即将刷新状态
            self.state = MZRefreshHeaderStatePulling;
        } else if (self.state == MZRefreshHeaderStatePulling && offsetY >= normal2pullingOffsetY) {
            // 转为普通状态
            self.state = MZRefreshHeaderStateIdle;
        }
    } else if (self.state == MZRefreshHeaderStatePulling) {// 即将刷新 && 手松开
        self.pullingPercent = 1.0;
        // 开始刷新
        self.state = MZRefreshHeaderStateRefreshing;
    } else {
        self.pullingPercent = (happenOffsetY - offsetY) / self.MZ_h;
    }
}

#pragma mark - 公共方法
- (void)setTitle:(NSString *)title forState:(MZRefreshHeaderState)state
{
    if (title == nil) return;
    self.stateTitles[@(state)] = title;
    
    // 刷新当前状态的文字
    self.stateLabel.text = self.stateTitles[@(self.state)];
}

- (void)beginRefreshing
{
    if (self.window) {
        self.state = MZRefreshHeaderStateRefreshing;
    } else {
        self.state = MZRefreshHeaderStateWillRefresh;
        // 刷新(预防从另一个控制器回到这个控制器的情况，回来要重新刷新一下)
        [self setNeedsDisplay];
    }
}

- (void)endRefreshing
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.state = MZRefreshHeaderStateIdle;
    });
}

- (BOOL)isRefreshing
{
    return self.state == MZRefreshHeaderStateRefreshing;
}

- (void)setState:(MZRefreshHeaderState)state
{
    if (_state == state) return;
    
    // 旧状态
    MZRefreshHeaderState oldState = _state;
    
    // 赋值
    _state = state;
    
    // 设置状态文字
    _stateLabel.text = _stateTitles[@(state)];
    
    switch (state) {
        case MZRefreshHeaderStateIdle: {
            if (oldState == MZRefreshHeaderStateRefreshing) {
                // 保存刷新时间
                self.updatedTime = [NSDate date];
                
                // 恢复inset和offset
                [UIView animateWithDuration:MZRefreshSlowAnimationDuration delay:0.0 options:UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionBeginFromCurrentState animations:^{
                    // 修复top值不断累加
                    _scrollView.MZ_insetT -= self.MZ_h;
                } completion:nil];
            }
            break;
        }
            
        case MZRefreshHeaderStateRefreshing: {
            [UIView animateWithDuration:MZRefreshFastAnimationDuration delay:0.0 options:UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionBeginFromCurrentState animations:^{
                // 增加滚动区域
                CGFloat top = _scrollViewOriginalInset.top + self.MZ_h;
                _scrollView.MZ_insetT = top;
                
                // 设置滚动位置
                _scrollView.MZ_offsetY = - top;
            } completion:^(BOOL finished) {
                // 回调
                if (self.refreshingBlock) {
                    self.refreshingBlock();
                }
                
                if ([self.refreshingTarget respondsToSelector:self.refreshingAction]) {
                    msgSend(msgTarget(self.refreshingTarget), self.refreshingAction, self);
                }
            }];
            break;
        }
            
        default:
            break;
    }
}

- (void)setTextColor:(UIColor *)textColor
{
    [super setTextColor:textColor];
    
    self.updatedTimeLabel.textColor = textColor;
    self.stateLabel.textColor = textColor;
}

- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    
    self.updatedTimeLabel.font = font;
    self.stateLabel.font = font;
}

- (void)setStateHidden:(BOOL)stateHidden
{
    _stateHidden = stateHidden;
    
    self.stateLabel.hidden = stateHidden;
    [self setNeedsLayout];
}

- (void)setUpdatedTimeHidden:(BOOL)updatedTimeHidden
{
    _updatedTimeHidden = updatedTimeHidden;
    
    self.updatedTimeLabel.hidden = updatedTimeHidden;
    [self setNeedsLayout];
}
@end