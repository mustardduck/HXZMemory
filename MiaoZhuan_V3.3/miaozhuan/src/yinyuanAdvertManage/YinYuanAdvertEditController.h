//
//  YinYuanAdvertEditController.h
//  miaozhuan
//
//  Created by momo on 14-11-19.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Redbutton.h"
#import "YinYuanDelegate.h"
#import "DatePickerViewController.h"

@class CRInfoNotify;

@interface YinYuanAdvertEditController : DotCViewController<YinYuanProdDelegate, DatePickerDelegate, YinYuanAdvertDelegate, UITextFieldDelegate, YinYuanProductBindingDelegate, UIActionSheetDelegate, UIAlertViewDelegate>
{
    NSMutableDictionary *_srcData;
    
    DatePickerViewController * _datePickerView;
    
    int _sexType;
    
    BOOL _isFirstResponder;
    
    NSInteger _textFeildTouchedY;
    
    UITextField *_activeField;
    
    CGPoint perPos;
    
    UIButton *fullSrcBtn;
    
    NSMutableArray * _bindingProdArr;
    
    NSMutableArray * _PushRegionals;
    
    CRInfoNotify * _titleNotify;
    CRInfoNotify * _sloganNotify;
    CRInfoNotify * _keywordNotify;
    CRInfoNotify * _contentNotify;
    CRInfoNotify * _linkNotify;
    CRInfoNotify * _telNotify;
    CRInfoNotify * _addressNotify;
    
    NSMutableDictionary * _notifyPicMsg;
}

@property (retain, nonatomic) IBOutlet UIImageView *tabimageView;
@property (retain, nonatomic) IBOutlet Redbutton *commitBtn;

@property (retain, nonatomic) IBOutlet UIView *firstView;
@property (retain, nonatomic) IBOutlet UIView *firstTopView;
@property (retain, nonatomic) IBOutlet UITextField *titleField;
@property (retain, nonatomic) IBOutlet UIScrollView *picSubScrollView;
@property (retain, nonatomic) IBOutlet UIView *firstBottomView;
@property (retain, nonatomic) IBOutlet UITextField *sloganField;
@property (retain, nonatomic) IBOutlet UITextField *keywordField;
@property (retain, nonatomic) IBOutlet UIButton *desBtn;
@property (retain, nonatomic) IBOutlet UITextField *webField;
@property (retain, nonatomic) IBOutlet UIImageView *telIcon;
@property (retain, nonatomic) IBOutlet UIButton *telIconBtn;
@property (retain, nonatomic) IBOutlet UIImageView *addressIcon;
@property (retain, nonatomic) IBOutlet UIButton *addressIconBtn;
@property (retain, nonatomic) IBOutlet UIButton *readmeBtn;
@property (retain, nonatomic) IBOutlet UITextField *telField;
@property (retain, nonatomic) IBOutlet UITextField *addressField;


@property (retain, nonatomic) IBOutlet UIView *secondView;
@property (retain, nonatomic) IBOutlet UIButton *bindingProdBtn;
@property (retain, nonatomic) IBOutlet UITextField *totalCountField;
@property (retain, nonatomic) IBOutlet UITextField *dayCountField;
@property (retain, nonatomic) IBOutlet UIButton *startDateBtn;
@property (retain, nonatomic) IBOutlet UIButton *endDateBtn;
@property (retain, nonatomic) IBOutlet UIButton *areaBtn;
@property (retain, nonatomic) IBOutlet UIButton *userBtn;

@property (retain, nonatomic) IBOutlet UIButton *firstBtn;
@property (retain, nonatomic) IBOutlet UIButton *secondBtn;
@property (retain, nonatomic) IBOutlet UIScrollView *mainScrollView;

@property (retain, nonatomic) NSString * ADsDes;

@property (nonatomic, retain) NSDate *startDate;
@property (nonatomic, retain) NSDate *endDate;

@property (assign, nonatomic) BOOL isEdit;

@property (retain, nonatomic) NSMutableDictionary * userDic;

@property (retain, nonatomic) NSString * isVerify;

@property (assign) BOOL isAlert;

@property (retain, nonatomic) NSString * advertId;

@property (assign) BOOL isFail;

- (IBAction)touchUpInsideOnBtn:(id)sender;


@end
