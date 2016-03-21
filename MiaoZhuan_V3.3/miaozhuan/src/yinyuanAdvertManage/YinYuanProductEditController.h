//
//  YinYuanProductEditController.h
//  miaozhuan
//
//  Created by momo on 14-11-15.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YinYuanDelegate.h"
#import "Redbutton.h"
#import "NetImageView.h"
#import "RRLineView.h"

@class CRInfoNotify;

@interface YinYuanProductEditController : DotCViewController<UIActionSheetDelegate, YinYuanProdDelegate, UITextFieldDelegate, YinYuanProductCategoreyDelegate, UITableViewDataSource, UITableViewDelegate, YinYuanSelectExPointDelegate, UIAlertViewDelegate>
{
    int _dayCount;
    
    int _totalCount;
    
    BOOL _isFirstResponder;
    
    NSInteger _textFeildTouchedY;
    
    UITextField *_activeField;

    CGPoint perPos;
    
    UIButton *fullSrcBtn;

    NSMutableDictionary *_srcData;

    NSMutableArray * _exPointsArr;
    
    NSString * _isVerify;
    
    int _exType;
    
    BOOL _isChengNuo;

    CRInfoNotify * _titleNotify;
    CRInfoNotify * _categoryNotify;
    CRInfoNotify * _desNotify;
    CRInfoNotify * _unitPriceNotify;
    
    NSMutableDictionary * _notifyPicMsg;
}

@property (retain, nonatomic) IBOutlet UIScrollView *mainScrollView;
@property (retain, nonatomic) IBOutlet UIView *mainView;
@property (retain, nonatomic) IBOutlet UITextField *prodNameField;
@property (retain, nonatomic) IBOutlet UIButton *cateBtn;
@property (retain, nonatomic) IBOutlet UIView *picMainView;
@property (retain, nonatomic) IBOutlet UIView *picView;
@property (retain, nonatomic) IBOutlet UIScrollView *picScrollView;
@property (retain, nonatomic) IBOutlet UIView *topView;
@property (retain, nonatomic) IBOutlet UIView *bottomView;
@property (retain, nonatomic) IBOutlet UITableView *duihuanTableView;
@property (retain, nonatomic) IBOutlet UIButton *prodDesBtn;
@property (retain, nonatomic) IBOutlet UITextField *prodPriceField;
@property (retain, nonatomic) IBOutlet UILabel *prodYinyuanLbl;
@property (retain, nonatomic) IBOutlet UIButton *duihuanLimitBtn;
@property (retain, nonatomic) IBOutlet UIButton *xianchangDuihuanBtn;
@property (retain, nonatomic) IBOutlet UIImageView *xianchangIcon;
@property (retain, nonatomic) IBOutlet UIButton *youjiDuihuanBtn;
@property (retain, nonatomic) IBOutlet UIImageView *youjiIcon;
@property (retain, nonatomic) IBOutlet UIView *duihuanDianView;
@property (retain, nonatomic) IBOutlet UIButton *duihuanDianBtn;

@property (retain, nonatomic) NSString * productDes;
@property (retain, nonatomic) IBOutlet Redbutton *commitBtn;
@property (retain, nonatomic) UIImage * promiseImage;
@property (assign, nonatomic) BOOL isEdit;
@property (retain, nonatomic) NSString * productId;
@property (retain, nonatomic) IBOutlet NetImageView *promiseImageView;
@property (retain, nonatomic) NSString * promisePicUrl;
@property (retain, nonatomic) IBOutlet UIView *bottomSubView;
@property (assign) BOOL isAlert;
@property (assign) BOOL isFail;

- (IBAction)touchUpInsideOnBtn:(id)sender;

@end
