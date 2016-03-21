//
//  CRHolderView.h
//  miaozhuan
//
//  Created by abyss on 14/12/22.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>

// #Useage:
//
// [self showHolder...];

typedef void (^holderBlock) (int index);
extern NSString* CRHolderView_DefualtHolder;

@interface CRHolderView : UIView
@property (retain, readonly) NSArray* button;

@property (retain, readonly) NSString* text;
@property (retain, readonly) NSString* mainText;
@property (retain, readonly) NSString* holderImg;

- (instancetype)initWithImg:(NSString *)img
                      text1:(NSString *)mainText
                      text2:(NSString *)text
                     button:(NSArray *)button
                      block:(holderBlock)block;

- (void)display:(BOOL)show;

@end



@interface UIViewController (CRUnit)

- (void)showHolderDefault;
- (void)showHolderWithImg:(NSString *)imgName text2:(NSString *)text;
- (void)showHolderWithImg:(NSString *)imgName text1:(NSString *)mainText text2:(NSString *)text;
- (void)showHolderWithImg:(NSString *)imgName
                    text1:(NSString *)mainText
                    text2:(NSString *)text
                   button:(NSArray *)buttonArray
                    block:(holderBlock)block;

- (void)displayHoder:(BOOL)show;
- (void)setHolderDefaultHight:(CGFloat)height;
@end


#define CRHolderFast_MJ(_dowhat)\
if (controller.refreshCount == 0) {_dowhat}\
else {[self displayHoder:NO];}\

#define CRHolderFast_MJ_Default()\
if (controller.refreshCount == 0) {[weakself showHolderDefault];}\
else {[self displayHoder:NO];}\
