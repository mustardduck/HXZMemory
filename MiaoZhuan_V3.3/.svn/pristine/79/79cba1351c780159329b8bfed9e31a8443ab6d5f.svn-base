//
//  YinYuanAdvertBindingProdController.h
//  miaozhuan
//
//  Created by momo on 14-12-1.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Redbutton.h"
#import "YinYuanDelegate.h"
#import "MJRefreshController.h"

@interface YinYuanAdvertBindingProdController : DotCViewController<UITextFieldDelegate>
{
    NSMutableArray *_listArr;
        
    NSMutableDictionary *_selNumDic;
    
    NSInteger _selIndex;
    
    MJRefreshController * _MJRefreshCon;
    
    NSMutableArray * _selArr;
}
@property (retain, nonatomic) IBOutlet UITableView *mainTableView;
@property (retain, nonatomic) IBOutlet Redbutton *okBtn;
@property (retain, nonatomic) IBOutlet UILabel *jinbiTotalLbl;
@property (retain, nonatomic) IBOutlet UILabel *yinyuanTotalLbl;
@property (assign) id<YinYuanProductBindingDelegate> delegate;

@property (retain, nonatomic) NSString * titleName;

@property (assign, nonatomic) BOOL isZhiGou;

@property (retain, nonatomic) NSMutableArray * selProdArr;

- (IBAction)touchUpInsideOnBtn:(id)sender;

@end
