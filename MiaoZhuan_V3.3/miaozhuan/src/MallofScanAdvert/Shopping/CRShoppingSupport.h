//
//  CRShoppingSupport.h
//  miaozhuan
//
//  Created by abyss on 14/12/20.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CRHeaderView;
@class CRSelectTable;
@class CRShoppingContentView;
@protocol CRShoppingSupportDeledate;
@interface CRShoppingSupport : NSObject
@property (assign, nonatomic) UIViewController* father;

@property (assign) BOOL         needRefresh;
@property (assign, readonly) NSInteger      pageIndex;
@property (retain, readonly) UITableView*   tableView;
@property (retain, readonly) CRHeaderView*  headerView;
@property (retain, readonly) CRSelectTable* selectTable;
@property (retain, readonly) CRHeaderView*  contentSection;
@property (retain, readonly) CRShoppingContentView* shoppingContent;
@property (retain, readonly) NSArray*       netArray;

@property (retain)           UIView*        goldHeaderp;

@property (assign) id<CRShoppingSupportDeledate> cr_delegate;
@property (assign)           NSInteger      startPage;

- (void)setHeaderView;
- (void)setContentSection;
- (void)setSelectTable;

- (UITableView *)configureTableView:(UITableView *)tableView;
@end

@protocol CRShoppingSupportDeledate <NSObject>
@optional
- (void) shouldChangePageViewTo:(NSInteger)pageIndex;
@end

#define cr_CleanViewBefore() if (_pageView) [_pageView removeFromSuperview]