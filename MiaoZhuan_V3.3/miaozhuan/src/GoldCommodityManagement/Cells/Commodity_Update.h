//
//  Commodity_Update.h
//  miaozhuan
//
//  Created by xm01 on 14-12-29.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModelData.h"

@interface Commodity_Update : UIViewController<UITextFieldDelegate>
{
    NSMutableArray    *_textField_array;
    
    NSMutableArray  *_data;
    
    UIScrollView    *_scrollView;
    UIView          *_topView;
    UIView          *_bottomView;
    
    UIButton        *_radio_0;
    UIButton        *_radio_1;
    
    int       _OfflineType;
    
    UpdateModel     *_updateModel;
    NSArray         *_uploadList;
    
    UITextField     *_tf_deliveryPrice;
    UILabel         *_lab_time;
    
    UIView          *_dateView;
    UIDatePicker    *_datePicker;
    
    BOOL keyBordIsShow;
}

@property(nonatomic, retain) UpdateModel    *updateModel;
@property(nonatomic, retain) NSArray        *uploadList;

@property(nonatomic, retain) NSMutableArray *price_array;              //存放代码生成的 textField
@property(nonatomic, retain) NSMutableArray *onhandQty_array;          //存放代码生成的 textField

@property(nonatomic, retain) IBOutlet UIScrollView  *scrollView;
@property(nonatomic, retain) IBOutlet UIView        *topView;
@property(nonatomic, retain) IBOutlet UIView        *bottomView;

@property(nonatomic, retain) IBOutlet UIButton      *radio_1;
@property(nonatomic, retain) IBOutlet UIButton      *radio_2;

@property(nonatomic, retain) IBOutlet UITextField   *tf_deliveryPrice;
@property(nonatomic, retain) IBOutlet UILabel       *lab_time;

//@property(nonatomic, retain) IBOutlet UIView        *dateView;

@property(nonatomic, retain) NSMutableArray *data;

@end
