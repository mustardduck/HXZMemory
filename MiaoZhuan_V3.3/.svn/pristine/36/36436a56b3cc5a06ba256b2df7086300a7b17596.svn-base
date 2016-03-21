//  代码地址: https://github.com/CoderMZLee/MZRefresh
//  代码地址: http://code4app.com/ios/%E5%BF%AB%E9%80%9F%E9%9B%86%E6%88%90%E4%B8%8B%E6%8B%89%E4%B8%8A%E6%8B%89%E5%88%B7%E6%96%B0/52326ce26803fabc46000000
//  MZRefreshFooter.m
//  MZRefreshExample
//
//  Created by MZ Lee on 15/3/5.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "MZRefreshFooter.h"
#import "MZRefreshConst.h"
#import "UIScrollView+MZExtension.h"
#import "MZRefreshHeader.h"
#import "UIView+MZExtension.h"
#import "UIScrollView+MZRefresh.h"
#import <objc/message.h>

@interface MZRefreshFooter()
/** 显示状态文字的标签 */
@property (weak, nonatomic) UILabel *stateLabel;
/** 点击可以加载更多 */
@property (weak, nonatomic) UIButton *loadMoreButton;
/** 没有更多的数据 */
@property (weak, nonatomic) UILabel *noMoreLabel;
/** 即将要执行的代码 */
@property (strong, nonatomic) NSMutableArray *willExecuteBlocks;
@end

@implementation MZRefreshFooter
#pragma mark - 懒加载
- (NSMutableArray *)willExecuteBlocks
{
    if (!_willExecuteBlocks) {
        self.willExecuteBlocks = [NSMutableArray array];
    }
    return _willExecuteBlocks;
}

- (UIButton *)loadMoreButton
{
    if (!_loadMoreButton) {
        UIButton *loadMoreButton = [[UIButton alloc] init];
        loadMoreButton.backgroundColor = [UIColor clearColor];
        [loadMoreButton addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_loadMoreButton = loadMoreButton];
    }
    return _loadMoreButton;
}

- (UILabel *)noMoreLabel
{
    if (!_noMoreLabel) {
        UILabel *noMoreLabel = [[UILabel alloc] init];
        noMoreLabel.backgroundColor = [UIColor clearColor];
        noMoreLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_noMoreLabel = noMoreLabel];
    }
    return _noMoreLabel;
}

- (UILabel *)stateLabel
{
    if (!_stateLabel) {
        UILabel *stateLabel = [[UILabel alloc] init];
        stateLabel.backgroundColor = [UIColor clearColor];
        stateLabel.textAlignment = NSTextAlignmentCenter;
        stateLabel.textColor = [UIColor redColor];//MZRefreshFooterLabelTextColor;
        stateLabel.font = MZRefreshFooterLabelFont;
        [self addSubview:_stateLabel = stateLabel];
    }
    return _stateLabel;
}

#pragma mark - 初始化方法
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // 默认底部控件100%出现时才会自动刷新
        self.appearencePercentTriggerAutoRefresh = 1.0;
        
        // 设置为默认状态
        self.automaticallyRefresh = YES;
        self.state = MZRefreshFooterStateIdle;
        
        // 初始化文字
        [self setTitle:MZRefreshFooterStateIdleText forState:MZRefreshFooterStateIdle];
        [self setTitle:MZRefreshFooterStateRefreshingText forState:MZRefreshFooterStateRefreshing];
        [self setTitle:MZRefreshFooterStateNoMoreDataText forState:MZRefreshFooterStateNoMoreData];
    }
    return self;
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    
    // 旧的父控件
    [self.superview removeObserver:self forKeyPath:MZRefreshContentSize context:nil];
    [self.superview removeObserver:self forKeyPath:MZRefreshPanState context:nil];
    
    if (newSuperview) { // 新的父控件
        // 监听
        [newSuperview addObserver:self forKeyPath:MZRefreshContentSize options:NSKeyValueObservingOptionNew context:nil];
        [newSuperview addObserver:self forKeyPath:MZRefreshPanState options:NSKeyValueObservingOptionNew context:nil];
        
        self.MZ_h = MZRefreshFooterHeight;
        _scrollView.MZ_insetB += self.MZ_h;
        
        // 重新调整frame
        [self adjustFrameWithContentSize];
    } else { // 被移除了
        _scrollView.MZ_insetB -= self.MZ_h;
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.loadMoreButton.frame = self.bounds;
    self.stateLabel.frame = self.bounds;
    self.noMoreLabel.frame = self.bounds;
}

#pragma mark - 私有方法
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    // 遇到这些情况就直接返回
    if (!self.userInteractionEnabled || self.alpha <= 0.01 || self.hidden) return;
    
    if (self.state == MZRefreshFooterStateIdle) {
        // 当是Idle状态时，才需要检测是否要进入刷新状态
        if ([keyPath isEqualToString:MZRefreshPanState]) {
            if (_scrollView.panGestureRecognizer.state == UIGestureRecognizerStateEnded) {// 手松开
                if (_scrollView.MZ_insetT + _scrollView.MZ_contentSizeH <= _scrollView.MZ_h) {  // 不够一个屏幕
                    if (_scrollView.MZ_offsetY > - _scrollView.MZ_insetT) { // 向上拽
                        [self beginRefreshing];
                    }
                } else { // 超出一个屏幕
                    if (_scrollView.MZ_offsetY > _scrollView.MZ_contentSizeH + _scrollView.MZ_insetB - _scrollView.MZ_h) {
                        [self beginRefreshing];
                    }
                }
            }
        } else if ([keyPath isEqualToString:MZRefreshContentOffset]) {
            if (self.state != MZRefreshFooterStateRefreshing && self.automaticallyRefresh) {
                // 根据contentOffset调整state
                [self adjustStateWithContentOffset];
            }
        }
    }
    
    // 不管是什么状态，都要调整位置
    if ([keyPath isEqualToString:MZRefreshContentSize]) {
        [self adjustFrameWithContentSize];
    }
}

#pragma mark 根据contentOffset调整state
- (void)adjustStateWithContentOffset
{
    if (self.MZ_y == 0) return;
    
    if (_scrollView.MZ_insetT + _scrollView.MZ_contentSizeH > _scrollView.MZ_h) { // 内容超过一个屏幕
        // 这里的_scrollView.MZ_contentSizeH替换掉self.MZ_y更为合理
        if (_scrollView.MZ_offsetY > _scrollView.MZ_contentSizeH - _scrollView.MZ_h + self.MZ_h * self.appearencePercentTriggerAutoRefresh + _scrollView.MZ_insetB - self.MZ_h) {
            // 当底部刷新控件完全出现时，才刷新
            [self beginRefreshing];
        }
    }
}

- (void)adjustFrameWithContentSize
{
    // 设置位置
    self.MZ_y = _scrollView.MZ_contentSizeH;
    
//    if (_scrollView.MZ_contentSizeH < _scrollView.MZ_h) {
//        _scrollView.MZ_contentSizeH = _scrollView.MZ_h;
//        self.MZ_y = _scrollView.MZ_h;
//    }else{
//        self.MZ_y = _scrollView.MZ_contentSizeH;
//    }
    
}

- (void)buttonClick
{
    [self beginRefreshing];
}

#pragma mark - 公共方法
- (void)setHidden:(BOOL)hidden
{
    __weak typeof(self) weakSelf = self;
    BOOL lastHidden = weakSelf.isHidden;
    CGFloat h = weakSelf.MZ_h;
    [weakSelf.willExecuteBlocks addObject:^{
        if (!lastHidden && hidden) {
            weakSelf.state = MZRefreshFooterStateIdle;
            _scrollView.MZ_insetB -= h;
        } else if (lastHidden && !hidden) {
            _scrollView.MZ_insetB += h;
            
            [weakSelf adjustFrameWithContentSize];
        }
    }];
    [weakSelf setNeedsDisplay]; // 放到drawRect是为了延迟执行，防止因为修改了inset，导致循环调用数据源方法
    
    [super setHidden:hidden];
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    for (void (^block)() in self.willExecuteBlocks) {
        block();
    }
    [self.willExecuteBlocks removeAllObjects];
}

- (void)beginRefreshing
{
    self.state = MZRefreshFooterStateRefreshing;
}

- (void)endRefreshing
{
    self.state = MZRefreshFooterStateIdle;
}

- (BOOL)isRefreshing
{
    return self.state == MZRefreshFooterStateRefreshing;
}

- (void)noticeNoMoreData
{
    self.state = MZRefreshFooterStateNoMoreData;
}

- (void)resetNoMoreData
{
    self.state = MZRefreshFooterStateIdle;
}

- (void)setTitle:(NSString *)title forState:(MZRefreshFooterState)state
{
    if (title == nil) return;
    
    // 刷新当前状态的文字
    switch (state) {
        case MZRefreshFooterStateIdle:
            [self.loadMoreButton setTitle:title forState:UIControlStateNormal];
            break;
            
        case MZRefreshFooterStateRefreshing:
            self.stateLabel.text = title;
            break;
            
        case MZRefreshFooterStateNoMoreData:
            self.noMoreLabel.text = title;
            break;
            
        default:
            break;
    }
}

- (void)setState:(MZRefreshFooterState)state
{
    if (_state == state) return;
    
    _state = state;
    
    switch (state) {
        case MZRefreshFooterStateIdle:
            self.noMoreLabel.hidden = YES;
            self.stateLabel.hidden = YES;
            self.loadMoreButton.hidden = NO;
            break;
            
        case MZRefreshFooterStateRefreshing:
        {
            self.loadMoreButton.hidden = YES;
            self.noMoreLabel.hidden = YES;
            if (!self.stateHidden) self.stateLabel.hidden = NO;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                if (self.refreshingBlock) {
                    self.refreshingBlock();
                }
                if ([self.refreshingTarget respondsToSelector:self.refreshingAction]) {
                    msgSend(msgTarget(self.refreshingTarget), self.refreshingAction, self);
                }
            });
        }
            break;
            
        case MZRefreshFooterStateNoMoreData:
            self.loadMoreButton.hidden = YES;
            self.noMoreLabel.hidden = NO;
            self.stateLabel.hidden = YES;
            break;
            
        default:
            break;
    }
}

- (void)setTextColor:(UIColor *)textColor
{
    [super setTextColor:textColor];
    
    self.stateLabel.textColor = textColor;
    [self.loadMoreButton setTitleColor:textColor forState:UIControlStateNormal];
    self.noMoreLabel.textColor = textColor;
}

- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    
    self.loadMoreButton.titleLabel.font = font;
    self.noMoreLabel.font = font;
    self.stateLabel.font = font;
}

- (void)setStateHidden:(BOOL)stateHidden
{
    _stateHidden = stateHidden;
    
    self.stateLabel.hidden = stateHidden;
    [self setNeedsLayout];
}
@end
