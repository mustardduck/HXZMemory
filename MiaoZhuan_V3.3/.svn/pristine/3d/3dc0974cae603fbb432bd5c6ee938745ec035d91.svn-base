//
//  PSAsDetailController.m
//  miaozhuan
//
//  Created by momo on 15/3/16.
//  Copyright (c) 2015年 zdit. All rights reserved.
//

#import "PSAsDetailController.h"
#import "NetImageView.h"
#import "GoodsListViewCell.h"
#import "PSOrganizationInfoViewController.h"
#import "DelegatorManager.h"
#import "BannerDetailViewController.h"
#import "RCScrollView.h"
#import "ConsultViewController.h"
#import "PreviewViewController.h"
#import "Share_Method.h"
#import "VipPriviliegeViewController.h"
#import "Redbutton.h"
#import "ScrollerViewWithTime.h"
#import "PlaySound.h"
#import "CRSliverDetailViewController.h"
#import "VoiceControl.h"
#import "RRLineView.h"
#import "PreviewViewController.h"
#import "KxMenu.h"

#import "CRDateCounter.h"

@interface PSAsDetailController ()<KxMenuDelegate>{
    UIImageView *moneyImageView;
    ScrollerViewWithTime *_recommandBanner;
    BOOL _notOnceADay;
}

@property (retain, nonatomic) IBOutlet UIScrollView *scrollview;

@property (retain, nonatomic) IBOutlet UIView *mainView;

@property (retain, nonatomic) IBOutlet UIView *companyView;

@property (retain, nonatomic) IBOutlet UIView *phoneAndAddressView;

@property (retain, nonatomic) IBOutlet UIView *contentView;

@property (retain, nonatomic) IBOutlet UIScrollView *picScrollView;

@property (retain, nonatomic) IBOutlet UILabel *lblContent;

@property (retain, nonatomic) IBOutlet RRLineView *line1;

@property (retain, nonatomic) IBOutlet UILabel *lblCompanyName;

@property (retain, nonatomic) IBOutlet NetImageView *imgLogo;

@property (retain, nonatomic) IBOutlet UIView *phoneView;

@property (retain, nonatomic) IBOutlet UIView *addressView;

@property (retain, nonatomic) IBOutlet UILabel *lblMobile;

@property (retain, nonatomic) IBOutlet UIButton *btnMobile;

@property (retain, nonatomic) IBOutlet UILabel *lblAddress;

@property (retain, nonatomic) IBOutlet UIButton *btnCollect;

@property (retain, nonatomic) IBOutlet UILabel *lblIsCollection;

@property (retain, nonatomic) IBOutlet Redbutton *btnPickS;

@property (retain, nonatomic) IBOutlet UILabel *lblTtName;

@property (nonatomic, assign) int integralNum;
@property (retain, nonatomic) DictionaryWrapper *dataDic;//所有数据
@property (nonatomic, retain) NSArray *dataArray;//tableview数据源
@property (nonatomic, retain) RCScrollView *bannerView;
@property (nonatomic, retain) RCScrollView *largeBannerView;
@property (retain, nonatomic) IBOutlet UIView *btnVIew;

@property (nonatomic, retain) IBOutlet UIView *alphaView;       //公益动画后，蒙层，防止无限操作

@end

@implementation PSAsDetailController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupMoveBackButton];
    
    [self setupMoveFowardButtonWithImage:@"more" In:@"morehover"];

    _lblTtName.left = 80;
    _lblTtName.width = 160;
    self.navigationItem.titleView = _lblTtName;
    
    //数据源
    [self getDataFromRequest];
    
    self.btnPickS.enabled = !_notShow;
    
    if(_btnPickS.enabled)
    {
        self.btnPickS.backgroundColor = AppColorRed;
    }
    else
    {
        self.btnPickS.backgroundColor = AppColorLightGray204;
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - banner
- (void)createBannerViewWithImages:(NSArray *)images{
    
    if (!images.count) {
        return;
    }
    CGSize tempsize = {270,390};
    if (!_recommandBanner) {
        _recommandBanner = [[ScrollerViewWithTime controllerFromView:_picScrollView andPSAsPictureSize:tempsize] retain];
    }
    
    [_recommandBanner addImageItems:images];
    
    __block typeof(self) weakself = self;
    _recommandBanner.TapActionBlock = ^(NSInteger pageIndex){
        PreviewViewController *model = WEAK_OBJECT(PreviewViewController, init);
        model.currentPage = pageIndex;
        NSMutableArray *pics = [NSMutableArray array];
        for (NSString *url in [_dataDic getArray:@"Pictures"]) {
            [pics addObject:@{@"PictureUrl" : url}];
        }
        model.dataArray = pics;
        [weakself presentViewController:model animated:NO completion:nil];
    };
}

#pragma mark - 网络请求
//获取表格数据源
- (void)getDataFromRequest{
    
    ADAPI_adv23_publicServiceAdvertDetails([GLOBAL_DELEGATOR_MANAGER addDelegator:self selector:@selector(handlePSAsDetail:)], _adId.length ? _adId : @"");
}

- (void)refresh:(DictionaryWrapper *)dic{
    //创建banner
    [self createBannerViewWithImages:[dic get:@"Pictures"]];
    
    //广告信息
    _lblTtName.text = [dic getString:@"Title"];
    
    //企业信息
    DictionaryWrapper *enInfos = [[dic get:@"PublicOrgInfo"] wrapper];
    _lblCompanyName.text = [enInfos getString:@"Name"];
    [_imgLogo setRoundCorner:11];
    [_imgLogo requestWithRecommandSize:[enInfos getString:@"LogoUrl"]];
    
    _btnCollect.selected = [dic getBool:@"IsCollect"];
    if (_btnCollect.selected) {
        _lblIsCollection.text = @"已收藏";
        _lblIsCollection.textColor = RGBCOLOR(240, 5, 0);
    } else {
        _lblIsCollection.text = @"收藏";
        _lblIsCollection.textColor = RGBCOLOR(136, 136, 136);
    }
    
    //电话位置、商家地址位置
    [self setMobileButtonPosition:dic];
    //scrollview动态高度
    [self setHeightForScrollView:[dic getString:@"Content"]];
}

- (void)handlePSAsDetail:(DelegatorArguments *)arguments{
    DictionaryWrapper* dic = arguments.ret;
    if (dic.operationSucceed)
    {
        _scrollview.hidden = NO;
        self.dataDic = [dic.data wrapper];
        [self refresh:_dataDic];
    }
    else
    {
        [HUDUtil showErrorWithStatus:dic.operationMessage];
        return;
    }
}

#pragma mark - 高度位置计算

//电话按钮位置和地址高度
- (void)setMobileButtonPosition:(DictionaryWrapper *)dic{
    _phoneAndAddressView.height = 0;
    if ([dic getBool:@"IsShowTel"]) {
        //电话
        CGSize size = [UICommon getSizeFromString:[dic getString:@"Tel"]
                                         withSize:CGSizeMake(MAXFLOAT, 21)
                                         withFont:19];
        _lblMobile.width = size.width;
        _lblMobile.text = [dic getString:@"Tel"];
        _phoneAndAddressView.height += _phoneView.height;
    } else {
        _addressView.top = _phoneView.top;
        _phoneView.hidden = YES;
    }
    if ([dic getBool:@"IsShowAddress"]) {
        //地址
        CGSize addressSize = [UICommon getSizeFromString:[dic getString:@"Address"]
                                                withSize:CGSizeMake(_lblAddress.width, MAXFLOAT)
                                                withFont:14];
        _lblAddress.height = addressSize.height;
        _lblAddress.text = [dic getString:@"Address"];
        _addressView.height = addressSize.height + 32;//_lblAddress.bottom < 50 ? 50 : _lblAddress.bottom;
        _phoneAndAddressView.height += _addressView.height + 10;
    } else {
        _addressView.hidden = YES;
    }
    
    if ([dic getBool:@"IsShowTel"] && [dic getBool:@"IsShowAddress"]) {
        RRLineView *templine = WEAK_OBJECT(RRLineView, initWithFrame:CGRectMake(15, _phoneView.bottom - 5, SCREENWIDTH, 0.5));
        [_phoneAndAddressView addSubview:templine];
    }
}

//计算scrollview高度并动态改变
- (void)setHeightForScrollView:(NSString *)content{
    
    //contentview height
    CGSize size = [UICommon getSizeFromString:content
                                     withSize:CGSizeMake(_lblContent.width, MAXFLOAT)
                                     withFont:14];
    _lblContent.text = content;
    _lblContent.height = size.height;
    _contentView.height = 50 + size.height;
    _line1.top =_contentView.height;
    
    //company view y
    _companyView.top = _contentView.bottom + 10;
    
    //_phoneAndAddressView y
    _phoneAndAddressView.top = _companyView.bottom;
    
    //mainview height
    _mainView.height = _phoneAndAddressView.bottom;
    
    _btnVIew.top = _mainView.bottom + 10;
    
    //mainview contentsize height
    RRLineView *line = WEAK_OBJECT(RRLineView, initWithFrame:CGRectMake(0, _phoneAndAddressView.bottom, SCREENWIDTH, 0.5));
    [_mainView addSubview:line];

    _scrollview.contentSize = CGSizeMake(SCREENWIDTH, _btnVIew.bottom);
}

- (void) goToOrganization
{
    NSString *orgId = [[[_dataDic get:@"PublicOrgInfo"] wrapper] getString:@"Id"];
    if (!orgId.length) {
        return;
    }
    PSOrganizationInfoViewController *merchant = WEAK_OBJECT(PSOrganizationInfoViewController, init);
    merchant.orzId = orgId;
    merchant.comeFrom = @"1";
    [UI_MANAGER.mainNavigationController pushViewController:merchant animated:YES];
}

- (IBAction)shopdetailClicked:(id)sender {

    [self goToOrganization];
}

//拨打电话
- (IBAction)makeCallClicked:(id)sender {
    [[UICommon shareInstance]makeCall:_lblMobile.text];
}

//商家详情
- (IBAction)onMoveFoward:(UIButton*) sender{
    
    // show menu
    if(![KxMenu isOpen])
    {
        NSMutableArray *menuItems = [NSMutableArray arrayWithCapacity:0];
        
//        if (!_notShow) {
//            [menuItems addObject:[KxMenuItem menuItem:@"组织详情"
//                                                image:[UIImage imageNamed:@"ads_detailIconnormal"]
//                                            highlight:[UIImage imageNamed:@"ads_detailIconhover"]
//                                               target:self
//                                               action:@selector(pushMenuItem:)]];
//        }
        
        [menuItems addObject:[KxMenuItem menuItem:@"组织详情"
                                            image:[UIImage imageNamed:@"ads_detailIconnormal"]
                                        highlight:[UIImage imageNamed:@"ads_detailIconhover"]
                                           target:self
                                           action:@selector(pushMenuItem:)]];
        
        [menuItems addObject:[KxMenuItem menuItem:@"分享给好友"
                                            image:[UIImage imageNamed:@"preview_menu_3_0"]
                                        highlight:[UIImage imageNamed:@"preview_menu_3_1"]
                                           target:self
                                           action:@selector(pushMenuItem:)]];
        
        CGRect rect = sender.frame;
        rect.origin.y = self.navigationController.navigationBar.frame.size.height;
        
        [KxMenu showMenuInView:self.navigationController.view
                      fromRect:rect
                     menuItems:menuItems
                     itemWidth:140.f];
        [KxMenu sharedMenu].delegate = self;
    }
    else
    {
        [KxMenu dismissMenu];
    }
    
    
}

//打开Menu
- (void) pushMenuItem:(id)sender
{
    //    NSLog(@"%@", sender);
}

-(void)which_tag_clicked:(int)tag
{
    if (tag == 1) {
        
        [[Share_Method shareInstance] getShareDataWithShareData:@{@"Key":@"3fc58c5dc91d41b1af6fd7f5e1a2e783", @"advert_id":_adId}];
        
    } else {//组织详情

        [self goToOrganization];
    }
}

//收藏
- (IBAction)collectionButtonClicked:(UIButton *)sender {
    if (!sender.selected) {
        ADAPI_adv3_CollectAdvert([GLOBAL_DELEGATOR_MANAGER addDelegator:self selector:@selector(handlePSACollect:)], [_adId intValue], 3);
    } else {
        ADAPI_adv3_RemoveAdvert([GLOBAL_DELEGATOR_MANAGER addDelegator:self selector:@selector(handlePSACollect:)], [_adId intValue], 3);
    }
}

- (IBAction)collectDownClicked:(UIButton *)sender {
    if (sender.selected) {
        _lblIsCollection.textColor = AppColorRed;
    } else {
        _lblIsCollection.textColor = AppColor(189);
    }
    
}

//收藏接口处理
- (void)handlePSACollect:(DelegatorArguments *)arguments{
    NSLog(@"%@",arguments.ret);
    DictionaryWrapper* dic = arguments.ret;
    
    if (dic.operationSucceed)
    {
        _btnCollect.selected = !_btnCollect.selected;
        if (_btnCollect.selected) {
            [HUDUtil showSuccessWithStatus:@"收藏成功"];
            _lblIsCollection.text = @"已收藏";
            _lblIsCollection.textColor = RGBCOLOR(240, 5, 0);
        } else {
            [HUDUtil showSuccessWithStatus:@"取消收藏"];
            _lblIsCollection.text = @"收藏";
            _lblIsCollection.textColor = RGBCOLOR(136, 136, 136);
        }
    }
    else
    {
        [HUDUtil showErrorWithStatus:dic.operationMessage];
        return;
    }
}

//继续
- (IBAction)nextAdsClicked:(UIButton *)sender
{
    if (!_adId.length || [_adId isKindOfClass:[NSNull class]]) {
        return;
    }
    
    ADAPI_publicServiceAdvertRead([GLOBAL_DELEGATOR_MANAGER addDelegator:self selector:@selector(handleRead:)],_adId);
    
    //打开蒙层
    _alphaView.hidden = NO;
}

- (void)handleRead:(DelegatorArguments *)arguments{
    DictionaryWrapper* dic = arguments.ret;
    if (dic.operationSucceed){
        [self imageAnmation];
    }
    else
    {
        //取消蒙层
        _alphaView.hidden = YES;
    }
}

-(void)imageAnmation{
    if (!moneyImageView) {
        CGRect frame = CGRectMake(0, 130 + 66, W(self.view.window), 62);
        
        moneyImageView = STRONG_OBJECT(UIImageView, initWithFrame:frame);
    }
    moneyImageView.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:moneyImageView];
    NSMutableArray *imageArray = [NSMutableArray new] ;
    for (int i = 1; i < 37; i++) {
        UIImage *image = nil;
        if(i == 19)
        {
            for (int j = 1; j < 11; j++)
            {
                image = [UIImage imageNamed:[NSString stringWithFormat:@"gy%d.png",i]];
                [imageArray  addObject:image];
            }
        }
        else if(i < 19 || i >= 29)
        {
            image = [UIImage imageNamed:[NSString stringWithFormat:@"gy%d.png",i]];
            [imageArray  addObject:image];
        }
    }
    
    moneyImageView.animationImages = imageArray;
    moneyImageView.animationDuration = 1.80f;
    moneyImageView.animationRepeatCount = 1;
    
    [moneyImageView startAnimating];
    [imageArray release];
    
    [self performSelector:@selector(stopAnimationed) withObject:nil afterDelay:1.8];
}
- (void)stopAnimationed{
    [moneyImageView stopAnimating];
    [moneyImageView removeFromSuperview];
    
    [self.navigationController popViewControllerAnimated:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"lookNextAds" object:nil];
}

- (void)dealloc {
    [moneyImageView release];
    [_adId release];
    [_largeBannerView release];
    [_dataArray release];
    [_imgLogo release];
    [_lblCompanyName release];
    [_lblContent release];
    [_lblMobile release];
    [_lblAddress release];
    [_btnMobile release];
    [_mainView release];
    [_phoneAndAddressView release];
    [_contentView release];
    [_scrollview release];
    [_companyView release];
    [_lblIsCollection release];
    [_addressView release];
    [_phoneView release];
    [_btnCollect release];
    [_btnPickS release];
    [_picScrollView release];
    [_lblTtName release];
    [_line1 release];

    [_btnVIew release];
    [_alphaView release];
    [super dealloc];
}

@end
