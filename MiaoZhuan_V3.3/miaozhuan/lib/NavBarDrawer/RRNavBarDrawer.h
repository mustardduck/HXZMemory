//
//  RRNavBarDrawer.h
//  miaozhuan
//
//  Created by 孙向前 on 14-11-3.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RRNavBarDrawerDelegate;

@interface RRNavBarDrawer : UIView

/** 抽屉视图 代理 */
@property (nonatomic, assign) id <RRNavBarDrawerDelegate> delegate;

/** 抽屉视图是否已打开 */
@property (nonatomic) BOOL isOpen;

/** 抽屉视图 位置 */
@property (nonatomic, assign) float frameX;

/**
 * 实例化抽屉视图
 * array @[@{@"normal":@"普通图片",@"hilighted":@"高亮图片",@"title":@"标题"}]
 */
- (id)initWithView:(UIView *)view andInfoArray:(NSArray *)array;

/**
 * 打开抽屉
 */
- (void)openNavBarDrawer;

/**
 * 关起抽屉
 */
- (void)closeNavBarDrawer;

@end

@protocol RRNavBarDrawerDelegate <NSObject>

@required
/** 关闭按钮 代理回调方法 */
- (void)didClickItem:(RRNavBarDrawer *)drawer atIndex:(NSInteger)index;

@end
