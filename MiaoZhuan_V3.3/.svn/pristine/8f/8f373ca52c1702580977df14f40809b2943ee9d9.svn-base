//  代码地址: https://github.com/CoderMZLee/MZRefresh
//  代码地址: http://code4app.com/ios/%E5%BF%AB%E9%80%9F%E9%9B%86%E6%88%90%E4%B8%8B%E6%8B%89%E4%B8%8A%E6%8B%89%E5%88%B7%E6%96%B0/52326ce26803fabc46000000
//  UIScrollView+MZRefresh.m
//  MZRefreshExample
//
//  Created by MZ Lee on 15/3/4.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "UIScrollView+MZRefresh.h"
#import "MZRefreshGifHeader.h"
#import "MZRefreshLegendHeader.h"
#import "MZRefreshGifFooter.h"
#import "MZRefreshLegendFooter.h"
#import <objc/runtime.h>

@implementation UIScrollView (MZRefresh)
#pragma mark - 下拉刷新
- (MZRefreshLegendHeader *)addLegendHeaderWithRefreshingBlock:(void (^)())block dateKey:(NSString *)dateKey
{
    MZRefreshLegendHeader *header = [self addLegendHeader];
    header.refreshingBlock = block;
    header.dateKey = dateKey;
    return header;
}

- (MZRefreshLegendHeader *)addLegendHeaderWithRefreshingTarget:(id)target refreshingAction:(SEL)action dateKey:(NSString *)dateKey
{
    MZRefreshLegendHeader *header = [self addLegendHeader];
    header.refreshingTarget = target;
    header.refreshingAction = action;
    header.dateKey = dateKey;
    return header;
}

- (MZRefreshLegendHeader *)addLegendHeaderWithRefreshingTarget:(id)target refreshingAction:(SEL)action
{
    return [self addLegendHeaderWithRefreshingTarget:target refreshingAction:action dateKey:nil];
}

- (MZRefreshLegendHeader *)addLegendHeaderWithRefreshingBlock:(void (^)())block
{
    return [self addLegendHeaderWithRefreshingBlock:block dateKey:nil];
}

- (MZRefreshLegendHeader *)addLegendHeader
{
    MZRefreshLegendHeader *header = [[MZRefreshLegendHeader alloc] init];
    self.header = header;
    
    return header;
}

- (MZRefreshGifHeader *)addGifHeaderWithRefreshingBlock:(void (^)())block dateKey:(NSString *)dateKey
{
    MZRefreshGifHeader *header = [self addGifHeader];
    header.refreshingBlock = block;
    header.dateKey = dateKey;
    return header;
}

- (MZRefreshGifHeader *)addGifHeaderWithRefreshingTarget:(id)target refreshingAction:(SEL)action dateKey:(NSString *)dateKey
{
    MZRefreshGifHeader *header = [self addGifHeader];
    header.refreshingTarget = target;
    header.refreshingAction = action;
    header.dateKey = dateKey;
    return header;
}

- (MZRefreshGifHeader *)addGifHeaderWithRefreshingBlock:(void (^)())block
{
    return [self addGifHeaderWithRefreshingBlock:block dateKey:nil];
}

- (MZRefreshGifHeader *)addGifHeaderWithRefreshingTarget:(id)target refreshingAction:(SEL)action
{
    return [self addGifHeaderWithRefreshingTarget:target refreshingAction:action dateKey:nil];
}

- (MZRefreshGifHeader *)addGifHeader
{
    MZRefreshGifHeader *header = [[MZRefreshGifHeader alloc] init];
    self.header = header;
    
    return header;
}

- (void)removeHeader
{
    self.header = nil;
}

#pragma mark - Property Methods
#pragma mark gifHeader
- (MZRefreshGifHeader *)gifHeader
{
    if ([self.header isKindOfClass:[MZRefreshGifHeader class]]) {
        return (MZRefreshGifHeader *)self.header;
    }
    
    return nil;
}

#pragma mark legendHeader
- (MZRefreshLegendHeader *)legendHeader
{
    if ([self.header isKindOfClass:[MZRefreshLegendHeader class]]) {
        return (MZRefreshLegendHeader *)self.header;
    }
    
    return nil;
}

#pragma mark header
static char MZRefreshHeaderKey;
- (void)setHeader:(MZRefreshHeader *)header
{
    if (header != self.header) {
        [self.header removeFromSuperview];
        
        [self willChangeValueForKey:@"header"];
        objc_setAssociatedObject(self, &MZRefreshHeaderKey,
                                 header,
                                 OBJC_ASSOCIATION_ASSIGN);
        [self didChangeValueForKey:@"header"];
        
        [self addSubview:header];
    }
}

- (MZRefreshHeader *)header
{
    return objc_getAssociatedObject(self, &MZRefreshHeaderKey);
}

#pragma mark - 上拉刷新
- (MZRefreshLegendFooter *)addLegendFooterWithRefreshingBlock:(void (^)())block
{
    MZRefreshLegendFooter *footer = [self addLegendFooter];
    footer.refreshingBlock = block;
    return footer;
}

- (MZRefreshLegendFooter *)addLegendFooterWithRefreshingTarget:(id)target refreshingAction:(SEL)action
{
    MZRefreshLegendFooter *footer = [self addLegendFooter];
    footer.refreshingTarget = target;
    footer.refreshingAction = action;
    return footer;
}

- (MZRefreshLegendFooter *)addLegendFooter
{
    MZRefreshLegendFooter *footer = [[MZRefreshLegendFooter alloc] init];
    self.footer = footer;
    
    return footer;
}

- (MZRefreshGifFooter *)addGifFooterWithRefreshingBlock:(void (^)())block
{
    MZRefreshGifFooter *footer = [self addGifFooter];
    footer.refreshingBlock = block;
    return footer;
}

- (MZRefreshGifFooter *)addGifFooterWithRefreshingTarget:(id)target refreshingAction:(SEL)action
{
    MZRefreshGifFooter *footer = [self addGifFooter];
    footer.refreshingTarget = target;
    footer.refreshingAction = action;
    return footer;
}

- (MZRefreshGifFooter *)addGifFooter
{
    MZRefreshGifFooter *footer = [[MZRefreshGifFooter alloc] init];
    self.footer = footer;
    
    return footer;
}

- (void)removeFooter
{
    self.footer = nil;
}

static char MZRefreshFooterKey;
- (void)setFooter:(MZRefreshFooter *)footer
{
    if (footer != self.footer) {
        [self.footer removeFromSuperview];
        
        [self willChangeValueForKey:@"footer"];
        objc_setAssociatedObject(self, &MZRefreshFooterKey,
                                 footer,
                                 OBJC_ASSOCIATION_ASSIGN);
        [self didChangeValueForKey:@"footer"];
        
        [self addSubview:footer];
    }
}

- (MZRefreshGifFooter *)gifFooter
{
    if ([self.footer isKindOfClass:[MZRefreshGifFooter class]]) {
        return (MZRefreshGifFooter *)self.footer;
    }
    return nil;
}

- (MZRefreshLegendFooter *)legendFooter
{
    if ([self.footer isKindOfClass:[MZRefreshLegendFooter class]]) {
        return (MZRefreshLegendFooter *)self.footer;
    }
    return nil;
}


- (MZRefreshFooter *)footer
{
    return objc_getAssociatedObject(self, &MZRefreshFooterKey);
}

#pragma mark - swizzle
+ (void)load
{
    Method method1 = class_getInstanceMethod([self class], NSSelectorFromString(@"dealloc"));
    Method method2 = class_getInstanceMethod([self class], @selector(deallocSwizzle));
    method_exchangeImplementations(method1, method2);
}

- (void)deallocSwizzle
{
    [self removeFooter];
    [self removeHeader];
    
    [self deallocSwizzle];
}

@end


#pragma mark - 1.0.0版本以前的接口
@implementation UIScrollView(MZRefreshDeprecated)
#pragma mark - 下拉刷新
/**
 *  添加一个下拉刷新头部控件
 *
 *  @param callback 回调
 */
- (void)addHeaderWithCallback:(void (^)())callback
{
    [self addHeaderWithCallback:callback dateKey:nil];
}

/**
 *  添加一个下拉刷新头部控件
 *
 *  @param callback 回调
 *  @param dateKey 刷新时间保存的key值
 */
- (void)addHeaderWithCallback:(void (^)())callback dateKey:(NSString*)dateKey
{
    [self addLegendHeader];
    self.header.dateKey = dateKey;
    self.header.refreshingBlock = callback;
}

/**
 *  添加一个下拉刷新头部控件
 *
 *  @param target 目标
 *  @param action 回调方法
 */
- (void)addHeaderWithTarget:(id)target action:(SEL)action
{
    [self addHeaderWithTarget:target action:action dateKey:nil];
}

/**
 *  添加一个下拉刷新头部控件
 *
 *  @param target 目标
 *  @param action 回调方法
 *  @param dateKey 刷新时间保存的key值
 */
- (void)addHeaderWithTarget:(id)target action:(SEL)action dateKey:(NSString*)dateKey
{
    [self addLegendHeader];
    self.header.dateKey = dateKey;
    [self.header setRefreshingTarget:target refreshingAction:action];
}

/**
 *  主动让下拉刷新头部控件进入刷新状态
 */
- (void)headerBeginRefreshing
{
    [self.header beginRefreshing];
}

/**
 *  让下拉刷新头部控件停止刷新状态
 */
- (void)headerEndRefreshing
{
    [self.header endRefreshing];
}

/**
 *  下拉刷新头部控件的可见性
 */
- (void)setHeaderHidden:(BOOL)headerHidden
{
    self.header.hidden = headerHidden;
}

- (BOOL)isHeaderHidden
{
    return self.header.isHidden;
}

/**
 *  是否正在下拉刷新
 */
- (BOOL)isHeaderRefreshing
{
    return self.header.isRefreshing;
}

#pragma mark - 上拉刷新
/**
 *  添加一个上拉刷新尾部控件
 *
 *  @param callback 回调
 */
- (void)addFooterWithCallback:(void (^)())callback
{
    [self addLegendFooter];
    self.footer.refreshingBlock = callback;
}

/**
 *  添加一个上拉刷新尾部控件
 *
 *  @param target 目标
 *  @param action 回调方法
 */
- (void)addFooterWithTarget:(id)target action:(SEL)action
{
    [self addLegendFooter];
    [self.footer setRefreshingTarget:target refreshingAction:action];
}

/**
 *  主动让上拉刷新尾部控件进入刷新状态
 */
- (void)footerBeginRefreshing
{
    [self.footer beginRefreshing];
}

/**
 *  让上拉刷新尾部控件停止刷新状态
 */
- (void)footerEndRefreshing
{
    [self.footer endRefreshing];
}

/**
 *  上拉刷新头部控件的可见性
 */
- (void)setFooterHidden:(BOOL)footerHidden
{
    self.footer.hidden = footerHidden;
}

- (BOOL)isFooterHidden
{
    return self.footer.isHidden;
}

/**
 *  是否正在上拉刷新
 */
- (BOOL)isFooterRefreshing
{
    return self.footer.isRefreshing;
}
@end
