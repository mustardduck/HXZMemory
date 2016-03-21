//
//  CRShoppingContentView.h
//  miaozhuan
//
//  Created by abyss on 14/12/26.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CRShoppingContentViewDelegate;
@interface CRShoppingContentView : UIView
@property (retain, readonly) NSMutableArray* visiableButtons;
@property (retain, readonly) NSMutableArray* unVisiableButtons;
@property (assign) id<CRShoppingContentViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)headFrame
                         with:(NSArray *)buttonArray
                     delegate:(id<CRShoppingContentViewDelegate>)delegate;
@end

@protocol CRShoppingContentViewDelegate <NSObject>
@optional
- (void)shoppingContentView:(CRShoppingContentView *)view button:(id)button didTouchAt:(NSInteger)buttonIndex data:(NSString *)data;
@end