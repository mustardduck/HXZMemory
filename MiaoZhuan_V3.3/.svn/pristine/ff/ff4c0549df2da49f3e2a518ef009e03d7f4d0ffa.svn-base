//
//  MainViewController.m
//  test
//
//  Created by 孙向前 on 14-10-21.
//  Copyright (c) 2014年 sunxq_xiaoruan. All rights reserved.
//

#import "MainViewController.h"
#import "GoodsCell.h"
#import "ShopCell.h"
#import "AdsViewController.h"
#import "GetRedPacketsViewController.h"
#import "RecommendMerchantViewController.h"
#import "BaseMainCell.h"
#import "AdvertCollectionViewController.h"
#import "RCScrollView.h"
#import "ConsumerPriviliegeViewController.h"
#import "RankListViewController.h"
#import "FindShopController.h"
#import "DetailBannerAdvertViewController.h"
#import "MallScanAdvertMain.h"
#import "GoldShopingMallDealHomeViewController.h"
#import "ConvertionCenterSetting.h"
#import "RecommendMerchantViewController.h"
#import "UserInfo.h"
#import "MerchantDetailViewController.h"
#import "CRSliverDetailViewController.h"
#import "Preview_Commodity.h"
#import "WebhtmlViewController.h"
#import "CRPushManager.h"

#import "CRAreViewController.h"
#import "CRMallManagerViewContrillrtViewController.h"
#import "CRScrollController.h"
#import "MJRefreshController.h"
#import "CRWebSupporter.h"
#import "HomeInfoCell.h"

#import "IWBrowseADMainViewController.h"


#import "IWMainDetail.h"
#import "IWRecruitDetailViewController.h"
#import "IWAttractBusinessDetailViewController.h"
#import "SellerDiscountDetail.h"
#import "IWCompanyIntroViewController.h"

@interface MainViewController ()<UITableViewDataSource,UITableViewDelegate, GetRedPacketDelegate>{
    CRScrollController *_scrollCon;
    BOOL _pageCount;
    NSTimer *timer;
    NSInteger unreadc;
}

@property (retain, nonatomic) IBOutlet UIButton *btn1;
@property (retain, nonatomic) IBOutlet UIButton *btn2;
@property (retain, nonatomic) IBOutlet UIButton *btn3;

@property (retain, nonatomic) IBOutlet UITableView *infoTableView;

@property (retain, nonatomic) IBOutlet UIScrollView *itemScroll;
@property (retain, nonatomic) IBOutlet UIButton *btnMore;
@property (retain, nonatomic) IBOutlet UILabel *lblMore;

@property (retain, nonatomic) IBOutlet UIScrollView *bannerSc;

@property (retain, nonatomic) IBOutlet UIScrollView *scrollview;
@property (retain, nonatomic) IBOutlet UITableView *goodsTableView;
@property (retain, nonatomic) IBOutlet UITableView *shopTableVIew;
@property (retain, nonatomic) IBOutlet UITableView *mainTableView;
@property (retain, nonatomic) IBOutlet NetImageView *imgBanner;
@property (retain, nonatomic) IBOutlet UIImageView *guideImageView;
@property (retain, nonatomic) IBOutlet UIView *hview;

@property (nonatomic, retain) MJRefreshController *MJRefreshCon;

@property (nonatomic, retain) NSArray *shopDataArray;//推荐商家
@property (nonatomic, retain) NSArray *goodsDataArray;//获取超值商品
@property (nonatomic, retain) NSArray *postBoardList;//张贴栏首页数据;
@property (nonatomic, assign) int currentGroup;

@property (nonatomic, retain) DictionaryWrapper *dataDic;

@end

NSInteger shopCellHeight = 75;
NSInteger goodsCellHeight = 162;
NSInteger infoCellHeight = 85;

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    _pageCount ++;
    [MTA trackPageViewBegin:NSStringFromClass([self class])];
    
    if (timer) {
        [timer resumeTimer];
    } else {
        timer = [NSTimer scheduledTimerWithTimeInterval:15*3600 target:self selector:@selector(getRequestData) userInfo:nil repeats:YES];
    }
    
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    if (_pageCount > 0)
    {
        [MTA trackPageViewEnd:NSStringFromClass([self class])];
        _pageCount --;
    }
    
    [timer pauseTimer];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleun:) name:@"BackHome" object:nil];
    
    [_btn1 setRoundCorner:7 withBorderColor:[UIColor clearColor]];
    [_btn2 setRoundCorner:7 withBorderColor:[UIColor clearColor]];
    [_btn3 setRoundCorner:7 withBorderColor:[UIColor clearColor]];
    
    _itemScroll.delegate = self;
    _itemScroll.contentSize = CGSizeMake(SCREENWIDTH * 1.5, _itemScroll.height);
    
    _unreadView.hidden = YES;
    
    _hview.hidden = [[NSUserDefaults standardUserDefaults] boolForKey:@"NotShowGuide"];
    if (![_hview superview]) {
//        [[[UIApplication sharedApplication] keyWindow] addSubview:_hview];
    }
    
    if (!_hview.hidden) {
        BOOL flag = [UICommon getIos4OffsetY];
        NSLog(@"%f",[UIScreen mainScreen].bounds.size.height);
        _hview.height = [UIScreen mainScreen].bounds.size.height;
        _guideImageView.image = [UIImage imageNamed:flag ? @"guide_one568.png" : @"guide_one.png"];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"NotShowGuide"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    [self sendRequest];
    
    NSString * refreshName = @"CustomerHome/Index";
    
    [_MJRefreshCon release];
    _MJRefreshCon = nil;
    _MJRefreshCon = [[MJRefreshController controllerNoFooterFrom:_mainTableView name:refreshName] retain];
    
    [self initTableView];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self calculateRedCount];
}

-(void)calculateRedCount
{
    ADAPI_DirectAdvert_DirectAdvertUnreadCount([GLOBAL_DELEGATOR_MANAGER addDelegator:self selector:@selector(handleUnread:)]);
}

//-(void)getCount
//{
//    ADAPI_DirectAdvert_DirectAdvertUnreadCount([GLOBAL_DELEGATOR_MANAGER addDelegator:self selector:@selector(handleUnread:)]);
//}

- (void)handleun:(NSNotification *)noti{
    
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"BackHome" object:nil];
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
  
//    ADAPI_DirectAdvert_DirectAdvertUnreadCount([GLOBAL_DELEGATOR_MANAGER addDelegator:self selector:@selector(handleUnread:)]);
}

- (void)handleUnread:(DelegatorArguments *)arguments{
    DictionaryWrapper *dic = arguments.ret;
    if (dic.operationSucceed) {
        unreadc = [dic.data intValue];
        self.unreadView.num = unreadc;
        
    } else {
        [HUDUtil showErrorWithStatus:dic.operationMessage];
    }
}

#pragma mark - 3.2改变item
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
   
    if ([scrollView isEqual:_itemScroll]) {
     
        BOOL flag = scrollView.contentOffset.x < 120;
        
        NSString *normalImgName = flag ? @"home_icon08" : @"home_icon04";
        NSString *hilightedImgName = flag ? @"home_icon08hover" : @"home_icon04hover";
        
        [_btnMore setImage:[UIImage imageNamed:normalImgName] forState:UIControlStateNormal];
        [_btnMore setImage:[UIImage imageNamed:hilightedImgName] forState:UIControlStateHighlighted];
        
        //未看红包
//        int advertUnreadCount = [_dataDic getInt:@"DirectAdvertUnreadCount"];
//        _unreadView.hidden = !unreadc || flag;
        _unreadView.num = unreadc;
        
        _lblMore.text = flag ? @"更多" : @"排行榜";
    }
}

- (void)initTableView
{
    NSString * refreshName = @"CustomerHome/Index";
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:@{@"service":[NSString stringWithFormat:@"%@%@", @"api/", refreshName]}];
    
    [_MJRefreshCon setURLGenerator:MJREFRESH_URL_GENERATOR_BLOCK{
        
        return dic.wrapper;
    }];
    
    MJRefreshOnRequestDone block = MJREFRESH_ON_REQUEST_DONE
    {
        NSLog(@"%@", netData);
        if(netData.data)
        {
            self.dataDic = netData.data;
            [self initData:netData.data];
            [self setMainTableviewHeight];
        }
        
    };
    
    [_MJRefreshCon setOnRequestDone:block];
    
    [self refreshTableView];
}

- (void) refreshTableView
{
    [_MJRefreshCon refreshWithLoading];
}

- (void)sendRequest{
    if (!USER_MANAGER.CustomerId) {
        [self performSelector:@selector(sendRequest) withObject:nil afterDelay:1];
        return;
    }
    [self getRequestData];
}

- (void)handleHome:(DelegatorArguments *)arguments{
    DictionaryWrapper* dic = arguments.ret;
    if (dic.operationSucceed) {
        self.dataDic = dic.data;
        [self initData:dic.data];
        [self setMainTableviewHeight];
        
        if (APP_DELEGATE.pushManager.needJumpAfterLogin) [APP_DELEGATE.pushManager notifyToJump];
        
    } else
    {
        [HUDUtil showErrorWithStatus:dic.operationMessage];
        return;
    }
}

- (void)getRequestData{
    ADAPI_CustomerHome_Index([GLOBAL_DELEGATOR_MANAGER addDelegator:self selector:@selector(handleHome:)]);
}

- (void)initData:(DictionaryWrapper *)dic{
    if ([dic isKindOfClass:[NSNull class]]) {
        return;
    }
    unreadc = [dic getInt:@"DirectAdvertUnreadCount"];
    _unreadView.num = unreadc;
    //张贴栏首页数据
    if (!self.postBoardList) {
        self.postBoardList = [dic getArray:@"PostBoardList"];
    }
    //商家
    if (!self.shopDataArray.count) {
        self.shopDataArray = [dic getArray:@"EnterpriseRecommend"];
    }
    //超值商品
    if (!self.goodsDataArray.count) {
        self.goodsDataArray = [dic getArray:@"RecommendProductList"];
    }
    //中间的banner
    NSArray *midBanner = [dic getArray:@"MidBannerAdvertList"];
    if (midBanner.count) {
        _imgBanner.zoom = 0.6;
        _imgBanner.holderColor = AppColorWhite;
        [_imgBanner requestWithRecommandSize:[[midBanner[0] wrapper] getString:@"Image"]];
    }
    //顶部banner
    //竞价广告
    NSArray *priceBanner = [dic getArray:@"BannerAdvertList"];
    //直营广告
    NSArray *selfBanner = [dic getArray:@"SelfBannerAdvertList"];
    NSMutableArray *banners = [NSMutableArray arrayWithArray:selfBanner];
    [banners addObjectsFromArray:priceBanner];
    
    [self createBanner:banners];
}

- (void)createBanner:(NSArray *)images{

    if (!images.count) {
        return;
    }
    
    NSMutableArray *imageUrls = [NSMutableArray array];
    for (NSDictionary *dic in images) {
        if ([[[dic wrapper] getString:@"Image"] length]) {
            [imageUrls addObject:[[dic wrapper] getString:@"Image"]];
        }
        if ([[[dic wrapper] getString:@"PictureUrl"] length]) {
            [imageUrls addObject:[[dic wrapper] getString:@"PictureUrl"]];
        }
    }

    if (!_scrollCon) {
        _scrollCon = [CRScrollController controllerFromView:_bannerSc];
        _scrollCon.picZoom  = 0.55f;
    }
    _scrollCon.picArray = imageUrls;
    
    _scrollCon.tapBlock = ^(NSInteger index)
    {
        
        DictionaryWrapper *dic = [images[index] wrapper];
        NSMutableDictionary *mutDic = [NSMutableDictionary dictionaryWithDictionary:[dic dictionary]];
        
        if (![dic getString:@"Type"].length || [[dic getString:@"Type"] isKindOfClass:[NSNull class]]) {
            [mutDic setValue:@"999" forKey:@"Type"];
        }
        
        [CRWebSupporter bannerForward:[mutDic wrapper]];
    };
}

- (void)setMainTableviewHeight{
    
    _mainTableView.tableHeaderView.height = 0;
    CGFloat mainTableHeight = 0;
    //count tableview height
    NSInteger shopCount = _shopDataArray.count;
    NSInteger goodsCount = _goodsDataArray.count;
    NSInteger postBoardListCount = _postBoardList.count;
    
    NSArray *midBanner = [_dataDic getArray:@"MidBannerAdvertList"];
    if (!midBanner.count) {
        _imgBanner.hidden = YES;
    }
    
    if (goodsCount) {
        
        //goods tableveiw height
        _goodsTableView.height = goodsCellHeight * ((goodsCount % 3) ? (goodsCount / 3 + 1) : (goodsCount / 3)) + 30;
        
    } else {
        
        [self setDelAndDatToNil:_goodsTableView];
        _goodsTableView.height = 0;
        _goodsTableView.hidden = YES;
    
    }
    
    if (_imgBanner.hidden) {//banner 不存在
        
        if (shopCount) {
            
            _shopTableVIew.top = _goodsTableView.bottom;
            
            _shopTableVIew.height = shopCellHeight * ([self delivery:shopCount] ? (shopCount / 2 + 1) : (shopCount / 2)) + 30;
            
            if (postBoardListCount) {
                
                _infoTableView.top = _shopTableVIew.bottom;
                
                _infoTableView.height = postBoardListCount * infoCellHeight  + 30;
                
                mainTableHeight = _infoTableView.bottom;
                
            } else {
                
                [self setDelAndDatToNil:_infoTableView];
                _infoTableView.height = 0;
                _infoTableView.hidden = YES;
                
                mainTableHeight = _shopTableVIew.bottom;
            }
            
        } else {
            
            [self setDelAndDatToNil:_shopTableVIew];
            _shopTableVIew.height = 0;
            _shopTableVIew.hidden = YES;
            
            if (postBoardListCount) {
                
                _infoTableView.top = _goodsTableView.bottom;
                
                _infoTableView.height = postBoardListCount * infoCellHeight + 36;
                
                mainTableHeight = _infoTableView.bottom;
            } else {
                
                [self setDelAndDatToNil:_infoTableView];
                _infoTableView.height = 0;
                _infoTableView.hidden = YES;
                
                mainTableHeight = _goodsTableView.bottom;
            }
            
        }
    } else {
        
        //banner top
        _imgBanner.top = _goodsTableView.bottom + 19;
        
        if (shopCount) {
            
            _shopTableVIew.top = _imgBanner.bottom;
            
            _shopTableVIew.height = shopCellHeight * ([self delivery:shopCount] ? (shopCount / 2 + 1) : (shopCount / 2)) + 30;
            
            if (postBoardListCount) {
                
                _infoTableView.top = _shopTableVIew.bottom;
                
                _infoTableView.height = postBoardListCount * infoCellHeight + 36;
                
                mainTableHeight = _infoTableView.bottom;
                
            } else {
                
                [self setDelAndDatToNil:_infoTableView];
                _infoTableView.height = 0;
                _infoTableView.hidden = YES;
                
                mainTableHeight = _shopTableVIew.bottom;
            }
            
        } else {
            
            [self setDelAndDatToNil:_shopTableVIew];
            _shopTableVIew.height = 0;
            _shopTableVIew.hidden = YES;
            
            if (postBoardListCount) {
                
                _infoTableView.top = _imgBanner.bottom;
                
                _infoTableView.height = postBoardListCount * infoCellHeight + 36;
                
                mainTableHeight = _infoTableView.bottom;
                
            } else {
                
                [self setDelAndDatToNil:_infoTableView];
                _infoTableView.height = 0;
                _infoTableView.hidden = YES;
                
                mainTableHeight = _imgBanner.bottom;
            }
            
        }
        
    }
    _scrollview.height = mainTableHeight + 7;
    _mainTableView.tableHeaderView = _scrollview;
    _mainTableView.tableHeaderView.height = _scrollview.height;
    
    [_shopTableVIew reloadData];
    [_goodsTableView reloadData];
    [_infoTableView reloadData];
    
}

- (void)setDelAndDatToNil:(UITableView *)tableview{
    tableview.delegate = nil;
    tableview.dataSource = nil;
}

- (void)countTableviewHeight:(UITableView *)tableview cellHeight:(CGFloat)height withDataCount:(NSInteger)count{
    if ([self delivery:count]) {
        tableview.height = (count / 2) * height + 30;
    } else {
        tableview.height = (count / 2 + 1) * height + 30;
    }
}

- (BOOL)delivery:(NSInteger)number{
    return number % 2;
}

#pragma mark - tableview delegate/datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([tableView isEqual:_mainTableView]) {
        return 0;
    } else {
        if ([tableView isEqual:_goodsTableView]) {
            NSInteger count = (_goodsDataArray.count % 3) ? (_goodsDataArray.count / 3 + 1) : (_goodsDataArray.count / 3);
            return count;
        } else if ([tableView isEqual:_shopTableVIew]){
            return [self delivery:_shopDataArray.count] ? (_shopDataArray.count / 2 + 1) : (_shopDataArray.count / 2);
        }else {
            return _postBoardList.count;
        }
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:_goodsTableView]) {
        return goodsCellHeight;
    } else if ([tableView isEqual:_shopTableVIew]) {
        return shopCellHeight;
    } else if ([tableView isEqual:_infoTableView]) {
        return infoCellHeight;
    } else {
        return 0;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier;
    BOOL flag = [tableView isEqual:_goodsTableView];
    identifier = flag ? @"goodscell" : ([tableView isEqual:_shopTableVIew] ? @"shopcell" : @"infocell");
    
    NSInteger index = indexPath.row;
    
    BaseMainCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    NSDictionary *dic2 = @{};
    NSDictionary *dic3 = @{};
    if (!cell) {

        NSInteger type = [tableView isEqual:_goodsTableView] ? 1 : ([tableView isEqual:_shopTableVIew] ? 0 : 2);
        
        if ([tableView isEqual:_infoTableView]) {
            
            ((HomeInfoCell *)cell).line.left = (index == _postBoardList.count - 1) ? 0 : 15;
            ((HomeInfoCell *)cell).selectionStyle = UITableViewCellSelectionStyleDefault;
            
            dic2 = _postBoardList[indexPath.row];
            cell = [BaseMainCell createCell:type withData: [dic2 wrapper]];
            
        } else {
            
            NSDictionary *dic1 = flag ? _goodsDataArray[3 * index] : _shopDataArray[2 * index];
            
            if (flag) {
                
                if (_goodsDataArray.count % 3 == 0) {
                    dic2 = _goodsDataArray[3 * index + 1];
                    dic3 = _goodsDataArray[3 * index + 2];
                } else if (_goodsDataArray.count % 3 == 1) {
                    
                    if (index == _goodsDataArray.count / 3 && _goodsDataArray.count % 3 == 1) {
                        dic2 = @{};
                        dic3 = @{};
                    } else {
                        dic2 = _goodsDataArray[3 * index + 1];
                        dic3 = _goodsDataArray[3 * index + 2];
                    }
                } else {
                    dic2 = _goodsDataArray[3 * index + 1];
                    if (index == _goodsDataArray.count / 3 && _goodsDataArray.count % 3 == 1) {
                        dic3 = @{};
                    } else if (index == _goodsDataArray.count / 3 && _goodsDataArray.count % 3 == 2) {
                        
                        dic3 = @{};
                    } else {
                        dic3 = _goodsDataArray[3 * index + 2];
                    }
                }
                
            } else {
                
                if ([self delivery:_shopDataArray.count] && index == _shopDataArray.count / 2) {
                    dic2 = @{};
                    dic3 = @{};
                } else {
                    dic2 = _shopDataArray[2 * index + 1];
                    dic3 = @{};
                }
                
            }
            
            cell = [BaseMainCell createCell:type withData: dic2 ? @[dic1,dic2,dic3] : @[dic1]];
        }
        
    }
    if (flag) {
        
        ((GoodsCell *)cell).btnFront.tag = 3 * indexPath.row + 1;
        [((GoodsCell *)cell).btnFront addTarget:self action:@selector(goodsItemClicked:) forControlEvents:UIControlEventTouchUpInside];
        if ([dic2 count]) {
            ((GoodsCell *)cell).btnFollow.tag = 3 * indexPath.row + 2;
            [((GoodsCell *)cell).btnFollow addTarget:self action:@selector(goodsItemClicked:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        if ([dic3 count]) {
            
            ((GoodsCell *)cell).btnLast.tag = 3 * indexPath.row + 3;
            [((GoodsCell *)cell).btnLast addTarget:self action:@selector(goodsItemClicked:) forControlEvents:UIControlEventTouchUpInside];
            
        }
        
        BOOL flag = _goodsDataArray.count % 3;
        NSInteger lastrow = flag ? (_goodsDataArray.count / 3) : (_goodsDataArray.count / 3 -1);
        
        if (lastrow == indexPath.row) {
            ((GoodsCell *)cell).v3.hidden = YES;
            ((GoodsCell *)cell).v1.height = ((GoodsCell *)cell).v2.height = 162;
        } else {
            ((GoodsCell *)cell).v3.hidden = NO;
            ((GoodsCell *)cell).v1.height = ((GoodsCell *)cell).v2.height = 161.5;
        }
        
   
    } else if ([tableView isEqual:_shopTableVIew]) {
        
        ((ShopCell *)cell).btnFront.tag = 2 * indexPath.row + 1;
        [((ShopCell *)cell).btnFront addTarget:self action:@selector(shopItemClicked:) forControlEvents:UIControlEventTouchUpInside];
        if ([dic2 count]) {
            ((ShopCell *)cell).btnFollow.tag = 2 * indexPath.row + 2;
            [((ShopCell *)cell).btnFollow addTarget:self action:@selector(shopItemClicked:) forControlEvents:UIControlEventTouchUpInside];
        }
       
    }  else if ([tableView isEqual:_infoTableView]) {
        ((HomeInfoCell *)cell).btnContent.tag = indexPath.row;
         [((HomeInfoCell *)cell).btnContent addTarget:self action:@selector(infoItemClicked:) forControlEvents:UIControlEventTouchUpInside];
    } else {
        return nil;
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if ([tableView isEqual:_infoTableView]) {
        
        NSInteger type = [[_postBoardList[indexPath.row] wrapper] getInt:@"Type"];
        NSDictionary *dic = [_postBoardList[indexPath.row] wrapper];
        NSLog(@"dic:%@",dic);
        switch (type) {
            case 1:
            {//招聘详情
               
            }
                break;
            case 2:
            {//招商详情
                
            }
                break;
            case 3:
            {//优惠详情
              
            }
                break;
            default:
                break;
        }
        
    }
    
}

#pragma mark - 事件
//点击商家
- (void)shopItemClicked:(UIButton *)button{
    NSInteger index = button.tag - 1;
    NSLog(@"%ld",(long)index);
    MerchantDetailViewController *model = WEAK_OBJECT(MerchantDetailViewController, init);
    model.enId = [[_shopDataArray[index] wrapper] getString:@"EnterpriseId"];
    model.comefrom = @"6";
    [UI_MANAGER.mainNavigationController pushViewController:model animated:YES];
}
//点击信息
-(void)infoItemClicked:(UIButton *) button
{
    NSInteger type = [[_postBoardList[button.tag] wrapper] getInt:@"Type"];
    
    NSDictionary *dic = [_postBoardList[button.tag] wrapper];
    NSLog(@"dic:%@",dic);
    NSString *detailId = [[_postBoardList[button.tag] wrapper] getString:@"Id"];
    switch (type) {
        case 1:
        {//招聘详情
            IWMainDetail *vc = [[IWMainDetail alloc] init];
            IWRecruitDetailViewController *vc0 = [[IWRecruitDetailViewController alloc] initWithNibName:NSStringFromClass([IWRecruitDetailViewController class]) bundle:nil];
            IWCompanyIntroViewController *vc1 = [[IWCompanyIntroViewController alloc] initWithNibName:NSStringFromClass([IWCompanyIntroViewController class]) bundle:nil];
            vc0.detailsId = detailId;
            vc0.detailType = IWRecruitDetailType_Browse;
            vc1.postBoardType = kPostBoardRecruit;
            vc.navTitle = @"招聘信息";
            vc.viewControllers = @[vc0,vc1];
            vc.viewControllersTitle = @[@"详情展示",@"企业简介"];
            
            [UI_MANAGER.mainNavigationController pushViewController:vc animated:YES];
            
        }
            break;
        case 2:
        {//招商详情
            IWMainDetail *vc = [[IWMainDetail alloc] init];
            IWAttractBusinessDetailViewController *vc0 = [[IWAttractBusinessDetailViewController alloc] initWithNibName:NSStringFromClass([IWAttractBusinessDetailViewController class]) bundle:nil];
            IWCompanyIntroViewController *vc1 = [[IWCompanyIntroViewController alloc] initWithNibName:NSStringFromClass([IWCompanyIntroViewController class]) bundle:nil];
            vc0.detailsId = detailId;
            vc0.detailType = IWAttractBusinessDetailType_Browse;
            vc1.postBoardType = kPostBoardAttractBusiness;
            vc.navTitle = @"招商信息";
            vc.viewControllers = @[vc0,vc1];
            vc.viewControllersTitle = @[@"详情展示",@"企业简介"];
            
            [UI_MANAGER.mainNavigationController pushViewController:vc animated:YES];
        }
            break;
        case 3:
        {//优惠详情
            IWMainDetail *vc = [[IWMainDetail alloc] init];
            SellerDiscountDetail *vc0 = [[SellerDiscountDetail alloc] initWithNibName:NSStringFromClass([SellerDiscountDetail class]) bundle:nil];
            IWCompanyIntroViewController *vc1 = [[IWCompanyIntroViewController alloc] initWithNibName:NSStringFromClass([IWCompanyIntroViewController class]) bundle:nil];
            vc1.postBoardType =kPostBoardDiscount;
            vc0.discountId = detailId;
            vc.navTitle = @"优惠信息";
            vc.viewControllers = @[vc0,vc1];
            vc.viewControllersTitle = @[@"详情展示",@"企业简介"];
            
            [UI_MANAGER.mainNavigationController pushViewController:vc animated:YES];
        }
            break;
        default:
            break;
    }
}

- (IBAction)tapGuide:(id)sender {
    BOOL flag = [UICommon getIos4OffsetY];
    
    if ([_guideImageView.image isEqual:[UIImage imageNamed:@"guide_two568.png"]] || [_guideImageView.image isEqual:[UIImage imageNamed:@"guide_two.png"]]) {
        _hview.hidden = YES;
        [_hview removeFromSuperview];
        return;
    }
    _guideImageView.image = [UIImage imageNamed:flag ? @"guide_two568.png" : @"guide_two.png"];
    
}
//点击商品
- (void)goodsItemClicked:(UIButton *)button{
    NSInteger index = button.tag - 1;
    NSLog(@"%ld",(long)index);
    int ptype = [[_goodsDataArray[index] wrapper] getInt:@"Type"];
    if (ptype) {
        //金币
        Preview_Commodity *model = WEAK_OBJECT(Preview_Commodity, init);
        model.productId = [[_goodsDataArray[index] wrapper] getInt:@"Id"];
        model.whereFrom = 1;
        [UI_MANAGER.mainNavigationController pushViewController:model animated:YES];
        
    } else {
        //银元
        CRSliverDetailViewController *model = WEAK_OBJECT(CRSliverDetailViewController, init);
        model.productId = [[_goodsDataArray[index] wrapper] getInt:@"Id"];
        model.advertId = [[_goodsDataArray[index] wrapper] getInt:@"AdvertId"];
        [UI_MANAGER.mainNavigationController pushViewController:model animated:YES];
    }
}
- (IBAction)midBannerClicked:(id)sender {
    NSArray *midBanner = [_dataDic getArray:@"MidBannerAdvertList"];
    if (midBanner.count) {
        [CRWebSupporter bannerForward:[midBanner[0] wrapper]];
    }
}

- (BOOL) isOver15MinutesWithBeginTime:(NSDate *)date{
    
    NSTimeInterval late=[date timeIntervalSince1970]*1;
    
    
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval now=[dat timeIntervalSince1970]*1;
    
    NSTimeInterval cha=now-late;
    
    return cha / 60 > 15;
    
}

//跳转
- (IBAction)buttonClicked:(UIButton *)sender {
    //根据tag来跳转到相应页面
    switch (sender.tag)
    {
        case 1:
        {//捡银元
            [[NSUserDefaults standardUserDefaults] setValue:@(1) forKey:@"HeaderManageCenterCurLineTag"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [UI_MANAGER.mainNavigationController pushViewController:WEAK_OBJECT(AdsViewController, init) animated:YES];
        }
            break;
        case 2:
        {//收红包
            [UI_MANAGER.mainNavigationController pushViewController:WEAK_OBJECT(GetRedPacketsViewController, init) animated:YES];
            
        }
            break;
        case 3:
        {//广告收藏
            [UI_MANAGER.mainNavigationController pushViewController:WEAK_OBJECT(AdvertCollectionViewController, init) animated:YES];
        }
            break;
            
        case 4:
        {//收红包
//            [UI_MANAGER.mainNavigationController pushViewController:WEAK_OBJECT(RankListViewController, init) animated:YES];
            GetRedPacketsViewController *obj = [[[GetRedPacketsViewController alloc] initWithNibName:@"GetRedPacketsViewController" bundle:nil] autorelease];
            obj.delegate = self;
            [UI_MANAGER.mainNavigationController pushViewController:obj animated:YES];
//            [UI_MANAGER.mainNavigationController pushViewController:WEAK_OBJECT(GetRedPacketsViewController, init) animated:YES];
        }
            break;
            
        case 5:
        {//商城
            [UI_MANAGER.mainNavigationController pushViewController:WEAK_OBJECT(MallScanAdvertMain, init) animated:YES];
            
//            [UI_MANAGER.mainNavigationController pushViewController:WEAK_OBJECT(CRMallManagerViewContrillrtViewController, init) animated:YES];
        }
            break;
            
        case 6:
        {//用户特权
            [UI_MANAGER.mainNavigationController pushViewController:WEAK_OBJECT(ConsumerPriviliegeViewController, init) animated:YES];
        }
            break;
        case 7:
        {//寻找商家

            [UI_MANAGER.mainNavigationController pushViewController:WEAK_OBJECT(FindShopController, init) animated:YES];
        }
            break;
        case 8:
        {//更多
            if (!_itemScroll.contentOffset.x) {
                //更多
                [_itemScroll setContentOffset:CGPointMake(160, 0) animated:YES];
            } else {
                //收红包
                //收红包返回首页
//                [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleun:) name:@"BackHome" object:nil];
//                [UI_MANAGER.mainNavigationController pushViewController:WEAK_OBJECT(GetRedPacketsViewController, init) animated:YES];
                 [UI_MANAGER.mainNavigationController pushViewController:WEAK_OBJECT(RankListViewController, init) animated:YES];
            }
            
        }
         break;
        case 9:
        {//招聘信息
            IWBrowseADMainViewController *iwbadmvc = [[IWBrowseADMainViewController alloc] init];
            iwbadmvc.browseADMainType = kPostBoardRecruit;
            [UI_MANAGER.mainNavigationController pushViewController:iwbadmvc animated:YES];
        }
            break;
        case 10:
        {//招商信息
            IWBrowseADMainViewController *iwbadmvc = [[IWBrowseADMainViewController alloc] init];
            iwbadmvc.browseADMainType = kPostBoardAttractBusiness;
            [UI_MANAGER.mainNavigationController pushViewController:iwbadmvc animated:YES];
            
        }
            break;
        case 11:
        {//易货商城
            MallScanAdvertMain *main = WEAK_OBJECT(MallScanAdvertMain, init);
            main.startPage = 1;
            [UI_MANAGER.mainNavigationController pushViewController:main animated:YES];
        }
            break;
        case 12:
        {//商家优惠
            IWBrowseADMainViewController *iwbadmvc = [[IWBrowseADMainViewController alloc] init];
            iwbadmvc.browseADMainType = kPostBoardDiscount;
            [UI_MANAGER.mainNavigationController pushViewController:iwbadmvc animated:YES];
        }
            break;
        case 13:
        {//兑换商城
            MallScanAdvertMain *main = WEAK_OBJECT(MallScanAdvertMain, init);
            [UI_MANAGER.mainNavigationController pushViewController:main animated:YES];
        }
            break;
        default:
            break;
    }

}

//推荐商家
- (void)sendRequestForRecommend{
    ADAPI_Enterprise_Recommend([GLOBAL_DELEGATOR_MANAGER addDelegator:self selector:@selector(handleRecommend:)], 1, 0, 4);
}

- (void)handleRecommend:(DelegatorArguments *)arguments
{
    DictionaryWrapper* dic = arguments.ret;
    if (dic.operationSucceed) {
        if ([[dic.data getArray:@"PageData"] count]) {
            self.shopDataArray = [dic.data getArray:@"PageData"];
            [self setMainTableviewHeight];
            [self.shopTableVIew reloadData];
        }
        
    } else {
        [HUDUtil showErrorWithStatus:dic.operationMessage];
        return;
    }
}
//超值商品
- (void)sendRequestForRecommendProduct{
    ADAPI_RecommendProduct_List([GLOBAL_DELEGATOR_MANAGER addDelegator:self selector:@selector(handleRecommendProduct:)], _currentGroup, 4);
}
//换一组（超值商品）
- (IBAction)nextGroupClicked:(id)sender {
//    if (_currentGroup >= 2) {
//        _currentGroup = -1;
//    }
    _currentGroup++;
    [self sendRequestForRecommendProduct];
}
- (void)handleRecommendProduct:(DelegatorArguments *)arguments{
    DictionaryWrapper* dic = arguments.ret;
    if (dic.operationSucceed) {
        if ([[dic.data getArray:@"PageData"] count] > 0) {
            self.goodsDataArray = [dic.data getArray:@"PageData"];
            [self setMainTableviewHeight];
            [self.goodsTableView reloadData];
        } else {
            _currentGroup = -1;
            [self nextGroupClicked:nil];
//            [HUDUtil showErrorWithStatus:@"暂无更多数据"];return;
        }
       
    } else {
        [HUDUtil showErrorWithStatus:dic.operationMessage];
        return;
    }
}
//更多(推荐商家)
- (IBAction)moreMerchantClicked:(id)sender {
    [UI_MANAGER.mainNavigationController pushViewController:WEAK_OBJECT(RecommendMerchantViewController, init) animated:YES];
}
//更多（信息）
- (IBAction)moreInfoClicked:(id)sender {
    IWBrowseADMainViewController *iwbadmvc = [[IWBrowseADMainViewController alloc] init];
    iwbadmvc.browseADMainType = kPostBoardDiscount;
    [UI_MANAGER.mainNavigationController pushViewController:iwbadmvc animated:YES];
}

#pragma mark - 内存管理

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_postBoardList release];
    [_scrollCon remove];
    [_goodsDataArray release];
    [_dataDic release];
    [_shopDataArray release];
    [_scrollview release];
    [_goodsTableView release];
    [_shopTableVIew release];
    [_mainTableView release];
    [_imgBanner release];
    [_guideImageView release];
    [_unreadView release];
    [_hview release];
    [_bannerSc release];
    [_itemScroll release];
    [_btnMore release];
    [_lblMore release];
    [_infoTableView release];
    [_btn1 release];
    [_btn2 release];
    [_btn3 release];
    [super dealloc];
}
@end
