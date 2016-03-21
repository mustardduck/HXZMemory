//
//  MerchantDetailViewController.m
//  miaozhuan
//
//  Created by 孙向前 on 14-10-29.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "MerchantDetailViewController.h"
#import "NetImageView.h"
#import "BaseMerchatCell.h"
#import "BaseHeaderView.h"
#import "MerchantListViewController.h"
#import "AdsDetailViewController.h"
#import "CRSliverDetailViewController.h"
#import "Preview_Commodity.h"
#import "RRLineView.h"
#import "PutInCell.h"
#import "SilverGoodsCell.h"
#import "GoldGoodsCell.h"
#import "RRNormalButton.h"
#import "IWMainDetail.h"
#import "SellerDiscountDetail.h"
#import "IWCompanyIntroViewController.h"
#import "IWAttractBusinessDetailViewController.h"
#import "IWRecruitDetailViewController.h"
#import "SJZZController.h"
#import "UserInfo.h"
#import "SJZTLController.h"
#import "SJYHCell.h"
#import "RRAttributedString.h"

@interface MerchantDetailViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (retain, nonatomic) IBOutlet UIView *companyLevelView;
@property (retain, nonatomic) IBOutlet UIView *mainView;
@property (retain, nonatomic) IBOutlet UIScrollView *scrollView;
@property (retain, nonatomic) IBOutlet UIView *contentView;
@property (retain, nonatomic) IBOutlet UIView *phoneAndAddressView;
@property (retain, nonatomic) IBOutlet UITableView *tableview;

@property (retain, nonatomic) IBOutlet NetImageView *imgIogoIcon;
@property (retain, nonatomic) IBOutlet UILabel *lblCompany;
@property (retain, nonatomic) IBOutlet UILabel *lblNum;
@property (retain, nonatomic) IBOutlet UIButton *btnIsVip;
@property (retain, nonatomic) IBOutlet UIButton *btnSliver;
@property (retain, nonatomic) IBOutlet UIButton *btnGold;

@property (retain, nonatomic) IBOutlet UILabel *lblContent;

@property (retain, nonatomic) IBOutlet UILabel *lblMobile;
@property (retain, nonatomic) IBOutlet UIButton *btnMoble;
@property (retain, nonatomic) IBOutlet UILabel *lblAddress;

@property (nonatomic, retain) DictionaryWrapper *dataDic;//所有数据
@property (nonatomic, retain) NSMutableArray *dataArray;//表格数据
@property (nonatomic, retain) NSMutableArray *headerTitles;//表格header title
@property (nonatomic, retain) NSMutableArray *footerTitles;//表格footer title
@property (nonatomic, retain) NSMutableArray *types;//cell类型
@property (nonatomic, retain) NSMutableArray *footerSections;
@property (nonatomic, retain) NSMutableArray *navTitles;

@property (retain, nonatomic) IBOutlet UIView *zIzhiView;
@property (retain, nonatomic) IBOutlet NetImageView *zizhiImageView;
@property (retain, nonatomic) IBOutlet UIButton *zizhiBtn;

@end

@implementation MerchantDetailViewController

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupMoveBackButton];
    [self setNavigateTitle:@"商家详情"];
    
//    self.enId = USER_MANAGER.EnterpriseId;//test momo
    
    [self getDataFromRequest];
}

//获取表格数据源
- (void)getDataFromRequest{
    self.footerSections = [NSMutableArray arrayWithCapacity:0];
    self.footerTitles = [NSMutableArray arrayWithCapacity:0];
    self.headerTitles = [NSMutableArray arrayWithCapacity:0];
    self.types = [NSMutableArray arrayWithCapacity:0];
    self.dataArray = [NSMutableArray arrayWithCapacity:0];
    self.navTitles = [NSMutableArray arrayWithCapacity:0];
    
    ADAPI_adv23_enterprise_index([GLOBAL_DELEGATOR_MANAGER addDelegator:self selector:@selector(handleEnterPriseInfo:)], _enId.length?_enId:@"", _comefrom.length?_comefrom:@"");
    
    [self.tableview setSeparatorStyle:UITableViewCellSeparatorStyleNone];
}

- (void)handleEnterPriseInfo:(DelegatorArguments *)arguments{
    DictionaryWrapper* dic = arguments.ret;
    if (dic.operationSucceed)
    {
        _scrollView.hidden = NO;
        self.dataDic = dic.data;
        [self refresh:self.dataDic];
    }
    else
    {
        [HUDUtil showErrorWithStatus:dic.operationMessage];
        return;
    }
}

- (IBAction)touchUpInsideOn:(id)sender {
    if(sender == _zizhiBtn)
    {
        PUSH_VIEWCONTROLLER(SJZZController);
        model.enterpId = _enId;
    }
}

//刷新页面
- (void)refresh:(DictionaryWrapper *)dic{
    NSString *cName = [dic getString:@"Name"];
    CGSize size = [UICommon getSizeFromString:cName withSize:CGSizeMake(180, MAXFLOAT) withFont:18];
    _lblCompany.height = size.height > 35 ? 43 : size.height;
    if (size.height < 25) {
        _lblCompany.top = 30;
    } else {
        _lblCompany.top = 20;
    }
    _companyLevelView.top = _lblCompany.bottom + 5;
    
    _lblCompany.text = cName;
    _lblNum.text = [dic getString:@"TotalExchanges"];
    [_imgIogoIcon requestWithRecommandSize:[dic getString:@"LogoUrl"]];
    [_imgIogoIcon setRoundCorner:11];
    
    //电话按钮位置
    [self setMobileButtonPosition:[dic getString:@"Tel"] address:[dic getString:@"Address"]];

    //银、金、直icon位置
    [self setIconImage:dic];
    
    DictionaryWrapper * wrapper = [[dic getDictionary:@"TEnterpriseCert"] wrapper];
    
    if(wrapper)
    {
        _zIzhiView.hidden = NO;
        
        NSString * title = [NSString stringWithFormat:@"%@张", [wrapper getString:@"CertCount"] ];
        
        [_zizhiBtn setTitle:title forState:UIControlStateNormal];
        
        [_zizhiImageView requestWithRecommandSize:[wrapper getString:@"CertUrl"]];
        
        [_zizhiImageView setBorderWithColor:AppColor(197)];
    }
    
    //scrollview动态高度
    [self setHeightForScrollView:[dic getString:@"Introduction"]];
}

//电话按钮和地址位置
- (void)setMobileButtonPosition:(NSString *)phoneNum address:(NSString *)address{
    CGSize size = [UICommon getSizeFromString:phoneNum
                                     withSize:CGSizeMake(MAXFLOAT, 21)
                                     withFont:19];
    _lblMobile.width = size.width;
    _lblMobile.text = phoneNum;
    
    CGSize addressSize = [UICommon getSizeFromString:address
                                     withSize:CGSizeMake(_lblAddress.width, MAXFLOAT)
                                     withFont:14];
    _lblAddress.height = addressSize.height;
    _lblAddress.text = address;
    
    _phoneAndAddressView.height = _lblAddress.bottom + 15;
}
//vip、银、金、直icon状态
- (void)setIconImage:(DictionaryWrapper *)dic{
    _btnGold.selected = [dic getBool:@"IsGold"];
    _btnIsVip.selected = [dic getBool:@"IsVip"];
    _btnSliver.selected = [dic getBool:@"IsSilver"];
}
//计算scrollview高度并动态改变
- (void)setHeightForScrollView:(NSString *)content{
    
    //contentview height
    CGSize size = [UICommon getSizeFromString:content
                                     withSize:CGSizeMake(_lblContent.width, MAXFLOAT)
                                     withFont:14];
    _lblContent.text = content;
    _lblContent.height = size.height;
    _contentView.height = 54 + size.height;
    
    //_phoneAndAddressView y
    _phoneAndAddressView.top = _contentView.bottom;
    
    //mainview height
    if(!_zIzhiView.hidden)
    {
        _zIzhiView.top = _phoneAndAddressView.bottom;

        _mainView.height = _zIzhiView.bottom;
    }
    else
    {
        _mainView.height = _phoneAndAddressView.bottom;
    }
    
    RRLineView *lineview = WEAK_OBJECT(RRLineView, initWithFrame:CGRectMake(0, _mainView.height, SCREENWIDTH, 0.5));
    [_scrollView addSubview:lineview];
    
    //tableview y
    _tableview.top = _mainView.bottom + 10;

    
    [self setHeightForTableView];
    
    //mainview contentsize height
    _scrollView.contentSize = CGSizeMake(SCREENWIDTH, _tableview.bottom);
}
//计算表格高度
- (void)setHeightForTableView{
    _tableview.height = 0;
    
    if ([[[_dataDic wrapper] getArray:@"Adverts"] count]) {
        if ([[_dataDic wrapper] getBool:@"IsHasMoreSilverAdvert"]) {
            _tableview.height += 60;
            [_footerTitles addObject:@"查看所有投放中的广告"];
            [_navTitles addObject:@"所有投放中的广告"];
            [_footerSections addObject:@(1)];
        } else {
            [_footerTitles addObject:@""];
            [_navTitles addObject:@""];
            _tableview.height += 10;
            [_footerSections addObject:@(0)];
        }
        [_dataArray addObject:[[_dataDic wrapper] getArray:@"Adverts"]];
        [_headerTitles addObject:@"投放中的广告"];
        [_types addObject:@"0"];
        
        _tableview.height += [[[_dataDic wrapper] getArray:@"Adverts"] count] * 145;//cell height
        _tableview.height += 30;//header height
    }
    
    if ([[[_dataDic wrapper] getArray:@"SilverProducts"] count]) {
        if ([[_dataDic wrapper] getBool:@"IsHasMoreSilverProduct"]) {
            _tableview.height += 60;
            [_footerTitles addObject:@"查看所有兑换商品"];
            [_navTitles addObject:@"所有兑换商品"];
            [_footerSections addObject:@(1)];
        } else {
            [_footerTitles addObject:@""];
            [_navTitles addObject:@""];
            [_footerSections addObject:@(0)];
            _tableview.height += 10;
        }
        [_dataArray addObject:[[_dataDic wrapper] getArray:@"SilverProducts"]];
        [_headerTitles addObject:@"兑换商品"];
        [_types addObject:@"1"];
        
        _tableview.height += [[[_dataDic wrapper] getArray:@"SilverProducts"] count] * 110;//cell height
        _tableview.height += 30;//header height
    }
    
    if ([[[_dataDic wrapper] getArray:@"GoldProducts"] count]) {
        if ([[_dataDic wrapper] getBool:@"IsHasMoreGoldProducts"]) {
            _tableview.height += 60;
            [_footerTitles addObject:@"查看所有易货商品"];
            [_navTitles addObject:@"所有易货商品"];
            [_footerSections addObject:@(1)];
            
        } else {
            [_footerTitles addObject:@""];
            [_navTitles addObject:@""];
            [_footerSections addObject:@(0)];
            _tableview.height += 10;
        }
        [_dataArray addObject:[[_dataDic wrapper] getArray:@"GoldProducts"]];
        [_headerTitles addObject:@"易货商品"];
        [_types addObject:@"2"];
        
        _tableview.height += [[[_dataDic wrapper] getArray:@"GoldProducts"] count] *110;//cell height
        _tableview.height += 30;//header height
    }
    
    if ([[[_dataDic wrapper] getArray:@"PostBoards"] count]) {
        if ([[_dataDic wrapper] getBool:@"IsHasMorePostBoard"]) {
            _tableview.height += 60;
            [_footerTitles addObject:@"查看所有优惠、招聘、招商信息"];
            [_navTitles addObject:@"优惠、招聘、招商信息"];
            [_footerSections addObject:@(1)];
            
        } else {
            [_footerTitles addObject:@""];
            [_navTitles addObject:@""];
            [_footerSections addObject:@(0)];
            _tableview.height += 10;
        }
        [_dataArray addObject:[[_dataDic wrapper] getArray:@"PostBoards"]];
        [_headerTitles addObject:@"招聘、招商、优惠信息"];
        [_types addObject:@"4"];
        
        _tableview.height += [[[_dataDic wrapper] getArray:@"PostBoards"] count] *110;//cell height
        _tableview.height += 30;//header height
    }
    
    if (_tableview.height) {
        RRLineView *lineview1 = WEAK_OBJECT(RRLineView, initWithFrame:CGRectMake(0, _mainView.height + 10, SCREENWIDTH, 0.5));
        [_scrollView addSubview:lineview1];
    }
    
    [self.tableview reloadData];
}

#pragma mark - 事件

//拨打电话
- (IBAction)makeCallClicked:(id)sender {
    [[UICommon shareInstance]makeCall:[self.dataDic getString:@"Tel"]];
}

- (void)showAll:(UIButton *)btn{
    btn.backgroundColor = [UIColor whiteColor];
    
    int type = [_types[btn.tag] intValue];
    if(type == 4)
    {
        PUSH_VIEWCONTROLLER(SJZTLController);
        model.enteId = _enId;
    }
    else{
        MerchantListViewController *list = WEAK_OBJECT(MerchantListViewController, init);
        list.type = _types[btn.tag];
        list.titleName = _navTitles[btn.tag];
        list.enId = _enId;
        [UI_MANAGER.mainNavigationController pushViewController:list animated:YES];
    }
}

#pragma mark - UITableViewDelegate/UITableViewDatasource
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30.f;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [BaseHeaderView createHeaderView:section withTitle:_headerTitles[section]];
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if ([_footerSections[section] intValue]) {
        return 60;
    }
    return 10;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{

    if (![_footerSections[section] intValue]) {
        
        UIView *view = WEAK_OBJECT(UIView, initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 10));
        view.backgroundColor = [UIColor clearColor];
        
        return view;
    } else {
        UIView *view = WEAK_OBJECT(UIView, initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 60));
        
        UIImageView *imgArrow = WEAK_OBJECT(UIImageView, initWithImage:[UIImage imageNamed:@"ads_img_bg.png"]);
        imgArrow.frame = CGRectMake(301, 18, 6, 12);
        
        RRLineView *linebottom = WEAK_OBJECT(RRLineView, initWithFrame:CGRectMake(0, 50, SCREENWIDTH, 0.5));
        [view addSubview:linebottom];

        RRNormalButton *btnClick = [RRNormalButton buttonWithType:UIButtonTypeCustom];
        btnClick.tag = section;
        btnClick.frame = CGRectMake(0, 0, SCREENWIDTH, 50);
        [btnClick setBackgroundColor:[UIColor whiteColor]];
        btnClick.titleLabel.font = Font(14);
        btnClick.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        btnClick.contentEdgeInsets = UIEdgeInsetsMake(0,15, 0, 0);
        [btnClick setTitleColor:RGBCOLOR(40, 130, 220) forState:UIControlStateNormal];
        [btnClick setTitle:_footerTitles[section] forState:UIControlStateNormal];
        [btnClick addTarget:self action:@selector(showAll:) forControlEvents:UIControlEventTouchUpInside];
        
        view.backgroundColor = [UIColor clearColor];
        [view addSubviews:btnClick,imgArrow, nil];
        return view;

    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [_dataArray count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [_types[indexPath.section] intValue] ? 110.f : 145.f;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_dataArray[section] count] > 3 ? 3 : [_dataArray[section] count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [BaseMerchatCell createCell:[_types[indexPath.section] integerValue] WithData:[_dataArray[indexPath.section] objectAtIndex:indexPath.row]];
    }
    
    switch ([_types[indexPath.section] intValue]) {
        case 0:
        {
            if (indexPath.row == [_dataArray[indexPath.section] count] - 1) {
                if (![_footerSections[indexPath.section] intValue]) {
                    ((PutInCell *)cell).line.top = 144.5;
                    ((PutInCell *)cell).line.left = 0;
                } else {
                    ((PutInCell *)cell).line.top = 144.5;
                    ((PutInCell *)cell).line.left = 15;
                }
                
            } else {
                ((PutInCell *)cell).line.top = 144.5;
                ((PutInCell *)cell).line.left = 15;
            }
        }
            
            break;
        case 1:
        {
            if (indexPath.row == [_dataArray[indexPath.section] count] - 1) {
                if (![_footerSections[indexPath.section] intValue]) {
                    ((SilverGoodsCell *)cell).line.top = 109.5;
                    ((SilverGoodsCell *)cell).line.left = 0;
                } else {
                    ((SilverGoodsCell *)cell).line.top = 109.5;
                    ((SilverGoodsCell *)cell).line.left = 15;
                }
                
            } else {
                ((SilverGoodsCell *)cell).line.top = 109.5;
                ((SilverGoodsCell *)cell).line.left = 15;
            }
        }
            break;
        case 2:
        {
            if (indexPath.row == [_dataArray[indexPath.section] count] - 1) {
                if (![_footerSections[indexPath.section] intValue]) {
                    ((GoldGoodsCell *)cell).line.top = 109.5;
                    ((GoldGoodsCell *)cell).line.left = 0;
                } else {
                    ((GoldGoodsCell *)cell).line.top = 109.5;
                    ((GoldGoodsCell *)cell).line.left = 15;
                }
                
            } else {
                ((GoldGoodsCell *)cell).line.top = 109.5;
                ((GoldGoodsCell *)cell).line.left = 15;
            }
        }
            break;
        case 3://直购
            break;
        case 4://张贴栏
            if (indexPath.row == [_dataArray[indexPath.section] count] - 1) {
                if (![_footerSections[indexPath.section] intValue]) {
                    ((SJYHCell *)cell).line.top = 109.5;
                    ((SJYHCell *)cell).line.left = 0;
                } else {
                    ((SJYHCell *)cell).line.top = 109.5;
                    ((SJYHCell *)cell).line.left = 15;
                }
                
            } else
            {
                ((SJYHCell *)cell).line.top = 109.5;
                ((SJYHCell *)cell).line.left = 15;
            }
            
            NSDictionary * dic = [_dataArray[indexPath.section] objectAtIndex:indexPath.row];

            NSString * str = @"";
            
            UIColor * titleColor = RGBCOLOR(255, 51, 94);
            
            int type = [dic.wrapper getInt:@"Type"];
            
            if(type == kPostBoardDiscount)
            {
                str = @"[优惠]";
                
                ((SJYHCell *)cell).timeCons.constant = 177;
            }
            else if (type == kPostBoardRecruit)
            {
                str = @"[招聘]";
                titleColor = RGBCOLOR(61, 144, 238);
            }
            else if (type == kPostBoardAttractBusiness)
            {
                str = @"[招商]";
                titleColor = RGBCOLOR(0, 193, 145);
            }
            
            ((SJYHCell *)cell).titlelbl.text = [NSString stringWithFormat:@"%@%@", str, [dic.wrapper getString:@"Title"]];
            
            NSAttributedString *attrStr = [RRAttributedString setText:((SJYHCell *)cell).titlelbl.text color: titleColor range:NSMakeRange(0, 4)];
            
            ((SJYHCell *)cell).titlelbl.attributedText = attrStr;
            

            break;
        default:
            break;
    }


    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    DictionaryWrapper *dic = [_dataArray[indexPath.section] objectAtIndex:indexPath.row];
    switch ([_types[indexPath.section] intValue]) {
        case 0:
            //投放中广告
        {
            PUSH_VIEWCONTROLLER(AdsDetailViewController);
            model.adId = [[dic wrapper] getString:@"Id"];
            model.isMerchant = YES;
//            model.notShow = YES;
            model.notShow = NO;
        }
            break;
        case 1:
            //银元兑换商品
        {
            PUSH_VIEWCONTROLLER(CRSliverDetailViewController);
            model.productId = [[dic wrapper] getInt:@"ProductId"];
            model.advertId = [[dic wrapper] getInt:@"AdvertId"];
            
        }
            break;
        case 2:
            //金币兑换商品
        {
            PUSH_VIEWCONTROLLER(Preview_Commodity);
            model.productId = [[dic wrapper] getInt:@"Id"];
            model.whereFrom = 1;
        }
            break;
        case 3:
            //直购
            break;
        case 4:
            //张贴栏
        {
//            int row = indexPath.row;
//            switch (row) {

            int Type = (PostBoardType)[[dic wrapper] getInt:@"Type"];
            switch (Type) {
                case kPostBoardDiscount://优惠
                {
                    IWMainDetail *vc = [[IWMainDetail alloc] init];
                    
                    SellerDiscountDetail *vc0 =[[SellerDiscountDetail alloc] initWithNibName:NSStringFromClass([SellerDiscountDetail class]) bundle:nil];
                    vc0.isPreview = NO;
                    vc0.discountId = [[dic wrapper] getString:@"Id"];
                    IWCompanyIntroViewController *vc1 = [[IWCompanyIntroViewController alloc] initWithNibName:NSStringFromClass([IWCompanyIntroViewController class]) bundle:nil];
                    vc1.postBoardType = kPostBoardDiscount;
                    vc.navTitle = @"商家优惠详情";
                    vc.viewControllers = @[vc0,vc1];
                    vc.viewControllersTitle = @[@"详情展示",@"企业简介"];
                    
                    [self.navigationController pushViewController:vc animated:YES];
                }
                    break;
                case kPostBoardRecruit://招聘
                {
                    IWMainDetail *vc = [[IWMainDetail alloc] init];
                    
                    IWRecruitDetailViewController *vc0 =[[IWRecruitDetailViewController alloc] initWithNibName:NSStringFromClass([IWRecruitDetailViewController class]) bundle:nil];
                    vc0.detailsId = [[dic wrapper] getString:@"Id"];
                    vc0.detailType = IWRecruitDetailType_Browse;
                    IWCompanyIntroViewController *vc1 = [[IWCompanyIntroViewController alloc] initWithNibName:NSStringFromClass([IWCompanyIntroViewController class]) bundle:nil];
                    vc1.postBoardType = kPostBoardRecruit;
                    vc.navTitle = @"招聘信息详情";
                    vc.viewControllers = @[vc0,vc1];
                    vc.viewControllersTitle = @[@"详情展示",@"企业简介"];
                    
                    [self.navigationController pushViewController:vc animated:YES];
                }
                    break;
                case kPostBoardAttractBusiness://招商
                {
                    IWMainDetail *vc = [[IWMainDetail alloc] init];
                    
                    IWAttractBusinessDetailViewController *vc0 =[[IWAttractBusinessDetailViewController alloc] initWithNibName:NSStringFromClass([IWAttractBusinessDetailViewController class]) bundle:nil];
                    vc0.detailType = IWAttractBusinessDetailType_Browse;
                    vc0.detailsId = [[dic wrapper] getString:@"Id"];
                    vc0.detailType = IWAttractBusinessDetailType_Browse;
                    IWCompanyIntroViewController *vc1 = [[IWCompanyIntroViewController alloc] initWithNibName:NSStringFromClass([IWCompanyIntroViewController class]) bundle:nil];
                    vc1.postBoardType = kPostBoardAttractBusiness;
                    vc.navTitle = @"招商信息详情";
                    vc.viewControllers = @[vc0,vc1];
                    vc.viewControllersTitle = @[@"详情展示",@"企业简介"];
                    
                    [self.navigationController pushViewController:vc animated:YES];
                }
                    break;
                default:
                    break;
            }
        }
            break;
        default:
            break;
    }
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat sectionHeaderHeight = 30;
    if (scrollView.contentOffset.y <= sectionHeaderHeight && scrollView.contentOffset.y >= 0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    } else if (scrollView.contentOffset.y >= sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
}

#pragma mark - 内存管理

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_comefrom release];
    [_footerSections release];
    [_enId release];
    [_types release];
    [_headerTitles release];
    [_footerTitles release];
    [_dataArray release];
    [_dataDic release];
    [_mainView release];
    [_scrollView release];
    [_contentView release];
    [_phoneAndAddressView release];
    [_tableview release];
    [_imgIogoIcon release];
    [_lblCompany release];
    [_lblNum release];
    [_lblContent release];
    [_lblMobile release];
    [_btnMoble release];
    [_lblAddress release];
    [_btnIsVip release];
    [_btnSliver release];
    [_btnGold release];
    [_companyLevelView release];
    [_zIzhiView release];
    [_zizhiImageView release];
    [_zizhiBtn release];
    [super dealloc];
}
@end
