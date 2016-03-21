//
//  CRButtonContainer.h
//  CRCoreUnit
//
//  Created by abyss on 14/12/19.
//  Copyright (c) 2014年 Abyss Roger. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


#define cr_buttonObjectArray (_buttonContainer.dataArray)
@protocol CRButtonContainerDelegate;
@interface CRButtonContainer : NSObject

@property (assign, readonly) Class buttonClass;
@property (retain, readonly) NSMutableArray *dataArray;


@property (assign) NSInteger height;
@property (assign) BOOL needCheckReTouch;
@property (assign) NSInteger needAutoawak;                          //defualt is -1, no
@property (retain, nonatomic) NSMutableArray*      buttonArray;            //NSString or NSDictionary,if it is NSDictionary,has key "title"
@property (assign) id<CRButtonContainerDelegate> cr_delegate;

- (instancetype)initWith:(NSArray *)buttonArray delegate:(id<CRButtonContainerDelegate>)delegate height:(CGFloat)height;

- (void)needAutoawakNow;
- (void)exchangeButton:(NSInteger)changeIndex to:(NSInteger)arrayIndex;
@end


@protocol CRButtonContainerDelegate <NSObject>
@optional

- (UIButton *)buttonContainer:(CRButtonContainer *)view willbuttonCustomBy:(CGFloat)height;
- (UIButton *)buttonContainer:(CRButtonContainer *)view the:(id)button shouldLayoutBy:(NSDictionary *)data;

- (void)buttonContainer:(CRButtonContainer *)view willRefreshData:(BOOL)shouldRemoveAllButtonsBefore;
- (void)buttonContainer:(CRButtonContainer *)view button:(id)button shouldResponseButtonTouchAt:(NSInteger)buttonIndex;

@end

extern CGFloat CRButtonContainer_Height;