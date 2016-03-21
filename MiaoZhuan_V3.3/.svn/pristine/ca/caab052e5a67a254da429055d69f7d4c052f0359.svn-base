//
//  IWComplainReasonListTableViewCellStyle2.h
//  miaozhuan
//
//  Created by admin on 15/5/4.
//  Copyright (c) 2015年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RTLabel.h"

typedef void(^IWComplainReasonListTableViewCellStyle2TextViewShouldBeginInput)(void);
typedef void(^IWComplainReasonListTableViewCellStyle2TextViewShouldEndInput)(void);

#define kIWComplainReasonListTableViewCellStyle2Height 201.f

@interface IWComplainReasonListTableViewCellStyle2 : UITableViewCell<UITextViewDelegate>
@property (retain, nonatomic) IBOutlet UILabel *label_Title;
@property (retain, nonatomic) IBOutlet UIImageView *imageView_Check;
@property (retain, nonatomic) IBOutlet UITextView *textView;
@property (retain, nonatomic) IBOutlet RTLabel *view_Alert;
@property (retain, nonatomic) IBOutlet UIView *view_BottomView;
@property (strong, nonatomic) IWComplainReasonListTableViewCellStyle2TextViewShouldBeginInput textViewShouldBeginInput;
@property (strong, nonatomic) IWComplainReasonListTableViewCellStyle2TextViewShouldEndInput textViewShouldEndInput;

@end
