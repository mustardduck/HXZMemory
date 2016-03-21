//
//  YinYuanADsDetailController.m
//  miaozhuan
//
//  Created by momo on 14-12-22.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "YinYuanADsDetailController.h"
#import "NetImageView.h"
#import "RCScrollView.h"
#import "PreviewViewController.h"
#import "YinYuanAdvertEditController.h"
#import "MerchantDetailViewController.h"
#import "YinYuanADsDetailProductCell.h"
#import "UIView+expanded.h"
#import "MerchantHomePageViewController.h"
#import "ScrollerViewWithTime.h"
#import "CRSliverDetailViewController.h"

@interface YinYuanADsDetailController ()
{
    NSMutableArray * _prodArr;
    
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

@property (retain, nonatomic) DictionaryWrapper *dataDic;//所有数据
@property (nonatomic, retain) RCScrollView *bannerView;
@property (nonatomic, retain) RCScrollView *largeBannerView;
@property (retain, nonatomic) IBOutlet UIButton *linkBtn;

@property (retain, nonatomic) IBOutlet UIScrollView *picScrollView;

@end

@implementation YinYuanADsDetailController

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setupMoveBackButton];
    
    [_imgLogo roundCornerBorder];
    
    ADAPI_SilverAdvertEnterpriseGetAdvertDetail([GLOBAL_DELEGATOR_MANAGER addDelegator:self selector:@selector(handleAdsDetail:)], _advertId);
    
    _bottomView.hidden = (_state != PlayedADType);
    if (_state == PlayedADType) {
        _scrollview.height -= 60;
    }
    
    _prodArr = STRONG_OBJECT(NSMutableArray, init);
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
    
    CGSize tempsize = {150,220};
    if (!_recommandBanner) {
        _recommandBanner = [[ScrollerViewWithTime controllerFromView:_picScrollView pictureSize:tempsize] retain];
    }
    
    [_recommandBanner addImageItems:imgs];
    
    _recommandBanner.TapActionBlock = ^(NSInteger pageIndex){
    //预览
        PreviewViewController *preview = WEAK_OBJECT(PreviewViewController, init);
        preview.dataArray = images;
        preview.currentPage = pageIndex;
        [self presentViewController:preview animated:NO completion:^{}];
        
    };
}

#pragma mark - 网络请求数据回调
- (void)handleAdsDetail:(DelegatorArguments *)arguments{
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
- (void)refresh:(DictionaryWrapper *)dic{
    
    //创建banner
    [self createBannerViewWithImages:[dic getArray:@"Pictures"]];
    
    //广告信息
    self.navigationItem.title = _lblAdsName.text = [dic getString:@"Title"];
    _lblAdsWord.text = [dic getString:@"Slogan"];
    
    //企业信息
    if (![[dic get:@"EnterpriseBasicInfo"] isKindOfClass:[NSNull class]]) {
        DictionaryWrapper *enInfos = [[dic get:@"EnterpriseBasicInfo"] wrapper];
        _lblCompanyName.text = [enInfos getString:@"Name"];
        [_imgLogo requestWithRecommandSize:[enInfos getString:@"LogoUrl"]];
        //银、金、直icon位置
        _btnGold.selected = [enInfos getBool:@"IsGold"];
        _btnDirect.selected = [enInfos getBool:@"IsDirect"];
        _btnIsVip.selected = [enInfos getBool:@"IsVip"];
        _btnSliver.selected = [enInfos getBool:@"IsSilver"];
    }
    //没有官网不隐藏点击给提示
//    NSString * url = [_dataDic getString:@"LinkUrl"];
//    if(!url.length)
//    {
//        _contentView.top = 302;
//    }
    
    //电话位置、商家地址位置
    [self setMobileButtonPosition:dic];
    //scrollview动态高度
    [self setHeightForScrollView:[dic getString:@"Content"]];
    
    
    //有绑定兑换商品，重新算scrollview高度
    
    NSArray * productArr = [dic getArray:@"SilverProducts"];
    
    if(productArr.count)
    {
        [_prodArr removeAllObjects];
        
        [_prodArr addObjectsFromArray:productArr];
        
        [self calculateProductPicView];
        
        [_mainTableView reloadData];
    }
}

- (void) calculateProductPicView
{
    _yinyuanView.hidden = NO;
    
    _yinyuanView.top = _phoneAndAddressView.bottom;
    
    _mainTableView.height = 110 * _prodArr.count;
    
    _yinyuanView.height = _mainTableView.bottom;
    
    _mainView.height = _yinyuanView.bottom;
    
    //mainview contentsize height
    _scrollview.contentSize = CGSizeMake(SCREENWIDTH, _mainView.bottom + 10);
}

#pragma mark - 高度位置计算

//电话按钮位置和地址高度
- (void)setMobileButtonPosition:(DictionaryWrapper *)dic{
    _phoneAndAddressView.height = 0;
    NSString *phone = [dic getString:@"Tel"];
    if (phone.length) {
        //电话
        CGSize size = [UICommon getSizeFromString:phone
                                         withSize:CGSizeMake(MAXFLOAT, 21)
                                         withFont:19];
        _lblMobile.width = size.width;
        _lblMobile.text = [dic getString:@"Tel"];
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
    _companyView.top = _contentView.bottom;//momo + 10
    
    //_phoneAndAddressView y
    _phoneAndAddressView.top = _companyView.bottom;
    
    //mainview height
    _mainView.height = _phoneAndAddressView.bottom;
    
    //mainview contentsize height
    _scrollview.contentSize = CGSizeMake(SCREENWIDTH, _mainView.bottom + 10);
}
//继续投放
- (IBAction)continueClicked:(id)sender {
    YinYuanAdvertEditController *add = WEAK_OBJECT(YinYuanAdvertEditController, init);
    add.isEdit = YES;
    add.advertId = self.advertId;
    [UI_MANAGER.mainNavigationController pushViewController:add animated:YES];
}

//商家官网
- (IBAction)merchantClicked:(id)sender {
    
    NSString * url = [_dataDic getString:@"LinkUrl"];
    
    if(url.length)
    {
        url = [UICommon formatUrl: url];
        
        MerchantHomePageViewController *temp = WEAK_OBJECT(MerchantHomePageViewController, init);
        temp.merchantLinkUrl = url;
        [self.navigationController pushViewController:temp animated:YES];

    }
    else
    {
        [HUDUtil showErrorWithStatus:@"暂无商家官网"];
    }
}

//商家详情
- (IBAction)shopDetailClicked:(id)sender {
    
    NSString *enId = [_dataDic getString:@"EnterpriseId"];
    if (!enId.length) {
        return;
    }
    MerchantDetailViewController *merchant = WEAK_OBJECT(MerchantDetailViewController, init);
    merchant.enId = enId;
    merchant.comefrom = @"1";
    [UI_MANAGER.mainNavigationController pushViewController:merchant animated:YES];
    
}

#pragma mark UITableViewDelegate and UITableViewDatasource methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _prodArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"YinYuanADsDetailProductCell";
    
    YinYuanADsDetailProductCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YinYuanADsDetailProductCell" owner:self options:nil] firstObject];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    NSInteger row = [indexPath row];
 
    NSDictionary * dic = _prodArr[row];
    
    [cell.imgView setRoundCorner];
    [cell.imgView setBorderWithColor:AppColor(220)];
    
    NSString * str = [dic.wrapper getString:@"PictureUrl"];

    [cell.imgView requestPic:str placeHolder: YES];
    
    if([dic.wrapper getString:@"Name"].length)
    {
        cell.titleLbl.text = [dic.wrapper getString:@"Name"];
    }
    
    if([dic.wrapper getString:@"UnitIntegral"].length)
    {
        cell.yinyuanNumLbl.text = [dic.wrapper getString:@"UnitIntegral"];
    }
    if([dic.wrapper getDouble:@"UnitPrice"])
    {
        cell.priceLbl.text = [NSString stringWithFormat:@"￥%0.2f", [dic.wrapper getDouble:@"UnitPrice"]];
    }
    
    return cell;
    
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    YinYuanADsDetailProductCell *cell = (YinYuanADsDetailProductCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.contentView.backgroundColor = AppColor(220);
    
    return YES;
}

- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    YinYuanADsDetailProductCell *cell = (YinYuanADsDetailProductCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor whiteColor];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //进入该商品的兑换商城页面
    
    NSDictionary * dic = _prodArr[indexPath.row];
    CRSliverDetailViewController * view = WEAK_OBJECT(CRSliverDetailViewController, init);
    view.advertId = [_advertId integerValue];
    view.productId = [dic.wrapper getInt:@"SilverProductId"];
    
    [self.navigationController pushViewController:view animated:YES];
}

#pragma mark - 内存管理
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc{
    
    [_recommandBanner release];

    [_prodArr release];
    
    [_lineAddr release];
    [_addressView release];
    [_phoneView release];
    [_bannerView release];
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
    [_mainTableView release];
    [_yinyuanView release];
    [_linkBtn release];
    [_picScrollView release];
    [super dealloc];
}

- (void)viewDidUnload {
    [self setBottomView:nil];
    [self setMainTableView:nil];
    [self setYinyuanView:nil];
    [self setLinkBtn:nil];
    [self setPicScrollView:nil];
    [super viewDidUnload];
}
@end
