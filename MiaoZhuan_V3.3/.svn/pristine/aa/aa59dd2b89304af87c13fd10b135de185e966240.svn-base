//
//  IWBrowseADMainViewController.m
//  dfvasdfsa
//
//  Created by luo on 15/5/10.
//  Copyright (c) 2015年 luo cena. All rights reserved.
//

#import "IWBrowseADMainViewController.h"
#import "IWBrowseADMainFilterTableViewCell.h"
#import "SharedData.h"
#import "API_PostBoard.h"
#import "Model_PostBoard.h"
#import "Definition.h"
#import "MZRefresh.h"
#import "IWBrowseADCellTableViewCell.h"
#import "IWSearchViewController.h"
#import "IWCollectViewController.h"

#import "IWMainDetail.h"
#import "IWRecruitDetailViewController.h"
#import "IWAttractBusinessDetailViewController.h"
#import "SellerDiscountDetail.h"
#import "IWCompanyIntroViewController.h"

#import "MMLocationManager.h"
#import <objc/runtime.h>

#import "RequestFailed.h"

/**
 *  地区
 */
@interface DistrictInfo : NSObject

@property (assign, nonatomic) int   districtId;         //区域代码
@property (assign, nonatomic) int   districtParentId;   //父区域代码
@property (assign, nonatomic) int   districtLevel;      //层级：1-省 2-市 3-区
@property (retain, nonatomic) NSString * districtName;  //区域名称
@property (retain, nonatomic) NSString * districtSpell; //拼音
@property (assign, nonatomic) BOOL   isSelect;

-(void) setupDataInfo:(NSDictionary *) dic;

@end

@implementation DistrictInfo

-(void) setupDataInfo:(NSDictionary *)dic{
    _districtId = [dic[@"RegionId"] integerValue];
    _districtParentId = [dic[@"ParentId"] integerValue];
    _districtLevel = [dic[@"Level"] integerValue];
    _districtName = dic[@"Name"];
    _districtSpell = dic[@"Spell"];
    _isSelect = NO;
}

@end


/**
 *  行业类别
 */
@interface IndustryCategoryInfo : NSObject

@property (assign, nonatomic) int       industryId;               //行业代码
@property (assign, nonatomic) int       industryParentId;          //父行业代码
@property (retain, nonatomic) NSString * industryName;      //行业名称
@property (retain, nonatomic) NSString * industrystring;    //图片Url
@property (assign, nonatomic) BOOL      isSelected;         //是否选中

-(void) setupDataInfo:(NSDictionary *) dic;

@end

@implementation IndustryCategoryInfo

-(void) setupDataInfo:(NSDictionary *)dic{
    _industryId = [dic[@"IndustryId"] integerValue];
    _industryParentId = [dic[@"ParentId"] integerValue];
    _industryName = dic[@"Name"];
    _industrystring = dic[@"PictureUrl"];
    _isSelected = NO;
}

@end

@interface OperatorCodeInfo (isSelected)

@property (assign,nonatomic) BOOL   isSeleted; // 是否选中

@end

@implementation OperatorCodeInfo (isSelected)

static void * isSeletedKey = (void *)@"isSeletedKey";

- (BOOL )isSeleted
{
    return [objc_getAssociatedObject(self, isSeletedKey) boolValue];
}

- (void) setIsSeleted:(BOOL)isSeleted{
    objc_setAssociatedObject(self, isSeletedKey, [NSNumber numberWithBool:isSeleted], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end

static int showLocationCount = 1;

@interface IWBrowseADMainViewController ()<UITableViewDataSource,UITableViewDelegate,CLLocationManagerDelegate,UIGestureRecognizerDelegate,RequestFailedDelegate>
{
    int  _pageIndex;
    int  _pageSize;
    CLLocationManager *_locationManager;
    CLGeocoder *_geocoder;
    NSMutableArray *_results;
    
    
    UIButton *_searchBtn;
    UIButton *_favoriteBtn;
    
    IWSearchViewController *_iWSearchViewController;
    
    UITapGestureRecognizer *_tapGestureRecognizer;
    
    BOOL _isClickLocation;
    
    RequestFailed *_requestFailed;
    
    BOOL _isMunicipality;           //是否选择直辖市
    BOOL _isLocationMunicipality;   //是否定位直辖市
    BOOL _isClickNearbyButton;      //是否离我最近
}

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintLine;
@property (weak, nonatomic) IBOutlet UIView             *viewHeader;

@property (weak,nonatomic) UIButton *buttonTopClick;
@property (strong, nonatomic) IBOutlet UIButton *buttonSellerDiscount;
@property (strong, nonatomic) IBOutlet UIButton *buttonRecruitment;
@property (strong, nonatomic) IBOutlet UIButton *buttonAttractBusiness;

@property (weak, nonatomic) IBOutlet UIView *viewHeaderBottom;
@property (weak,nonatomic) UIButton *buttonBottomClick;
@property (weak, nonatomic) IBOutlet UIButton *buttonBottomOrigin;
@property (assign,nonatomic)  BOOL  isLocaltionSuccess;  // 是否定位成功

@property (retain, nonatomic) IBOutlet UITableView *tableViewLeft;
@property (retain, nonatomic) IBOutlet UITableView *tableViewRight;
@property (retain, nonatomic) IBOutlet UITableView *tableViewFull;
@property (retain, nonatomic) IBOutlet UITableView *tableViewContent;

@property (retain, nonatomic) IBOutlet UIImageView *imageViewNoResult;
@property (retain, nonatomic) IBOutlet UILabel *lableNoResult;
@property (retain, nonatomic) IBOutlet UILabel *lableLocation;
@property (retain, nonatomic) IBOutlet UIView *viewLeftAndRight;


/**
 *  行业不限
 */
@property (retain, nonatomic) IndustryCategoryInfo *noIndustryCategoryLimite;

/**
 *  投资金额不限
 */
@property (retain, nonatomic) OperatorCodeInfo    *noInvestmentLimite;

/**
 *  薪水不限
 */
@property (retain, nonatomic) OperatorCodeInfo    *noSalaryLimite;

/**
 *  全国，省地区不限
 */
@property (retain, nonatomic) DistrictInfo        *noDistrictProvinceLimite;

/**
 *  全国，市地区不限
 */
@property (retain, nonatomic) DistrictInfo        *noDistrictCityLimite;


/**
 *  当前定位城市
 */
@property (retain, nonatomic) DistrictInfo        *districtInLocation;

/**
 *  筛选地区
 */
@property (retain, nonatomic) DistrictInfo              *inputProvinceInfo;
@property (retain, nonatomic) DistrictInfo              *inputCityInfo;
/**
 *  筛选行业
 */
@property (retain, nonatomic) IndustryCategoryInfo      *inputIndustryCategoryInfo;
/**
 *  筛选薪水
 */
@property (retain, nonatomic) OperatorCodeInfo          *inputSalary;
/**
 *  筛选投资
 */
@property (retain, nonatomic) OperatorCodeInfo          *inputInvestment;
@property (assign, nonatomic) RegionType                 inputRegionType;

///**
// *  所有区域列表
// */
//@property (retain, nonatomic) NSMutableDictionary * dicDistrictLeft;   //左边tableview data
///**
// *  二级区域列表
// */
//@property (retain, nonatomic) NSMutableArray * arrayDistrictRight;  //右边tableview data
/**
 *  行业
 */
@property (retain, nonatomic) NSMutableArray * arrayIndustry;       //行业
/**
 *  薪水
 */
@property (retain, nonatomic) NSMutableArray * arraySalary;         //薪水

/**
 *  省
 */
@property (retain, nonatomic) NSMutableDictionary *dicDistrictProvice;

/**
 *  市
 */
@property (retain, nonatomic) NSMutableDictionary *dicDistrictCity;


/**
 *  区
 */
@property (retain, nonatomic) NSMutableDictionary *dicDistrictDistrict;

/**
 *  二级区域列表
 */
@property (retain, nonatomic) NSMutableArray * arrayDistrictRight;  //右边tableview data

@end

@implementation IWBrowseADMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    //    [user setObject:@(29.5106467640871) forKey:@"kMZLatitude"];
    //    [user setObject:@(106.459200317919) forKey:@"kMZLongitude"];
    //    [user synchronize];
    
    _dicDistrictProvice = [[NSMutableDictionary alloc] init];
    _dicDistrictCity = [[NSMutableDictionary alloc] init];
    _dicDistrictDistrict = [[NSMutableDictionary alloc] init];
    _isLocationMunicipality  = NO;
    _isClickNearbyButton = NO;
    
    for (int i = 0 ; i < [SharedData getInstance].operatorInvestAmountCodeList.count; i ++) {
        OperatorCodeInfo *oci = [SharedData getInstance].operatorInvestAmountCodeList[i];
        oci.isSeleted = NO;
    }
    
    self.buttonBottomClick = self.buttonBottomOrigin;
    
    self.inputRegionType = kRegionAdministrativeDivision;
    _pageIndex = 0;
    _pageSize = 30;
    _results = [[NSMutableArray alloc] init];
    _isLocaltionSuccess = NO;
    _isClickLocation = NO;
    _isMunicipality = NO;
    
    InitNav(@"信息");
    [self setupMoveBackButton];
    
    _favoriteBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    _favoriteBtn.frame=CGRectMake(SCREENWIDTH - 80, 6, 30, 30) ;
    _favoriteBtn.tag = 1;
    [_favoriteBtn addTarget:self action:@selector(buttonNavigateClick:) forControlEvents:UIControlEventTouchUpInside];
    [_favoriteBtn setImage:[UIImage imageNamed:@"IW_favorite"] forState:UIControlStateNormal];
    [_favoriteBtn setImage:[UIImage imageNamed:@"IW_favorite_hover"] forState:UIControlStateHighlighted];
    
    _searchBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    _searchBtn.frame=CGRectMake(SCREENWIDTH - 40, 6, 30, 30) ;
    [_searchBtn setImage:[UIImage imageNamed:@"IW_search"] forState:UIControlStateNormal];
    [_searchBtn setImage:[UIImage imageNamed:@"IW_search_hover"] forState:UIControlStateHighlighted];
    _searchBtn.tag = 0;
    [_searchBtn addTarget:self action:@selector(buttonNavigateClick:) forControlEvents:UIControlEventTouchUpInside];
    
    if (_tapGestureRecognizer == nil) {
        _tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyBoard)];
        _tapGestureRecognizer.delegate = self;
        _tapGestureRecognizer.numberOfTouchesRequired = 1;
        [self.tableViewRight addGestureRecognizer:_tapGestureRecognizer];
    }
    
    //    UIBarButtonItem *barSearchBtn=[[UIBarButtonItem alloc]initWithCustomView:searchBtn];
    //    UIBarButtonItem *barFavoriteBtn=[[UIBarButtonItem alloc]initWithCustomView:favoriteBtn];
    //    UIBarButtonItem * spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:self action:nil];
    //
    //    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 100, 0, 80, 40)];
    //    toolBar.backgroundColor = [UIColor clearColor];
    //    [toolBar setItems:@[barSearchBtn,spaceItem,barFavoriteBtn] animated:NO];
    //
    //    for (UIView *view in [toolBar subviews]) {
    //
    //        if ([view isKindOfClass:[UIImageView class]]) {
    //
    //            [view removeFromSuperview];
    //        }
    //    }
    //    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:toolBar];
    //    [self.navigationController.navigationBar addSubview:toolBar];
    [self.navigationController.navigationBar addSubview:_favoriteBtn];
    [self.navigationController.navigationBar addSubview:_searchBtn];
    
    
    self.noIndustryCategoryLimite = [[IndustryCategoryInfo alloc] init];
    self.noIndustryCategoryLimite.industryId = 0;
    self.noIndustryCategoryLimite.industryParentId = 0;
    self.noIndustryCategoryLimite.industryName = @"不限";
    self.noIndustryCategoryLimite.isSelected = YES;
    
    self.noInvestmentLimite = [[OperatorCodeInfo alloc] init];
    self.noInvestmentLimite.codeId = 0;
    self.noInvestmentLimite.codeText = @"不限";
    self.noInvestmentLimite.codeValue = @"";
    self.noInvestmentLimite.codeSortId = @"";
    self.noInvestmentLimite.isSeleted = YES;
    
    self.noSalaryLimite = [[OperatorCodeInfo alloc] init];
    self.noSalaryLimite.codeId = 0;
    self.noSalaryLimite.codeText = @"不限";
    self.noSalaryLimite.codeSortId = @"";
    self.noSalaryLimite.codeValue = @"";
    self.noSalaryLimite.isSeleted = YES;
    
    self.noDistrictProvinceLimite = [[DistrictInfo alloc] init];
    self.noDistrictProvinceLimite.districtId = 0;
    self.noDistrictProvinceLimite.districtParentId = 0;
    self.noDistrictProvinceLimite.districtLevel = 1;
    self.noDistrictProvinceLimite.districtName = @"不限";
    self.noDistrictProvinceLimite.districtSpell = @"";
    self.noDistrictProvinceLimite.isSelect = YES;
    self.inputProvinceInfo = self.noDistrictProvinceLimite;
    
    self.districtInLocation = [[DistrictInfo alloc] init];
    self.districtInLocation.districtId = -1;
    self.districtInLocation.districtParentId = 0;
    self.districtInLocation.districtLevel = 1;
    self.districtInLocation.districtName = @"定位中";
    self.districtInLocation.districtSpell = @"";
    self.districtInLocation.isSelect = NO;
    
    self.noDistrictCityLimite = [[DistrictInfo alloc] init];
    self.noDistrictCityLimite.districtId = 0;
    self.noDistrictCityLimite.districtParentId = 0;
    self.noDistrictCityLimite.districtLevel = 1;
    self.noDistrictCityLimite.districtName = @"不限";
    self.noDistrictCityLimite.districtSpell = @"";
    self.noDistrictCityLimite.isSelect = YES;
    self.inputCityInfo = self.noDistrictCityLimite;
    
    self.tableViewFull.hidden = YES;
    self.tableViewLeft.hidden = YES;
    self.tableViewRight.hidden = YES;
    self.tableViewFull.tableFooterView = [[UIView alloc] init];
    self.tableViewLeft.tableFooterView = [[UIView alloc] init];
    //    self.tableViewRight.tableFooterView = [[UIView alloc] init];
    
    switch (self.browseADMainType) {
        case kPostBoardRecruit:
        {
            [self.buttonBottomOrigin setTitle:@"  薪资  " forState:UIControlStateNormal];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.buttonBottomOrigin.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -100);
                self.buttonBottomOrigin.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 15);
            });
            [self.buttonBottomOrigin setNeedsLayout];
            [self.buttonBottomOrigin setNeedsDisplay];
            self.buttonRecruitment.selected = YES;
            self.buttonRecruitment.titleLabel.font = [UIFont systemFontOfSize:16];
            self.buttonTopClick = self.buttonRecruitment;
        }
            break;
        case kPostBoardAttractBusiness:
        {
            [self.buttonBottomOrigin setTitle:@"投资金额" forState:UIControlStateNormal];
            self.buttonAttractBusiness.selected = YES;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.buttonBottomOrigin.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -132);
                self.buttonBottomOrigin.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 20);
            });
            
            self.buttonAttractBusiness.titleLabel.font = [UIFont systemFontOfSize:16];
            self.buttonTopClick = self.buttonAttractBusiness;
        }
            break;
        case kPostBoardDiscount:
        {
            [self.buttonBottomOrigin setTitle:@"离我最近" forState:UIControlStateNormal];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.buttonBottomOrigin.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -132);
                self.buttonBottomOrigin.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 1);
                
            });
            [self.buttonBottomOrigin setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
            [self.buttonBottomOrigin setImage:[UIImage imageNamed:@""] forState:UIControlStateSelected];
            self.buttonSellerDiscount.selected = YES;
            self.buttonSellerDiscount.titleLabel.font = [UIFont systemFontOfSize:16];
            self.buttonTopClick = self.buttonSellerDiscount;
        }
            break;
        default:
            break;
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.viewHeader layoutIfNeeded];
        [UIView animateWithDuration:0.3f animations:^{
            self.constraintLine.constant = self.buttonTopClick.frame.origin.x;
            [self.viewHeader layoutIfNeeded];
            
        }];
    });
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleUpdateSuccessAction:) name:UpdateSuccessAction object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleUpdateFailureAction:) name:UpdateFailureAction object:nil];
    
    [self.tableViewContent addGifHeaderWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
    self.tableViewContent.header.updatedTimeHidden = YES;
    
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (int i = 1; i<=16; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"Loadicon.bundle/Loadicon%d",i]];
        [refreshingImages addObject:image];
    }
    [self.tableViewContent.gifHeader setImages:@[refreshingImages[0]] forState:MZRefreshHeaderStateIdle];
    [self.tableViewContent.gifHeader setImages:@[refreshingImages[0]] forState:MZRefreshHeaderStatePulling];
    [self.tableViewContent.gifHeader setImages:refreshingImages forState:MZRefreshHeaderStateRefreshing];
    
    
    
    [self.tableViewContent.header beginRefreshing];
    self.lableLocation.text = @"当前:定位中...";
    [self buttonClickLocation:nil];
    
    //    if ([_tableViewFull respondsToSelector:@selector(setSeparatorInset:)]) {
    //
    //        [_tableViewFull setSeparatorInset:UIEdgeInsetsZero];
    //        [_tableViewLeft setSeparatorInset:UIEdgeInsetsZero];
    //        [_tableViewRight setSeparatorInset:UIEdgeInsetsZero];
    //
    //    }
    
    //    if ([_tableViewFull respondsToSelector:@selector(setLayoutMargins:)]) {
    //
    //        [_tableViewFull setLayoutMargins:UIEdgeInsetsZero];
    //        [_tableViewLeft setLayoutMargins:UIEdgeInsetsZero];
    //        [_tableViewRight setLayoutMargins:UIEdgeInsetsZero];
    //
    //    }
}


-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //    _searchBtn.hidden = NO;
    //    _favoriteBtn.hidden = NO;
    [self.navigationController.navigationBar addSubview:_favoriteBtn];
    [self.navigationController.navigationBar addSubview:_searchBtn];
}

-(void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //    _searchBtn.hidden = YES;
    //    _favoriteBtn.hidden = YES;
    
    [_searchBtn removeFromSuperview];
    [_favoriteBtn removeFromSuperview];
    
}

-(void)onMoveBack:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

//定位
- (IBAction)buttonClickLocation:(UIButton *)sender {
    
    if (sender) {
        _isClickLocation = YES;
    }
    if(_isClickLocation)
        [HUDUtil showWithStatus:@"定位中..."];
    showLocationCount = 1;
    if([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
    {
        //定位管理器
        _locationManager= STRONG_OBJECT(CLLocationManager, init);
        
        if (![CLLocationManager locationServicesEnabled] || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied) {
            
            self.districtInLocation.districtId = -1;
            self.districtInLocation.districtName = @"定位失败，点击重试";
            self.lableLocation.text = @"定位失败，点击重试";
            [HUDUtil showErrorWithStatus:@"定位服务当前可能尚未打开，请去设置-隐私-定位服务里打开！"];
            
            return;
        }
        //如果没有授权则请求用户授权
        if ([CLLocationManager authorizationStatus]==kCLAuthorizationStatusNotDetermined){
            
            [_locationManager requestWhenInUseAuthorization];
            
        }else if([CLLocationManager authorizationStatus]==kCLAuthorizationStatusAuthorizedWhenInUse || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorized){
            //设置代理
            _locationManager.delegate=self;
            //设置定位精度
            _locationManager.desiredAccuracy=kCLLocationAccuracyBest;
            //定位频率,每隔多少米定位一次
            CLLocationDistance distance=10.0;//十米定位一次
            _locationManager.distanceFilter=distance;
            //启动跟踪定位
            [_locationManager startUpdatingLocation];
        }
    }
    else
    {
        __block __weak IWBrowseADMainViewController *wself = self;
        
        _lableLocation.text = @"正在定位中...";
        
        [[MMLocationManager shareLocation] getState:^(NSString * city){
            if(_isClickLocation)
                [HUDUtil showSuccessWithStatus:@"定位成功"];
            if (city.length > 0) {
                wself.isLocaltionSuccess = YES;
                wself.lableLocation.text = [NSString stringWithFormat:@"定位:%@",city];
                wself.districtInLocation.districtName = city;
                wself.districtInLocation.districtLevel = 1;
                wself.districtInLocation.districtParentId = 1;
            }else{
                wself.lableLocation.text = @"定位失败，点击重试";
                wself.districtInLocation.districtName = @"定位失败";
                wself.districtInLocation.districtId = -2;
            }
        } error:^(NSError *error){
            
            if(_isClickLocation)
                [HUDUtil showErrorWithStatus:@"定位失败"];
            
            wself.isLocaltionSuccess =  NO;
            if (showLocationCount > 0) {
                showLocationCount--;
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"定位服务未开启" message:@"请允许“秒赚”定位你的位置\n(设置>隐私>定位服务>开启秒赚)" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alert show];
            }
            wself.lableLocation.text = @"定位失败，点击重试";
            wself.districtInLocation.districtId = -1;
            wself.districtInLocation.districtName = @"定位失败";
        }];
    }
}

//可以通过模拟器设置一个虚拟位置，否则在模拟器中无法调用此方法
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    CLLocation *location=[locations firstObject];//取出第一个位置
    CLLocationCoordinate2D coordinate=location.coordinate;//位置坐标
    
    _geocoder = STRONG_OBJECT(CLGeocoder, init);
    [self getAddressByLatitude:coordinate.latitude longitude:coordinate.longitude];
    
    NSLog(@"经度：%f,纬度：%f,海拔：%f,航向：%f,行走速度：%f",coordinate.longitude,coordinate.latitude,location.altitude,location.course,location.speed);
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:@(coordinate.longitude) forKey:@"kMZLongitude"];
    [userDefault setObject:@(coordinate.latitude) forKey:@"kMZLatitude"];
    [userDefault synchronize];
    
    //如果不需要实时定位，使用完即使关闭定位服务
    [_locationManager stopUpdatingLocation];
}

#pragma mark 根据坐标取得地名
-(void)getAddressByLatitude:(CLLocationDegrees)latitude longitude:(CLLocationDegrees)longitude{
    
    
    //反地理编码
    CLLocation *location=[[CLLocation alloc]initWithLatitude:latitude longitude:longitude];
    [_geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        
        if (error){
            NSLog(@"Geocode failed with error: %@", error);
        }
        
        CLPlacemark *placemark=[placemarks firstObject];
        
        DictionaryWrapper * dic = placemark.addressDictionary.wrapper;
        
        NSString * addressText = [dic getString:@"Name"];
        
        if(addressText.length == 0)
        {
            self.isLocaltionSuccess = NO;
            addressText = @"定位失败，点击重试";
            self.districtInLocation.districtId  = -1;
            self.districtInLocation.districtName = @"定位失败";
            if(_isClickLocation)
                [HUDUtil showErrorWithStatus:@"定位失败"];
        }
        else
        {
            addressText = [addressText substringFromIndex:2];
            addressText = [NSString stringWithFormat:@"当前 : %@", addressText];
            if(_isClickLocation)
                [HUDUtil showSuccessWithStatus:@"定位成功"];
        }
        self.isLocaltionSuccess = YES;
        self.lableLocation.text = addressText;
        self.districtInLocation.districtName = [dic getString:@"State"];
        
        //        if ([[self.dicDistrictLeft allKeys] count]) {
        //            [self.dicDistrictLeft enumerateKeysAndObjectsUsingBlock:^(NSString *key,NSArray *districts, BOOL *stop){
        //                for (DistrictInfo *obj in districts) {
        //                    if ([[dic getString:@"State"] isEqualToString:obj.districtName]) {
        //                        self.districtInLocation.districtId = obj.districtId;
        //                    }
        //                }
        //            }];
        //        }
        //        [self.tableViewLeft reloadData];
    }];
}


//-(void)viewDidLayoutSubviews
//{
//    [super viewDidLayoutSubviews];
//
//    // Force your tableview margins (this may be a bad idea)
//    if ([self.tableViewContent respondsToSelector:@selector(setSeparatorInset:)]) {
//        [self.tableViewContent setSeparatorInset:UIEdgeInsetsZero];
//        [self.tableViewLeft setSeparatorInset:UIEdgeInsetsZero];
//        [self.tableViewRight setSeparatorInset:UIEdgeInsetsZero];
//        [self.tableViewFull setSeparatorInset:UIEdgeInsetsZero];
//
//    }
//
//    if ([self.tableViewContent respondsToSelector:@selector(setLayoutMargins:)]) {
//        [self.tableViewContent setLayoutMargins:UIEdgeInsetsZero];
//        [self.tableViewLeft setLayoutMargins:UIEdgeInsetsZero];
//        [self.tableViewRight setLayoutMargins:UIEdgeInsetsZero];
//        [self.tableViewFull setLayoutMargins:UIEdgeInsetsZero];
//
//    }
//}


-(void) buttonNavigateClick:(UIButton *)sender{
    //search
    if (sender.tag == 0) {
        if (_iWSearchViewController == nil)
            _iWSearchViewController = [[IWSearchViewController alloc] initWithNibName:NSStringFromClass([IWSearchViewController class]) bundle:nil];
        [self.navigationController pushViewController:_iWSearchViewController animated:YES];
        //collection
    }else if (sender.tag == 1){
        
        IWCollectViewController *vc = [[IWCollectViewController alloc] initWithNibName:NSStringFromClass([IWCollectViewController class]) bundle:nil];
        vc.postBoardType = self.browseADMainType;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (IBAction)buttonClick:(UIButton *)sender {
    
    _pageIndex = 0;
    [_results removeAllObjects];
    [_tableViewContent reloadData];
    
    [self.viewHeader layoutIfNeeded];
    [UIView animateWithDuration:0.3f animations:^{
        self.constraintLine.constant = sender.frame.origin.x;
        [self.viewHeader layoutIfNeeded];
        
    }];
    
    self.buttonBottomClick.selected = NO;
    
    self.inputProvinceInfo.isSelect = NO;
    self.inputCityInfo.isSelect  = NO;
    self.inputIndustryCategoryInfo.isSelected = NO;
    self.inputSalary.isSeleted  = NO;
    self.inputInvestment.isSeleted  = NO;
    
    
    self.buttonTopClick.titleLabel.font = [UIFont systemFontOfSize:14];
    self.buttonTopClick.selected = NO;
    self.buttonTopClick = sender;
    self.buttonTopClick.titleLabel.font = [UIFont systemFontOfSize:16];
    self.buttonTopClick.selected = YES;
    
    self.inputInvestment = self.noInvestmentLimite;
    self.inputIndustryCategoryInfo = self.noIndustryCategoryLimite;
    self.inputSalary = self.noSalaryLimite;
    self.inputProvinceInfo = self.noDistrictProvinceLimite;
    self.inputCityInfo = self.noDistrictCityLimite;
    self.inputRegionType = kRegionAdministrativeDivision;
    
    self.inputProvinceInfo.isSelect = YES;
    self.inputCityInfo.isSelect  = YES;
    self.inputIndustryCategoryInfo.isSelected = YES;
    self.inputSalary.isSeleted  = YES;
    self.inputInvestment.isSeleted  = YES;
    
    
    self.tableViewLeft.hidden = YES;
    self.tableViewRight.hidden = YES;
    self.tableViewFull.hidden = YES;
    self.viewLeftAndRight.hidden = YES;
    
    switch (sender.tag) {
        case 0:    //商家优惠
        {
            
            self.browseADMainType = kPostBoardDiscount;
            [self.buttonBottomOrigin setTitle:@"离我最近" forState:UIControlStateNormal];
            self.buttonBottomOrigin.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -132);
            self.buttonBottomOrigin.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 1);
            [self.buttonBottomOrigin setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
            [self.buttonBottomOrigin setImage:[UIImage imageNamed:@""] forState:UIControlStateSelected];
            
        }
            break;
        case 1:    //招聘信息
        {
            self.browseADMainType = kPostBoardRecruit;
            [self.buttonBottomOrigin setTitle:@"薪资" forState:UIControlStateNormal];
            self.buttonBottomOrigin.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -80);
            self.buttonBottomOrigin.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 15);
            [self.buttonBottomOrigin setImage:[UIImage imageNamed:@"IWlittleDown"] forState:UIControlStateNormal];
            [self.buttonBottomOrigin setImage:[UIImage imageNamed:@"IWlittleUp"] forState:UIControlStateSelected];
            
        }
            break;
        case 2:    //招商信息
        {
            self.browseADMainType = kPostBoardAttractBusiness;
            [self.buttonBottomOrigin setTitle:@"投资金额" forState:UIControlStateNormal];
            self.buttonBottomOrigin.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -132);
            self.buttonBottomOrigin.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 20);
            [self.buttonBottomOrigin setImage:[UIImage imageNamed:@"IWlittleDown"] forState:UIControlStateNormal];
            [self.buttonBottomOrigin setImage:[UIImage imageNamed:@"IWlittleUp"] forState:UIControlStateSelected];
            
        }
            break;
            
        default:
            break;
    }
    [self.tableViewContent.header beginRefreshing];
}

/**
 *  切换筛选条件
 *
 *  @param sender 按钮
 */
- (IBAction)buttonBottomClick:(UIButton *)sender {
    _isClickNearbyButton = NO;
    self.inputRegionType = kRegionAdministrativeDivision;
    switch (sender.tag) {
        case 3:
        {
            if(self.buttonBottomClick.tag == 3){
                self.buttonBottomClick.selected = !self.buttonBottomClick.selected;
            }else{
                self.buttonBottomClick.selected = NO;
                self.buttonBottomClick = sender;
                self.buttonBottomClick.selected = YES;
            }
            
            
            self.tableViewLeft.hidden = !self.tableViewLeft.hidden;
            //            self.tableViewRight.hidden = YES;
            self.tableViewFull.hidden = YES;
            
            if (self.tableViewLeft.hidden == YES) {
                self.viewLeftAndRight.hidden = YES;
                self.tableViewRight.hidden = YES;
            }else{
                self.viewLeftAndRight.hidden = NO;
                self.tableViewRight.hidden = NO;
                
                if([[self.dicDistrictProvice  allKeys] count] == 0){
                    ADAPI_Region_GetAllBaiduRegionList([GLOBAL_DELEGATOR_MANAGER addDelegator:self selector:@selector(handleRegionList:)]);
                }else{
                    [self.tableViewLeft reloadData];
                }
            }
            
        }
            break;
        case 4:
        {
            
            if(self.buttonBottomClick.tag == 4){
                self.buttonBottomClick.selected = !self.buttonBottomClick.selected;
                self.tableViewFull.hidden =  !self.tableViewFull.hidden;
            }else{
                self.tableViewFull.hidden = NO;
                self.buttonBottomClick.selected = NO;
                self.buttonBottomClick = sender;
                self.buttonBottomClick.selected = YES;
            }
            
            if (self.tableViewLeft.hidden == NO) {
                self.tableViewLeft.hidden = YES;
                self.tableViewRight.hidden = YES;
                self.viewLeftAndRight.hidden = YES;
                self.viewLeftAndRight.hidden = YES;
            }
            if (self.arrayIndustry == nil) {
                self.arrayIndustry = [[NSMutableArray alloc] init];
                //                ADAPI_Industry_GetIndustryCategoryList([GLOBAL_DELEGATOR_MANAGER addDelegator:self selector:@selector(handleIndustry:)]);
                ADAPI_Industry_GetIndustryCategoryList([GLOBAL_DELEGATOR_MANAGER addDelegator:self selector:@selector(handleIndustry:)], @"0");
            }else{
                [self.tableViewFull reloadData];
            }
            
        }
            break;
        case 5:
        {
            
            if(self.buttonBottomClick.tag == 5){
                if (self.browseADMainType == kPostBoardDiscount) {
                    self.tableViewFull.hidden = YES;
                    self.buttonBottomClick.selected = !self.buttonBottomClick.selected;
                    self.inputRegionType = self.buttonBottomClick.selected;
                    [self refreshData];
                }else{
                    self.buttonBottomClick.selected = !self.buttonBottomClick.selected;
                    self.tableViewFull.hidden =  !self.tableViewFull.hidden;
                    [self refreshData];
                }
            }else if(self.buttonBottomClick.tag == 4 && self.browseADMainType == kPostBoardDiscount){
                self.tableViewFull.hidden = YES;
                self.buttonBottomClick.selected = NO;
                self.buttonBottomClick = sender;
                self.buttonBottomClick.selected = !self.buttonBottomClick.selected;
                self.inputRegionType = self.buttonBottomClick.selected;
                [self refreshData];
            }else{
                self.tableViewFull.hidden = YES;
                self.buttonBottomClick.selected = NO;
                self.buttonBottomClick = sender;
                self.buttonBottomClick.selected = YES;
            }
            if (self.tableViewLeft.hidden == NO) {
                self.tableViewLeft.hidden = YES;
                self.tableViewRight.hidden = YES;
                self.viewLeftAndRight.hidden = YES;
                self.tableViewFull.hidden = YES;
            }
            if (self.browseADMainType == kPostBoardRecruit) {
                if ([[SharedData getInstance].operatorCompanySalaryCodeList count] == 0) {
                    [[API_PostBoard getInstance] engine_outside_operator_companySalary];
                }else{
                    [self.tableViewFull reloadData];
                }
            }else if(self.browseADMainType == kPostBoardAttractBusiness){
                if ([[SharedData getInstance].operatorInvestAmountCodeList count] == 0) {
                    [[API_PostBoard getInstance] engine_outside_operator_investAmount];
                }else{
                    [self.tableViewFull reloadData];
                }
            }else if(self.browseADMainType == kPostBoardDiscount){
                if(self.buttonBottomClick.selected){
                    _inputCityInfo = nil;
                    _inputProvinceInfo = nil;
                    _isClickNearbyButton = YES;
                    self.inputRegionType = kRegionNearby;
                    _pageIndex = 0;
                    [self loadData];
                }
            }
        }
            break;
            
        default:
            break;
    }
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    if(tableView == _tableViewContent){
        return [_results  count];
    }
    NSInteger section = 1;
    if (tableView == self.tableViewLeft) {
        section =  [[self.dicDistrictProvice allKeys] count] + 2; //加上全国、定位城市
    }else if (tableView == self.tableViewRight){
        section = 2;
    }else if (tableView == self.tableViewFull){
        section = section +1;   //加不限
    }
    return section;
}


-(UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * headerview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 23)];
    headerview.backgroundColor = RGBCOLOR(247, 247, 247);
    UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(15, 6, self.view.frame.size.width - 15, 10)];
    titleLable.backgroundColor = [UIColor clearColor];
    titleLable.font = [UIFont systemFontOfSize:12];
    titleLable.textColor = RGBCOLOR(153, 153, 153);
    
    UIView *lineHeader = nil;
    if(tableView == self.tableViewContent){
        lineHeader = [[UIView alloc] initWithFrame:CGRectMake(0, -0.5, self.view.frame.size.width, 0.5)];
        
        if (section == 0) {
            lineHeader.frame = CGRectMake(0, 0, self.view.frame.size.width, 0.5);
        }
        
        lineHeader.backgroundColor = RGBCOLOR(204, 204, 204);
        [headerview addSubview:lineHeader];
    }
    
    NSString *title = nil;
    if([tableView isEqual:_tableViewContent]){
        title =  [_results[section] allKeys][0];
        //        if (section != 0) {
        //            titleLable.frame = CGRectMake(15, -5, self.view.frame.size.width - 15, 8);
        //            lineHeader.frame = CGRectMake(0, -10, self.view.frame.size.width, 0.5);
        //        }
    }
    //1级区域列表
    if (tableView == self.tableViewLeft) {
        if(section == 0){
            
        }else if (section == 1){
            title = @"当前定位";
        }else{
            NSArray *resultArray = [[self.dicDistrictProvice allKeys] sortedArrayUsingComparator:^NSComparisonResult(NSString* obj1, NSString* obj2) {
                
                NSComparisonResult result = [obj1 compare:obj2];
                return result == NSOrderedDescending; // 升序
            }];
            title = resultArray[section - 2]; //加上全国、定位城市
        }
    }
    //2级区域列表
    else if (tableView == self.tableViewRight){
    }
    titleLable.text = title;
    [headerview addSubview:titleLable];
    return headerview;
}


-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger row = 0;
    
    //1级区域列表
    if (tableView == self.tableViewLeft) {
        
        if(section == 0){   //全国
            row = 1;
        }else if (section == 1){ //当前定位
            row = 1;
        }else{
            NSArray *resultArray = [[self.dicDistrictProvice allKeys] sortedArrayUsingComparator:^NSComparisonResult(NSString* obj1, NSString* obj2) {
                
                NSComparisonResult result = [obj1 compare:obj2];
                return result == NSOrderedDescending; // 升序
            }];
            NSArray *data = [self.dicDistrictProvice objectForKey:resultArray[section - 2]];
            row = [data count];
        }
    }
    //2级区域列表
    else if(tableView == self.tableViewRight){
        if (section == 0) { //不限
            row =  1;
        }else
            row = [self.arrayDistrictRight count];
    }
    //过滤条件
    else if(tableView == self.tableViewFull){
        //行业类别
        if (self.buttonBottomClick.tag == 4) {
            if (section == 0) { //不限
                row = 1;
            }else
                row = [self.arrayIndustry count];
        }
        //薪水
        else if (self.buttonBottomClick.tag == 5 && self.browseADMainType == kPostBoardRecruit){
            if (section == 0) { //不限
                row = 1;
            }else
                row = [[SharedData getInstance].operatorCompanySalaryCodeList count];
        }
        //投资金额
        else if (self.buttonBottomClick.tag == 5 && self.browseADMainType == kPostBoardAttractBusiness){
            if (section == 0) { //不限
                row = 1;
            }else
                row = [[SharedData getInstance].operatorInvestAmountCodeList count];
        }
    }
    //主内容
    else if (tableView == self.tableViewContent){
        if(_results.count == 0)return 0;
        row = [[_results[section] allValues][0] count];
        //        row = [[SharedData getInstance].postBoardList count];
    }
    
    return row;
}



-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(tableView ==  self.tableViewContent){
        return 23;
    }
    else if (tableView == self.tableViewLeft){
        if (section == 0) {
            return 0.000000000001f;
        }else
            return 20;
    }
    else if (tableView == self.tableViewRight){
        if (section == 0) {
            return 0.000000000001f;
        }else
            return 0.000000000001f;
    }else if (tableView == self.tableViewFull){
        if (section == 0) {
            return 0.000000000001f;
        }else
            return 0;
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView == _tableViewContent)return 112.0f;
    return 45.f;
}


-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellDistrictReusable = @"IWBrowseADMainFilterTableViewCell";
    static NSString *cellContentReusable = @"IWBrowseADCellTableViewCell";
    UITableViewCell *cell = nil;
    
    //1级区域列表
    if (tableView == self.tableViewLeft) {
        IWBrowseADMainFilterTableViewCell *cellDistrict = (IWBrowseADMainFilterTableViewCell*) [tableView dequeueReusableCellWithIdentifier:cellDistrictReusable];
        
        if(cellDistrict == nil){
            cellDistrict =  [[[NSBundle mainBundle] loadNibNamed:@"IWBrowseADMainFilterTableViewCell" owner:self options:nil] lastObject];
        }
        DistrictInfo *obj = nil;
        cellDistrict.textLabel.font = [UIFont systemFontOfSize:14.f];
        cellDistrict.textLabel.textColor = RGBCOLOR(34, 34, 34);
        if(indexPath.section == 0){
            obj = self.noDistrictProvinceLimite;
            cellDistrict.layoutConstraintLocationIcon.constant = 0;
            cellDistrict.lableDistrict.text = @"";
            cellDistrict.textLabel.text = obj.districtName;
        }else if (indexPath.section == 1){
            obj = self.districtInLocation;
            cellDistrict.layoutConstraintLocationIcon.constant = 11;
            cellDistrict.lableDistrict.text = obj.districtName;
            cellDistrict.textLabel.text = @"";
        }else{
            NSArray *resultArray = [[self.dicDistrictProvice allKeys] sortedArrayUsingComparator:^NSComparisonResult(NSString* obj1, NSString* obj2) {
                
                NSComparisonResult result = [obj1 compare:obj2];
                return result == NSOrderedDescending; // 升序
            }];
            NSArray *data = [self.dicDistrictProvice objectForKey:resultArray[indexPath.section - 2]];
            obj = data[indexPath.row];
            cellDistrict.layoutConstraintLocationIcon.constant = 0;
            cellDistrict.lableDistrict.text = @"";
            cellDistrict.textLabel.text = obj.districtName;
        }
        
        cellDistrict.layoutConstraintLineX.constant = 0;
        cellDistrict.layoutConstraintLineTail.constant = 0.f;
        
        cell = cellDistrict;
    }
    //2级区域列表
    else if (tableView == self.tableViewRight){
        IWBrowseADMainFilterTableViewCell *cellDistrict = (IWBrowseADMainFilterTableViewCell*) [tableView dequeueReusableCellWithIdentifier:cellDistrictReusable];
        
        if(cellDistrict == nil){
            cellDistrict =  [[[NSBundle mainBundle] loadNibNamed:@"IWBrowseADMainFilterTableViewCell" owner:self options:nil] lastObject];
            cellDistrict.contentView.backgroundColor = RGBCOLOR(239, 239, 244);
        }
        
        DistrictInfo *obj = nil;
        if (indexPath.section == 0) {
            obj = self.noDistrictCityLimite;
            tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        }else{
            obj = self.arrayDistrictRight[indexPath.row];
        }
        if (obj.isSelect) {
            cellDistrict.imageViewCheck.image = [UIImage imageNamed:@"ads_list_right"];
            cellDistrict.textLabel.textColor = RGBCOLOR(250, 9, 28);
        }else{
            cellDistrict.imageViewCheck.image = nil;
            cellDistrict.textLabel.textColor = RGBCOLOR(34, 34, 34);
        }
        cellDistrict.textLabel.font = [UIFont systemFontOfSize:14.f];
        cellDistrict.lableDistrict.text = @"";
        cellDistrict.textLabel.text = obj.districtName;
        
        cellDistrict.layoutConstraintLocationIcon.constant = 0;
        cellDistrict.layoutConstraintLineX.constant = 0;
        cellDistrict.layoutConstraintLineTail.constant = 0.f;
        
        cell = cellDistrict;
    }
    else if (tableView == self.tableViewFull){
        //行业类别
        if (self.buttonBottomClick.tag == 4) {
            IWBrowseADMainFilterTableViewCell *cellDistrict = (IWBrowseADMainFilterTableViewCell*) [tableView dequeueReusableCellWithIdentifier:cellDistrictReusable];
            
            if(cellDistrict == nil){
                cellDistrict =  [[[NSBundle mainBundle] loadNibNamed:@"IWBrowseADMainFilterTableViewCell" owner:self options:nil] lastObject];
            }
            
            
            
            IndustryCategoryInfo *obj = nil;
            if (indexPath.section == 0) {
                obj = self.noIndustryCategoryLimite;
            }else
                obj = self.arrayIndustry[indexPath.row];
            
            if (obj.isSelected) {
                cellDistrict.imageViewCheck.image = [UIImage imageNamed:@"ads_list_right"];
                cellDistrict.textLabel.textColor = RGBCOLOR(250, 9, 28);
            }else{
                cellDistrict.imageViewCheck.image = nil;
                cellDistrict.textLabel.textColor = RGBCOLOR(34, 34, 34);
            }
            cellDistrict.textLabel.font = [UIFont systemFontOfSize:14.f];
            cellDistrict.textLabel.text = obj.industryName;
            cellDistrict.lableDistrict.text = @"";
            
            cellDistrict.layoutConstraintLocationIcon.constant = 0;
            cellDistrict.layoutConstraintLineX.constant = 15;
            cellDistrict.layoutConstraintLineTail.constant = 0.f;
            
            cell = cellDistrict;
        }//薪水
        else if (self.buttonBottomClick.tag == 5 && self.browseADMainType == kPostBoardRecruit){
            IWBrowseADMainFilterTableViewCell *cellDistrict = (IWBrowseADMainFilterTableViewCell*) [tableView dequeueReusableCellWithIdentifier:cellDistrictReusable];
            
            if(cellDistrict == nil){
                cellDistrict =  [[[NSBundle mainBundle] loadNibNamed:@"IWBrowseADMainFilterTableViewCell" owner:self options:nil] lastObject];
            }
            OperatorCodeInfo *obj  = nil;
            if (indexPath.section == 0) {
                obj = self.noSalaryLimite;
            }else{
                obj  = [SharedData getInstance].operatorCompanySalaryCodeList[indexPath.row];
            }
            if (obj.isSeleted) {
                cellDistrict.imageViewCheck.image = [UIImage imageNamed:@"ads_list_right"];
                cellDistrict.textLabel.textColor = RGBCOLOR(250, 9, 28);
            }else{
                cellDistrict.imageViewCheck.image = nil;
                cellDistrict.textLabel.textColor = RGBCOLOR(34, 34, 34);
            }
            cellDistrict.textLabel.font = [UIFont systemFontOfSize:14.f];
            cellDistrict.textLabel.text = obj.codeText;
            cellDistrict.lableDistrict.text = @"";
            
            cellDistrict.layoutConstraintLocationIcon.constant = 0;
            cellDistrict.layoutConstraintLineX.constant = 15;
            cellDistrict.layoutConstraintLineTail.constant = 0.f;
            cell = cellDistrict;
        }
        //投资金额
        else if (self.buttonBottomClick.tag == 5 && self.browseADMainType == kPostBoardAttractBusiness){
            IWBrowseADMainFilterTableViewCell *cellDistrict = (IWBrowseADMainFilterTableViewCell*) [tableView dequeueReusableCellWithIdentifier:cellDistrictReusable];
            
            if(cellDistrict == nil){
                cellDistrict =  [[[NSBundle mainBundle] loadNibNamed:@"IWBrowseADMainFilterTableViewCell" owner:self options:nil] lastObject];
            }
            
            OperatorCodeInfo *obj  =  nil;
            
            if (indexPath.section == 0) {
                obj = self.noInvestmentLimite;
            }else{
                obj = (OperatorCodeInfo*)[SharedData getInstance].operatorInvestAmountCodeList[indexPath.row];
            }
            if (obj.isSeleted) {
                cellDistrict.imageViewCheck.image = [UIImage imageNamed:@"ads_list_right"];
                cellDistrict.textLabel.textColor = RGBCOLOR(250, 9, 28);
            }else{
                cellDistrict.imageViewCheck.image = nil;
                cellDistrict.textLabel.textColor = RGBCOLOR(34, 34, 34);
            }
            cellDistrict.lableDistrict.text = @"";
            cellDistrict.textLabel.text = obj.codeText;
            cellDistrict.textLabel.font = [UIFont systemFontOfSize:14.f];
            cellDistrict.layoutConstraintLocationIcon.constant = 0;
            cellDistrict.layoutConstraintLineX.constant = 15;
            cellDistrict.layoutConstraintLineTail.constant = 0.f;
            cell = cellDistrict;
        }
        
    }
    //主tableview content
    else if (tableView == self.tableViewContent){
        IWBrowseADCellTableViewCell * cellContent = (IWBrowseADCellTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellContentReusable];
        if (cellContent == nil) {
            cellContent = [[[NSBundle mainBundle] loadNibNamed:@"IWBrowseADCellTableViewCell" owner:self options:nil] lastObject];
        }
        NSString *key = [_results[indexPath.section] allKeys][0];
        [cellContent setupDataContent:_results[indexPath.section][key][indexPath.row] PostBoardType:_browseADMainType];
        cell = cellContent;
        if(self.browseADMainType == kPostBoardDiscount && self.buttonBottomClick.tag == 5 && self.buttonBottomClick.selected == YES){
            PostBoardInfo * obj = _results[indexPath.section][key][indexPath.row];
            cellContent.label_Address.text = [NSString stringWithFormat:@"%0.2fKM",obj.postBoardDistance];
        }
        
        cellContent.label_Line.hidden = (indexPath.row == [[_results[indexPath.section] allValues][0] count] - 1);
        return cellContent;
    }
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //1级区域列表
    if (tableView == self.tableViewLeft) {
        
        if (indexPath.section == 0) { //全国
            self.tableViewRight.hidden = NO;
            self.noDistrictCityLimite.isSelect = YES;
            _arrayDistrictRight = nil;
            [self.tableViewRight reloadData];
            self.inputProvinceInfo = nil;
            
        }else if (indexPath.section == 1) {  //定位城市
            
            if (self.districtInLocation.districtId == -1) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"定位服务未开启" message:@"请允许“秒赚”定位你的位置\n(设置>隐私>定位服务>开启秒赚)" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alert show];
                return;
            }else if (self.districtInLocation.districtId == -2){
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"定位服务失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alert show];
                return;
            }
            self.tableViewRight.hidden = NO;
            self.districtInLocation.isSelect = YES;
            
            self.inputCityInfo.isSelect = NO;
            self.inputCityInfo = self.noDistrictCityLimite;
            self.inputCityInfo.isSelect = YES;
            
            if(_isLocationMunicipality){
                _isMunicipality = YES;
            }else{
                _isMunicipality = NO;
            }
            _arrayDistrictRight = [_dicDistrictDistrict objectForKey:@(self.districtInLocation.districtId)];
            
            [_tableViewRight reloadData];
        }else{
            NSArray *resultArray = [[self.dicDistrictProvice allKeys] sortedArrayUsingComparator:^NSComparisonResult(NSString* obj1, NSString* obj2) {
                
                NSComparisonResult result = [obj1 compare:obj2];
                return result == NSOrderedDescending; // 升序
            }];
            NSArray *data = [self.dicDistrictProvice objectForKey:resultArray[indexPath.section - 2]];
            DistrictInfo *districtInfo = data[indexPath.row];
            
            if ([self.dicDistrictCity objectForKey:@(districtInfo.districtId)]) {
                NSMutableArray *city = [self.dicDistrictCity objectForKey:@(districtInfo.districtId)];
                if ([city count] == 1) {
                    DistrictInfo *dis = city[0];
                    _isMunicipality = YES;
                    _arrayDistrictRight = [self.dicDistrictDistrict objectForKey:@(dis.districtId)];
                    
                }else{
                    _isMunicipality = NO;
                    _arrayDistrictRight = [self.dicDistrictCity objectForKey:@(districtInfo.districtId)];
                }
                [_tableViewRight reloadData];
            }
            
            self.inputProvinceInfo = districtInfo;
            self.inputCityInfo.isSelect = NO;
            self.inputCityInfo = self.noDistrictCityLimite;
            self.tableViewRight.hidden = NO;
            self.noDistrictCityLimite.isSelect = YES;
            [_tableViewRight reloadData];
        }
    }
    //2级区域列表
    else if (tableView == self.tableViewRight){
        
        if(indexPath.section == 0){
            
            self.inputCityInfo.isSelect = NO;
            self.inputCityInfo = self.noDistrictCityLimite;
            self.inputCityInfo.isSelect = YES;
            self.inputCityInfo = nil;
            
        }else{
            self.noDistrictCityLimite.isSelect = NO;
            
            DistrictInfo *obj = self.arrayDistrictRight[indexPath.row];
            if(self.inputCityInfo.districtId != obj.districtId)
                self.inputCityInfo.isSelect = NO;
            self.inputCityInfo = obj;
            obj.isSelect = !obj.isSelect;
        }
        
        [self.tableViewRight reloadData];
        
        //load data
        self.buttonBottomClick.selected = NO;
        self.tableViewLeft.hidden = YES;
        self.tableViewRight.hidden = YES;
        self.viewLeftAndRight.hidden = YES;
        
        self.inputRegionType = kRegionAdministrativeDivision;
        [self refreshData];
    }
    else if (tableView == self.tableViewFull){
        
        self.inputRegionType = kRegionAdministrativeDivision;
        //行业类别
        if (self.buttonBottomClick.tag == 4) {
            if (indexPath.section == 0) {
                self.inputIndustryCategoryInfo.isSelected = NO;
                self.inputIndustryCategoryInfo = self.noIndustryCategoryLimite;
                self.inputIndustryCategoryInfo.isSelected = YES;
                [self.tableViewFull reloadData];
                self.tableViewFull.hidden = YES;
            }else{
                self.noIndustryCategoryLimite.isSelected = NO;
                self.inputIndustryCategoryInfo.isSelected = NO;
                IndustryCategoryInfo *obj = self.arrayIndustry[indexPath.row];
                if(self.inputIndustryCategoryInfo.industryId != obj.industryId)
                    self.inputIndustryCategoryInfo.isSelected = NO;
                self.inputIndustryCategoryInfo = obj;
                obj.isSelected = !obj.isSelected;
                [self.tableViewFull reloadData];
            }
        }
        //薪水
        else if (self.buttonBottomClick.tag == 5 && self.browseADMainType == kPostBoardRecruit){
            if (indexPath.section == 0) {
                self.inputSalary.isSeleted = NO;
                self.inputSalary = self.noSalaryLimite;
                self.noSalaryLimite.isSeleted = YES;
            }else
            {
                self.noSalaryLimite.isSeleted = NO;
                self.inputSalary.isSeleted = NO;
                self.inputSalary = [SharedData getInstance].operatorCompanySalaryCodeList[indexPath.row];
                self.inputSalary.isSeleted = YES;
            }
        }
        //投资金额
        else if (self.buttonBottomClick.tag == 5 && self.browseADMainType == kPostBoardAttractBusiness){
            if (indexPath.section == 0) {
                self.inputInvestment.isSeleted = NO;
                self.inputInvestment = self.noInvestmentLimite;
                self.inputInvestment.isSeleted = YES;
            }else{
                self.noInvestmentLimite.isSeleted = NO;
                self.inputInvestment.isSeleted = NO;
                self.inputInvestment = [SharedData getInstance].operatorInvestAmountCodeList[indexPath.row];
                self.inputInvestment.isSeleted = YES;
            }
            
        }
        self.buttonBottomClick.selected = NO;
        self.tableViewFull.hidden = YES;
        [self refreshData];
    }
    //content tableview
    else if (tableView == self.tableViewContent){
        NSString *key = [_results[indexPath.section] allKeys][0];
        PostBoardInfo *obj = _results[indexPath.section][key][indexPath.row];
        switch (obj.postBoardType) {
            case kPostBoardRecruit:
            {
                IWMainDetail *vc = [[IWMainDetail alloc] init];
                vc.navTitle = @"招聘信息";
                IWRecruitDetailViewController *vc0 = [[IWRecruitDetailViewController alloc] initWithNibName:NSStringFromClass([IWRecruitDetailViewController class]) bundle:nil];
                vc0.detailsId = obj.postBoardId;
                vc0.detailType = IWRecruitDetailType_Browse;
                IWCompanyIntroViewController *vc1 = [[IWCompanyIntroViewController alloc] initWithNibName:NSStringFromClass([IWCompanyIntroViewController class]) bundle:nil];
                
                vc1.postBoardType = kPostBoardRecruit;
                vc.viewControllers = @[vc0,vc1];
                vc.viewControllersTitle = @[@"详情展示",@"企业简介"];
                
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case kPostBoardAttractBusiness:
            {
                IWMainDetail *vc = [[IWMainDetail alloc] init];
                vc.navTitle = @"招商信息";
                IWAttractBusinessDetailViewController *vc0 = [[IWAttractBusinessDetailViewController alloc] initWithNibName:NSStringFromClass([IWAttractBusinessDetailViewController class]) bundle:nil];
                vc0.detailsId = obj.postBoardId;
                vc0.detailType = IWAttractBusinessDetailType_Browse;
                IWCompanyIntroViewController *vc1 = [[IWCompanyIntroViewController alloc] initWithNibName:NSStringFromClass([IWCompanyIntroViewController class]) bundle:nil];
                vc1.postBoardType = kPostBoardAttractBusiness;
                vc.viewControllers = @[vc0,vc1];
                vc.viewControllersTitle = @[@"详情展示",@"企业简介"];
                
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case kPostBoardDiscount:
            {
                IWMainDetail *vc = [[IWMainDetail alloc] init];
                vc.navTitle = @"优惠信息";
                SellerDiscountDetail *vc0 = [[SellerDiscountDetail alloc] initWithNibName:NSStringFromClass([SellerDiscountDetail class]) bundle:nil];
                vc0.discountId = obj.postBoardId;
                IWCompanyIntroViewController *vc1 = [[IWCompanyIntroViewController alloc] initWithNibName:NSStringFromClass([IWCompanyIntroViewController class]) bundle:nil];
                vc1.postBoardType = kPostBoardDiscount;
                vc.viewControllers = @[vc0,vc1];
                vc.viewControllersTitle = @[@"详情展示",@"企业简介"];
                
                [self.navigationController pushViewController:vc animated:YES];
                
            }
                break;
            default:
                break;
        }
        
    }
}
/**
 *  加载数据
 */

-(void) refreshData{
    _pageIndex = 0;
    [self loadData];
    
}
-(void)loadMoreData{
    [self loadData];
}


-(void) loadData{
    
    NSString *provinceId = self.inputProvinceInfo? [NSString stringWithFormat:@"%d",self.inputProvinceInfo.districtId]:@"0";
    NSString *cityId =  [NSString stringWithFormat:@"%d",self.inputCityInfo.districtId];
    NSString *districtId = @"0";
    
    if (!_isClickNearbyButton) {
        if (_isMunicipality) {
            provinceId = @"0";
            if (self.inputCityInfo == nil) {
                cityId = self.districtInLocation? [NSString stringWithFormat:@"%d",self.districtInLocation.districtId]:@"0";
            }else{
                cityId = [NSString stringWithFormat:@"%d",self.inputCityInfo.districtParentId];
            }
            districtId = [NSString stringWithFormat:@"%d",self.inputCityInfo.districtId];
        }
    }
    
    
    
    NSString *industryId = self.inputIndustryCategoryInfo? [NSString stringWithFormat:@"%d",self.inputIndustryCategoryInfo.industryId]:@"0";
    NSString *salaryCode = self.inputSalary.codeId? [NSString stringWithFormat:@"%@",self.inputSalary.codeId]:@"";
    NSString *investCode = self.inputInvestment.codeId ? [NSString stringWithFormat:@"%@",self.inputInvestment.codeId]:@"";
    
    //    1-招聘消息；2-招商消息；3-优惠消息
    [[API_PostBoard getInstance] engine_outside_postBoard_listIndex:_pageIndex
                                                               size:_pageSize
                                                               type:self.browseADMainType
                                                             region:self.inputRegionType
                                                         provinceId:provinceId
                                                             cityId:cityId
                                                         districtId:districtId
                                                         industryId:industryId
                                                  companySalaryCode:salaryCode
                                                   investAmountCode:investCode];
    
}

#pragma mark -- 获取同一天数据
-(void)theSameDayDataFromArray:(NSArray *)array{
    [_results removeAllObjects];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    for (int i = 0; i < [SharedData getInstance].postBoardList.count; i ++) {
        PostBoardInfo *pbi = [SharedData getInstance].postBoardList[i];
        NSString *date = [pbi.postBoardRefreshTime componentsSeparatedByString:@"T"][0];
        
        if([[dic allKeys] containsObject:date]){
            NSMutableArray *pbis = [NSMutableArray arrayWithArray:dic[date]];
            [pbis addObject:pbi];
            [dic setObject:pbis forKey:date];
        }else{
            [dic setObject:@[pbi] forKey:date];
        }
        
    }
    NSMutableArray *tempResult = [NSMutableArray array];
    NSArray *allKeys = [dic allKeys];
    for (int i = 0 ; i < allKeys.count; i ++) {
        NSString *key = [dic allKeys][i];
        [tempResult addObject:@{
                                key:dic[key]
                                }];
    }
    NSComparator cmptr = ^(id obj1, id obj2){
        NSDictionary *obj1_ = obj1;
        NSDictionary *obj2_ = obj2;
        
        NSString *dateString1 = [obj1_ allKeys][0];
        NSString *dateString2 = [obj2_ allKeys][0];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        
        NSDate *date1 = [formatter dateFromString:dateString1];
        NSDate *date2 = [formatter dateFromString:dateString2];
        
        NSComparisonResult comparisonResult = [date2 compare:date1];
        
        return comparisonResult;
    };
    tempResult = [NSMutableArray arrayWithArray:[tempResult sortedArrayUsingComparator:cmptr]];
    for (int i = 0; i < tempResult.count; i ++) {
        NSString *date = [tempResult[i] allKeys][0];
        BOOL today = [self isSomeDay:[NSDate date] DateString:date];
        if(!today){
            BOOL yesterday = [self isSomeDay:[NSDate dateWithTimeIntervalSinceNow:-(24*60*60)] DateString:date];
            if(yesterday){
                [_results addObject:@{@"昨天":tempResult[i][date]}];
            }else{
                [_results addObject:@{date:tempResult[i][date]}];
            }
        }else{
            [_results addObject:@{@"今天":tempResult[i][date]}];
        }
    }
    //    for (int i = 0; i < _results.count; i ++) {
    //        NSDictionary *dic = _results[i];
    //        NSString *date = [dic allKeys][0];
    //        NSArray *arr= dic[date];
    //        for (int j = 0; j < arr.count; j ++) {
    //            PostBoardInfo *pbi = arr[j];
    //            NSLog(@"date :%@, title :%@",date,pbi.postBoardTitle);
    //        }
    //    }
    //    NSLog(@"");
}

#pragma mark -- 是否是某天
-(BOOL)isSomeDay:(NSDate *)date DateString:(NSString *)dateString{
    BOOL flag = NO;
    NSString *someDay = [UICommon usaulFormatTime:date formatStyle:@"yyyy-MM-dd"];
    if([someDay isEqualToString:dateString]){
        flag = YES;
    }
    
    return flag;
}

#pragma mark -- 数据请求成功回调
-(void)handleUpdateSuccessAction:(NSNotification *)noti{
    [_requestFailed.view removeFromSuperview];
    [self.tableViewContent.header endRefreshing];
    [self.tableViewContent.footer endRefreshing];
    NSDictionary *dict = [noti userInfo];
    update_type type = [[dict objectForKey:@"update"]intValue];
    int ret = [[dict objectForKey:@"ret"] intValue];
    _pageIndex++;
    if(ret == 1){
        if(type == ut_operator_companySalary){
            //薪水
            if (self.buttonBottomClick.tag == 5 && self.browseADMainType == kPostBoardRecruit ) {
                [self.tableViewFull reloadData];
            }
            
        }else if (type == ut_operator_investAmount){
            //投资金额
            if (self.buttonBottomClick.tag == 5 && self.browseADMainType == kPostBoardAttractBusiness ) {
                [self.tableViewFull reloadData];
            }
        }else if (type == ut_postBoard_list){
            if ([[SharedData getInstance].postBoardList count] != 0) {
                self.imageViewNoResult.hidden = YES;
                self.tableViewContent.hidden = NO;
                //                self.tableViewFull.hidden = YES;
                self.lableNoResult.hidden = YES;
                if([SharedData getInstance].postBoardList == nil){
                    NSLog(@"1");
                }else{
                    NSLog(@"2");
                }
                if ([[SharedData getInstance].postBoardList count] >= _pageSize) {
                    [self.tableViewContent addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
                    self.tableViewContent.footer.textColor = MZRefreshFooterLabelTextColor;
                }
                [self theSameDayDataFromArray:[SharedData getInstance].postBoardList];
                [self.tableViewContent reloadData];
            }else{
                self.imageViewNoResult.hidden = NO;
                self.lableNoResult.hidden = NO;
                self.tableViewContent.hidden = YES;
            }
        }
    }else{
        [HUDUtil showErrorWithStatus:dict[@"msg"]];
    }
}

#pragma mark -- 数据请求失败回调
-(void)handleUpdateFailureAction:(NSNotification *)noti{
    
    [HUDUtil showErrorWithStatus:@"网络不给力，请检查后重试"];
    [self.tableViewContent.header endRefreshing];
    [self.tableViewContent.footer endRefreshing];
    
    _requestFailed= [RequestFailed getInstance];
    _requestFailed.delegate = self;
    [_requestFailed.view addSubview:_requestFailed.viewNoNet];
    [self.view addSubview:_requestFailed.view];
    
    return;
}

/**
 *  网络加载失败刷新
 */
-(void)didClickedRefresh{
    
    [self refreshData];
    
}


/**
 *  处理1级区域数据源
 *
 */
- (void)handleRegionList:(DelegatorArguments *)arguments{
    DictionaryWrapper* result = arguments.ret;
    
    if (result.operationSucceed) {
        
        BOOL isDistrict = NO; //判断是否是直辖市
        BOOL isFind = NO;
        
        for (NSDictionary *dic in result.data) {
            
            DistrictInfo *obj = [[DistrictInfo alloc] init];
            [obj setupDataInfo:dic];
            
            //匹配省份
            //            if (self.districtInLocation.districtId == -1 && !isDistrict) {
            
            if(self.districtInLocation.districtName.length > 0){
                
                if ([obj.districtName isEqualToString:self.districtInLocation.districtName]) {
                    isFind = YES;
                }else{
                    isFind = NO;
                }
                
                if (isFind) {
                    if(!isDistrict){
                        if(obj.districtLevel == 2){
                            isDistrict = YES;
                            _isLocationMunicipality = YES;
                        }
                        self.districtInLocation.districtId = obj.districtId;
                        self.districtInLocation.districtParentId = obj.districtParentId;
                        self.districtInLocation.districtLevel = obj.districtLevel;
                        self.districtInLocation.districtName = obj.districtName;
                        self.districtInLocation.districtSpell = obj.districtSpell;
                    }
                }
            }
            //            }
            
            
            
            //层级：1-省 2-市 3-区
            if (obj.districtLevel == 1) {
                NSString *index = [[obj.districtSpell substringToIndex:1] uppercaseString];
                if([self.dicDistrictProvice objectForKey:index] == nil){
                    [self.dicDistrictProvice setObject:[[NSMutableArray alloc] initWithObjects:obj, nil] forKey:index];
                }else{
                    NSMutableArray *provice = [self.dicDistrictProvice objectForKey:index];
                    [provice addObject:obj];
                }
            }else if (obj.districtLevel == 2){
                if ([self.dicDistrictCity objectForKey:@(obj.districtParentId)] == nil) {
                    [self.dicDistrictCity setObject:[[NSMutableArray alloc] initWithObjects:obj, nil] forKey:@(obj.districtParentId)];
                }else{
                    NSMutableArray *citys = [self.dicDistrictCity objectForKey:@(obj.districtParentId)];
                    [citys addObject:obj];
                }
            }else if (obj.districtLevel == 3){
                if ([self.dicDistrictDistrict objectForKey:@(obj.districtParentId)] == nil) {
                    [self.dicDistrictDistrict setObject:[[NSMutableArray alloc] initWithObjects:obj, nil] forKey:@(obj.districtParentId)];
                }else{
                    NSMutableArray *district = [self.dicDistrictDistrict objectForKey:@(obj.districtParentId)];
                    [district addObject:obj];
                }
            }
        }
    } else {
        
        [HUDUtil showErrorWithStatus:result.operationMessage];
        return;
    }
    [_tableViewLeft reloadData];
}

/**
 *  处理2级区域列表
 *
 */
-(void) handleSubRegionList:(DelegatorArguments *)arguments{
    DictionaryWrapper* result = arguments.ret;
    
    //    if (result.operationSucceed) {
    //        if (self.arrayDistrictRight == nil) {
    //            self.arrayDistrictRight = [[NSMutableArray alloc] init];
    //        }
    //        [self.arrayDistrictRight removeAllObjects];
    //        [self.arrayDistrictRight addObject:self.noDistrictCityLimite];
    //
    //        for (NSDictionary *dic in result.data) {
    //
    //            DistrictInfo *obj = [[DistrictInfo alloc] init];
    //            [obj setupDataInfo:dic];
    //            [self.arrayDistrictRight addObject:obj];
    //        }
    //        [self.tableViewRight reloadData];
    //    } else {
    //
    //        [HUDUtil showErrorWithStatus:result.operationMessage];
    //        return;
    //    }
}

/**
 *  处理行业类别
 *
 */
-(void) handleIndustry:(DelegatorArguments *)arguments{
    DictionaryWrapper* result = arguments.ret;
    
    if (result.operationSucceed) {
        if (self.arrayIndustry == nil) {
            self.arrayIndustry = [[NSMutableArray alloc] init];
        }
        for (NSDictionary *dic in result.data) {
            
            IndustryCategoryInfo *obj = [[IndustryCategoryInfo alloc] init];
            [obj setupDataInfo:dic];
            [self.arrayIndustry addObject:obj];
        }
        [self.tableViewFull reloadData];
    } else {
        [HUDUtil showErrorWithStatus:result.operationMessage];
        return;
    }
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    //    // 若为UITableViewCellContentView（即点击了tableViewCell），则不截获Touch事件
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        return NO;
    }else{
        self.buttonBottomClick.selected = NO;
        self.tableViewLeft.hidden = YES;
        self.tableViewRight.hidden = YES;
        self.viewLeftAndRight.hidden = YES;
    }
    
    return  YES;
}

-(void)hideKeyBoard{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
