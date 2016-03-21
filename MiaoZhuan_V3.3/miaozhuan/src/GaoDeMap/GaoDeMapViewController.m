//
//  GaoDeMapViewController.m
//  miaozhuan
//
//  Created by Santiago on 14-11-6.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "GaoDeMapViewController.h"
#import "MAMapkit/MAMapKit.h"
#import "AMapSearchKit/AMapSearchAPI.h"
#import "GeoDetailViewController.h"
#import "CommonUtility.h"
#import "GeocodeAnnotation.h"

@interface GaoDeMapViewController () <MAMapViewDelegate, AMapSearchDelegate, UITextFieldDelegate, UISearchBarDelegate, UISearchDisplayDelegate, UITableViewDataSource, UITableViewDelegate, MAMapViewDelegate>
{
    double _baiduLatitude;
    double _baiduLongtitude;
    BOOL _ensureBtnClicked;
    NSMutableArray *_oldSearchHistoryArray;
    float _keyboardHeight;
}

//@property (retain, nonatomic) UISearchBar *searchBar;
//@property (nonatomic, strong) UISearchDisplayController *displayController;
@property (nonatomic, strong) NSMutableArray *tips;

@property (nonatomic, strong) MAMapView *mapView;
@property (nonatomic, strong) AMapSearchAPI *search;
@property (nonatomic, strong) MAPointAnnotation *mark;
@property (nonatomic, strong) UILabel *locationLabel;
@property (nonatomic, strong) NSMutableArray *locationArray;
@property (retain, nonatomic) IBOutlet UIView *detailLocationView;
@property (retain, nonatomic) IBOutlet UILabel *choosedLocationOfDetailView;
@property (retain, nonatomic) IBOutlet UITextField *editedLocationOfDetailView;
@property (retain, nonatomic) IBOutlet UIView *blackBackGroundView;
@property (strong, nonatomic) UITableView *searchHistoryTable;
@property (nonatomic, retain) IBOutlet UIView * searchView;
@property (nonatomic, retain) IBOutlet UIView * searchBarView;
@property (nonatomic, retain) IBOutlet UIButton * searchBtn;
@property (nonatomic, retain) IBOutlet UITextField * searchTextField;


@end

@implementation GaoDeMapViewController
@synthesize mapView = _mapView;
@synthesize mark = _mark;
@synthesize search = _search;
@synthesize chooseLocation = _chooseLocation;
@synthesize delegate;
@synthesize locationLabel = _locationLabel;
@synthesize locationArray = _locationArray;
@synthesize longitude = _longitude;
@synthesize latidiute = _latidiute;
@synthesize typeName = _typeName;
@synthesize detailLocationView = _detailLocationView;
@synthesize choosedLocationOfDetailView = _choosedLocationOfDetailView;
@synthesize editedLocationOfDetailView = _editedLocationOfDetailView;
@synthesize blackBackGroundView = _blackBackGroundView;
//@synthesize searchBar = _searchBar;
@synthesize searchHistoryTable = _searchHistoryTable;
MTA_viewDidAppear()
MTA_viewDidDisappear()

// 地理编码 搜索
- (void)searchGeocodeWithKey:(NSString *)key adcode:(NSString *)adcode
{
    if (key.length == 0)
    {
        return;
    }
    
    AMapGeocodeSearchRequest *geo = [[AMapGeocodeSearchRequest alloc] init];
    geo.address = key;
    
    if (adcode.length > 0)
    {
        geo.city = @[adcode];
    }
    
    [self.search AMapGeocodeSearch:geo];
}

// 输入提示 搜索
- (void)searchTipsWithKey:(NSString *)key {
     
    if (key.length == 0){

        if ([APP_DELEGATE.userConfig getString:@"MapSearchHistoryString"].length == 0) {
            
            //初始化一个搜索历史数组
            NSMutableArray *searchHistoryArray = WEAK_OBJECT(NSMutableArray, init);
            [APP_DELEGATE.userConfig set:@"MapSearchHistoryArray" value:searchHistoryArray];
            [_searchHistoryTable removeFromSuperview];
            return;
        }else {
            
            [_searchHistoryTable removeFromSuperview];
            key = [APP_DELEGATE.userConfig getString:@"MapSearchHistoryString"];
            
            //在搜索历史数组中增加数据
            NSMutableArray *searchHistoryArray = [APP_DELEGATE.userConfig get:@"MapSearchHistoryArray"];
            
            if (![key isEqualToString:[searchHistoryArray lastObject]]) {
                
                [searchHistoryArray addObject:key];
            }
            
            if ([searchHistoryArray count] > 10) {
                
                int x = [searchHistoryArray count] - 10;
                
                for (int i = 0; i < x; i++) {
                    
                    [searchHistoryArray removeObjectAtIndex:0];
                }
                
                [APP_DELEGATE.userConfig set:@"MapSearchHistoryArray" value:searchHistoryArray];
            }
             _oldSearchHistoryArray = STRONG_OBJECT(NSMutableArray, initWithArray:searchHistoryArray);
            [self.view addSubview:_searchHistoryTable];
            [_searchHistoryTable reloadData];
            _searchHistoryTable.hidden = YES;
            [self performSelector:@selector(bringTableViewToFont) withObject:nil afterDelay:0.0];
        }
    }else {
    
        [_searchHistoryTable removeFromSuperview];
    }
    
    [APP_DELEGATE.userConfig set:@"MapSearchHistoryString" string:key];
    AMapInputTipsSearchRequest *tips = [[AMapInputTipsSearchRequest alloc] init];
    
    tips.keywords = key;
    [self.search AMapInputTipsSearch:tips];
}

- (void)bringTableViewToFont {

    if (_keyboardHeight == 0) {
        
        _keyboardHeight = 246;
    }
    
    float historyTableHeight = SCREENHEIGHT - _keyboardHeight - self.searchView.frame.size.height;
    [_searchHistoryTable setFrame:CGRectMake(0, self.searchView.frame.size.height, 320, historyTableHeight)];
    [self.view bringSubviewToFront:_searchHistoryTable];
    _searchHistoryTable.hidden = NO;
    _searchHistoryTable.showsVerticalScrollIndicator = NO;
}

- (IBAction)searchAdress
{
    NSString *key = _searchTextField.text;
    [self clearAndSearchGeocodeWithKey:key adcode:nil];
    [_searchTextField resignFirstResponder];
}

- (void)clearAndSearchGeocodeWithKey:(NSString *)key adcode:(NSString *)adcode
{
    
    [self searchGeocodeWithKey:key adcode:adcode];
}

- (void)gotoDetailForGeocode:(AMapGeocode *)geocode
{
    if (geocode != nil)
    {
        GeoDetailViewController *geoDetailViewController = [[GeoDetailViewController alloc] init];
        geoDetailViewController.geocode = geocode;
        
        [self.navigationController pushViewController:geoDetailViewController animated:YES];
    }
}


- (void)hiddenKeyboard {
    
    [_editedLocationOfDetailView resignFirstResponder];
    [_searchTextField resignFirstResponder];

}

//键盘出现
- (void)keyboardWillShow:(NSNotification*)aNotify {
    
    if (_ensureBtnClicked) {
        
        //获取键盘的高度
        NSDictionary *userInfo = [aNotify userInfo];
        NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
        CGRect keyboardRect = [aValue CGRectValue];
        int height = keyboardRect.size.height;
        _keyboardHeight = height;
        [UIView animateWithDuration:0.25 animations:^{
            _detailLocationView.frame = CGRectMake(0, self.view.frame.size.height - _detailLocationView.frame.size.height-height, self.view.frame.size.width, _detailLocationView.frame.size.height);
        }];
    }
}

//键盘消失
- (void)keyboardWillHide:(NSNotification*)aNotify {
    
    if (_ensureBtnClicked) {
        
        [UIView animateWithDuration:0.25 animations:^{
            _detailLocationView.frame = CGRectMake(0, self.view.frame.size.height - _detailLocationView.frame.size.height, self.view.frame.size.width, _detailLocationView.frame.size.height);
        }];
    }
}

- (void)loadTheMap {

    [self.view addSubview:self.mapView];
    self.mapView.alpha = 0;
    
    [UIView animateWithDuration:0.6 animations:^{
        self.mapView.alpha = 1.0;
    }];
}

- (void)setUpTwoLabel {
    
    [self setTitle:@"地图定位"];
    
    self.locationLabel = WEAK_OBJECT(UILabel, initWithFrame:CGRectMake(20, [[UIScreen mainScreen] bounds].size.height-120, [[UIScreen mainScreen] bounds].size.width-40, 35));
    self.locationLabel.textAlignment = NSTextAlignmentCenter;
    [self.locationLabel setBackgroundColor:RGBACOLOR(254, 243, 218, 1)];
    self.locationLabel.layer.cornerRadius = 4;
    self.locationLabel.layer.masksToBounds = YES;
    
    [self.locationLabel setFont:[UIFont systemFontOfSize:15]];
    [self.locationLabel setTextColor:RGBCOLOR(176, 130, 39)];
    
    self.locationLabel.layer.borderWidth = 0.5;
    self.locationLabel.layer.borderColor = [RGBCOLOR(206, 178, 125) CGColor];
    
    [self.view addSubview:_locationLabel];
    
    [_detailLocationView setOrigin:CGPointMake(0, self.view.frame.size.height)];
    [self.view addSubview:_detailLocationView];
    
    [self.view addSubview:_blackBackGroundView];
    [self.view insertSubview:_blackBackGroundView belowSubview:_detailLocationView];
}

- (void)searchReGeocode {
    
    AMapReGeocodeSearchRequest *regeoRequest = WEAK_OBJECT(AMapReGeocodeSearchRequest, init);
    regeoRequest.searchType = AMapSearchType_ReGeocode;
    regeoRequest.location = [AMapGeoPoint locationWithLatitude:_mark.coordinate.latitude longitude:_mark.coordinate.longitude];

    //获取经纬度
    regeoRequest.radius = 100;
    regeoRequest.requireExtension = NO;
    [self.search AMapReGoecodeSearch: regeoRequest];
}

//高德坐标系转化为百度坐标系
const double x_pi = 3.14159265358979324 * 3000.0 / 180.0;

- (void)bd_encrypt:(double)gg_lat andLon:(double)gg_lon {
    
    double x = gg_lon, y = gg_lat;
    double z = sqrt(x * x + y * y) + 0.00002 * sin(y * x_pi);
    double theta = atan2(y, x) + 0.000003 * cos(x * x_pi);
    
    _baiduLongtitude = z * cos(theta) + 0.0065;
    _baiduLatitude = z * sin(theta) + 0.006;
}

//百度转换为高德
- (void)bd_decrypt:(double)bd_lat andLon:(double) bd_lon {
    
    if (bd_lat == 0 || bd_lon == 0) {
        self.latidiute = 0;
        self.longitude = 0;
        return;
    }
    
    double x = bd_lon - 0.0065, y = bd_lat - 0.006;
    double z = sqrt(x * x + y * y) - 0.00002 * sin(y * x_pi);
    double theta = atan2(y, x) - 0.000003 * cos(x * x_pi);
    self.longitude = z * cos(theta);
    self.latidiute = z * sin(theta);
}

//设置默认标注位置
- (void)setUpAnnotations {
    
    //是否传坐标定位
    if (_longitude != 0||_latidiute != 0) {
        
        self.mark = WEAK_OBJECT(MAPointAnnotation, init);
        _mark.coordinate = CLLocationCoordinate2DMake(_latidiute, _longitude);
        _mark.title      = @"拖动地图中心到需要定位的位置";
        
        [self.mapView addAnnotation:_mark];
        [self.mapView setCenterCoordinate:_mark.coordinate animated:TRUE];
        
    }else {
        
        self.mark = WEAK_OBJECT(MAPointAnnotation, init);
        _mark.coordinate = CLLocationCoordinate2DMake(_mapView.userLocation.location.coordinate.latitude, _mapView.userLocation.location.coordinate.longitude);
        _mark.title      = @"拖动地图中心到您需要定位的位置";
        
        [self.mapView addAnnotation:_mark];
        [self.mapView setCenterCoordinate:_mark.coordinate animated:TRUE];
    }
}

//提示是否继续添加
-(void)showIfAddMore {
    [AlertUtil showAlert:nil
                 message:@"是否继续添加精准定位地址？"
                 buttons:@[
                           @{
                               @"title":@"不再添加",
                               @"delegator":ALERT_VIEW_DELEGATOR_BLOCK({
        [delegate getDataArray:_locationArray];
        [self.navigationController popViewControllerAnimated:YES];
    })},
                           @{
                               @"title":@"继续添加",
                               @"delegator":ALERT_VIEW_DELEGATOR_BLOCK({
        return;
    })}]];
    
}

//确定按钮
- (IBAction) onMoveFoward:(UIButton*) sender {
    
    if (![_chooseLocation isEqual:@""]) {
        
        //获取一系列地址和经纬度
        if ([delegate respondsToSelector:@selector(getDataArray:)]) {
            
            NSString *tem = [NSString stringWithFormat:@"投放地区: %@",_chooseLocation];
            [AlertUtil showAlert:@"确认投放"
                         message:tem
                         buttons:@[
                                   @"取消",
                                   @{
                                       @"title":@"确定",
                                       @"delegator":ALERT_VIEW_DELEGATOR_BLOCK({
                
                [self showIfAddMore];
                
                WDictionaryWrapper *wrapper = WEAK_OBJECT(WDictionaryWrapper, init);
                [wrapper set:@"location" string:_chooseLocation];
                [wrapper set:@"latitude" double:_mark.coordinate.latitude];
                [wrapper set:@"longtitude" double:_mark.coordinate.longitude];
                [self.locationArray addObject:wrapper];
                [HUDUtil showSuccessWithStatus:@"设置成功"];
            })}]];
        }
        
        //获取单个定位地址和经纬度
        if ([delegate respondsToSelector:@selector(getLocation:)]&&[delegate respondsToSelector:@selector(getLongitude:andLatitude:)]&&![_typeName isEqualToString:@"ConvertCenterMap"]) {
            [AlertUtil showAlert:@"确定吗"
                         message:@"商家位置一旦提交不能修改"
                         buttons:@[
                                   @"取消",
                                   @{
                                       @"title":@"确定",
                                       @"delegator":ALERT_VIEW_DELEGATOR_BLOCK({
                
                //获取地址
                if([delegate respondsToSelector:@selector(getLocation:)]){
                    
                    [delegate getLocation:_chooseLocation];
                }
                //获取经纬度
                if([delegate respondsToSelector:@selector(getLongitude:andLatitude:)]){
                    
                    [self bd_encrypt:_mark.coordinate.latitude andLon:_mark.coordinate.longitude];
                    [delegate getLongitude:_baiduLongtitude andLatitude:_baiduLatitude];
                }
                
                [self.navigationController popViewControllerAnimated:YES];
            })
                                       }]];}
    }else {
        
        [AlertUtil showAlert:@"定位失败"
                     message:@"请检查您的网络或定位服务设置"];
    }
    
    if ([_typeName isEqualToString:@"ConvertCenterMap"]) {
        
        _ensureBtnClicked = YES;
        
        [UIView animateWithDuration:0.25 animations:^{
            
            [self.detailLocationView setOrigin:CGPointMake(0, self.view.frame.size.height-_detailLocationView.frame.size.height)];
            self.blackBackGroundView.hidden = NO;
        }];
    }
}

- (IBAction)onMoveBack:(UIButton *)sender{
    
    //获取一系列地址和经纬度
    if ([delegate respondsToSelector:@selector(getDataArray:)]) {
        [delegate getDataArray:_locationArray];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

//细节位置取消
- (IBAction)cancle:(id)sender {
    
    [_editedLocationOfDetailView resignFirstResponder];
    
    [UIView animateWithDuration:0.25 animations:^{
        
        [self.detailLocationView setOrigin:CGPointMake(0, self.view.frame.size.height)];
        self.blackBackGroundView.hidden = YES;
    }];
    _ensureBtnClicked = NO;
}

//细节位置确定
- (IBAction)confirm:(id)sender {
    
    [_editedLocationOfDetailView resignFirstResponder];
    
    [UIView animateWithDuration:0.25 animations:^{
        
        [self.detailLocationView setOrigin:CGPointMake(0, self.view.frame.size.height)];
        self.blackBackGroundView.hidden = YES;
    }];
    
    //获取经纬度
    if([delegate respondsToSelector:@selector(getLongitude:andLatitude:)]) {
        
        [self bd_encrypt:_mark.coordinate.latitude andLon:_mark.coordinate.longitude];
        [delegate getLongitude:_baiduLongtitude andLatitude:_baiduLatitude];
    }
    
    //获取地址
    if([delegate respondsToSelector:@selector(getLocation:)]) {
        
        if (!_editedLocationOfDetailView.text||[_editedLocationOfDetailView.text isEqualToString:@""]) {
            
            [delegate getLocation:_chooseLocation];
        }else {
            
            [delegate getLocation:[NSString stringWithFormat:@"%@%@",_chooseLocation,_editedLocationOfDetailView.text]];
        }
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [_editedLocationOfDetailView resignFirstResponder];
    [super touchesBegan:touches withEvent:event];
}

#pragma mark - Initialization
- (void)initSearchBar {
    
//    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 44)];
//    self.searchBar.barStyle     = UIBarStyleDefault;
//    self.searchBar.translucent  = NO;
//    self.searchBar.delegate     = self;
//    self.searchBar.placeholder  = @"输入需要定位的地址";
//    self.searchBar.keyboardType = UIKeyboardTypeDefault;
//    [self.searchBar setBackgroundImage:[UIImage imageNamed:@"mapSearchBarBG.png"] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
//    [self.mapView addSubview:self.searchBar];
    
    [self addDoneToKeyboard:_searchTextField];
    
    _searchBarView.layer.cornerRadius = 5.0;
    
    _searchBtn.layer.cornerRadius = 5.0;
    _searchBtn.clipsToBounds = YES;
    
    [self.mapView addSubview:_searchView];
    
}

- (void)initSearchDisplay {
//    
//    self.displayController = [[UISearchDisplayController alloc] initWithSearchBar:self.search contentsController:self];
//    self.displayController.delegate                = self;
//    self.displayController.searchResultsDataSource = self;
//    self.displayController.searchResultsDelegate   = self;
}

#pragma mark - MAMapViewDelegate
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation {
    
    if ([annotation isKindOfClass:[MAPointAnnotation class]]) {
        
        static NSString *pointReuseIndetifier = @"pointReuseIndetifier";
        MAPinAnnotationView* annotationView = (MAPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndetifier];
        if (!annotationView) {
            
            annotationView = WEAK_OBJECT(MAPinAnnotationView, initWithAnnotation:annotation reuseIdentifier:pointReuseIndetifier);
        }
        annotationView.canShowCallout               = YES;
        annotationView.animatesDrop                 = TRUE;
        annotationView.draggable                    = YES;
        annotationView.rightCalloutAccessoryView    = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        annotationView.pinColor                     = MAPinAnnotationColorGreen;
        return annotationView;
    }
    return nil;
}

//地图区域改变
- (void)mapView:(MAMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    
    if (!self.markScrollWithMap == 1) {
    
        self.mark.coordinate = _mapView.centerCoordinate;
    }
    [self searchReGeocode];
}

//定位获取失败回调
-(void)mapView:(MAMapView*)mapView didFailToLocateUserWithError:(NSError*)error {
    
    [AlertUtil showAlert:@"定位服务未开启"
                 message:@"请允许“秒赚”定位您的位置\n（设置>隐私>定位服务>开启秒赚）"];
}

- (void)mapView:(MAMapView *)mapView annotationView:(MAAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    if ([view.annotation isKindOfClass:[GeocodeAnnotation class]])
    {
        [self gotoDetailForGeocode:[(GeocodeAnnotation*)view.annotation geocode]];
    }
}

#pragma mark - AMapSearchDelegate
//逆地理编码回调
- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response {
    
    self.chooseLocation = response.regeocode.formattedAddress;
    _locationLabel.text = _chooseLocation;
    self.choosedLocationOfDetailView.text = _chooseLocation;
}

//search错误信息
- (void)searchRequest:(id)request didFailWithError:(NSError *)error {
    
    NSLog(@"%s: searchRequest = %@, errInfo= %@", __func__, [request class], error);
}

//地理编码回调
- (void)onGeocodeSearchDone:(AMapGeocodeSearchRequest *)request response:(AMapGeocodeSearchResponse *)response {
    
    if (response.geocodes.count == 0) {
        
        [AlertUtil showAlert:nil
                     message:@"抱歉，搜索不到相关结果"
                     buttons:@[
                               @"确定",]];
        return;
    }
    
    [response.geocodes enumerateObjectsUsingBlock:^(AMapGeocode *obj, NSUInteger idx, BOOL *stop) {
        GeocodeAnnotation *geocodeAnnotation = [[GeocodeAnnotation alloc] initWithGeocode:obj];
        self.mark.coordinate = geocodeAnnotation.coordinate;
        [self.mapView setCenterCoordinate:_mark.coordinate animated:TRUE];
    }];
}


//输入提示回调
- (void)onInputTipsSearchDone:(AMapInputTipsSearchRequest *)request response:(AMapInputTipsSearchResponse *)response {
    
    [self.tips setArray:response.tips];
//    [self.displayController.searchResultsTableView reloadData];
}

#pragma mark - UISearchBarDelagate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
//    NSString *key = searchBar.text;
//    [self clearAndSearchGeocodeWithKey:key adcode:nil];
//    [self.displayController setActive:NO animated:NO];
//    self.searchBar.text = key;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {

    [_searchHistoryTable removeFromSuperview];
}

#pragma mark - UISearchDisplayDelagate
- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    
    [_searchHistoryTable removeFromSuperview];
    [self searchTipsWithKey:searchString];
    return YES;
}

// called when table is shown/hidden
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {

    [self searchTipsWithKey:nil];
    return YES;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (tableView == _searchHistoryTable) {
        
        return [_oldSearchHistoryArray count];
    }else {
    
        return self.tips.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *tipCellIdentifier = @"tipCellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tipCellIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:tipCellIdentifier];
    }
    
    if (tableView == _searchHistoryTable) {
        
        cell.textLabel.text = _oldSearchHistoryArray[indexPath.row];
    }else {
        
        AMapTip *tip = self.tips[indexPath.row];
        cell.textLabel.text = tip.name;
        cell.detailTextLabel.text = tip.adcode;
    }
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == _searchHistoryTable) {
        
        self.searchTextField.text = _oldSearchHistoryArray[indexPath.row];
        [_searchHistoryTable removeFromSuperview];
    }else {
    
        AMapTip *tip = self.tips[indexPath.row];
        [self clearAndSearchGeocodeWithKey:tip.name adcode:tip.adcode];
//        [self.displayController setActive:NO animated:NO];
        self.searchTextField.text = tip.name;
    }
}

#pragma mark - LifeCycle
- (id)init
{
    if (self = [super init])
    {
        self.tips = [NSMutableArray array];
    }
    _searchHistoryTable = STRONG_OBJECT(UITableView, init);
    _searchHistoryTable.delegate = self;
    _searchHistoryTable.dataSource = self;
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setupMoveBackButton];
    
    if (!_hiddenRightItem) {
        [self setupMoveFowardButtonWithTitle:@"确定"];
    }
    
    _ensureBtnClicked = NO;
    
    [MAMapServices sharedServices].apiKey =@"be2c3e32c7ed52ce4f53eca8346de1ca";
    self.search = WEAK_OBJECT(AMapSearchAPI, initWithSearchKey: @"be2c3e32c7ed52ce4f53eca8346de1ca" Delegate:self);
    self.mapView = WEAK_OBJECT(MAMapView, initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height));
    self.mapView.delegate = self;
    self.search.delegate = self;
    self.mapView.showsUserLocation = YES;
    self.mapView.zoomLevel = 16;
    self.mapView.showsCompass = NO;
    
    [self performSelector:@selector(setUpAnnotations) withObject:nil afterDelay:0.4f];
    [self performSelector:@selector(searchReGeocode) withObject:nil afterDelay:0.5f];
    [self performSelector:@selector(loadTheMap) withObject:nil afterDelay:0.4f];
    [self performSelector:@selector(setUpTwoLabel) withObject:nil afterDelay:0.5f];
    
    self.locationArray = WEAK_OBJECT(NSMutableArray, init);
    
    self.editedLocationOfDetailView.layer.cornerRadius = 5;
    self.editedLocationOfDetailView.layer.borderWidth = 0.5;
    self.editedLocationOfDetailView.layer.borderColor = [RGBCOLOR(204, 204, 204) CGColor];
    
    [self addDoneToKeyboard:_editedLocationOfDetailView];
    
    //增加监听，当键盘出现或改变时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    //增加监听，当键退出时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    [self initSearchBar];
//    [self initSearchDisplay];
}



- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    [_searchBarView release];
    [_searchView release];
    self.delegate = nil;
    _mapView.delegate = nil;
    _search.delegate = nil;
    [_locationLabel release];
    [_locationArray release];
    [_chooseLocation release];
    [_search release];
    [_mapView release];
    [_mark release];
    [_typeName release];
    [_detailLocationView release];
    [_choosedLocationOfDetailView release];
    [_editedLocationOfDetailView release];
    [_blackBackGroundView release];
//    [_searchBar release];
    [_oldSearchHistoryArray release];
    [_searchHistoryTable release];
    [super dealloc];
}

@end
