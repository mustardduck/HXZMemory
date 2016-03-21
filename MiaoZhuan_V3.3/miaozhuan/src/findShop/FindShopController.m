//
//  FindShopController.m
//  miaozhuan
//
//  Created by momo on 14-10-22.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "FindShopController.h"
#import "FindShopCell.h"
#import "SearchShopController.h"
#import "MMLocationManager.h"
#import "MJRefreshController.h"
#import "SearchShopCell.h"
#import "findShopCityCell.h"

#import "NSDictionary+expanded.h"
#import "BaserHoverView.h"
#import "MerchantDetailViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface FindShopController ()<CLLocationManagerDelegate,UITableViewDataSource, UITableViewDelegate>
@property (retain, nonatomic) IBOutlet UIImageView *nearbySelectedIcon;
@property (retain, nonatomic) IBOutlet UIImageView *mostProdSelectedIcon;
@property (retain, nonatomic) NSString * addressText;
@property (retain, nonatomic) NSIndexPath * curFirstPath;
@property (retain, nonatomic) NSIndexPath * curSecondPath;
@property (assign, nonatomic) BOOL isSelectedFirst;
@property (assign, nonatomic) BOOL isSelectedSecond;
@end

@implementation FindShopController
{
    MJRefreshController *_MJRefreshCon;
    
    CLLocationManager *_locationManager;
    CLGeocoder *_geocoder;
}

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
        
    _categoryArr = STRONG_OBJECT(NSMutableArray, init);
    
    _provinceArr = STRONG_OBJECT(NSMutableArray, init);
    
    _cityArr = STRONG_OBJECT(NSMutableArray, init);
    
    _provinceDic = STRONG_OBJECT(NSMutableDictionary, init);
    
    _cityDic = STRONG_OBJECT(NSMutableDictionary, init);
    
    _provinceNameDic = STRONG_OBJECT(NSMutableDictionary, init);
    
    _cityIdDic = STRONG_OBJECT(NSMutableDictionary, init);
    
    _provinceIdDic = STRONG_OBJECT(NSMutableDictionary, init);
    
    self.categoryId = 0;
    
    self.provinceId = 0;
    
    self.cityId = 0;
    
    self.districtId = 0;
    
    self.sortTypeNum = 0;
    
    InitNav(@"寻找商家");
    
    [self setupMoveBackButton];
    
    [self setupMoveFowardButtonWithImage:@"searchShopBtn" In:@"searchShopBtnHover"];
    
    ADAPI_GetIndustryCategoryList([self genDelegatorID:@selector(getIndustryCategoryList:)], 0);
    
    
    NSArray * arr = [APP_DELEGATE.userConfig getArray:@"LocationDictionary"];
    
    if(arr.count > 0)
    {
        [self setSrcDataForArea:arr];
    }
    else
    {
        ADAPI_RegionGetAllBaiduRegionList([self genDelegatorID:@selector(RegionGetAllBaiduRegionList:)]);
    }
    
    [self initTableView];
    
    [self refreshLocation];
    
    [self fixView];
}

- (void) fixView
{
    UIView * line = WEAK_OBJECT(UIView, init);
    
    line.backgroundColor = AppColor(204);
    
    line.frame = CGRectMake(106, 12, 0.5, 15);
    
    [self.view addSubview:line];
    
    line = WEAK_OBJECT(UIView, init);

    line.backgroundColor = AppColor(204);

    line.frame = CGRectMake(213, 12, 0.5, 15);
    
    [self.view addSubview:line];
    
    _filterBtn.right = W(self.view) - 8;
    
    _filterBtn.bottom = H(self.view) -  8;
    
    _lineView.top = 39.5;
    
    line = WEAK_OBJECT(UIView, init);
    
    line.backgroundColor = AppColor(204);
    
    float height = 0;
    
    if([UICommon getIos4OffsetY] > 0)
    {
        height = 568 - 64 - 40 - 20;
    }
    else
    {
        height = 480 - 64 - 40 - 20;
    }
    
    line.frame = CGRectMake(160, 0, 0.5, height);

    
    [_cityView addSubview:line];
    
    _cityTableView.left = 160.5;
    
}

- (void)initTableView
{
    NSString * refreshName = @"Enterprise/GetNearbyEnterpriseList";
    
    _MJRefreshCon = [MJRefreshController controllerFrom:_mainTableView name:refreshName];
    
    __block FindShopController * weakself = self;
    
    [_MJRefreshCon setURLGenerator:MJREFRESH_URL_GENERATOR_BLOCK{
        
        NSString * isVip = weakself.selectVipBtn.selected ? @"true" : @"false";
        NSString * isSilver = weakself.selectDuihuanBtn.selected ? @"true" : @"false";
        NSString * isGold = weakself.selectJinbiBtn.selected ? @"true" : @"false";
        NSString * isDirect = weakself.selectZhigouBtn.selected ? @"true" : @"false";
        
        NSDictionary * dic = @{@"service":[NSString stringWithFormat:@"%@%@", @"api/", refreshName ],
                               @"parameters":@{@"CategoryId": [NSNumber numberWithInteger: weakself.categoryId],
                                               @"ProvinceId":[NSNumber numberWithInteger: weakself.provinceId],
                                               @"CityId":[NSNumber numberWithInteger: weakself.cityId],
                                               @"DistrictId":[NSNumber numberWithInteger: weakself.districtId],
                                               @"SortType":[NSNumber numberWithInteger: weakself.sortTypeNum],
                                               @"IsVip":isVip,
                                               @"IsSilver":isSilver,
                                               @"IsGold":isGold,
                                               @"IsDirect":isDirect,
                                               @"pageIndex":@(pageIndex),
                                               @"pageSize":@(pageSize)}
                               };
        
        return dic.wrapper;
    }];
    
    {
        MJRefreshOnRequestDone block = MJREFRESH_ON_REQUEST_DONE
        {
            if(controller.refreshCount > 0 && netData.operationSucceed)
            {
                _mainTableView.hidden = NO;
            }
            else
            {
                [self createHoverViewWhenNoData];
            }
        };
        
        [_MJRefreshCon setOnRequestDone:block];
        [_MJRefreshCon setPageSize:30];
        [_MJRefreshCon retain];
    }
    
    [self refreshTableView];

}

- (void) refreshTableView
{
    [_MJRefreshCon refreshWithLoading];
}

- (void)createHoverViewWhenNoData{
    
    BaserHoverView * hover = (BaserHoverView *)[self.view viewWithTag:1111];
    
    if(!hover)
    {
        hover = WEAK_OBJECT(BaserHoverView, initWithTitle:@"抱歉" message:@"没有筛选到此类商家");
        
        hover.frame = _mainTableView.frame;
        
        hover.tag = 1111;
        
        [self.view addSubview:hover];
        
        [self.view sendSubviewToBack:hover];

    }
    
    _mainTableView.hidden = YES;

}

//以ABCD...为key组装
- (void) setUppercaseDic:(NSDictionary *) dict
{
    DictionaryWrapper * wrapper = dict.wrapper;
    
    NSString *str = [wrapper getString:@"Name"];
    
    if (str.length)
    {
        NSString * spellStr = [wrapper getString:@"Spell"];
        
        if(spellStr && [spellStr length] > 0)
        {
            NSString *keyStr = [[spellStr substringToIndex:1] uppercaseString];
            
            [_provinceDic setObjects:dict forKey: keyStr];
        }
    }
}

//以省名...为key组装
- (void) setProvinceNameKeyDic:(NSDictionary *) dict
{
    DictionaryWrapper * wrapper = dict.wrapper;
    
    NSString * name = [wrapper getString:@"Name"];
    
    NSString *regionId = [wrapper getString:@"RegionId"];
    
    if (name.length && regionId.length)
    {
        [_provinceNameDic setObjects:regionId forKey:name];
    }
}

//以城市Id...为key组装
- (void) setCityIdKeyDic:(NSDictionary *) dict
{
    DictionaryWrapper * wrapper = dict.wrapper;
    
    NSString * name = [wrapper getString:@"Name"];
    
    NSString *regionId = [wrapper getString:@"RegionId"];
    
    if (name.length && regionId.length)
    {
        [_cityIdDic setObjects:name forKey:regionId];
    }
}

//以省Id...为key组装
- (void) setProvinceIdKeyDic:(NSDictionary *) dict
{
    DictionaryWrapper * wra = dict.wrapper;
    
    NSString * name = [wra getString:@"Name"];
    
    NSString *regionId = [wra getString:@"RegionId"];
    
    if (name.length && regionId.length)
    {
        [_provinceIdDic setObjects:name forKey:regionId];
    }
}

- (void)RegionGetAllBaiduRegionList:(DelegatorArguments*)arguments
{
    [arguments logError];
    
    DictionaryWrapper *wrapper = arguments.ret;
    
    [_provinceDic removeAllObjects];
    
    [_cityDic removeAllObjects];

    if (wrapper.operationSucceed)
    {
        for (NSDictionary *dic in wrapper.data)
        {
            int level = [dic.wrapper getInt:@"Level"];
            
            if(level == 1)//省
            {
                [self setUppercaseDic:dic];
                
                [self setProvinceNameKeyDic:dic];
                
                [self setProvinceIdKeyDic:dic];
            }
            else
            {//把市和区都以parentId为key组装
                NSString *str = [dic.wrapper getString:@"Name"];
                
                if (str.length)
                {
                    NSString *parentIdStr = [dic.wrapper getString:@"ParentId"];

                    if(parentIdStr && [parentIdStr length] > 0)
                    {
                        [_cityDic setObjects:dic forKey:[NSString stringWithFormat:@"%@",parentIdStr]];
                        
                    }
                }
                
                [self setCityIdKeyDic:dic];
            }
        }
        
        //给二级分类加上 “全部”
        for (NSString * aKey in [_cityDic allKeys])
        {
            if ([_cityDic objectForKey:aKey])
            {
                NSArray * arr = [_cityDic.wrapper getArray:aKey];
                
                NSMutableArray *array = [NSMutableArray arrayWithArray: arr];
                
                NSDictionary * aDic = arr[0];
                
                NSDictionary * dic = @{@"RegionId" : @"0",
                                       @"ParentId": aKey,
                                       @"Level": [aDic.wrapper getString:@"Level"],
                                       @"Name": @"全部"
                                           };
                
                [array insertObject:dic atIndex:0];
                
                [(NSMutableDictionary*)_cityDic setObject:array forKey:aKey];
            }
        }
        
        [_provinceTableView reloadData];
        
        [_cityTableView reloadData];
    }
    else
    {
        [HUDUtil showErrorWithStatus:wrapper.operationMessage];
        
    }
}

- (void) setSrcDataForArea:(NSArray *) arr
{
    [_provinceDic removeAllObjects];
    
    [_cityDic removeAllObjects];
    
    for (NSDictionary *dic in arr)
    {
        int level = [dic.wrapper getInt:@"Level"];
        
        if(level == 1)//省
        {
            [self setUppercaseDic:dic];
            
            [self setProvinceNameKeyDic:dic];
            
            [self setProvinceIdKeyDic:dic];
        }
        else
        {//把市和区都以parentId为key组装
            NSString *str = [dic.wrapper getString:@"Name"];
            
            if (str.length)
            {
                NSString *parentIdStr = [dic.wrapper getString:@"ParentId"];
                
                if(parentIdStr && [parentIdStr length] > 0)
                {
                    [_cityDic setObjects:dic forKey:[NSString stringWithFormat:@"%@",parentIdStr]];
                    
                }
            }
            
            [self setCityIdKeyDic:dic];
        }
    }
    
    //给二级分类加上 “全部”
    for (NSString * aKey in [_cityDic allKeys])
    {
        if ([_cityDic objectForKey:aKey])
        {
            NSArray * arr = [_cityDic.wrapper getArray:aKey];
            
            NSMutableArray *array = [NSMutableArray arrayWithArray: arr];
            
            NSDictionary * aDic = arr[0];
            
            NSDictionary * dic = @{@"RegionId" : @"0",
                                   @"ParentId": aKey,
                                   @"Level": [aDic.wrapper getString:@"Level"],
                                   @"Name": @"全部"
                                   };
            
            [array insertObject:dic atIndex:0];
            
            [(NSMutableDictionary*)_cityDic setObject:array forKey:aKey];
        }
    }
    
    [_provinceTableView reloadData];
    
    [_cityTableView reloadData];
}

- (void)getIndustryCategoryList:(DelegatorArguments*)arguments
{
    [arguments logError];
    
    DictionaryWrapper *wrapper = arguments.ret;
   
    if (wrapper.operationSucceed)
    {
        [_categoryArr removeAllObjects];
        
        NSDictionary * beginDic = [NSDictionary dictionaryWithObjectsAndKeys:@"0", @"IndustryId" , @"全部类别" , @"Name" , nil];
        
        [_categoryArr addObject:beginDic];
        
        [_categoryArr  addObjectsFromArray:wrapper.data];
        
        [_cateTableView reloadData];
        
    }
    else
    {
        [HUDUtil showErrorWithStatus:wrapper.operationMessage];
        
    }
}

- (void) refreshLocation
{
    if([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
    {
        //定位管理器
        _locationManager= STRONG_OBJECT(CLLocationManager, init);
        
        if (![CLLocationManager locationServicesEnabled] || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied) {
            
            [HUDUtil showErrorWithStatus:@"定位服务当前可能尚未打开，请去设置-隐私-定位服务里打开！"];
            
            return;
        }
        //如果没有授权则请求用户授权
        if ([CLLocationManager authorizationStatus]==kCLAuthorizationStatusNotDetermined){
            
            [_locationManager requestWhenInUseAuthorization];
            
        }else if([CLLocationManager authorizationStatus]==kCLAuthorizationStatusAuthorizedWhenInUse || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorized){
            
            _locationLbl.text = @"正在定位中...";
            
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
        __block __weak FindShopController *wself = self;
        
        _locationLbl.text = @"正在定位中...";
        
        [[MMLocationManager shareLocation] getAddress:^(NSString *addressString) {
            
            NSString *strUrl = [addressString stringByReplacingOccurrencesOfString:@"(null)" withString:@""];
            
            if(strUrl.length == 0)
            {
                strUrl = @"定位失败，请重新获取";
            }
            else
            {
                strUrl = [NSString stringWithFormat:@"当前 : %@", strUrl];
            }
            
            wself.locationLbl.text = strUrl;
            
        }];
        
        [[MMLocationManager shareLocation] getState:^(NSString *stateString) {
            
            wself.addressText = stateString;
            
        }];
    }
   
}

#pragma mark - CoreLocation 代理
#pragma mark 跟踪定位代理方法，每次位置发生变化即会执行（只要定位到相应位置）
//可以通过模拟器设置一个虚拟位置，否则在模拟器中无法调用此方法
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    CLLocation *location=[locations firstObject];//取出第一个位置
    CLLocationCoordinate2D coordinate=location.coordinate;//位置坐标
    
    _geocoder= STRONG_OBJECT(CLGeocoder, init);
    [self getAddressByLatitude:coordinate.latitude longitude:coordinate.longitude];
    
    NSLog(@"经度：%f,纬度：%f,海拔：%f,航向：%f,行走速度：%f",coordinate.longitude,coordinate.latitude,location.altitude,location.course,location.speed);
    
    //如果不需要实时定位，使用完即使关闭定位服务
    [_locationManager stopUpdatingLocation];
}

- (void) setTopBarAllUnselected
{
    [self setTopBarSelectIcon:_categoryLbl selectBtn:_categoryBtn andArrowImg:_arrowIcon1 withStatus:NO];
    [self setTopBarSelectIcon:_cityLbl selectBtn:_cityBtn andArrowImg:_arrowIcon2 withStatus:NO];
    [self setTopBarSelectIcon:_sortTypeLbl selectBtn:_SortTypeBtn andArrowImg:_arrowIcon3 withStatus:NO];
}

#pragma mark 根据坐标取得地名
-(void)getAddressByLatitude:(CLLocationDegrees)latitude longitude:(CLLocationDegrees)longitude{
    //反地理编码
    CLLocation *location=[[CLLocation alloc]initWithLatitude:latitude longitude:longitude];
    [_geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        
        CLPlacemark *placemark=[placemarks firstObject];

        DictionaryWrapper * dic = placemark.addressDictionary.wrapper;
        
        NSString * addressText = [dic getString:@"Name"];
        
        if(addressText.length == 0)
        {
            addressText = @"定位失败，请重新获取";
        }
        else
        {
            addressText = [addressText substringFromIndex:2];
            
            addressText = [NSString stringWithFormat:@"当前 : %@", addressText];
        }
        
        _locationLbl.text = addressText;

        self.addressText = [dic getString:@"State"];

    }];
}

- (void)showLocationSubView:(NSString *)locationName
{
    NSString * locaName = [locationName substringToIndex:2];
    
    for (NSString * key in [_provinceNameDic allKeys]) {
        
        NSString * keyword = [key substringToIndex:2];
        
        if([keyword isEqualToString:locaName])
        {
            NSArray * arr = [_provinceNameDic.wrapper getArray:key];
            
            [self refreshCityTableView:arr[0] andProvName:locationName];
        }
    }
}

- (IBAction) touchUpInsideOnBtn:(id)sender
{
    UIButton * btn = (UIButton *)sender;
    
    if(sender == _categoryBtn)
    {
        _categoryView.hidden = !_categoryView.hidden ;
        _cityView.hidden = YES;
        _sortView.hidden = YES;
        _filterView.hidden = YES;
        
        [self setTopBarSelectIcon:_categoryLbl selectBtn:_categoryBtn andArrowImg:_arrowIcon1 withStatus:!_categoryBtn.selected];
        [self setTopBarSelectIcon:_cityLbl selectBtn:_cityBtn andArrowImg:_arrowIcon2 withStatus:NO];
        [self setTopBarSelectIcon:_sortTypeLbl selectBtn:_SortTypeBtn andArrowImg:_arrowIcon3 withStatus:NO];
        
        if(!_categoryView.hidden)
        {
            [_cateTableView reloadData];
        }
    }
    else if(sender == _cityBtn)
    {
        _categoryView.hidden = YES;
        _cityView.hidden = !_cityView.hidden;
        _sortView.hidden = YES;
        _filterView.hidden = YES;
        
        [self setTopBarSelectIcon:_categoryLbl selectBtn:_categoryBtn andArrowImg:_arrowIcon1 withStatus:NO];
        [self setTopBarSelectIcon:_cityLbl selectBtn:_cityBtn andArrowImg:_arrowIcon2 withStatus:!_cityBtn.selected];
        [self setTopBarSelectIcon:_sortTypeLbl selectBtn:_SortTypeBtn andArrowImg:_arrowIcon3 withStatus:NO];
        
        if(!_cityView.hidden)//显示区域选择
        {
            [_provinceTableView reloadData];
            
            [_cityTableView reloadData];

            if([_cityLbl.text isEqualToString:@"全国"])
            {
                [self showLocationSubView:_addressText];
                
                self.curFirstPath = [NSIndexPath indexPathForRow:0 inSection:0];
                
                self.isSelectedFirst = YES;
                
                findShopCityCell * cell = (findShopCityCell *) [_provinceTableView cellForRowAtIndexPath:_curFirstPath];
                
                cell.selected = YES;
            }
            else
            {
                if(_isSelectedFirst && _isSelectedSecond)
                {
                    findShopCityCell * cell = (findShopCityCell *) [_provinceTableView cellForRowAtIndexPath:_curFirstPath];
                    
                    cell.selected = YES;
                    
                    findShopCityCell * cityCell = (findShopCityCell *) [_cityTableView cellForRowAtIndexPath:_curSecondPath];

                    cityCell.selected = YES;
                    
                    cityCell.selectIcon.hidden = NO;
                    
                    cityCell.titleLbl.textColor = [UIColor titleRedColor];
                }
            }
            
        }
        
    }else if(sender == _SortTypeBtn)
    {
        _categoryView.hidden = YES;
        _cityView.hidden = YES;
        _sortView.hidden = !_sortView.hidden;
        _filterView.hidden = YES;
        
        [self setTopBarSelectIcon:_categoryLbl selectBtn:_categoryBtn andArrowImg:_arrowIcon1 withStatus:NO];
        [self setTopBarSelectIcon:_cityLbl selectBtn:_cityBtn andArrowImg:_arrowIcon2 withStatus:NO];
        [self setTopBarSelectIcon:_sortTypeLbl selectBtn:_SortTypeBtn andArrowImg:_arrowIcon3 withStatus:!_SortTypeBtn.selected];
        
        if(!_sortView.hidden)
        {
            if(_sortTypeNum == nearbyType)
            {
                _nearbySelectedIcon.hidden = NO;
                _nearbyBtn.titleLabel.textColor = [UIColor titleRedColor];
                
                _mostProdSelectedIcon.hidden = YES;
                _mostProductBtn.titleLabel.textColor = [UIColor titleBlackColor];
            }
            else if (_sortTypeNum == mostProdType)
            {
                _mostProdSelectedIcon.hidden = NO;
                _mostProductBtn.titleLabel.textColor = [UIColor titleRedColor];
                
                _nearbySelectedIcon.hidden = YES;
                _nearbyBtn.titleLabel.textColor = [UIColor titleBlackColor];
            }
            else
            {
                _nearbySelectedIcon.hidden = YES;
                _nearbyBtn.titleLabel.textColor = [UIColor titleBlackColor];

                _mostProdSelectedIcon.hidden = YES;
                _mostProductBtn.titleLabel.textColor = [UIColor titleBlackColor];

            }
        }
    }
    else if(sender == _nearbyBtn)
    {
        _sortView.hidden = YES;
        
        _sortTypeNum = nearbyType;
        
        _sortTypeLbl.text = _nearbyBtn.titleLabel.text;

        [self setTopBarSelectIcon:_sortTypeLbl selectBtn:_SortTypeBtn andArrowImg:_arrowIcon3 withStatus:NO];
        
        [self refreshTableView];

    }
    else if(sender == _mostProductBtn)
    {
        _sortView.hidden = YES;
        
        _sortTypeNum = mostProdType;
        
        _sortTypeLbl.text = _mostProductBtn.titleLabel.text;
        
        [self setTopBarSelectIcon:_sortTypeLbl selectBtn:_SortTypeBtn andArrowImg:_arrowIcon3 withStatus:NO];
        
        [self refreshTableView];
    }
    else if(sender == _locationRefreshBtn)
    {
        [self refreshLocation];
    }
    else if(sender == _countryBtn)
    {
        _cityView.hidden = YES;
        
        _cityLbl.text = @"全国";
        
        [self setTopBarSelectIcon:_cityLbl selectBtn:_cityBtn andArrowImg:_arrowIcon2 withStatus:NO];
        
        [self refreshTableView];
        
    }
    else if(sender == _filterBtn)
    {
        _categoryView.hidden = YES;
        _cityView.hidden = YES;
        _sortView.hidden = YES;
        _filterView.hidden = NO;
        
        _selectVipBtn.selected = NO;
        _selectDuihuanBtn.selected = NO;
        _selectJinbiBtn.selected = NO;
        
        [self setFilterSelectIcon:_VipIcon andSelectBtn:_selectVipBtn withStatus:_selectVipBtn.selected];
        [self setFilterSelectIcon:_DuihuanIcon andSelectBtn:_selectDuihuanBtn withStatus:_selectDuihuanBtn.selected];
        [self setFilterSelectIcon:_JinBiIcon andSelectBtn:_selectJinbiBtn withStatus:_selectJinbiBtn.selected];
//        [self setFilterSelectIcon:_ZhigouIcon andSelectBtn:_selectZhigouBtn withStatus:_selectZhigouBtn.selected];

        [self setTopBarAllUnselected];
        
        [self.view bringSubviewToFront:_filterView];
    }
    else if(sender == _CancelBtn)
    {
        _filterView.hidden = YES;        
    }
    else if(sender == _okBtn)
    {
        _filterView.hidden = YES;

        [self refreshTableView];
    }
    else if(sender == _selectVipBtn)
    {
        [self setFilterSelectIcon:_VipIcon andSelectBtn:_selectVipBtn withStatus:!_selectVipBtn.selected];
    }
    else if(sender == _selectDuihuanBtn)
    {
        [self setFilterSelectIcon:_DuihuanIcon andSelectBtn:_selectDuihuanBtn withStatus:!_selectDuihuanBtn.selected];
    }
    else if(sender == _selectJinbiBtn)
    {
        [self setFilterSelectIcon:_JinBiIcon andSelectBtn:_selectJinbiBtn withStatus:!_selectJinbiBtn.selected];
    }
    else if(sender == _selectZhigouBtn)
    {
        [self setFilterSelectIcon:_ZhigouIcon andSelectBtn:_selectZhigouBtn withStatus:!_selectZhigouBtn.selected];
    }
    else if (sender == _filterFullscreenBtn)
    {
        _filterView.hidden = YES;
    }
    else if (sender == _sortTypeFullscreenBtn)
    {
        _sortView.hidden = YES;
        
        [self setTopBarSelectIcon:_sortTypeLbl selectBtn:_SortTypeBtn andArrowImg:_arrowIcon3 withStatus:NO];
    }
    else if (btn.tag == 1111 )
    {
        [self touchUpInsideOnBtn:_categoryBtn];
    }
    else if (btn.tag == 1112 )
    {
        [self touchUpInsideOnBtn:_cityBtn];
    }
    else if (btn.tag == 1113 )
    {
        [self touchUpInsideOnBtn:_SortTypeBtn];
    }
}

- (void) setFilterSelectIcon:(UIImageView *)imgIcon andSelectBtn:(UIButton *)selectBtn withStatus:(BOOL)isSelected
{
    imgIcon.image = isSelected ? [UIImage imageNamed:@"findShopfilterSelectBtn"]: [UIImage imageNamed:@"findShopfilterBtn"];
    
    selectBtn.selected = isSelected;
}

- (void) setTopBarSelectIcon:(UILabel *)titleLbl selectBtn:(UIButton *) selectBtn andArrowImg:(UIImageView *)arrowIcon withStatus:(BOOL)isSelected
{
    titleLbl.textColor = isSelected ? [UIColor titleRedColor] : [UIColor titleBlackColor];
    
    arrowIcon.image = isSelected ? [UIImage imageNamed:@"ads_list_up"]: [UIImage imageNamed:@"ads_arrow"];
    
    selectBtn.selected = isSelected;
}

- (void) onMoveBack:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) onMoveFoward:(UIButton *)sender
{
    [UI_MANAGER.mainNavigationController pushViewController:WEAK_OBJECT(SearchShopController, init) animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) refreshCityTableView:(NSString * ) regionId andProvName:(NSString *)provinceName
{
    [_cityArr removeAllObjects];
    
    NSArray * arr = [_cityDic.wrapper getArray: regionId];
    
    if(arr.count == 2)
    {
        DictionaryWrapper * dic = [arr[1] wrapper];
        
        NSString * cityName = [[dic getString:@"Name"] substringToIndex:2];
        
        provinceName = [provinceName substringToIndex:2];
        
        if([cityName isEqualToString:provinceName])
        {
            NSString * regionId = [dic getString:@"RegionId"];
            
            arr = [_cityDic.wrapper getArray:regionId];
        }
    }
    
    [_cityArr addObjectsFromArray: arr];
    
    [_cityTableView reloadData];
}

#pragma mark UITableViewDelegate and UITableViewDatasource methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if(tableView == _provinceTableView)
    {
        return [[_provinceDic allKeys] count] + 1;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView == _mainTableView)
    {
        return 110;
    }
    else
    {
        return 45;
    }
}

//返回索引数组A……Z
//-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
//{
//    if(tableView == _provinceTableView)
//    {
//        return [[_provinceDic allKeys] sortedArrayUsingSelector:@selector(compare:)];
//    }
//    return nil;
//}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if(tableView == _provinceTableView)
    {
        UIView* customView = WEAK_OBJECT(UIView, initWithFrame:CGRectMake(0, 0, 160, 23));
        
        customView.backgroundColor = AppColor(247);
        
        UILabel * headerLabel = WEAK_OBJECT(UILabel, initWithFrame:CGRectZero);
        
        headerLabel.backgroundColor = [UIColor clearColor];
        headerLabel.opaque = NO;
        headerLabel.textColor = AppColor(153);
        headerLabel.font = Font(12);
        headerLabel.frame = CGRectMake(15, 0, 140, 23);
        
        if(section == 0)
        {
            headerLabel.text = @"当前定位";
        }
        else if (section > 0)
        {
            headerLabel.text = [[[_provinceDic allKeys] sortedArrayUsingSelector:@selector(compare:)] objectAtIndex:section - 1];
        }
        
        [customView addSubview:headerLabel];
        
        return customView;
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(tableView == _provinceTableView)
    {
        return 23.0f;
    }
    return 0;
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    if(tableView == _provinceTableView)
//    {
//        return [[[_provinceDic allKeys] sortedArrayUsingSelector:@selector(compare:)] objectAtIndex:section];
//    }
//    return nil;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   
    if(tableView == _mainTableView)
    {
        return _MJRefreshCon.refreshCount;
    }
    else if (tableView == _cateTableView)
    {
        return _categoryArr.count;
    }
    else if (tableView == _provinceTableView)
    {
        NSInteger count = 0;
        
        if(section == 0)
        {
            count += 1;
        }
        else if(section > 0)
        {
            count += [[_provinceDic objectForKey:[[[_provinceDic allKeys] sortedArrayUsingSelector:@selector(compare:)] objectAtIndex:section - 1]] count];
        }
        
        return count;
        
    }
    else if (tableView == _cityTableView)
    {
        return _cityArr.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == _mainTableView)
    {
        static NSString *identifier = @"FindShopCell";
        
        FindShopCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
        if (!cell) {
            
            cell = [[[NSBundle mainBundle] loadNibNamed:@"FindShopCell" owner:self options:nil] firstObject];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

        }
        
        DictionaryWrapper * dic = [_MJRefreshCon dataAtIndex:indexPath.row];
        
        [cell.imgView setRoundCorner:11.0];
        
        NSString * str = [dic getString:@"LogoUrl"];
        
        if(str.length > 5)
        {
            [cell.imgView requestPic:str placeHolder:NO];
        }else
        {
            [cell.imgView requestPic:@"" placeHolder:YES];
        }
        
        cell.titleLbl.text = [dic getString:@"Name"];
        
        cell.vipIcon.image = [dic getBool:@"IsVip"] ? [UIImage imageNamed:@"fatopviphover"] : [UIImage imageNamed:@"fatopvip"];
        cell.yinyuanIcon.image = [dic getBool:@"IsSilver"] ? [UIImage imageNamed:@"fatopyinhover"] : [UIImage imageNamed:@"fatopyin"];
        cell.jinbiIcon.image = [dic getBool:@"IsGold"] ? [UIImage imageNamed:@"fatopjinhover"] : [UIImage imageNamed:@"fatopjin"];
        cell.zhigouIcon.image = [dic getBool:@"IsDirect"] ? [UIImage imageNamed:@"fatopzhihover"] : [UIImage imageNamed:@"fatopzhi"];
        
        cell.distanceLbl.text = [dic getString:@"DistanceRange"];
        
        cell.titleLbl.textColor = [dic getBool:@"IsVip"] ? [UIColor titleRedColor] : [UIColor titleBlackColor];
        
        
        UIView *view = WEAK_OBJECT(UIView, initWithFrame:CGRectMake(15 , H(cell.contentView) - 0.5, 320, 0.5));
        view.backgroundColor = AppColor(204);
        [cell.contentView addSubview:view];
        
        return cell;
    }
    else if (tableView == _cateTableView)
    {
        static NSString *identifier = @"SearchShopCell";
        
        SearchShopCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
        if (!cell) {
            
            cell = [[[NSBundle mainBundle] loadNibNamed:@"SearchShopCell" owner:self options:nil] firstObject];
            
        }
        
        NSDictionary * dic = [_categoryArr objectAtIndex:indexPath.row];
        
//        if(_categoryId == [dic.wrapper getInt:@"IndustryId"])
//        {
//            cell.selectIcon.hidden = NO;
//            
//            cell.titleLbl.textColor = [UIColor titleRedColor];
//        }
//        else
//        {
//            cell.selectIcon.hidden = YES;
//            
//            cell.titleLbl.textColor = [UIColor titleBlackColor];
//        }
        
        cell.titleLbl.text = [dic.wrapper getString:@"Name"];
        
        if([cell.titleLbl.text isEqualToString: _categoryLbl.text])
        {
            cell.selectIcon.hidden = NO;
            
            cell.titleLbl.textColor = [UIColor titleRedColor];
        }
        else
        {
            cell.selectIcon.hidden = YES;
            
            cell.titleLbl.textColor = [UIColor titleBlackColor];
        }
        
        return cell;
    }
    else if (tableView == _provinceTableView)
    {
        NSString *identifier = @"findShopCityCell";
        
        [tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        
        findShopCityCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
        if (!cell) {
            
            cell = [[[NSBundle mainBundle] loadNibNamed:@"findShopCityCell" owner:self options:nil] firstObject];
            
            cell.selectionStyle = UITableViewCellSelectionStyleGray;
            
            cell.selectedBackgroundView = WEAK_OBJECT(UIView, initWithFrame:cell.frame);
            
            cell.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:239.0/255 green:239.0/255 blue:240.0/255 alpha:1];
            
            cell.line.top = 44.5;
            
        }
        
        if(indexPath.row == 0 && indexPath.section == 0)
        {
            cell.titleLbl.text = _addressText;
            
            cell.titleLbl.left = 30;
            
            UIImageView * icon = WEAK_OBJECT(UIImageView , initWithFrame:CGRectMake(15, 15, 11, 13));
            
            icon.image = [UIImage imageNamed:@"locationRedIcon"];
            
            [cell addSubview:icon];
        }
        else if(indexPath.section > 0)
        {
            NSArray *provArr = [_provinceDic objectForKey:[[[_provinceDic allKeys] sortedArrayUsingSelector:@selector(compare:)] objectAtIndex:indexPath.section - 1]];
            
            NSDictionary * dic = provArr[indexPath.row];
            
            cell.titleLbl.text = [dic.wrapper getString:@"Name"];
        }
        
        return cell;
    }
    else if (tableView == _cityTableView)
    {
        NSString *identifier = @"findShopCityCell";
        
        [tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        
        findShopCityCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
        if (!cell) {
            
            cell = [[[NSBundle mainBundle] loadNibNamed:@"findShopCityCell" owner:self options:nil] firstObject];
            
            cell.selectionStyle = UITableViewCellSelectionStyleGray;
            
            cell.backgroundColor = [UIColor colorWithRed:239.0/255 green:239.0/255 blue:240.0/255 alpha:1];
            
            cell.selectedBackgroundView = WEAK_OBJECT(UIView, initWithFrame:cell.frame);
            
            cell.selectedBackgroundView.backgroundColor = AppColor(220);
            
            cell.line.top = 44.5;
        }
        
        NSDictionary * dic = _cityArr[indexPath.row];
        
        cell.titleLbl.text = [dic.wrapper getString:@"Name"];
        
        return cell;
    }
    
    return nil;
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _mainTableView)
    {
        FindShopCell *cell = (FindShopCell *)[tableView cellForRowAtIndexPath:indexPath];
        cell.contentView.backgroundColor = AppColor(220);
        return YES;
    }
    
    return YES;
}
- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _mainTableView)
    {
        FindShopCell *cell = (FindShopCell *)[tableView cellForRowAtIndexPath:indexPath];
        cell.contentView.backgroundColor = [UIColor whiteColor];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == _cateTableView)
    {
        _categoryView.hidden = YES;
        
        DictionaryWrapper * dic = [_categoryArr objectAtIndex:indexPath.row];
        
        _categoryId = [dic.wrapper getInt:@"IndustryId"];
        
        _categoryLbl.text = [dic.wrapper getString:@"Name"];
        
        [self setTopBarSelectIcon:_categoryLbl selectBtn:_categoryBtn andArrowImg:_arrowIcon1 withStatus:NO];
        
        [self refreshTableView];
        
    }
    else if (tableView == _provinceTableView)
    {
        findShopCityCell * cell = (findShopCityCell *) [_provinceTableView cellForRowAtIndexPath:_curFirstPath];
        
        if(_curFirstPath.section == indexPath.section && _curFirstPath.row == indexPath.row)
        {
            cell.selected = YES;
        }
        else
        {
            cell.selected = NO;
        }
    
        self.curFirstPath = indexPath;
        
        self.isSelectedFirst = YES;
        
        if(indexPath.row == 0 && indexPath.section == 0)
        {
            [self showLocationSubView:_addressText];
        }
        else if(indexPath.section > 0)
        {
            NSArray *provArr = [_provinceDic objectForKey:[[[_provinceDic allKeys] sortedArrayUsingSelector:@selector(compare:)] objectAtIndex:indexPath.section - 1]];
            
            NSDictionary * dic = provArr[indexPath.row];
            
            NSString * regionId = [dic.wrapper getString:@"RegionId"];
            
            NSDictionary * pDic = provArr[indexPath.row];
            
            NSString * provinceName = [pDic.wrapper getString:@"Name"];
            
            [self refreshCityTableView:regionId andProvName:provinceName];
        }
    }
    else if (tableView == _cityTableView)
    {
        self.curSecondPath = indexPath;
        
        self.isSelectedSecond = YES;
        
        findShopCityCell * cell = (findShopCityCell *) [tableView cellForRowAtIndexPath:indexPath];
        
//        cell.selectIcon.hidden = NO;
        
//        cell.titleLbl.textColor = [UIColor titleRedColor];
        
        _cityView.hidden = YES;
        
        [self setTopBarSelectIcon:_cityLbl selectBtn:_cityBtn andArrowImg:_arrowIcon2 withStatus:NO];
        
        NSDictionary * dic = [_cityArr objectAtIndex:indexPath.row];
        
        int level = [dic.wrapper getInt:@"Level"];
        
        if(level == 2)//二级是市(省-市关系）
        {
            self.cityId = [dic.wrapper getInt:@"RegionId"];
            
            self.provinceId = [dic.wrapper getInt:@"ParentId"];
            
            self.districtId = 0;
            
        }
        else if (level == 3)//二级是区（市-区关系）
        {
            self.districtId = [dic.wrapper getInt:@"RegionId"];

            self.cityId = [dic.wrapper getInt:@"ParentId"];

            self.provinceId = 0;

        }
        
        NSString * name = [dic.wrapper getString:@"Name"];
        
        if([name isEqualToString:@"全部"])
        {
            NSString * key = [dic.wrapper getString:@"ParentId"];
            
            if(level == 2)
            {
                name = [_provinceIdDic objectForKey: key][0];

            }
            else if (level == 3)
            {
                name = [_cityIdDic objectForKey: key][0];
            }
        }
        
        _cityLbl.text = name;
        
        CGSize size = [UICommon getWidthFromLabel:_cityLbl withMaxWidth:84];
        
        _cityLbl.width = size.width;
        
        _cityLbl.left = (106 - (size.width + 13)) / 2 + 107;
        
        _arrowIcon2.left = XW(_cityLbl) + 3;
        
        [self setTopBarSelectIcon:_cityLbl selectBtn:_cityBtn andArrowImg:_arrowIcon2 withStatus:NO];
        
        [self refreshTableView];
        
    }
    else if (tableView == _mainTableView)
    {
        
        DictionaryWrapper * dic = [_MJRefreshCon dataAtIndex:indexPath.row];

        NSString *enId = [dic getString:@"EnterpriseId"];
        
        if (!enId.length) {
            return;
        }
        MerchantDetailViewController *merchant = WEAK_OBJECT(MerchantDetailViewController, init);
        merchant.enId = enId;
        merchant.comefrom = @"0";
        [UI_MANAGER.mainNavigationController pushViewController:merchant animated:YES];
    }
}

- (void)dealloc {
    
    [_geocoder release];
    
    [_locationManager release];
    
    [_MJRefreshCon release];
    
    [_cityIdDic release];
    
    [_provinceIdDic release];
    
    [_categoryArr release];
    [_cityArr release];
    [_provinceArr release];
    
    [_provinceDic release];
    [_cityDic release];
    [_provinceNameDic release];
    
    [_categoryBtn release];
    [_cityBtn release];
    [_SortTypeBtn release];
    [_categoryLbl release];
    [_cityLbl release];
    [_sortTypeLbl release];
    [_arrowIcon1 release];
    [_arrowIcon2 release];
    [_arrowIcon3 release];
    [_locationLbl release];
    [_locationRefreshBtn release];
    [_mainTableView release];
    [_categoryView release];
    [_cateTableView release];
    [_cityView release];
    [_countryBtn release];
    [_provinceTableView release];
    [_cityTableView release];
    [_filterBtn release];
    [_sortView release];
    [_nearbyBtn release];
    [_mostProductBtn release];
    [_filterView release];
    [_CancelBtn release];
    [_okBtn release];
    [_selectVipBtn release];
    [_selectDuihuanBtn release];
    [_selectJinbiBtn release];
    [_selectZhigouBtn release];
    [_VipIcon release];
    [_DuihuanIcon release];
    [_JinBiIcon release];
    [_ZhigouIcon release];
    [_filterFullscreenBtn release];
    [_sortTypeFullscreenBtn release];
    [_lineView release];
    [_nearbySelectedIcon release];
    [_mostProdSelectedIcon release];
    [super dealloc];
}
@end
