//
//  YinYuanAdvertEditSubController.h
//  miaozhuan
//
//  Created by momo on 14-11-19.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YinYuanDelegate.h"
#import "AgePicker.h"

@interface YinYuanAdvertEditSubController : DotCViewController<UIActionSheetDelegate, UITableViewDataSource, UITableViewDelegate, UIPickerViewDataSource,UIPickerViewDelegate, AgePickerDelegate >
{
    NSInteger _sexType;
    
    NSMutableDictionary * _srcData;
    
    NSMutableArray * _quesArr;
    
    BOOL _isQuesAll;
    
    NSMutableArray * _selQuesArr;
    
    AgePicker * _agePicker;
    
    BOOL * _isRefresh;
}

@property (retain, nonatomic) NSString * naviTitle;

@property (assign, nonatomic) NSObject<YinYuanAdvertDelegate> * delegate;
@property (retain, nonatomic) IBOutlet UIButton *sexBtn;
@property (retain, nonatomic) IBOutlet UIButton *moneyBtn;
@property (retain, nonatomic) IBOutlet UIButton *ageBtn;
@property (retain, nonatomic) IBOutlet UITableView *incomeTableview;
@property (retain, nonatomic) IBOutlet UIView *incomeView;
@property (retain, nonatomic) IBOutlet UIButton *cancelBtn;
@property (retain, nonatomic) IBOutlet UIButton *okBtn;
@property (retain, nonatomic) IBOutlet UIView *incomeSubView;
@property (retain, nonatomic) IBOutlet UIButton *fullScreenBtn;
@property (retain, nonatomic) NSMutableDictionary * userDic;

@property (assign, nonatomic) NSString * minAge;
@property (assign, nonatomic) NSString * maxAge;

- (IBAction)touchUpInsideOnBtn:(id)sender;

@end
