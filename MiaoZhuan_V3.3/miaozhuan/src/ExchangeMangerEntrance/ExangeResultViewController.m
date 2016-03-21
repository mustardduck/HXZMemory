//
//  ExangeResultViewController.m
//  miaozhuan
//
//  Created by apple on 14/12/5.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "ExangeResultViewController.h"
#import "Redbutton.h"
#import "RRAttributedString.h"
#import "RRLineView.h"

@interface ExangeResultViewController ()<UIAlertViewDelegate>
{
    DictionaryWrapper * result;
}
@property (retain, nonatomic) IBOutlet UILabel *exangeNameLable;
@property (retain, nonatomic) IBOutlet UILabel *exangeNeedYinyuan;
@property (retain, nonatomic) IBOutlet UILabel *exangeNumLable;
@property (retain, nonatomic) IBOutlet UILabel *exangeTime;
@property (retain, nonatomic) IBOutlet UILabel *userNameLable;
@property (retain, nonatomic) IBOutlet UILabel *phoneLable;
@property (retain, nonatomic) IBOutlet UILabel *orderNumLable;
@property (retain, nonatomic) IBOutlet RRLineView *lineImageOne;
@property (retain, nonatomic) IBOutlet UIView *viewOne;
@property (retain, nonatomic) IBOutlet UIView *viewTwo;
@property (retain, nonatomic) IBOutlet RRLineView *lineImageTop;
@property (retain, nonatomic) IBOutlet UIView *showView;


- (IBAction)touchUpInside:(id)sender;

@property (retain, nonatomic) IBOutlet Redbutton *okBtn;

@end

@implementation ExangeResultViewController

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    InitNav(@"兑换信息结果");
    
    ADAPI_adv3_ExchangeManagement_GetExchangeRecordDetail([self genDelegatorID:@selector(HandleNotification:)],_OrderNumber,_ExchangeAddressId);
}

- (void)HandleNotification:(DelegatorArguments *)arguments
{
    if ([arguments isEqualToOperation:ADOP_adv3_ExchangeManagement_GetExchangeRecordDetail])
    {
        [arguments logError];
        
        DictionaryWrapper *wrapper = arguments.ret;
        
        if (wrapper.operationSucceed)
        {
            result = wrapper.data;
            
            [result retain];
            
             [self setResult:result];
        }
        else if (wrapper.operationErrorCode || wrapper.operationPromptCode)
        {
            [AlertUtil showAlert:@"" message:wrapper.operationMessage buttons:@[@"好的"]];
            
            _okBtn.backgroundColor = RGBCOLOR(153, 153, 153);
            _okBtn.enabled = NO;
            [self.navigationController popViewControllerAnimated:YES];
            return;
        }
    }
    else if ([arguments isEqualToOperation:ADOP_adv3_ExchangeManagement_ConfirmExchange])
    {
        [arguments logError];
        
        DictionaryWrapper *wrapper = arguments.ret;
        
        if (wrapper.operationSucceed)
        {
            [HUDUtil showSuccessWithStatus:wrapper.operationMessage];
            
            [self.navigationController popViewControllerAnimated:YES];
        }
        else if(wrapper.operationPromptCode || wrapper.operationErrorCode)
        {
            [AlertUtil showAlert:@"" message:wrapper.operationMessage buttons:@[@"好的"]];
        }
    }
}

-(void) setResult:(DictionaryWrapper *)_dic
{
    _showView.hidden = YES;
    
    if (200 <= [_dic getInt:@"OrderStatus"] && [_dic getInt:@"OrderStatus"] <=299)
    {
        _okBtn.hidden = NO;
    }
    
    _exangeNameLable.text = [_dic getString:@"ProductName"];
    
    if (_exangeNameLable.text.length <= 19)
    {
        RRLineView * one = [[RRLineView alloc] initWithFrame:CGRectMake(0, 0, 320, 0.5)];
        
        one.image = [UIImage imageNamed:@"line.png"];
        
        [_viewOne addSubview:one];
        
        
        RRLineView * two= [[RRLineView alloc] initWithFrame:CGRectMake(0, 155, 320, 0.5)];
        
        two.image = [UIImage imageNamed:@"line.png"];
        
        [_viewOne addSubview:two];
        
        _exangeNameLable.frame = CGRectMake(15, 43, 290, 16);
        
        _exangeNeedYinyuan.frame = CGRectMake(15, 68, 290, 11);
        
        _exangeNumLable.frame = CGRectMake(15, 87, 290, 11);
        
        _exangeTime.frame = CGRectMake(15, 107, 290, 11);
        
        _orderNumLable.frame = CGRectMake(15, 126, 290, 11);
        
        _viewOne.frame = CGRectMake(0, 10, 320, 155);
        
        _viewTwo.frame = CGRectMake(0, 175, 320, 90);
        
        _okBtn.frame = CGRectMake(15, 275, 290, 40);
    }
    
    _exangeNeedYinyuan.text = [NSString stringWithFormat:@"所需银元：%d",[_dic getInt:@"TotalPrice"]];
    
    _exangeNumLable.text = [NSString stringWithFormat:@"兑换数量：%d",[_dic getInt:@"Count"]];
    
    NSString * time = [_dic getString:@"OrderTime"];
    
    time = [UICommon format19Time:time];
    
    _exangeTime.text = [NSString stringWithFormat:@"下单时间：%@",time];
    
    _orderNumLable.text = [NSString stringWithFormat:@"兑换单号：%@",[_dic getString:@"OrderNumber"]];
    
    NSAttributedString * attributedString = [RRAttributedString setText:_exangeNeedYinyuan.text color:RGBCOLOR(153, 153, 153) range:NSMakeRange(0, 5)];
    
    _exangeNeedYinyuan.attributedText = attributedString;
    
    NSAttributedString * attributedStringnum = [RRAttributedString setText:_exangeNumLable.text color:RGBCOLOR(153, 153, 153) range:NSMakeRange(0, 5)];
    
    _exangeNumLable.attributedText = attributedStringnum;
    
    NSAttributedString * attributedStringtime = [RRAttributedString setText:_exangeTime.text color:RGBCOLOR(153, 153, 153) range:NSMakeRange(0, 5)];
    
    _exangeTime.attributedText = attributedStringtime;
    
    NSAttributedString * attributedStringOrderNum = [RRAttributedString setText:_orderNumLable.text color:RGBCOLOR(153, 153, 153) range:NSMakeRange(0, 5)];
    
    _orderNumLable.attributedText = attributedStringOrderNum;
   
    _userNameLable.text = [NSString stringWithFormat:@"姓名：%@",[_dic getString:@"TrueName"]];
    
    _phoneLable.text = [NSString stringWithFormat:@"电话：%@",[_dic getString:@"UserName"]];
    
    NSAttributedString * attributedStringName = [RRAttributedString setText:_userNameLable.text color:RGBCOLOR(153, 153, 153) range:NSMakeRange(0, 3)];
    
    NSAttributedString * attributedStringPhone = [RRAttributedString setText:_phoneLable.text color:RGBCOLOR(153, 153, 153) range:NSMakeRange(0, 3)];
    
    _userNameLable.attributedText = attributedStringName;
    
    _phoneLable.attributedText = attributedStringPhone;
}

- (IBAction)touchUpInside:(id)sender
{
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"" message:@"确认本次兑换吗" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    
    [alert show];
    
    [alert release];
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        NSString * enterId = [NSString stringWithFormat:@"%d",[result getInt:@"EnterpriseId"]];
        
        NSString * orderNum = [result getString:@"OrderNumber"];
        
        ADAPI_adv3_ExchangeManagement_ConfirmExchange([self genDelegatorID:@selector(HandleNotification:)], enterId, orderNum, _ExchangeAddressId, @"", @"");
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
    [result release];
    result = nil;
    [_exangeNameLable release];
    [_exangeNeedYinyuan release];
    [_exangeNumLable release];
    [_exangeTime release];
    [_userNameLable release];
    [_phoneLable release];
    [_okBtn release];
    [_orderNumLable release];
    [_lineImageOne release];
    [_viewOne release];
    [_viewTwo release];
    [_lineImageTop release];
    [_showView release];
    [super dealloc];
}

- (void)viewDidUnload
{
    [self setExangeNameLable:nil];
    [self setExangeNeedYinyuan:nil];
    [self setExangeNumLable:nil];
    [self setExangeTime:nil];
    [self setUserNameLable:nil];
    [self setPhoneLable:nil];
    [self setOkBtn:nil];
    [super viewDidUnload];
}

@end
