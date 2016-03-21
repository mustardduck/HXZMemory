//
//  OpenRedPacketViewController.m
//  miaozhuan
//
//  Created by Santiago on 14-10-30.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "OpenRedPacketViewController.h"
#import "ScrollerViewWithTime.h"
#import "ConsultViewController.h"
#import "MerchantDetailViewController.h"
#import "NetImageView.h"
#import "MerchantHomePageViewController.h"
#import "VipPriviliegeViewController.h"
#import "PlaySound.h"
#import "LineView.h"
#import "Share_Method.h"
#import "Redbutton.h"
#import "PreviewViewController.h"
#import "KxMenu.h"
#import "CRMTAManager.h"
#import "RealNameAuthenticationViewController.h"

@interface OpenRedPacketViewController ()<UIScrollViewDelegate, ScrollerWithTimeDelegate, KxMenuDelegate>{

    ScrollerViewWithTime* _recommandBanner;
    float _scrollerContentHeight;
    
    IBOutlet UIView *companyInfoView;
    IBOutlet UILabel *companyInfoLabel;
    IBOutlet UIView *bottomView;
    BOOL _isCollected;
    float _moneyInRedPacket;
    
    float extraAddressHeight;
}

@property (retain, nonatomic) IBOutlet UIScrollView *mainScrollerView;
@property (retain, nonatomic) IBOutlet UIView *buttomOprationView;
@property (retain, nonatomic) IBOutlet UIScrollView *adScrollerView;
@property (retain, nonatomic) IBOutlet UIButton *collectBtn;
@property (retain, nonatomic) IBOutlet UIButton *consultBtn;

@property (retain, nonatomic) IBOutlet UILabel *adsName;
@property (retain, nonatomic) IBOutlet UILabel *adsWord;
@property (retain, nonatomic) IBOutlet NetImageView *companyLogo;
@property (retain, nonatomic) IBOutlet UILabel *companyPhoneNumber;

@property (retain, nonatomic) IBOutlet UILabel *labelOnTheTopOfAddress;
@property (retain, nonatomic) IBOutlet UILabel *companyAddress;
@property (retain, nonatomic) IBOutlet UILabel *companyName;
@property (retain, nonatomic) IBOutlet UIImageView *vipImageView;
@property (retain, nonatomic) IBOutlet UIImageView *silverImageView;
@property (retain, nonatomic) IBOutlet UIImageView *goldImageView;
@property (retain, nonatomic) IBOutlet Redbutton *openRedPacketBtn;
@property (strong, nonatomic) UIImageView *moneyImageView;
@property (strong, nonatomic) NSString *merchantId;
@property (strong, nonatomic) NSString *merchantUrl;
@property (strong, nonatomic) NSString *todayStr;

@property (retain, nonatomic) IBOutlet UIButton *toMerchantHomePageBtn;
@property (retain, nonatomic) IBOutlet UIImageView *littleArrowToHomePage;

@property (strong, nonatomic) NSArray *pictureArray;

@property (retain, nonatomic) IBOutlet LineView *UILineView;
@property (retain, nonatomic) IBOutlet LineView *UILineView2;
@property (retain, nonatomic) IBOutlet LineView *UILineView3;
@property (retain, nonatomic) IBOutlet LineView *UILineView4;
@property (retain, nonatomic) IBOutlet LineView *UILineView5;
@property (retain, nonatomic) IBOutlet LineView *UILineView6;
@property (retain, nonatomic) IBOutlet LineView *UILineView7;
@property (retain, nonatomic) IBOutlet LineView *UILineView8;
@property (retain, nonatomic) IBOutlet LineView *UILineView9;
@property (assign, nonatomic) int oldVipLevel;
@end

@implementation OpenRedPacketViewController
@synthesize mainScrollerView = _mainScrollerView;
@synthesize buttomOprationView = _buttomOprationView;
@synthesize adScrollerView = _adScrollerView;
@synthesize collectBtn = _collectBtn;
@synthesize adsId = _adsId;
@synthesize adsName = _adsName;
@synthesize adsWord = _adsWord;
@synthesize companyLogo = _companyLogo;
@synthesize companyPhoneNumber = _companyPhoneNumber;
@synthesize companyAddress = _companyAddress;
@synthesize companyName = _companyName;
@synthesize vipImageView = _vipImageView;
@synthesize silverImageView = _silverImageView;
@synthesize goldImageView = _goldImageView;
@synthesize openRedPacketBtn = _openRedPacketBtn;
@synthesize moneyImageView = _moneyImageView;
@synthesize merchantId = _merchantId;
@synthesize merchantUrl = _merchantUrl;
@synthesize todayStr = _todayStr;
@synthesize toMerchantHomePageBtn = _toMerchantHomePageBtn;
@synthesize littleArrowToHomePage = _littleArrowToHomePage;
@synthesize pictureArray = _pictureArray;
@synthesize oldVipLevel = _oldVipLevel;

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (_comeformCounsel == 1)
    {
        //从客户咨询跳转过来
        _openRedPacketBtn.enabled = NO;
        _openRedPacketBtn.backgroundColor = AppColorLightGray204;
        [_collectBtn setImage:[UIImage imageNamed:@"uncollectable.png"] forState:UIControlStateNormal];
        _collectBtn.enabled = NO;
        _consultBtn.enabled = NO;
    }
    
    _isCollected = NO;
    [self setupMoveBackButton];
     [self setupMoveFowardButtonWithImage:@"more" In:@"morehover"];
    ADAPI_RedPacketDetail([self genDelegatorID:@selector(getInformation:)], _adsId);
    
    self.companyLogo.layer.borderWidth = 0.5;
    self.companyLogo.layer.borderColor = [RGBCOLOR(197, 197, 197) CGColor];
    
    [self.collectBtn setImage:[UIImage imageNamed:@"collect"] forState:UIControlStateNormal];
    [self.collectBtn setImage:[UIImage imageNamed:@"collecthover"] forState:UIControlStateHighlighted];
    [self.collectBtn setTitle:@"收藏" forState:UIControlStateNormal];
    
    [self.consultBtn setImage:[UIImage imageNamed:@"consult"] forState:UIControlStateNormal];
    [self.consultBtn setImage:[UIImage imageNamed:@"consulthover"] forState:UIControlStateHighlighted];
    [self.consultBtn setTitle:@"咨询" forState:UIControlStateNormal];
    
    
    [self.UILineView setSize:CGSizeMake(320, 0.5)];
    [self.UILineView2 setSize:CGSizeMake(320, 0.5)];
    [self.UILineView3 setSize:CGSizeMake(305, 0.5)];

    [self.UILineView6 setSize:CGSizeMake(320, 0.5)];
    [self.UILineView7 setSize:CGSizeMake(320, 0.5)];
    [self.UILineView8 setSize:CGSizeMake(305, 0.5)];
    [self.UILineView9 setSize:CGSizeMake(305, 0.5)];
    
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"MM-dd-yyyy"];
    self.todayStr = [dateFormat stringFromDate:date];
    [dateFormat release];
    
    //商家信息
    DictionaryWrapper *dic = [APP_DELEGATE.runtimeConfig getDictionary:RUNTIME_USER_LOGIN_INFO].wrapper;
    _oldVipLevel = [dic getInt:@"VipLevel"];
}

- (void)onMoveFoward:(UIButton *)sender {
    
    if(![KxMenu isOpen])
    {
        NSArray *menuItems =
        @[
          
          [KxMenuItem menuItem:@"商家详情"
                         image:[UIImage imageNamed:@"ads_detailIconnormal"]
                     highlight:[UIImage imageNamed:@"ads_detailIconhover"]
                        target:self
                        action:@selector(pushMenuItem:)],
          
          [KxMenuItem menuItem:@"分享给好友"
                         image:[UIImage imageNamed:@"preview_menu_3_0"]
                     highlight:[UIImage imageNamed:@"preview_menu_3_1"]
                        target:self
                        action:@selector(pushMenuItem:)],
          ];
        
        CGRect rect = sender.frame;
        
        rect.origin.y = 40.5;
        [KxMenu showMenuInView:self.navigationController.view
                      fromRect:rect
                     menuItems:menuItems
                     itemWidth:135.f];
        [KxMenu sharedMenu].delegate = self;
    }
    else
    {
        [KxMenu dismissMenu];
    }
}

//打开Menu
- (void) pushMenuItem:(id)sender{}

#pragma mark - KXMEnuDelagate
-(void)which_tag_clicked:(int) tag {
    
    switch (tag) {
        case 0:{
            
            MerchantDetailViewController *temp = WEAK_OBJECT(MerchantDetailViewController, init);
            temp.enId = _merchantId;
            temp.comefrom = @"2";
            [self.navigationController pushViewController:temp animated:YES];
            break;
        }
        case 1:{

            NSString *adsIDStr = [NSString stringWithFormat:@"%d",_adsId];
            [[Share_Method shareInstance] getShareDataWithShareData:@{@"Key":@"5dfe16f3c9664c23ac8007f6b751be06",@"advert_id":adsIDStr.length ? adsIDStr : @""}];
            break;}
        default:
            break;
    }
}

- (IBAction)toMerchantDetailPage:(id)sender {
    
    MerchantDetailViewController *temp = WEAK_OBJECT(MerchantDetailViewController, init);
    temp.enId = _merchantId;
     temp.comefrom = @"2";
    [self.navigationController pushViewController:temp animated:YES];
}


- (void)viewWillDisappear:(BOOL)animated {

    self.collectBtn.alpha = 1;
    [self.delegate refresh];
}

- (void)getInformation:(DelegatorArguments*)arguments {

    DictionaryWrapper *wrapper = arguments.ret;
    if (wrapper.operationSucceed)
    {

        self.buttomOprationView.hidden = NO;
        DictionaryWrapper *dataSource = wrapper.data;
        
        if (![dataSource getBool:@"IsCanFavorite"]) {

            [_collectBtn setImage:[UIImage imageNamed:@"uncollectable.png"] forState:UIControlStateNormal];
            _collectBtn.enabled = NO;
        }
        
        if (![dataSource getBool:@"IsAllowEarn"]) {
            
            _openRedPacketBtn.enabled = NO;
        }
        
        CGSize tempsize = {150,207};
        _recommandBanner = [ScrollerViewWithTime controllerFromView:_adScrollerView pictureSize:tempsize];
        [_recommandBanner retain];
        _recommandBanner.delegate = self;
        
        if ([[dataSource getArray:@"Pictures"] count] == 0) {
            
            [_recommandBanner addImageItems:@[@""]];
        }else {
        
            [_recommandBanner addImageItems:[dataSource getArray:@"Pictures"]];
            
            NSMutableArray *thePictureArray = WEAK_OBJECT(NSMutableArray, init);
            for (int i = 0; i < [[dataSource getArray:@"Pictures"] count]; i++) {
                WDictionaryWrapper *temp = WEAK_OBJECT(WDictionaryWrapper, init);
                [temp set:@"PictureUrl" string:[dataSource getArray:@"Pictures"][i]];
                [thePictureArray addObject:temp.dictionary];
            }
            self.pictureArray = [NSArray arrayWithArray:thePictureArray];
        }
        
        [self.adsName setText:[dataSource getString:@"Name"]];
        [self setTitle:[dataSource getString:@"Name"]];
        [self.adsWord setText:[dataSource getString:@"AdvertWord"]];
        [self.companyPhoneNumber setText:[dataSource getString:@"Tel"]];
        [self.companyAddress setText:[dataSource getString:@"Address"]];
        
        NSString *str = [dataSource getString:@"Address"];
        CGSize size = [str sizeWithFont:self.companyAddress.font constrainedToSize:CGSizeMake(287, MAXFLOAT)lineBreakMode:NSLineBreakByWordWrapping];
        
        if (size.height > 20) {
            
            [self.companyAddress setFrame:CGRectMake(15, 185, 287, 35)];
            extraAddressHeight = 21;
            [self.UILineView6 setOrigin:CGPointMake(0, 213.5 + 21)];
        }else {
        
            extraAddressHeight = 0;
            [self.UILineView6 setOrigin:CGPointMake(0, 213.5)];
        }
        
        [self setFrame:[dataSource getString:@"Content"]];
        
        [self.buttomOprationView setSize:CGSizeMake(320, 214 - 14 + size.height)];
        
        self.merchantUrl = [dataSource getString:@"Link"];
        
        if ([dataSource getString:@"Link"]&&![[dataSource getString:@"Link"] isEqualToString:@""]) {
#warning 孙向前修改此处
//            self.toMerchantHomePageBtn.enabled = YES;
            self.littleArrowToHomePage.hidden = NO;
        }else {
        
//            self.toMerchantHomePageBtn.enabled = NO;
            self.littleArrowToHomePage.hidden = YES;
        }
        
        DictionaryWrapper *merchantInfo = [dataSource getDictionaryWrapper:@"EnterpriseInfo"];
        
        self.merchantId = [merchantInfo getString:@"Id"];
        [self.companyLogo requestPicture:[merchantInfo getString:@"LogoUrl"]];
        self.companyName.text = [merchantInfo getString:@"Name"];
        
        _isCollected = [dataSource getBool:@"IsFavorite"];
        
        if (_isCollected) {
            
            [self.collectBtn setImage:[UIImage imageNamed:@"alreadyCollected"] forState:UIControlStateNormal];
            [self.collectBtn setImage:[UIImage imageNamed:@"alreadyCollectedhover"] forState:UIControlStateHighlighted];
            [self.collectBtn setTitle:@"已收藏" forState:UIControlStateNormal];
            [self.collectBtn setTitle:@"已收藏" forState:UIControlStateHighlighted];
            [self.collectBtn setTitleColor:RGBCOLOR(240, 5, 0) forState:UIControlStateNormal];
        }else {
        
            [self.collectBtn setImage:[UIImage imageNamed:@"collect"] forState:UIControlStateNormal];
            [self.collectBtn setImage:[UIImage imageNamed:@"collecthover"] forState:UIControlStateHighlighted];
            [self.collectBtn setTitle:@"收藏" forState:UIControlStateNormal];
            [self.collectBtn setTitle:@"收藏" forState:UIControlStateHighlighted];
            [self.collectBtn setTitleColor:RGBCOLOR(136, 136, 136) forState:UIControlStateNormal];
        }
        
        if ([dataSource getBool:@"IsRead"]) {
            
            [self.openRedPacketBtn setBackgroundColor:RGBCOLOR(204, 204, 204)];
            self.openRedPacketBtn.enabled = NO;
        }
        
        if ([merchantInfo getBool:@"IsVip"]) {
            
            [self.vipImageView setImage:[UIImage imageNamed:@"vip_selected"]];
        }else {

            [self.vipImageView setImage:[UIImage imageNamed:@"vip_normal"]];
        }
        
        if ([merchantInfo getBool:@"IsSilver"]) {
            
            [self.silverImageView setImage:[UIImage imageNamed:@"sliver_selected"]];
        }else {
        
            [self.silverImageView setImage:[UIImage imageNamed:@"sliver_normal"]];
        }
        
        if ([merchantInfo getBool:@"IsGold"]) {
            
            [self.goldImageView setImage:[UIImage imageNamed:@"gold_selected"]];
        }else {
            
            [self.goldImageView setImage:[UIImage imageNamed:@"gold_normal"]];
        }
    }else{
        
        [HUDUtil showErrorWithStatus:@"请求数据失败！"];
    }
}

//去商家官网
- (IBAction)gotoMerchantHomePage:(id)sender {

    if (!_merchantUrl.length || [_merchantUrl isKindOfClass:[NSNull class]]) {
        
        [HUDUtil showErrorWithStatus:@"此商家没有官网"];
        return;
    }
    MerchantHomePageViewController *temp = WEAK_OBJECT(MerchantHomePageViewController, init);
    temp.merchantLinkUrl = _merchantUrl;
    [self.navigationController pushViewController:temp animated:YES];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

- (IBAction)numDialButton:(id)sender {
    
    if([CTSIMSupportGetSIMStatus() isEqualToString:kCTSIMSupportSIMStatusNotInserted]){
        
        [HUDUtil showErrorWithStatus:@"请先插入SIM卡"];
    }else{

        [[UICommon shareInstance]makeCall:_companyPhoneNumber.text];
    }
}

- (IBAction)clickCollectBtn:(id)sender {
    
    if (!_isCollected) {
        //收藏红包广告
        ADAPI_CollectRedPacketAds([self genDelegatorID:@selector(applyToCollectAds:)], self.adsId);
    }else {
        //取消收藏红包广告
        ADAPI_CancelCollectRedPacketAds([self genDelegatorID:@selector(cancleCollectingAds:)], self.adsId);
    }
}

- (void)applyToCollectAds:(DelegatorArguments*)arguments {

    DictionaryWrapper *wrapper = arguments.ret;
    if (wrapper.operationSucceed) {
        
        _isCollected = YES;
        [self.collectBtn setImage:[UIImage imageNamed:@"alreadyCollected"] forState:UIControlStateNormal];
        [self.collectBtn setImage:[UIImage imageNamed:@"alreadyCollectedhover"] forState:UIControlStateHighlighted];
        [self.collectBtn setTitle:@"已收藏" forState:UIControlStateNormal];
        [self.collectBtn setTitle:@"已收藏" forState:UIControlStateHighlighted];
        [self.collectBtn setTitleColor:RGBCOLOR(240, 5, 0) forState:UIControlStateNormal];
        [HUDUtil showSuccessWithStatus:@"收藏成功"];
    }else {
    
        return;
    }
}

- (void)cancleCollectingAds:(DelegatorArguments*)arguments {

    DictionaryWrapper *wrapper = arguments.ret;
    if (wrapper.operationSucceed) {
        _isCollected = NO;
        [self.collectBtn setImage:[UIImage imageNamed:@"collect"] forState:UIControlStateNormal];
        [self.collectBtn setImage:[UIImage imageNamed:@"collecthover"] forState:UIControlStateHighlighted];
        [self.collectBtn setTitle:@"收藏" forState:UIControlStateNormal];
        [self.collectBtn setTitle:@"收藏" forState:UIControlStateHighlighted];
        [self.collectBtn setTitleColor:RGBCOLOR(136, 136, 136) forState:UIControlStateNormal];
        [HUDUtil showSuccessWithStatus:@"取消收藏"];
    }else {
        
        return;
    }
}

//点击咨询按钮
- (IBAction)consultFun:(id)sender {
    
    //3.3需求
    DictionaryWrapper * dic =[APP_DELEGATE.runtimeConfig getDictionary:RUNTIME_USER_LOGIN_INFO].wrapper;
    
    //判断是否商家
    if ([dic getInt:@"EnterpriseStatus"] == 4)//已激活商家
    {
        ConsultViewController* temp = WEAK_OBJECT(ConsultViewController, init);
        NSDictionary *tempDic = @{@"Id":[NSString stringWithFormat:@"%d",_adsId],@"Type":@"2"};
        temp.commitDic = [NSMutableDictionary dictionaryWithDictionary:tempDic];
        [self.navigationController pushViewController:temp animated:YES];
        
    }
    else
    {
        //实名认证非认证成功
        if ([dic getInt:@"IdentityStatus"] == 0 || [dic getInt:@"IdentityStatus"] == 2)
        {
            __block typeof(self) weakself = self;
            [AlertUtil showAlert:@"实名认证" message:@"通过实名认证才能咨询商家" buttons:@[@"确定",@{
                                                                               @"title":@"去认证",
                                                                               @"delegator":ALERT_VIEW_DELEGATOR_BLOCK
                                                                               ({
                [weakself.navigationController pushViewController:WEAK_OBJECT(RealNameAuthenticationViewController, init) animated:YES];
            })
                                                                               }]];
        }
        else if ([dic getInt:@"IdentityStatus"] == 3)
        {
            [HUDUtil showErrorWithStatus:@"你的实名认证还在审核中！"];
        }
    }
}

//拆红包按钮
- (IBAction)openRedPocketFunc:(id)sender {
    
    [APP_MTA MTA_touch_From:MTAEVENT_get_red_packet];
    
    DictionaryWrapper *wrapper = [[APP_DELEGATE.userConfig get:@"THEREDPACKETLIMIT"] wrapper];
    
    //商家信息
    DictionaryWrapper *dic = [APP_DELEGATE.runtimeConfig getDictionary:RUNTIME_USER_LOGIN_INFO].wrapper;
    int vipLevel = [dic getInt:@"VipLevel"];
    
    if ([[wrapper get:@"time"] isEqualToString:_todayStr]&&[[wrapper getString:@"ifReachLimit"] isEqualToString:@"1"]&&_oldVipLevel == vipLevel) {
        
        if (vipLevel == 0) {
         
            [AlertUtil showAlert:@"收满啦！"
                         message:@"普通用户每天最多收取5元，成为VIP可收取更多！"
                         buttons:@[
                                   @{
                                       @"title":@"以后再说",
                                       @"delegator":ALERT_VIEW_DELEGATOR_BLOCK({
                return;
            })},
                                   @{
                                       @"title":@"成为用户VIP",
                                       @"delegator":ALERT_VIEW_DELEGATOR_BLOCK({
                PUSH_VIEWCONTROLLER(VipPriviliegeViewController);
            })}]];
        }else if(vipLevel == 7) {
            
            [AlertUtil showAlert:@"收满啦！"
                         message:@"今天您已收满12元了，邀请粉丝帮您收红包，每天最多可赚取1万元！"
                         buttons:@[
                                   @{
                                       @"title":@"以后再说",
                                       @"delegator":ALERT_VIEW_DELEGATOR_BLOCK({
                return;
            })},
                                   @{
                                       @"title":@"邀请粉丝",
                                       @"delegator":ALERT_VIEW_DELEGATOR_BLOCK({
                //邀请粉丝
                [[Share_Method shareInstance] getShareDataWithShareData:@{@"Key":@"b48f4584ef5fb324cf5c4a803ed8e575"}];
            })}]];
            return;
        }else {
            
            [AlertUtil showAlert:@"收满啦！"
                         message:[NSString stringWithFormat:@"VIP用户每天最多收取%d元，升级VIP可收取更多！",vipLevel+5]
                         buttons:@[
                                   @{
                                       @"title":@"以后再说",
                                       @"delegator":ALERT_VIEW_DELEGATOR_BLOCK({
                return;
            })},
                                   @{
                                       @"title":@"升级用户VIP",
                                       @"delegator":ALERT_VIEW_DELEGATOR_BLOCK({
                PUSH_VIEWCONTROLLER(VipPriviliegeViewController);
            })}]];
                return;
        }
        
    }else {
        
        ADAPI_OpenRedPacket([self genDelegatorID:@selector(handleOpenRedPacket:)], [NSString stringWithFormat:@"%i",_adsId]);
    }
}

- (void)handleOpenRedPacket:(DelegatorArguments*)arguments {

    DictionaryWrapper *wrapper = arguments.ret;
    
    if (wrapper.operationSucceed) {
     
        [PlaySound playSound:@"OpenRedPacketV" type:@"mp3"];
        
        DictionaryWrapper *dataSource = wrapper.data;
        _moneyInRedPacket = [dataSource getFloat:@"MoneyToEarn"];
        [self.openRedPacketBtn setBackgroundColor:RGBCOLOR(204, 204, 204)];
        self.openRedPacketBtn.enabled = NO;
        [self imageAnmation];
        
        NSString *temp;
        if ([dataSource getBool:@"IsReachedDailyMax"]) {
            
            temp = @"1";
        }else {
        
            temp = @"0";
        }
        
        WDictionaryWrapper *wrapper = WEAK_OBJECT(WDictionaryWrapper, init);
        [wrapper set:@"time" string:_todayStr];
        [wrapper set:@"ifReachLimit" string:temp];
        [APP_DELEGATE.userConfig set:@"THEREDPACKETLIMIT" value:wrapper.dictionary];
        
//        [self.navigationController popViewControllerAnimated:YES];
        
    }else {
    
        DictionaryWrapper *dic = [APP_DELEGATE.runtimeConfig getDictionary:RUNTIME_USER_LOGIN_INFO].wrapper;
        int vipLevel = [dic getInt:@"VipLevel"];
        
        if (vipLevel == 0) {
            
            [AlertUtil showAlert:@"收满啦！"
                         message:@"普通用户每天最多收取5元，成为VIP可收取更多！"
                         buttons:@[
                                   @{
                                       @"title":@"以后再说",
                                       @"delegator":ALERT_VIEW_DELEGATOR_BLOCK({
                return;
            })},
                                   @{
                                       @"title":@"成为用户VIP",
                                       @"delegator":ALERT_VIEW_DELEGATOR_BLOCK({
                PUSH_VIEWCONTROLLER(VipPriviliegeViewController);
            })}]];
        }else if(vipLevel == 7) {
            
            [AlertUtil showAlert:@"收满啦！"
                         message:@"今天您已收满12元了，邀请粉丝帮您收红包，每天最多可赚取1万元！"
                         buttons:@[
                                   @{
                                       @"title":@"以后再说",
                                       @"delegator":ALERT_VIEW_DELEGATOR_BLOCK({
                return;
            })},
                                   @{
                                       @"title":@"邀请粉丝",
                                       @"delegator":ALERT_VIEW_DELEGATOR_BLOCK({
                //邀请粉丝
                [[Share_Method shareInstance] getShareDataWithShareData:@{@"Key":@"b48f4584ef5fb324cf5c4a803ed8e575"}];
            })}]];
            return;
        }else {
            
            [AlertUtil showAlert:@"收满啦！"
                         message:[NSString stringWithFormat:@"VIP用户每天最多收取%d元，升级VIP可收取更多！",vipLevel+5]
                         buttons:@[
                                   @{
                                       @"title":@"以后再说",
                                       @"delegator":ALERT_VIEW_DELEGATOR_BLOCK({
                return;
            })},
                                   @{
                                       @"title":@"升级用户VIP",
                                       @"delegator":ALERT_VIEW_DELEGATOR_BLOCK({
                PUSH_VIEWCONTROLLER(VipPriviliegeViewController);
            })}]];
            return;
        }
        return;
    }
}

#pragma mark - ScrollerWithTimeDelegate
- (void)scrollerPictureClicked:(int)indexCount {
    
    PreviewViewController *temp = WEAK_OBJECT(PreviewViewController, init);
    temp.currentPage = indexCount;
    temp.dataArray = _pictureArray;
    [self.navigationController presentViewController:temp animated:YES completion:^{}];
}
#pragma mark - 事件
//图片动画
-(void)imageAnmation{
    
    if (!_moneyImageView) {
        self.moneyImageView = WEAK_OBJECT(UIImageView, initWithFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y - 150, self.view.frame.size.width, self.view.frame.size.height));
    }
    NSLog(@"%@",NSStringFromCGRect(self.view.frame));
    self.moneyImageView.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:_moneyImageView];
    NSMutableArray *imageArray = [NSMutableArray new] ;
    for (int i = 1; i < 27; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"合成 %d.png",i]];
        [imageArray  addObject:image];
    }
    
    self.moneyImageView.animationImages = imageArray;
    self.moneyImageView.animationDuration = 1.5;
    [_moneyImageView startAnimating];
    [imageArray release];
    [self performSelector:@selector(textFieldAnimation:) withObject:nil afterDelay:0.7];
    [self performSelector:@selector(stopAnimationed) withObject:nil afterDelay:1.5];
}

- (void)stopAnimationed{
    
    [_moneyImageView stopAnimating];
    [_moneyImageView removeFromSuperview];
    
//    [self.navigationController popViewControllerAnimated:YES];
}

//文字动画
- (void)textFieldAnimation:(NSString *)text{
    UILabel *lblIntegralNum = WEAK_OBJECT(UILabel, initWithFrame:CGRectMake(0, self.view.height / 3 * 2 - 75, SCREENWIDTH, 21));
    lblIntegralNum.text = [NSString stringWithFormat:@"+%.2f元",_moneyInRedPacket];
    lblIntegralNum.font = Font(11);
    lblIntegralNum.textAlignment = NSTextAlignmentCenter;
    lblIntegralNum.alpha = 0.5;
    lblIntegralNum.textColor = RGBCOLOR(240, 5, 0);
    lblIntegralNum.tag = 100000;
    [self.view addSubview:lblIntegralNum];
    
    [self wordAnimation];
}

- (void)wordAnimation{
    
    CAKeyframeAnimation *scale = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    
    CATransform3D scaleUp = CATransform3DMakeScale(2.5, 2.5, 1); // Scale in x and y
    CATransform3D rotationScaled = CATransform3DRotate (scaleUp, 0, 0, 0, 1); // Rotate the scaled font
    
    [scale setValues:[NSArray arrayWithObjects:
                      [NSValue valueWithCATransform3D:CATransform3DIdentity],
                      [NSValue valueWithCATransform3D:rotationScaled],
                      nil]];
    
    // set the duration
    [scale setDuration: 1.0];
    
    UIView *v = [self.view viewWithTag:100000];
    
    // animate your label layer
    if (v) {
        [[v layer] addAnimation:scale forKey:@"scaleText"];
    }

    __block typeof(self) weakSelf = self;
    [UIView animateWithDuration:1 animations:^{
        v.alpha = 1.f;
        v.top = weakSelf.view.height / 3 - 75;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1.0 animations:^{
            v.alpha = 0.f;
        } completion:^(BOOL finished) {
            [v removeFromSuperview];
            [self.navigationController popViewControllerAnimated:YES];
        }];
    }];
}
- (void)setFrame:(NSString*)str {
    
    CGSize content = [str sizeWithFont:companyInfoLabel.font constrainedToSize:CGSizeMake(300,MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];

    companyInfoLabel.text = str;
    
    [companyInfoView setFrame:CGRectMake(0, 351, _mainScrollerView.frame.size.width, 49+content.height+10)];
    
    [companyInfoLabel setFrame:CGRectMake(15, 34, 290,content.height+10)];
    
    [self.UILineView4 setFrame:CGRectMake(0, 0, 320, 0.5)];
    [self.UILineView5 setFrame:CGRectMake(0, companyInfoView.frame.size.height - 0.5, 320, 0.5)];
    
    [bottomView setFrame:CGRectMake(0, companyInfoView.frame.origin.y+companyInfoView.frame.size.height+10+1, 320, 214 + extraAddressHeight)];
    
    _buttomOprationView.frame = CGRectMake(0, bottomView.frame.origin.y + bottomView.frame.size.height + 10, 320, 60);
    
    [_mainScrollerView setContentSize:CGSizeMake(_mainScrollerView.frame.size.width, 351+companyInfoView.frame.size.height+10+bottomView.frame.size.height+10 + _buttomOprationView.frame.size.height)];
}

- (void)dealloc {
    [_pictureArray release];
    [_todayStr release];
    [_merchantId release];
    [_merchantUrl release];
    [_companyName release];
    [_companyAddress release];
    [_companyLogo release];
    [_mainScrollerView release];
    [_buttomOprationView release];
    [_adScrollerView release];
    [bottomView release];
    [companyInfoView release];
    [companyInfoLabel release];
    [_collectBtn release];
    [_adsName release];
    [_adsWord release];
    [_companyPhoneNumber release];
    [_vipImageView release];
    [_silverImageView release];
    [_goldImageView release];
    [_openRedPacketBtn release];
    [_labelOnTheTopOfAddress release];
    [_consultBtn release];
    [_UILineView release];
    [_UILineView2 release];
    [_UILineView3 release];
    [_UILineView4 release];
    [_UILineView5 release];
    [_UILineView6 release];
    [_UILineView7 release];
    [_UILineView8 release];
    [_UILineView9 release];
    [_toMerchantHomePageBtn release];
    [_littleArrowToHomePage release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setTodayStr:nil];
    self.delegate = nil;
    [self setCompanyName:nil];
    [self setCompanyLogo:nil];
    [self setMainScrollerView:nil];
    [self setButtomOprationView:nil];
    [self setAdScrollerView:nil];
    [self setPictureArray:nil];
    [bottomView release];
    bottomView = nil;
    [companyInfoView release];
    companyInfoView = nil;
    [companyInfoLabel release];
    companyInfoLabel = nil;
    [super viewDidUnload];
}
@end
