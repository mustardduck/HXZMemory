//
//  AccAdsDetailViewController.m
//  miaozhuan
//
//  Created by 孙向前 on 14-12-12.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "AccAdsDetailViewController.h"
#import "NetImageView.h"
#import "RCScrollView.h"
#import "PreviewViewController.h"
#import "AddAccurateAdsViewController.h"
#import "BannerDetailViewController.h"
#import "ScrollerViewWithTime.h"
#import "RRLineView.h"
#import "MerchantDetailViewController.h"
#import "UI_CycleScrollView.h"


@interface AccAdsDetailViewController ()<UI_CycleScrollViewDelegate>{
    ScrollerViewWithTime *_recommandBanner;
}

@property (retain, nonatomic) IBOutlet UIView *companyView;
@property (retain, nonatomic) IBOutlet UIScrollView *scrollview;
@property (retain, nonatomic) IBOutlet UIView *contentView;
@property (retain, nonatomic) IBOutlet UIView *phoneAndAddressView;
@property (retain, nonatomic) IBOutlet UIView *mainView;
//ads
@property (retain, nonatomic) IBOutlet UILabel *lblAdsName;
@property (retain, nonatomic) IBOutlet UILabel *lblAdsWord;
//company
@property (retain, nonatomic) IBOutlet NetImageView *imgLogo;
@property (retain, nonatomic) IBOutlet UILabel *lblCompanyName;
@property (retain, nonatomic) IBOutlet UIButton *btnIsVip;
@property (retain, nonatomic) IBOutlet UIButton *btnSliver;
@property (retain, nonatomic) IBOutlet UIButton *btnGold;
@property (retain, nonatomic) IBOutlet UIButton *btnDirect;
//conten
@property (retain, nonatomic) IBOutlet UILabel *lblContent;
@property (retain, nonatomic) IBOutlet UILabel *lblMobile;
@property (retain, nonatomic) IBOutlet UIButton *btnMobile;
@property (retain, nonatomic) IBOutlet UILabel *lblAddress;
@property (retain, nonatomic) IBOutlet UIView *addressView;
@property (retain, nonatomic) IBOutlet UIImageView *lineAddr;
@property (retain, nonatomic) IBOutlet UIView *phoneView;

@property (retain, nonatomic) IBOutlet UIView *bottomView;
@property (retain, nonatomic) IBOutlet UIScrollView *picScrollView;
@property (retain, nonatomic) IBOutlet UIImageView *imgArrow;

@property (retain, nonatomic) DictionaryWrapper *dataDic;//所有数据
@property (nonatomic, retain) RCScrollView *bannerView;
@property (nonatomic, retain) RCScrollView *largeBannerView;
@property (nonatomic, retain) UI_CycleScrollView *cycleView;

@end

@implementation AccAdsDetailViewController

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupMoveBackButton];
    
    ADAPI_DirectAdvert_LoadAdvert([GLOBAL_DELEGATOR_MANAGER addDelegator:self selector:@selector(handleAdsDetail:)], _directAdvertId);
    
    _bottomView.hidden = (_state != 6);
    if (_state == 6) {
        _scrollview.height -= 60;
    }
}

#pragma mark - banner
- (void)createBannerViewWithImages:(NSArray *)images{
    
    if (!images.count) {
        return;
    }
    NSMutableArray *imgs = [NSMutableArray array];
    for (int i = 0; i < images.count; i++)
    {
        [imgs addObject:[[images[i] wrapper] getString:@"PictureUrl"]];
    }
//
//    CGSize tempsize = {150,217};
//    if (!_recommandBanner) {
//        _recommandBanner = [[ScrollerViewWithTime controllerFromView:_picScrollView pictureSize:tempsize] retain];
//    }
//    
//    [_recommandBanner addImageItems:imgs];
//    
//    __block typeof(self) weakself = self;
//    _recommandBanner.TapActionBlock = ^(NSInteger pageIndex){
//        
//        PreviewViewController *model = WEAK_OBJECT(PreviewViewController, init);
//        model.currentPage = pageIndex;
//        model.dataArray = [_dataDic getArray:@"Pictures"];
//        [weakself presentViewController:model animated:NO completion:nil];
//    };

    _cycleView = [[UI_CycleScrollView alloc] initWithFrame:_picScrollView.frame];
    _cycleView.delegate = self;
    [_picScrollView addSubview:_cycleView];
    
    [_cycleView setPictureUrls:[NSMutableArray arrayWithArray:imgs]];

}

-(void)CycleImageTap:(int)page {
    
    PreviewViewController *model = WEAK_OBJECT(PreviewViewController, init);
    model.currentPage = page;
    model.dataArray = [_dataDic getArray:@"Pictures"];
    [self presentViewController:model animated:NO completion:nil];
}

#pragma mark - 网络请求数据回调
- (void)handleAdsDetail:(DelegatorArguments *)arguments{
    DictionaryWrapper* dic = arguments.ret;
    if (dic.operationSucceed)
    {
        _scrollview.hidden = NO;
        self.dataDic = [dic.data wrapper];
        if (!_dataDic || [_dataDic isKindOfClass:[NSNull class]]) {
            return;
        }
        
        [self refresh:_dataDic];
    }
    else
    {
        [HUDUtil showErrorWithStatus:dic.operationMessage];
        return;
    }
    
}
- (void)refresh:(DictionaryWrapper *)dic{
    
    NSString *url = [_dataDic getString:@"LinkUrl"];
//    _imgArrow.hidden = !url.length;
    
    //创建banner
    [self createBannerViewWithImages:[dic get:@"Pictures"]];
    
    //广告信息
    self.navigationItem.title = _lblAdsName.text = [dic getString:@"Name"];
    _lblAdsWord.text = [dic getString:@"Slogan"];
    
    //企业信息
    if (![[dic get:@"EnterpriseInfo"] isKindOfClass:[NSNull class]]) {
        DictionaryWrapper *enInfos = [[dic get:@"EnterpriseInfo"] wrapper];
        _lblCompanyName.text = [enInfos getString:@"Name"];
        [_imgLogo setRoundCorner:11];
        [_imgLogo requestWithRecommandSize:[enInfos getString:@"LogoUrl"]];
        //银、金、直icon位置
        _btnGold.selected = [enInfos getBool:@"IsGold"];
        _btnDirect.selected = [enInfos getBool:@"IsDirect"];
        _btnIsVip.selected = [enInfos getBool:@"IsVip"];
        _btnSliver.selected = [enInfos getBool:@"IsSilver"];
    }
    
    //电话位置、商家地址位置
    [self setMobileButtonPosition:dic];
    //scrollview动态高度
    [self setHeightForScrollView:[dic getString:@"Description"]];
}
#pragma mark - 高度位置计算

//电话按钮位置和地址高度
- (void)setMobileButtonPosition:(DictionaryWrapper *)dic{
    _phoneAndAddressView.height = 0;
    NSString *phone = [dic getString:@"Phone"];
    if (phone.length) {
        //电话
        CGSize size = [UICommon getSizeFromString:phone
                                         withSize:CGSizeMake(MAXFLOAT, 21)
                                         withFont:19];
        _lblMobile.width = size.width;
        _lblMobile.text = [dic getString:@"Phone"];
        _phoneAndAddressView.height += _phoneView.height;
    } else {
        _addressView.top = _phoneView.top;
        _phoneView.hidden = YES;
        _lineAddr.hidden = YES;
    }
    NSString *address = [dic getString:@"Address"];
    if (address.length) {
        //地址
        CGSize addressSize = [UICommon getSizeFromString:address
                                                withSize:CGSizeMake(_lblAddress.width, MAXFLOAT)
                                                withFont:14];
        _lblAddress.height = addressSize.height < 21 ? 21 : addressSize.height;
        _lblAddress.text = [dic getString:@"Address"];
        _addressView.height = _lblAddress.bottom;
        _phoneAndAddressView.height += _addressView.height + 10;
    } else {
        _addressView.hidden = YES;
    }
}

//计算scrollview高度并动态改变
- (void)setHeightForScrollView:(NSString *)content{
    
    //contentview height
    CGSize size = [UICommon getSizeFromString:content
                                     withSize:CGSizeMake(_lblContent.width, MAXFLOAT)
                                     withFont:14];
    _lblContent.text = content;
    _lblContent.height = size.height < 21 ? 21 : size.height;
    _contentView.height = 45 + _lblContent.height;
    
    //company view y
    _companyView.top = _contentView.bottom + 10;
    
    //_phoneAndAddressView y
    _phoneAndAddressView.top = _companyView.bottom;
    
    //mainview height
    _mainView.height = _phoneAndAddressView.bottom;

    //mainview contentsize height
    RRLineView *line = WEAK_OBJECT(RRLineView, initWithFrame:CGRectMake(0, _phoneAndAddressView.bottom, SCREENWIDTH, 0.5));
    [_scrollview addSubview:line];
    _scrollview.contentSize = CGSizeMake(SCREENWIDTH, _mainView.bottom + 10);
}
//继续投放
- (IBAction)continueClicked:(id)sender {
    AddAccurateAdsViewController *add = WEAK_OBJECT(AddAccurateAdsViewController, init);
    add.directAdvertId = self.directAdvertId;
    [[NSUserDefaults standardUserDefaults] setBool:(_state == 6) forKey:@"ClearTime"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [UI_MANAGER.mainNavigationController pushViewController:add animated:YES];
}
//商家官网
- (IBAction)merchantClicked:(id)sender {
    NSString *url = [_dataDic getString:@"LinkUrl"];
    if (!url.length) {
        [HUDUtil showErrorWithStatus:@"此商家没有官网"];return;
    }
    BannerDetailViewController *banner = [[BannerDetailViewController alloc] init];
    banner.urlStr = url;
    [self.navigationController pushViewController:banner animated:YES];
}
//拨打电话
- (IBAction)makecallClicked:(id)sender {
    [[UICommon shareInstance]makeCall:[_dataDic getString:@"Phone"]];
}
//商家详情
- (IBAction)shoperClicked:(id)sender {
    PUSH_VIEWCONTROLLER(MerchantDetailViewController);
    model.comefrom = @"0";
    model.enId = [[_dataDic getDictionaryWrapper:@"EnterpriseInfo"] getString:@"Id"];
}

#pragma mark - 内存管理
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc{
    
    [_recommandBanner release];
    [_lineAddr release];
    [_addressView release];
    [_phoneView release];
    [_largeBannerView release];
    [_lblAdsName release];
    [_lblAdsWord release];
    [_imgLogo release];
    [_lblCompanyName release];
    [_btnDirect release];
    [_btnGold release];
    [_btnIsVip release];
    [_btnSliver release];
    [_lblContent release];
    [_lblMobile release];
    [_lblAddress release];
    [_btnMobile release];
    [_mainView release];
    [_phoneAndAddressView release];
    [_contentView release];
    [_scrollview release];
    [_companyView release];


    [_bottomView release];
    [_picScrollView release];
    [_imgArrow release];
    [super dealloc];
}

- (void)viewDidUnload {
    [self setBottomView:nil];
    [self setPicScrollView:nil];
    [self setImgArrow:nil];
    [super viewDidUnload];
}
@end
