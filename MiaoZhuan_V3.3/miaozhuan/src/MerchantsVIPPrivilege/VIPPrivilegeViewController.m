//
//  VIPPrivilegeViewController.m
//  miaozhuan
//
//  Created by apple on 14/11/4.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "VIPPrivilegeViewController.h"
#import "UIView+expanded.h"
#import "Redbutton.h"
#import "NetImageView.h"
#import "RRAttributedString.h"
#import "VIPPrivilegeExplainViewController.h"
#import "CROrderManagerViewController.h"
#import "ConfirmOrderViewController.h"
#import "RRLineView.h"
#import "WebhtmlViewController.h"
#import "SharedData.h"


@interface VIPPrivilegeViewController ()<UIScrollViewDelegate,UIWebViewDelegate>
{
    int yearNum;
    
    DictionaryWrapper* resultDic;
    
    NSString * ExpireTime;
    
    int tag;
}

@property (retain, nonatomic) IBOutlet NetImageView *merchantsImageLogo;
@property (retain, nonatomic) IBOutlet UILabel *merchantsTitle;
@property (retain, nonatomic) IBOutlet UIImageView *merchantsVipImage;
@property (retain, nonatomic) IBOutlet UILabel *merchantsMatureLable;
@property (retain, nonatomic) IBOutlet UIButton *explainDetailBtn;
@property (retain, nonatomic) IBOutlet UIWebView *matureWeb;
@property (retain, nonatomic) IBOutlet UILabel *moneyLable;
@property (retain, nonatomic) IBOutlet Redbutton *buyNowBtn;
@property (retain, nonatomic) IBOutlet UIButton *reduceBtn;
@property (retain, nonatomic) IBOutlet UIButton *increaseBtn;
@property (retain, nonatomic) IBOutlet UILabel *yearLable;
@property (retain, nonatomic) IBOutlet UILabel *contentLable;
@property (retain, nonatomic) IBOutlet UILabel *payMoneyLable;
@property (retain, nonatomic) IBOutlet UIButton *cancelBtn;
@property (retain, nonatomic) IBOutlet UIButton *okBtn;
@property (retain, nonatomic) IBOutlet UIView *showView;
@property (retain, nonatomic) IBOutlet UIView *numVIew;
@property (retain, nonatomic) IBOutlet UIImageView *lineImage;
@property (retain, nonatomic) IBOutlet RRLineView *lineOne;
@property (retain, nonatomic) IBOutlet UIView *hightView;
@property (retain, nonatomic) IBOutlet UIScrollView *scrollerview;


- (IBAction)touchUpInsideBtn:(id)sender;

@end

@implementation VIPPrivilegeViewController
@synthesize merchantsImageLogo = _merchantsImageLogo;
@synthesize merchantsTitle = _merchantsTitle;
@synthesize merchantsVipImage = _merchantsVipImage;
@synthesize merchantsMatureLable = _merchantsMatureLable;
@synthesize explainDetailBtn = _explainDetailBtn;
@synthesize matureWeb = _matureWeb;
@synthesize moneyLable = _moneyLable;
@synthesize buyNowBtn = _buyNowBtn;
@synthesize reduceBtn = _reduceBtn;
@synthesize increaseBtn = _increaseBtn;
@synthesize yearLable = _yearLable;
@synthesize cancelBtn = _cancelBtn;
@synthesize contentLable = _contentLable;
@synthesize payMoneyLable = _payMoneyLable;
@synthesize okBtn = _okBtn;
@synthesize numVIew = _numVIew;
@synthesize showView = _showView;

-(void)viewWillAppear:(BOOL)animated {
    
    ADAPI_adv3_GetSummaryStatus([self genDelegatorID:@selector(HandleNotification:)]);
    
//    ADAPI_GetContentByCode([self genDelegatorID:@selector(HandleNotification:)], @"f5be170596b0ccd1f23b8f7c149a33b4");
}


- (void)HandleNotification:(DelegatorArguments *)arguments
{
    if ([arguments isEqualToOperation:ADOP_adv3_GetSummaryStatus])
    {
        [arguments logError];
        
        DictionaryWrapper *wrapper = arguments.ret;
        
        if (wrapper.operationSucceed)
        {
            resultDic = [wrapper.data retain];
            
            [self setVIPSummaryStatus:resultDic];
        }
        else if (wrapper.operationPromptCode || wrapper.operationErrorCode)
        {
            [AlertUtil showAlert:@"" message:wrapper.operationMessage buttons:@[@"好的"]];
        }
    }
//    else if ([arguments isEqualToOperation:ADOP_GetContentByCode])
//    {
//        [arguments logError];
//        
//        DictionaryWrapper *wrapper = arguments.ret;
//        
//        if (wrapper.operationSucceed)
//        {
//            NSLog(@"---%@",wrapper.data);
//            
//            [_supporter getContent:htmlTemplatePath];
//            [_webHtmlView loadHTMLString:htmlTemplatePath baseURL:nil];
//        }
//        else if(wrapper.operationPromptCode || wrapper.operationErrorCode)
//        {
//            [HUDUtil showErrorWithStatus:wrapper.operationMessage];
//        }
//    }

}

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    InitNav(@"商家VIP特权");

    [self setupMoveFowardButtonWithImage:@"goumai@2x.png" In:@"goumai@2x.png"];
    
    _showView.hidden =  YES;
    
    [self setRound];
    
    [_scrollerview setContentSize:CGSizeMake(320, 553)];
}

- (void)onMoveFoward:(UIButton *)sender
{
    PUSH_VIEWCONTROLLER(CROrderManagerViewController);
    model.type = CRENUM_OrderTypeEnterpriseVIP;
}

//加载完成 计算contentSize
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
//    CGRect frame = webView.frame;
//    CGSize fittingSize = [webView sizeThatFits:CGSizeZero];
//    frame.size = fittingSize;
//    webView.frame = frame;
}

-(void) setVIPSummaryStatus : (DictionaryWrapper*) dic
{
    _hightView.hidden = YES;
    
    DictionaryWrapper* enterprise =[APP_DELEGATE.runtimeConfig getDictionary:RUNTIME_USER_LOGIN_INFO].wrapper;
    
    _merchantsTitle.text = [enterprise getString:@"EnterpriseName"];
    
    if ([enterprise getString:@"EnterpriseName"].length <= 12)
    {
        _merchantsTitle.frame = CGRectMake(85, 15, 230, 39);
        _merchantsVipImage.frame = CGRectMake(85, 50, 17, 17);
        _merchantsMatureLable.frame = CGRectMake(110, 48, 187, 21);
    }
    
    [_merchantsImageLogo requestPic:[enterprise getString:@"EnterpriseLogoUrl"] placeHolder:NO];
    
    NSString *htmlTemplatePath = [dic getString:@"VipContent"];
    
    //包含
    if([htmlTemplatePath rangeOfString:@"device-width"].location != NSNotFound)
    {
        htmlTemplatePath = [htmlTemplatePath stringByReplacingOccurrencesOfString:@"device-width" withString:@"290"];
    }
    
    [_matureWeb loadHTMLString:htmlTemplatePath baseURL:nil];
    
    _matureWeb.delegate = self;

    if ([dic getBool:@"IsVip"] == YES)
    {
        [SharedData getInstance].personalInfo.userIsEnterpriseVip = YES;
        
        ExpireTime = [dic getString:@"ExpireTime"];
        
        NSString * time = ExpireTime;
        
        _merchantsVipImage.image = [UIImage imageNamed:@"fatopviphover"];
        
        time = [UICommon formatTime:time];
        
        if([ExpireTime length] > 0)
        {
            _merchantsMatureLable.text = [NSString stringWithFormat:@"商家VIP到期时间 %@",[time substringToIndex:10]];
        }

        [_buyNowBtn setTitle:@"继续购买" forState:UIControlStateNormal];
    }
    
    float price = [[[[dic getArray:@"PriceList"] objectAtIndex:0] wrapper]getFloat:@"UnitPrice"];
    
    _moneyLable.text = [NSString stringWithFormat:@"¥%.2f/年",price];
}


-(void) setRound
{
    [_buyNowBtn roundCorner];
    
    [_merchantsImageLogo roundCornerRadiusBorder];
    
    [_yearLable roundCornerBorder];
    
    _cancelBtn.top = 180.5;
    _okBtn.top = 180.5;
    
    _numVIew.layer.masksToBounds = YES;
    _numVIew.layer.cornerRadius = 8.0;
    _numVIew.layer.borderWidth = 0.5;
    _numVIew.layer.borderColor = [[UIColor clearColor] CGColor];
    
    yearNum = 1;
    
    _lineImage.frame = CGRectMake(145, 180, 0.5, 45);
    
    _lineOne.top = 426.5;
    
    if (yearNum == 1)
    {
        _reduceBtn.enabled = NO;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)touchUpInsideBtn:(id)sender
{
    if (sender == _buyNowBtn)
    {
        _showView.hidden = NO;
        _numVIew.frame = CGRectMake(15, 95, _numVIew.width, _numVIew.height);
        [self.view addSubview:_numVIew];
    }
    else if (sender == _reduceBtn)
    {
        _reduceBtn.enabled = YES;
        _increaseBtn.enabled = YES;
        yearNum -= 1;
  
        if (yearNum == 1)
        {
             _reduceBtn.enabled = NO;
        }
    }
    else if (sender == _increaseBtn)
    {
        if(yearNum > 10) return;
        yearNum++;
        _reduceBtn.enabled = YES;
        _increaseBtn.enabled = YES;
        
        if (yearNum == 10)
        {
            _increaseBtn.enabled = NO;
        }
    }
    else if (sender == _cancelBtn)
    {
        if ([self.view superview])
        {
            _showView.hidden = YES;
            [_numVIew removeFromSuperview];
        }
    }
    else if (sender == _okBtn)
    {
        //购买数量
        NSString *count = [NSString stringWithFormat:@"%d",yearNum];
        //跳转去购买
        NSDictionary *dic = @{@"OrderType" : @"3", @"ItemCount" : count};
        ADAPI_Payment_GoCommonOrderShow([GLOBAL_DELEGATOR_MANAGER addDelegator:self selector:@selector(handleGoCommonOrderShow:)], dic);
    }
    else if(sender == _explainDetailBtn)
    {
        PUSH_VIEWCONTROLLER(WebhtmlViewController);
        model.navTitle = @"商家VIP介绍";
        model.ContentCode = @"e1461c1686cd3fb7859be503b26b8d6c";
    }
    
    NSDate *yearday;
    
    if ([resultDic getBool:@"IsVip"] == true)
    {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        
        NSString * newTime = [UICommon format19Time:ExpireTime];
        
        NSDate *date = [dateFormatter dateFromString:newTime];
        
        NSLog(@"%@", date);
        
        [dateFormatter release];
        
        yearday = [NSDate dateWithTimeInterval:+(24*60*60)*365*yearNum +(24*60*60) sinceDate:date];
    }
    else
    {
        yearday =[NSDate dateWithTimeIntervalSinceNow:+(24*60*60)*365*yearNum + (24*60*60)];
    }
    
    NSDateFormatter *formatter = [[NSDateFormatter  alloc] init];
    
    [formatter setDateFormat:@"yyyy年MM月dd日"];
    
    NSString *todayTime = [formatter stringFromDate:yearday];
    
    float price = [[[[resultDic getArray:@"PriceList"] objectAtIndex:0] wrapper]getFloat:@"UnitPrice"];
    
    NSString * jinbi = [NSString stringWithFormat:@"%d广告金币",(int)price*yearNum];
    
    _contentLable.text = [NSString stringWithFormat:@"额外赠送 %@   有效期到%@",jinbi,todayTime];
    
    _payMoneyLable.text = [NSString stringWithFormat:@"应付金额 ¥%.2f",price*yearNum];
    
    _yearLable.text = [NSString stringWithFormat:@"%d年",yearNum];
    
    NSAttributedString * nowattributedString = [RRAttributedString setText:_contentLable.text color:RGBCOLOR(246, 100, 0) range:NSMakeRange(5, jinbi.length)];
    
    NSAttributedString * string = [RRAttributedString setText:_payMoneyLable.text font:[UIFont systemFontOfSize:28] color:RGBCOLOR(240, 5, 0) range:NSMakeRange(5, _payMoneyLable.text.length - 5)];
    
    _contentLable.attributedText = nowattributedString;
    
    _payMoneyLable.attributedText = string;
    
    [formatter release];
}

#pragma mark - 购买
- (void)handleGoCommonOrderShow:(DelegatorArguments *)arguments
{
    DictionaryWrapper *dic = arguments.ret;
    
    if (dic.operationSucceed)
    {
        [APP_MTA MTA_touch_From:MTAEVENT_business_vip_to_pay];
        
        PUSH_VIEWCONTROLLER(ConfirmOrderViewController);
        model.type = 3;
        model.payDic = @{@"OrderSerialNo" : @"", @"OrderType" : @"3", @"ItemCount" : [NSString stringWithFormat:@"%d",yearNum]};
        model.orderInfoDic = dic.data;
        model.goodsInfo = @[@{@"name" : @"商家VIP",@"num" : [NSString stringWithFormat:@"%d",yearNum]}];
        
        if ([self.view superview])
        {
            _showView.hidden = YES;
            [_numVIew removeFromSuperview];
        }
    }
    else
    {
        [HUDUtil showErrorWithStatus:dic.operationMessage];
        return;
    }
}

- (void)dealloc
{
    [resultDic release];
    
    resultDic = nil;
    
    [_merchantsImageLogo release];
    [_merchantsTitle release];
    [_merchantsVipImage release];
    [_merchantsMatureLable release];
    [_explainDetailBtn release];
    [_matureWeb release];
    [_moneyLable release];
    [_buyNowBtn release];
    [_reduceBtn release];
    [_increaseBtn release];
    [_yearLable release];
    [_contentLable release];
    [_payMoneyLable release];
    [_cancelBtn release];
    [_okBtn release];
    [_numVIew release];
    [_showView release];
    [_lineImage release];
    [_lineOne release];
    [_hightView release];
    [_scrollerview release];
    [super dealloc];
}

- (void)viewDidUnload
{
    [self setMerchantsImageLogo:nil];
    [self setMerchantsTitle:nil];
    [self setMerchantsVipImage:nil];
    [self setMerchantsMatureLable:nil];
    [self setExplainDetailBtn:nil];
    [self setMatureWeb:nil];
    [self setMoneyLable:nil];
    [self setBuyNowBtn:nil];
    [self setReduceBtn:nil];
    [self setIncreaseBtn:nil];
    [self setYearLable:nil];
    [self setContentLable:nil];
    [self setPayMoneyLable:nil];
    [self setCancelBtn:nil];
    [self setOkBtn:nil];
    [self setNumVIew:nil];
    [self setShowView:nil];
    [super viewDidUnload];
}

@end
