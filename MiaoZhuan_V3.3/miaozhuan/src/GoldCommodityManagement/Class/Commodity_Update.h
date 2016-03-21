//
//  Commodity_Update.h
//  miaozhuan
//
//  Created by xm01 on 14-12-29.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModelData.h"
#import "UserKeyboard.h"
#import "DatePickerViewController.h"

@protocol Commodity_Update_Delegate <NSObject>

//可以重新上架
-(void)resendPutaway:(BOOL)isEqual allOnhandQty:(int)allOnhandQty;

@end

@interface Commodity_Update : UIViewController

@property(nonatomic, retain) UpdateModel                        *updateModel;

@property(nonatomic, assign) id<Commodity_Update_Delegate>      delegate;

@end
