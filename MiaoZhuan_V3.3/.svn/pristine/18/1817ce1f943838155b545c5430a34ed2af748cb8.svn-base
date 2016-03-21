//
//  BuyAccurateAdsViewController.m
//  miaozhuan
//
//  Created by 孙向前 on 14-11-14.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "BuyAccurateAdsViewController.h"
#import "BuyAdsListCell.h"
#import "BuyAdsListViewController.h"
#import "ConfirmOrderViewController.h"
#import "RRLineView.h"
#import "RRAttributedString.h"

@interface BuyAccurateAdsViewController ()<UITextFieldDelegate>
{
    DictionaryWrapper * result;
    
    float money;
    
    int MaxCount;
    
    int MinCount;
}

@property (retain, nonatomic) IBOutlet UILabel *lblNum;
@property (retain, nonatomic) IBOutlet UITextField *numText;
@property (retain, nonatomic) IBOutlet UILabel *numLable;
@property (retain, nonatomic) IBOutlet UILabel *moneyLable;
- (IBAction)btnBuy:(id)sender;

@end

@implementation BuyAccurateAdsViewController

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigateTitle:@"购买红包广告条数"];
    [self setupMoveBackButton];
    [self setupMoveFowardButtonWithImage:@"购买记录.png" In:@"购买记录hover.png"];
    
    [_numText setRoundCorner:5.f];
    _numText.delegate = self;
    [self addDoneToKeyboard:_numText];
}

-(void)hiddenKeyboard
{
    int num = [_numText.text intValue];
    
    if (num < MinCount)
    {
        _numText.text = [NSString stringWithFormat:@"%d",MinCount];
    }
    else if (num > MaxCount)
    {
        _numText.text = [NSString stringWithFormat:@"%d",MaxCount];
    }
    
    [self setNumTextLable:[_numText.text intValue]];
    
    [_numText resignFirstResponder];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    ADAPI_DirectAdvert_Snap([GLOBAL_DELEGATOR_MANAGER addDelegator:self selector:@selector(handleDiretAdSnap:)]);
    
    ADAPI_adv3_3_DirectAdvert_GetPrice([GLOBAL_DELEGATOR_MANAGER addDelegator:self selector:@selector(handleDiretAdSnap:)]);
}

- (void)handleDiretAdSnap:(DelegatorArguments *)arguments
{
    if ([arguments isEqualToOperation:ADOP_DirectAdvert_Snap])
    {
        [arguments logError];
        DictionaryWrapper* dic = arguments.ret;
        if (dic.operationSucceed)
        {
            _lblNum.text = [NSString stringWithFormat:@"%@条", [dic.data getString:@"Remain"]];
            
        } else {
            
            [HUDUtil showErrorWithStatus:dic.operationMessage];
            return;
        }
    }
    else if ([arguments isEqualToOperation:ADOP_adv3_3_DirectAdvert_GetPrice])
    {
        [arguments logError];
        DictionaryWrapper* dic = arguments.ret;
        if (dic.operationSucceed)
        {
            result = dic.data;
            [result retain];
            [self getData];
        }
        else
        {
            
            [HUDUtil showErrorWithStatus:dic.operationMessage];
            return;
        }
    }
}

-(void) getData;
{
    _numText.text = [NSString stringWithFormat:@"%d",[result getInt:@"DefaultCount"] / [result getInt:@"UnitValue"]];
    
    _numLable.text = [NSString stringWithFormat:@"%@条",[result getString:@"UnitName"]];
    
    [self setNumTextLable:[_numText.text intValue]];
    
    MaxCount = [result getInt:@"MaxCount"] / [result getInt:@"UnitValue"];
    
    MinCount = [result getInt:@"MinCount"] / [result getInt:@"UnitValue"];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
{
    NSMutableString *text0 = [[textField.text mutableCopy] autorelease];
    [text0 replaceCharactersInRange:range withString:string];
    
    int txtNum = [text0 intValue];
    
    [self setNumTextLable:txtNum];
    
    return YES;
}

-(void) setNumTextLable:(int)text
{
    money = (float) text * [result getDouble:@"Price"] * [result getInt:@"UnitValue"];
    NSString * moneyS = [NSString stringWithFormat:@"%.2f",money];
    _moneyLable.text = [NSString stringWithFormat:@"将花费 %.2f 元钱",money];
    
    NSAttributedString * nowattributedStringFour = [RRAttributedString setText:_moneyLable.text color:AppColorRed range:NSMakeRange(4, moneyS.length)];
    
    _moneyLable.attributedText = nowattributedStringFour;

}

- (IBAction)btnBuy:(id)sender
{
    [self hiddenKeyboard];
    
    //购买数量
    NSString *count = [NSString stringWithFormat:@"%d",[_numText.text intValue] * [result getInt:@"UnitValue"]] ;
    //跳转去购买
    NSDictionary *dic = @{@"OrderType" : @"6", @"ItemCount" : count};
    ADAPI_Payment_GoCommonOrderShow([GLOBAL_DELEGATOR_MANAGER addDelegator:self selector:@selector(handleGoCommonOrderShow:)], dic);
}

//购买记录
- (void)onMoveFoward:(UIButton *)sender{
    PUSH_VIEWCONTROLLER(BuyAdsListViewController);
}

#pragma mark - 购买
- (void)handleGoCommonOrderShow:(DelegatorArguments *)arguments{
    DictionaryWrapper *dic = arguments.ret;
    if (dic.operationSucceed) {
        PUSH_VIEWCONTROLLER(ConfirmOrderViewController);
        model.type = 3;
        model.goodsInfo = @[@{@"name" : [dic.data getString:@"ProductName"], @"num" : @"1"}];
        model.payDic = @{@"OrderSerialNo" : @"", @"OrderType" : @"6", @"ItemCount" : [dic.data getString:@"ItemCount"]};
        model.orderInfoDic = dic.data;
    } else {
        [HUDUtil showErrorWithStatus:dic.operationMessage];
        return;
    }
}

#pragma mark - 内存管理
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc {
    [_lblNum release];
    [_numText release];
    [_numLable release];
    [_moneyLable release];
    [result release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setLblNum:nil];

    [super viewDidUnload];
}

@end
