//
//  AddConvertCenterViewController.h
//  miaozhuan
//
//  Created by Santiago on 14-11-15.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YinYuanDelegate.h"

typedef enum
{
    CREAT_CONVERT_CENTER,
    EDIT_CONVERT_CENTER_ALREDY_HAVE
} ConvertStyle;
@protocol EndEditingConvertCenter <NSObject>

@optional
- (void)refreshList;

- (void)refreshListWithSelectId:(NSString *)selectId;

@end


@interface AddConvertCenterViewController : DotCViewController

@property(nonatomic, assign) ConvertStyle style;
@property(nonatomic, assign) int convertCenterId;
@property(nonatomic, assign) id<EndEditingConvertCenter>delegate;

@property (assign) id<YinYuanSelectExPointDelegate> yinYuanDelegate;

@property (nonatomic, assign) BOOL isYinYuanProduct;
@end