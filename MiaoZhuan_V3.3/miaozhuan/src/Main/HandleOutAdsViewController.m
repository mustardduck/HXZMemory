//
//  HandleOutAdsViewController.m
//  test
//
//  Created by 孙向前 on 14-10-21.
//  Copyright (c) 2014年 sunxq_xiaoruan. All rights reserved.
//

#import "HandleOutAdsViewController.h"
#import "AdsBiddingAndManagement.h"
#import "CustomerConsultationViewController.h"
#import "DetailBannerAdvertViewController.h"
#import "VIPPrivilegeViewController.h"
#import "DataAnalysis.h"
#import "BusinessInfoViewController.h"
#import "Redbutton.h"
#import "UIView+expanded.h"
#import "NetImageView.h" 
#import "ApplyToBeMerchantStep1.h"
#import "CreatMerchantStatementViewController.h"
#import "RRAttributedString.h"
#import "RedPoint.h"
#import "AccurateManagerViewController.h"
#import "YinYuanManageMainController.h"
#import "BusinessInfoManagerViewController.h"
#import "ExchangeMangerViewController.h"
#import "ControlViewController.h"
#import "YinYuanAdvertListController.h"
#import "AdsBiddingAndManagement.h"
#import "MyBiddingViewController.h"
#import "DraftBoxViewController.h"
#import "PhoneAuthenticationViewController.h"
#import "CRScrollController.h"
#import "WebhtmlViewController.h"
#import "CRWebSupporter.h"
#import "IWManagementViewController.h"
#import "ManagerOwnManagersViewController.h"
#import "BuyGoldViewController.h"

@interface HandleOutAdsViewController ()<UIAlertViewDelegate,CRSCDelegate>
{
    DictionaryWrapper* resultDic;
    
    DictionaryWrapper* AdvertSummaryDic;
    
    BOOL _pageCount;
    
    NSArray * arrImage;
    
    CRScrollController *_scrollCon;
    
    BOOL checkFlag;
}

@property (retain, nonatomic) IBOutlet UIScrollView *mainScrollerView;
@property (retain, nonatomic) IBOutlet UILabel *companyTitleLbale;
@property (retain, nonatomic) IBOutlet HightedButton *btnPulishSilverAdvert;
@property (retain, nonatomic) IBOutlet HightedButton *btnPulishMoneyAdvert;
@property (retain, nonatomic) IBOutlet HightedButton *btnPulishRivalAdvert;
@property (retain, nonatomic) IBOutlet HightedButton *btnManllManger;
@property (retain, nonatomic) IBOutlet HightedButton *btnMerchantsPrivilege;
@property (retain, nonatomic) IBOutlet HightedButton *btnCustomerConsulting;
@property (retain, nonatomic) IBOutlet HightedButton *btnDataAnalyse;
@property (retain, nonatomic) IBOutlet UIImageView *topVipImage;
@property (retain, nonatomic) IBOutlet UIImageView *topYinImage;
@property (retain, nonatomic) IBOutlet UIImageView *topJinImage;
@property (retain, nonatomic) IBOutlet UIImageView *topZhiImage;
@property (retain, nonatomic) IBOutlet UIButton *topBtn;

@property (retain, nonatomic) IBOutlet HightedButton *merchantdiscountBtn;
@property (retain, nonatomic) IBOutlet HightedButton *recruitmentBtn;
@property (retain, nonatomic) IBOutlet HightedButton *merchantsBtn;
@property (retain, nonatomic) IBOutlet HightedButton *waiterBtn;

@property (retain, nonatomic) IBOutlet UIButton *gouxuanBtn;
@property (retain, nonatomic) IBOutlet UILabel *xieyiLable;
@property (retain, nonatomic) IBOutlet UIButton *agreeBtn;

- (IBAction)btnTouchUpInside:(id)sender;


@property (retain, nonatomic) IBOutlet UIView *waitingView;
@property (retain, nonatomic) IBOutlet UIView *loseVIew;
@property (retain, nonatomic) IBOutlet Redbutton *loseBtn;
@property (retain, nonatomic) IBOutlet UIView *activationView;
@property (retain, nonatomic) IBOutlet Redbutton *activationBtn;
@property (retain, nonatomic) IBOutlet UIView *becomeVIew;
@property (retain, nonatomic) IBOutlet Redbutton *becomeBtn;
@property (retain, nonatomic) IBOutlet NetImageView *handImage;
@property (retain, nonatomic) IBOutlet UIView *showView;
@property (retain, nonatomic) IBOutlet UILabel *silverAdvertNum;
@property (retain, nonatomic) IBOutlet UILabel *moneyAdvertNum;
@property (retain, nonatomic) IBOutlet UILabel *rivalAdvertNum;
@property (retain, nonatomic) IBOutlet UILabel *zengsongLableMoney;
@property (retain, nonatomic) IBOutlet RedPoint *silverAdvertImageNum;
@property (retain, nonatomic) IBOutlet RedPoint *vipImageNum;
@property (retain, nonatomic) IBOutlet RedPoint *moneyImageNum;
@property (retain, nonatomic) IBOutlet UIView *viewOne;
@property (retain, nonatomic) IBOutlet UIView *viewTwo;
@property (retain, nonatomic) IBOutlet UIView *viewthree;
@property (retain, nonatomic) IBOutlet UIView *viewfour;
@property (retain, nonatomic) IBOutlet UIView *viewfive;
@property (retain, nonatomic) IBOutlet UIView *viewsix;
@property (retain, nonatomic) IBOutlet UIView *viewseven;

- (IBAction)otherTouch:(id)sender;
@property (retain, nonatomic) IBOutlet UIButton *otherYinYuanBtn;
@property (retain, nonatomic) IBOutlet UIButton *otherJinZhunBtn;
@property (retain, nonatomic) IBOutlet UIButton *otherJingJiaBtn;
@property (retain, nonatomic) IBOutlet UIButton *otherVipBtn;

@property (retain, nonatomic) IBOutlet UIView *lineViewOne;
@property (retain, nonatomic) IBOutlet UIView *lineTwo;
@property (retain, nonatomic) IBOutlet UIView *lineThree;
@property (retain, nonatomic) IBOutlet UIView *lineFour;
@property (retain, nonatomic) IBOutlet UIView *lineFive;
@property (retain, nonatomic) IBOutlet UIScrollView *scrollerImage;

@property (retain, nonatomic) IBOutlet Redbutton *examinBtn;
- (IBAction)examinTouchUpinside:(id)sender;
@property (retain, nonatomic) IBOutlet UIButton *examinWenBtn;
@property (retain, nonatomic) IBOutlet HightedButton *payGGJBBtn;

@end

@implementation HandleOutAdsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (IBAction)sendBiddingAds:(id)sender
{
    [UI_MANAGER.mainNavigationController pushViewController:WEAK_OBJECT(AdsBiddingAndManagement, init) animated:YES];
}

- (void) viewRefresh
{
    [self GetenterpriseStatus];
}

-(void) GetenterpriseStatus
{
    ADAPI_adv3_GetEnterpriseStatus([self genDelegatorID:@selector(HandleNotification:)]);
}

- (void)HandleNotification:(DelegatorArguments *)arguments
{
    if ([arguments isEqualToOperation:ADOP_adv3_GetEnterpriseStatus])
    {
        [arguments logError];
        
        DictionaryWrapper *wrapper = arguments.ret;
        
        if (wrapper.operationSucceed)
        {
            resultDic = [wrapper.data retain];
            
            [self setMerchants:resultDic];
        }
        else if (wrapper.operationPromptCode || wrapper.operationErrorCode)
        {
            [AlertUtil showAlert:@"" message:wrapper.operationMessage buttons:@[@"好的"]];
            return;
        }
    }
    else if ([arguments isEqualToOperation:ADOP_adv3_GetAdvertSummary])
    {        
        [arguments logError];
        
        DictionaryWrapper *wrapper = arguments.ret;
        
        if (wrapper.operationSucceed)
        {
            AdvertSummaryDic = [wrapper.data retain];
            
            [self setAdvertSummary:AdvertSummaryDic];
        }
        else if(wrapper.operationPromptCode || wrapper.operationErrorCode)
        {
            [AlertUtil showAlert:@"" message:wrapper.operationMessage buttons:@[@"好的"]];
            return;
        }
    }
    else if ([arguments isEqualToOperation:ADOP_adv3_Activation])
    {
        [arguments logError];
        
        DictionaryWrapper *wrapper = arguments.ret;
        
        if (wrapper.operationSucceed)
        {
            _activationView.hidden = YES;
        
            [self GetenterpriseStatus];
        }
        else if(wrapper.operationPromptCode || wrapper.operationErrorCode)
        {
            [AlertUtil showAlert:@"" message:wrapper.operationMessage buttons:@[@"好的"]];
            return;
        }
    }
    else if ([arguments isEqualToOperation:ADOP_adv3_Enterprise_CheckIsCanCreate])
    {
        [arguments logError];
        
        DictionaryWrapper *wrapper = arguments.ret;
        
        if (wrapper.operationSucceed)
        {
            [UI_MANAGER.mainNavigationController pushViewController:WEAK_OBJECT(CreatMerchantStatementViewController, init) animated:YES];
        }
        else if (wrapper.operationDealWithCode)
        {
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"" message:wrapper.operationMessage delegate:self cancelButtonTitle:@"稍后再去" otherButtonTitles:@"立即认证", nil];
            [alert show];
            [alert release];
            return;
        }
        else if(wrapper.operationPromptCode || wrapper.operationErrorCode)
        {
            [AlertUtil showAlert:@"" message:wrapper.operationMessage buttons:@[@"好的"]];
            return;
        }
    }
    else if ([arguments isEqualToOperation:ADOP_adv3_1_Operator_GetBanner])
    {
        [arguments logError];
        
        DictionaryWrapper *wrapper = arguments.ret;
        
        if (wrapper.operationSucceed)
        {
            NSLog(@"--发广告首页bannner%@",wrapper);
            
            _showView.hidden = YES;
            arrImage = wrapper.data;
            [arrImage retain];
            _scrollCon.picArray = arrImage;
            
            //或者 使用代理
            _scrollCon.delegate = self;
            
        }
        else if(wrapper.operationPromptCode || wrapper.operationErrorCode)
        {
            [AlertUtil showAlert:@"" message:wrapper.operationMessage buttons:@[@"好的"]];
            return;
        }
    }

}

- (void)scrollView:(CRScrollController *)view didSelectPage:(NSInteger)index
{
//    PUSH_VIEWCONTROLLER(WebhtmlViewController);
//    model.ContentCode = [[[arrImage objectAtIndex:index] wrapper] getString:@"Code"];
#warning 孙向前修改
    if ([arrImage count] == 0)
    {
        
    }
    else
    {
        [CRWebSupporter bannerForward:[[arrImage objectAtIndex:index] wrapper]];
    }
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 2)
    {
        if (buttonIndex == 1)
        {
            [UI_MANAGER.mainNavigationController pushViewController:WEAK_OBJECT(VIPPrivilegeViewController, init) animated:YES];
        }
    }
    else
    {
        if (buttonIndex == 1)
        {
            [UI_MANAGER.mainNavigationController pushViewController:WEAK_OBJECT(PhoneAuthenticationViewController, init) animated:YES];
        }
    }
}

-(void) setMerchants:(DictionaryWrapper*) dicwrapper
{
    DictionaryWrapper* dic =[APP_DELEGATE.runtimeConfig getDictionary:RUNTIME_USER_LOGIN_INFO].wrapper;
    
    NSString * EnterpriseStatus = [NSString stringWithFormat:@"%d",[dicwrapper getInt:@"EnterpriseStatus"]];
    
    _showView.hidden = YES;
    
    if ([EnterpriseStatus isEqualToString:@"0"])
    {
        //成为商家
        [self.view addSubview:_becomeVIew];
    }
    else if ([EnterpriseStatus isEqualToString:@"1"])
    {
        //审核中
        [self.view addSubview:_waitingView];
    }
    else if ([EnterpriseStatus isEqualToString:@"2"])
    {
        //失败
        [self.view addSubview:_loseVIew];
    }
    else if ([EnterpriseStatus isEqualToString:@"3"])
    {
        [_waitingView removeFromSuperview];
        //成功
        [self.view addSubview:_activationView];
        
        int gold = [dicwrapper getInt:@"EnterpriseCreatedGold"];
        
        if (gold > 0)
        {
            _zengsongLableMoney.hidden = NO;
        }
        
        _zengsongLableMoney.text = [NSString stringWithFormat:@"赠送%d金币",gold];
        
        NSAttributedString * nowattributedString = [RRAttributedString setText:_zengsongLableMoney.text color:RGBCOLOR(240, 5, 0) range:NSMakeRange(2, _zengsongLableMoney.text.length - 2)];
        
        _zengsongLableMoney.attributedText = nowattributedString;
    }
    else
    {
        ADAPI_adv3_1_Operator_GetBanne([self genDelegatorID:@selector(HandleNotification:)], @"1fe865f2a2a7cf21059d844bd16f4754");
        
        [_loseVIew removeFromSuperview];
        [_activationView removeFromSuperview];
        [_becomeVIew removeFromSuperview];
        [_waitingView removeFromSuperview];
        
        [APP_DELEGATE.runtimeConfig set:RUNTIME_USER_LOGIN_INFO".EnterpriseStatus" int:4];
        
        //立即激活
        NSArray*                controllerArray = nil;
        ControlViewController*  fatherContoller = nil;
        {
            controllerArray = [DotCUIManager instance].mainNavigationController.viewControllers;
            for (UIViewController *target in controllerArray)
            {
                if ( [target isKindOfClass:[ControlViewController class]])
                {
                    fatherContoller = (ControlViewController *)target;
                }
            }
            [fatherContoller viewDidLayoutSubviews];
        }
        
        ADAPI_adv3_GetAdvertSummary([self genDelegatorID:@selector(HandleNotification:)]);
        
        _companyTitleLbale.text = [dic getString:@"EnterpriseName"];
        
        NSLog(@"---url%@",[dic getString:@"EnterpriseLogoUrl"]);
        
        [_handImage requestPic:[dic getString:@"EnterpriseLogoUrl"] placeHolder:NO];
        
        if ([dicwrapper getBool:@"IsVip"] == true){
            _topVipImage.image = [UIImage imageNamed:@"fatopviphover"];
        }
        if ([dicwrapper getBool:@"IsSilver"] == true) {
            _topYinImage.image = [UIImage imageNamed:@"fatopyinhover"];
        }
        if ([dicwrapper getBool:@"IsGold"] == true) {
            _topJinImage.image = [UIImage imageNamed:@"fatopjinhover"];
        }
        if ([dicwrapper getBool:@"IsDirect"] == true) {
//            _topZhiImage.image = [UIImage imageNamed:@"fatopzhihover"];
        }
        
        if (_companyTitleLbale.text.length <= 10)
        {
            _companyTitleLbale.frame = CGRectMake(90, 20, 185, 36);
            _topVipImage.frame = CGRectMake(90, 57, 17, 17);
            _topYinImage.frame = CGRectMake(112, 57, 17, 17);
            _topJinImage.frame = CGRectMake(136, 57, 17, 17);
//            _topZhiImage.frame = CGRectMake(165, 57, 17, 17);
        }
    }
}


-(void) setAdvertSummary : (DictionaryWrapper*) Dic
{
    _silverAdvertNum.text = [NSString stringWithFormat:@"%d",[Dic getInt:@"SilverAdvertPlay"]];
    
    _moneyAdvertNum.text = [NSString stringWithFormat:@"%d",[Dic getInt:@"DirectAdvertPlay"]];
    
    _rivalAdvertNum.text = [NSString stringWithFormat:@"%d",[Dic getInt:@"BiddingAdvertPlay"]];
    
    
    if ([Dic getInt:@"SilverAdvertUnread"] == 0)
    {
        _silverAdvertImageNum.hidden = YES;
    }
    else
    {
        _silverAdvertImageNum.hidden = NO;
        _silverAdvertImageNum.num = [Dic getInt:@"SilverAdvertUnread"];
    }
    
    if ([Dic getInt:@"CounselUnreadCount"] == 0)
    {
        _vipImageNum.hidden = YES;
    }
    else
    {
        _vipImageNum.hidden = NO;
        _vipImageNum.num = [Dic getInt:@"CounselUnreadCount"];
    }
    
    if ([Dic getInt:@"DirectAdvertUnread"] == 0)
    {
        _moneyImageNum.hidden = YES;
    }
    else
    {
        _moneyImageNum.hidden = NO;
        _moneyImageNum.num = [Dic getInt:@"DirectAdvertUnread"];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    _pageCount ++;
    [MTA trackPageViewBegin:NSStringFromClass([self class])];
    
    checkFlag = YES;
    
    [_gouxuanBtn setBackgroundImage:[UIImage imageNamed:@"findShopfilterSelectBtn"] forState:UIControlStateNormal];
    
    _becomeBtn.backgroundColor = AppColorRed;
    
    _becomeBtn.userInteractionEnabled = YES;
    
    checkFlag = YES;
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    if (_pageCount > 0)
    {
        [MTA trackPageViewEnd:NSStringFromClass([self class])];
        _pageCount --;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _scrollCon = [CRScrollController controllerFromView:_scrollerImage];
    _scrollCon.isBackWhite = YES;
    
    [_mainScrollerView setContentSize:CGSizeMake(320, 555)];
    
    [self setRound];
    
    NSAttributedString *attributedString = [RRAttributedString setText:_xieyiLable.text color:RGBCOLOR(85, 85, 85) range:NSMakeRange(0, 3)];
    _xieyiLable.attributedText = attributedString;
}

-(void) setRound
{
    [_becomeBtn roundCorner];
    [_loseBtn roundCorner];
    [_activationBtn roundCorner];

    [_handImage roundCornerRadius];
    
    _handImage.layer.cornerRadius = 11.0;
    
    _showView.frame = CGRectMake(0, 0, 320, [[UIScreen mainScreen] bounds].size.height - 114);
    
    _loseVIew.frame = CGRectMake(0, 0, 320, [[UIScreen mainScreen] bounds].size.height - 114);
    _activationView.frame = CGRectMake(0, 0, 320, [[UIScreen mainScreen] bounds].size.height - 114);
    _becomeVIew.frame = CGRectMake(0, 0, 320, [[UIScreen mainScreen] bounds].size.height - 114);
    
    _waitingView.frame = CGRectMake(0, 0, 320, [[UIScreen mainScreen] bounds].size.height - 114);
    
    _viewOne.frame = CGRectMake(5, 260, 100, 0.5);
    _viewTwo.frame = CGRectMake(215, 260, 100, 0.5);
    _viewthree.frame = CGRectMake(110, 260, 100, 0.5);
    _viewfour.frame = CGRectMake(5, 365, 100, 0.5);
    _viewfive.frame = CGRectMake(110, 365, 100, 0.5);
    _viewsix.frame = CGRectMake(215, 365, 100, 0.5);
    _viewseven.frame = CGRectMake(5, 470, 100, 0.5);
    
    _lineViewOne.frame = CGRectMake(80, 0, 0.5, 300);
    _lineTwo.frame = CGRectMake(160, 0, 0.5, 300);
    _lineThree.frame = CGRectMake(240, 0, 0.5, 300);
    _lineFour.frame = CGRectMake(0, 100, 320, 0.5);
    _lineFive.frame = CGRectMake(0, 200, 320, 0.5);
}

- (IBAction)btnTouchUpInside:(id)sender
{
    if (sender == _btnPulishSilverAdvert)
    {
        //发布银元广告;
        [UI_MANAGER.mainNavigationController pushViewController:WEAK_OBJECT(YinYuanManageMainController, init) animated:YES];

    }
    else if (sender == _btnPulishMoneyAdvert)
    {
        //红包广告
        [UI_MANAGER.mainNavigationController pushViewController:WEAK_OBJECT(AccurateManagerViewController, init) animated:YES];
    }
    else if (sender == _btnPulishRivalAdvert)
    {
        //竞价广告
    }
    else if (sender == _btnManllManger)
    {
        //商城管理
        ExchangeMangerViewController *model = WEAK_OBJECT(ExchangeMangerViewController, init);
        model.type = @"2";
        [UI_MANAGER.mainNavigationController pushViewController:model animated:YES];
        
    }
    else if (sender == _btnMerchantsPrivilege)
    {
        //商家特权
        [UI_MANAGER.mainNavigationController pushViewController:WEAK_OBJECT(VIPPrivilegeViewController, init) animated:YES];
    }
    else if (sender == _btnCustomerConsulting)
    {
        //客户咨询
        [UI_MANAGER.mainNavigationController pushViewController:WEAK_OBJECT(CustomerConsultationViewController, init) animated:YES];
    }
    else if (sender == _btnDataAnalyse)
    {
        //数据分析
        [UI_MANAGER.mainNavigationController pushViewController:WEAK_OBJECT(DataAnalysis, init) animated:YES];
    }
    else if (sender == _topBtn)
    {
        [UI_MANAGER.mainNavigationController pushViewController:WEAK_OBJECT(BusinessInfoViewController, init) animated:YES];
        //商家信息
    }else if (sender == _loseBtn)
    {
        ApplyToBeMerchantStep1 *temp = WEAK_OBJECT(ApplyToBeMerchantStep1, init);
        temp.editStatement = 1;
        [UI_MANAGER.mainNavigationController pushViewController:temp animated:YES];
    }
    else if (sender == _becomeBtn)
    {
        //创建商家
        
        ADAPI_adv3_Enterprise_CheckIsCanCreate([self genDelegatorID:@selector(HandleNotification:)]);
        
//        [UI_MANAGER.mainNavigationController pushViewController:WEAK_OBJECT(CreatMerchantStatementViewController, init) animated:YES];
    }
    else if (sender == _activationBtn)
    {
        ADAPI_adv3_Activation([self genDelegatorID:@selector(HandleNotification:)]);
    }
    else if (sender == _merchantdiscountBtn)
    {
        //商家优惠
        [self goto_ShangJiaYouHui_Management];
    }
    else if (sender == _recruitmentBtn)
    {
        //招聘信息
        [self goto_ZhaoPin_Management];
    }
    else if (sender == _merchantsBtn)
    {
        //招商信息
        [self goto_ZhaoShang_Management];
    }
    else if (sender == _waiterBtn)
    {
        //我的店小二
        ManagerOwnManagersViewController *mg = WEAK_OBJECT(ManagerOwnManagersViewController, init);
        [UI_MANAGER.mainNavigationController pushViewController:mg animated:YES];
    }
    else if (sender == _payGGJBBtn)
    {
        //购买广告金币
        BuyGoldViewController *buygold = WEAK_OBJECT(BuyGoldViewController, init);
        [UI_MANAGER.mainNavigationController pushViewController:buygold animated:YES];
    }
    else if (sender == _gouxuanBtn)
    {
        if (checkFlag)
        {
            [_gouxuanBtn setBackgroundImage:[UIImage imageNamed:@"fashouweigou"] forState:UIControlStateNormal];
            
            _becomeBtn.backgroundColor = AppColorLightGray204;
            
            _becomeBtn.userInteractionEnabled = NO;
            
            checkFlag = NO;
        }
        else
        {
            [_gouxuanBtn setBackgroundImage:[UIImage imageNamed:@"fashougou"] forState:UIControlStateNormal];
            
            _becomeBtn.backgroundColor = AppColorRed;
            
            _becomeBtn.userInteractionEnabled = YES;
            
            checkFlag = YES;
        }
    }
    else if (sender == _agreeBtn)
    {
        PUSH_VIEWCONTROLLER(WebhtmlViewController);
        model.navTitle = @"秒赚广告商户服务协议";
        model.ContentCode = @"3ed178efb1aa89180338d2b29e08a0db";
    }
}

#pragma mark -- 招聘管理
-(void)goto_ZhaoPin_Management{
    IWManagementViewController *imtvc = [[IWManagementViewController alloc] init];
    imtvc.type = IWManagementType_ZhaoPin;
    [UI_MANAGER.mainNavigationController pushViewController:imtvc animated:YES];
}

#pragma mark -- 招商管理
-(void)goto_ZhaoShang_Management{
    IWManagementViewController *imtvc = [[IWManagementViewController alloc] init];
    imtvc.type = IWManagementType_ZhaoShang;
    [UI_MANAGER.mainNavigationController pushViewController:imtvc animated:YES];
    
}

#pragma mark -- 商家优惠管理
-(void)goto_ShangJiaYouHui_Management{
    IWManagementViewController *imtvc = [[IWManagementViewController alloc] init];
    imtvc.type = IWManagementType_ShangJiaYouHui;
    [UI_MANAGER.mainNavigationController pushViewController:imtvc animated:YES];
    
}

- (IBAction)otherTouch:(id)sender
{
    if (sender == _otherYinYuanBtn)
    {
        YinYuanAdvertListController *yinyuanlist = WEAK_OBJECT(YinYuanAdvertListController, init);
        yinyuanlist.queryType = PlayingADType;
        [UI_MANAGER.mainNavigationController pushViewController:yinyuanlist animated:YES];
    }
    else if (sender == _otherJinZhunBtn)
    {
        DraftBoxViewController *draft = WEAK_OBJECT(DraftBoxViewController, init);
        draft.state = 1;
        [UI_MANAGER.mainNavigationController pushViewController:draft animated:YES];
    }
    else if (sender == _otherJingJiaBtn)
    {
        if ([resultDic getBool:@"IsVip"] == YES)
        {
            [UI_MANAGER.mainNavigationController pushViewController:WEAK_OBJECT(MyBiddingViewController, init) animated:YES];
        }
        else
        {
            [UI_MANAGER.mainNavigationController pushViewController:WEAK_OBJECT(AdsBiddingAndManagement, init) animated:YES];
        }
    }
    else if (sender == _otherVipBtn)
    {
        if ([resultDic getBool:@"IsVip"] == YES)
        {
            [UI_MANAGER.mainNavigationController pushViewController:WEAK_OBJECT(VIPPrivilegeViewController, init) animated:YES];
        }
        else
        {
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"立即购买VIP" message:@"获得尊贵商家特权" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [alert show];
            alert.tag = 2;
            [alert release];
        }
    }
}

//审核商家的btn
- (IBAction)examinTouchUpinside:(id)sender
{
    if (sender == _examinBtn)
    {
        //发布银元广告;
        [UI_MANAGER.mainNavigationController pushViewController:WEAK_OBJECT(YinYuanManageMainController, init) animated:YES];
    }
    else if (sender == _examinWenBtn)
    {
        [AlertUtil showAlert:@"" message:@"本通道是给商家开辟的快速“发银元广告”入口，商家可以在等待审核商家申请的同时提交银元广告资料一并审核" buttons:@[@"确定"]];
        return;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
    [_mainScrollerView release];
    [_companyTitleLbale release];
    [_btnPulishSilverAdvert release];
    [_btnPulishMoneyAdvert release];
    [_btnPulishRivalAdvert release];
    [_btnManllManger release];
    [_btnMerchantsPrivilege release];
    [_btnCustomerConsulting release];
    [_btnDataAnalyse release];
    [_topVipImage release];
    [_topYinImage release];
    [_topJinImage release];
    [_topZhiImage release];
    [_topBtn release];
    [_waitingView release];
    [_loseVIew release];
    [_loseBtn release];
    [_activationView release];
    [_activationBtn release];
    [_becomeVIew release];
    [_becomeBtn release];
    [_handImage release];
    
    [resultDic release];
    resultDic = nil;
    
    [AdvertSummaryDic release];
    
    AdvertSummaryDic = nil;
    
    [_showView release];
    [_silverAdvertNum release];
    [_moneyAdvertNum release];
    [_rivalAdvertNum release];
    [_zengsongLableMoney release];
    [_silverAdvertImageNum release];
    [_vipImageNum release];
    [_moneyImageNum release];
    [_viewOne release];
    [_viewTwo release];
    [_viewthree release];
    [_viewfour release];
    [_viewfive release];
    [_viewsix release];
    [_viewseven release];
    [_otherYinYuanBtn release];
    [_otherJinZhunBtn release];
    [_otherJingJiaBtn release];
    [_otherVipBtn release];
    [_lineViewOne release];
    [_lineTwo release];
    [_lineThree release];
    [_lineFour release];
    [_scrollerImage release];
    [_examinBtn release];
    [_examinWenBtn release];
    [_lineFive release];
    [_merchantdiscountBtn release];
    [_recruitmentBtn release];
    [_merchantsBtn release];
    [_waiterBtn release];
    [_payGGJBBtn release];
    [_gouxuanBtn release];
    [_xieyiLable release];
    [_agreeBtn release];
    [super dealloc];
}

@end
