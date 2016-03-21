//
//  BiddingListViewController.m
//  miaozhuan
//
//  Created by Santiago on 14-11-7.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "BiddingListViewController.h"
#import "BiddingListCell.h"
#import "PickerViewSelfDefined.h"
@interface BiddingListViewController ()<UITableViewDataSource, UITableViewDelegate, PickerViewSelfDefineDelegate>

@property (retain, nonatomic) IBOutlet UITableView *mainTable;
@property (retain, nonatomic) IBOutlet UIButton *flashAdsButton;
@property (retain, nonatomic) IBOutlet UIButton *bannerAdsButton;
@property (retain, nonatomic) IBOutlet UIButton *recommandAdsButton;
@property (retain, nonatomic) IBOutlet UIView *redLine;
@property (retain, nonatomic) IBOutlet UIImageView *downArrowIcon;
@property (retain, nonatomic) IBOutlet UILabel *locationLabel;
@property (strong, nonatomic) NSArray *dataSource;
@property (retain, nonatomic) IBOutlet UILabel *biddingTypeLabel;
@property (retain, nonatomic) IBOutlet UIButton *chooseLocationBtn;

@property (retain, nonatomic) IBOutlet UIView *grayBackGroundView;

@property (retain, nonatomic) IBOutlet UIView *locationView;
@property (retain, nonatomic) IBOutlet UIView *nodataView;

@property (strong, nonatomic) PickerViewSelfDefined *locatePicker;

@property (strong, nonatomic) NSArray *locationDataSource;

@property (strong, nonatomic) NSString *adsType;
@property (strong, nonatomic) NSString *rangeType;
@property (strong, nonatomic) NSString *regionsId;
@property (retain, nonatomic) IBOutlet UILabel *dateLabel;

@property (retain, nonatomic) IBOutlet UIView *UILineView;
@property (retain, nonatomic) IBOutlet UIView *UILineView2;
@property (retain, nonatomic) IBOutlet UIView *tableHeadView;

@property (retain, nonatomic) IBOutlet UIView *UITitleView;
@end

@implementation BiddingListViewController
@synthesize rangeType = _rangeType;
@synthesize adsType = _adsType;
@synthesize regionsId = _regionsId;
@synthesize dataSource = _dataSource;
@synthesize mainTable = _mainTable;
@synthesize flashAdsButton = _flashAdsButton;
@synthesize bannerAdsButton = _bannerAdsButton;
@synthesize recommandAdsButton = _recommandAdsButton;
@synthesize redLine = _redLine;
@synthesize downArrowIcon = _downArrowIcon;
@synthesize locationLabel = _locationLabel;
@synthesize biddingTypeLabel = _biddingTypeLabel;
@synthesize locatePicker = _locatePicker;
@synthesize locationDataSource = _locationDataSource;
@synthesize locationView = _locationView;
@synthesize nodataView = _nodataView;
@synthesize chooseLocationBtn = _chooseLocationBtn;
@synthesize grayBackGroundView = _grayBackGroundView;
@synthesize dateLabel = _dateLabel;
@synthesize tableHeadView = _tableHeadView;

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setupMoveBackButton];
    [self setTitle:@"竞价热榜"];
    [_mainTable registerNib:[UINib nibWithNibName:@"BiddingListCell" bundle:nil] forCellReuseIdentifier:@"BiddingListCell"];
    self.adsType = @"1";
    self.rangeType = @"1";
    self.regionsId = @"0";
    
    NSDate *  senddate=[NSDate date];
    
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    
    [dateformatter setDateFormat:@"YYYY年MM月dd日"];
    
    NSString *  locationString=[dateformatter stringFromDate:senddate];
    [dateformatter release];
    self.dateLabel.text = locationString;
    self.locationView.layer.borderWidth = 0.5;
    self.locationView.layer.borderColor = [RGBCOLOR(204, 204, 204) CGColor];
    
    [self.UILineView setSize:CGSizeMake(285, 0.5)];
    [self.UILineView2 setFrame:CGRectMake(0, 44.5, 320, 0.5)];
    
    _mainTable.tableHeaderView = _tableHeadView;
    ADAPI_AdsBidding([self genDelegatorID:@selector(getBiddingList:)],_adsType, _rangeType, _regionsId);
    _mainTable.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)getBiddingList:(DelegatorArguments*)arguments {

    DictionaryWrapper *wrapper = arguments.ret;
    if (wrapper.operationSucceed) {
        
        self.dataSource = wrapper.data;
        
        if (!_dataSource || [_dataSource isKindOfClass:[NSNull class]]) {
            
            self.nodataView.hidden = NO;
            self.UILineView.hidden = YES;
            self.UITitleView.hidden = YES;
            return;
            
        }else {
        
            self.nodataView.hidden = YES;
            self.UILineView.hidden = NO;
            self.UITitleView.hidden = NO;
            self.mainTable.hidden = NO;
        }
        [_mainTable reloadData];
    }else {
    
        self.nodataView.hidden = NO;
        self.UILineView.hidden = YES;
        self.UITitleView.hidden = YES;
        [HUDUtil showWithStatus:wrapper.operationMessage];
    }
}

//选择广告列表类型
//闪屏
- (IBAction)flashAdsList:(UIButton*)sender {
    self.adsType = @"1";
    [_flashAdsButton setTitleColor:RGBCOLOR(240, 5, 0) forState:UIControlStateNormal];
    [_bannerAdsButton setTitleColor:RGBCOLOR(34, 34, 34) forState:UIControlStateNormal];
    [_recommandAdsButton setTitleColor:RGBCOLOR(34, 34, 34) forState:UIControlStateNormal];
    [_flashAdsButton.titleLabel setFont:[UIFont systemFontOfSize:17]];
    [_bannerAdsButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [_recommandAdsButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    
    [UIView animateWithDuration:0.3 animations:^{
        
        [_redLine setFrame:CGRectMake(20, 38, 75, 2)];
    }];
    ADAPI_AdsBidding([self genDelegatorID:@selector(getBiddingList:)],_adsType, _rangeType, _regionsId);
}
//首页轮换
- (IBAction)mainPageBannerList:(UIButton*)sender {
    
    self.adsType = @"2";
    [_flashAdsButton setTitleColor:RGBCOLOR(34, 34, 34) forState:UIControlStateNormal];
    [_bannerAdsButton setTitleColor:RGBCOLOR(240, 5, 0) forState:UIControlStateNormal];
    [_recommandAdsButton setTitleColor:RGBCOLOR(34, 34, 34) forState:UIControlStateNormal];
    [_flashAdsButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [_bannerAdsButton.titleLabel setFont:[UIFont systemFontOfSize:17]];
    [_recommandAdsButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    
    [UIView animateWithDuration:0.3 animations:^{
        
        [_redLine setFrame:CGRectMake(106, 38, 107, 2)];
    }];
    
    ADAPI_AdsBidding([self genDelegatorID:@selector(getBiddingList:)],_adsType, _rangeType, _regionsId);
}
//推荐商家
- (IBAction)recommandMerchantList:(UIButton*)sender {
    
    self.adsType = @"3";
    [_flashAdsButton setTitleColor:RGBCOLOR(34, 34, 34) forState:UIControlStateNormal];
    [_bannerAdsButton setTitleColor:RGBCOLOR(34, 34, 34) forState:UIControlStateNormal];
    [_recommandAdsButton setTitleColor:RGBCOLOR(240, 5, 0) forState:UIControlStateNormal];
    [_flashAdsButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [_bannerAdsButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [_recommandAdsButton.titleLabel setFont:[UIFont systemFontOfSize:17]];
    
    [UIView animateWithDuration:0.3 animations:^{
        
        [_redLine setFrame:CGRectMake(224, 38, 74, 2)];
    }];
    
    ADAPI_AdsBidding([self genDelegatorID:@selector(getBiddingList:)],_adsType, _rangeType, _regionsId);
}

- (IBAction)chooseLocationType:(id)sender {
    //默认全国
    self.regionsId = @"0";
    self.biddingTypeLabel.text = @"全国榜";
    self.locationLabel.text = @"全国";
    [self.biddingTypeLabel setTextColor:RGBCOLOR(34, 34, 34)];
    [self.locationLabel setTextColor:RGBCOLOR(34, 34, 34)];
    //获取地区信息数据
    if ([[APP_DELEGATE.runtimeConfig getArray:RUNTIME_USER_LOGIN_INFO".LocationArray"] count] > 0) {
        
        self.chooseLocationBtn.enabled = NO;
        self.flashAdsButton.enabled = NO;
        self.bannerAdsButton.enabled = NO;
        self.recommandAdsButton.enabled = NO;
        self.grayBackGroundView.hidden = NO;
        
        self.locationDataSource = [APP_DELEGATE.runtimeConfig getArray:RUNTIME_USER_LOGIN_INFO".LocationArray"];
        if (!_locatePicker) {
            
            self.locatePicker = STRONG_OBJECT(PickerViewSelfDefined, initPickerWithDelegate:self name:ONELEVELSELFDEFINED userData:_biddingTypeLabel.text array:nil);
            [_locatePicker showInView:self.view];
            [_locatePicker release];
            self.locatePicker = nil;
            [self.downArrowIcon setImage:[UIImage imageNamed:@"littleUp.png"]];
        }
    }else {
    
        ADAPI_RegionGetAllBaiduRegionList([self genDelegatorID:@selector(handleRegionList:)]);
    }
}


- (void)handleRegionList:(DelegatorArguments*)arguments {
    
    DictionaryWrapper *wrapper = arguments.ret;
    if (wrapper.operationSucceed) {

        self.chooseLocationBtn.enabled = NO;
        self.flashAdsButton.enabled = NO;
        self.bannerAdsButton.enabled = NO;
        self.recommandAdsButton.enabled = NO;
        self.grayBackGroundView.hidden = NO;
        
        self.locationDataSource = wrapper.data;
        [APP_DELEGATE.runtimeConfig set:RUNTIME_USER_LOGIN_INFO".LocationArray" value:_locationDataSource];
        
        if (!_locatePicker) {
            
            self.locatePicker = STRONG_OBJECT(PickerViewSelfDefined, initPickerWithDelegate:self name:ONELEVELSELFDEFINED userData:_biddingTypeLabel.text array:nil);
            [_locatePicker showInView:self.view];
            [_locatePicker release];
            self.locatePicker = nil;
            [self.downArrowIcon setImage:[UIImage imageNamed:@"littleUp.png"]];
        }
    }else{
        
        [HUDUtil showErrorWithStatus:wrapper.operationMessage];
    }
}

#pragma mark - PickerViewSelfDefinedDelegate

- (void)pickerDidChangeContent:(PickerViewSelfDefined *)picker {
    
    if (picker.locate.locationType) {
        
        self.biddingTypeLabel.text = picker.locate.locationType;
        [self.biddingTypeLabel setTextColor:RGBCOLOR(240, 5, 0)];
    }
    
    switch (picker.name) {
        case 1:
            
            self.rangeType = @"2";
            self.locationLabel.text = picker.locate.state;
            [self.locationLabel setTextColor:RGBCOLOR(240, 5, 0)];
            self.regionsId = [NSString stringWithFormat:@"%d",[picker.locate.stateData getInt:@"RegionId"]];
            break;
        case 2:
            
            self.rangeType = @"3";
            self.locationLabel.text = picker.locate.city;
            [self.locationLabel setTextColor:RGBCOLOR(240, 5, 0)];
            self.regionsId = [NSString stringWithFormat:@"%d",[picker.locate.cityData getInt:@"RegionId"]];
            break;
            
        case 3:
            
            self.rangeType = @"4";
            self.locationLabel.text = picker.locate.district;
            [self.locationLabel setTextColor:RGBCOLOR(240, 5, 0)];
            self.regionsId = [NSString stringWithFormat:@"%d",[picker.locate.districtData getInt:@"RegionId"]];
            break;
            
        case 4:
            
            self.rangeType = @"1";
            self.locationLabel.text = @"全国";
            [self.locationLabel setTextColor:RGBCOLOR(240, 5, 0)];
            self.regionsId = @"0";
            break;
        default:
            break;
    }
}

- (void)endOperating {
    
    self.chooseLocationBtn.enabled = YES;
    self.flashAdsButton.enabled = YES;
    self.bannerAdsButton.enabled = YES;
    self.recommandAdsButton.enabled = YES;
    self.grayBackGroundView.hidden = YES;
}

- (void)pickerClearContent:(PickerViewSelfDefined *)picker {
    
    self.biddingTypeLabel.text = picker.userData;
    [self.downArrowIcon setImage:[UIImage imageNamed:@"littleDown.png"]];
    [self.locationLabel setTextColor:RGBCOLOR(34, 34, 34)];
    [self.biddingTypeLabel setTextColor:RGBCOLOR(34, 34, 34)];
}

- (void)refreshData:(PickerViewSelfDefined *)picker {

    ADAPI_AdsBidding([self genDelegatorID:@selector(getBiddingList:)],_adsType, _rangeType, _regionsId);
    [self.downArrowIcon setImage:[UIImage imageNamed:@"littleDown.png"]];
    [self.locationLabel setTextColor:RGBCOLOR(34, 34, 34)];
    [self.biddingTypeLabel setTextColor:RGBCOLOR(34, 34, 34)];
}

- (void)pushAnotherPicker:(NSString*)string {
    
    self.chooseLocationBtn.enabled = NO;
    self.flashAdsButton.enabled = NO;
    self.bannerAdsButton.enabled = NO;
    self.recommandAdsButton.enabled = NO;
    self.grayBackGroundView.hidden = NO;
    
    if ([string isEqualToString:@"省级榜"]) {
        
        if (!_locatePicker) {
            
            self.locatePicker = STRONG_OBJECT(PickerViewSelfDefined, initPickerWithDelegate:self name:ONELEVEL userData:_biddingTypeLabel.text array:_locationDataSource);
            [_locatePicker showInView:self.view];
            self.locationLabel.text = _locatePicker.locate.state;
            self.regionsId = [NSString stringWithFormat:@"%d",[_locatePicker.locate.stateData getInt:@"RegionId"]];
            [_locatePicker release];
            self.locatePicker = nil;
        }
    }
    if ([string isEqualToString:@"市级榜"]) {
        
        if (!_locatePicker) {
            
            self.locatePicker = STRONG_OBJECT(PickerViewSelfDefined, initPickerWithDelegate:self name:TWOLEVEL userData:_biddingTypeLabel.text array:_locationDataSource);
            [_locatePicker showInView:self.view];
            self.locationLabel.text = _locatePicker.locate.city;
            self.regionsId = [NSString stringWithFormat:@"%d",[_locatePicker.locate.cityData getInt:@"RegionId"]];
            [_locatePicker release];
            self.locatePicker = nil;
        }
        
    }
    if ([string isEqualToString:@"区级榜"]) {
        
        if (!_locatePicker) {
            
            self.locatePicker = STRONG_OBJECT(PickerViewSelfDefined, initPickerWithDelegate:self name:THREELEVEL userData:_biddingTypeLabel.text array:_locationDataSource);
            [_locatePicker showInView:self.view];
            self.locationLabel.text = _locatePicker.locate.district;
            self.regionsId = [NSString stringWithFormat:@"%d",[_locatePicker.locate.districtData getInt:@"RegionId"]];
            [_locatePicker release];
            self.locatePicker = nil;
        }
    }
}

#pragma mark - UITableDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [_dataSource count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    BiddingListCell *cell = [_mainTable dequeueReusableCellWithIdentifier:@"BiddingListCell" forIndexPath:indexPath];
    
    cell.companyName.text = [[_dataSource[indexPath.row] wrapper] getString:@"EnterpriseName"];
    cell.location.text = [[_dataSource[indexPath.row]wrapper] getString:@"Region"];
    cell.biddingPrice.text = [NSString stringWithFormat:@"%.2f/次",[[[_dataSource[indexPath.row]wrapper] getString:@"Price"] floatValue]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row<9) {
        
        cell.rankingNumber.text = [NSString stringWithFormat:@"0%ld",(long)indexPath.row+1];
    }else {
    
        cell.rankingNumber.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row+1];
    }
    switch ([_adsType intValue]) {
            //闪屏1个
        case 1:
            if (indexPath.row == 0) {
                [cell.rankingNumber setTextColor:[UIColor redColor]];
            }else{
                [cell.rankingNumber setTextColor:[UIColor lightGrayColor]];
            }
            break;
            //首页5个
        case 2:
            if (indexPath.row < 5) {
                [cell.rankingNumber setTextColor:[UIColor redColor]];
            }else {
                [cell.rankingNumber setTextColor:[UIColor lightGrayColor]];
            }
            break;
            //推荐商家
        case 3:

                [cell.rankingNumber setTextColor:[UIColor redColor]];
            break;
            
        default:
            break;
    }
    
    if (indexPath.row == [_dataSource count] - 1) {
        
        [cell.UILineBottomView setFrame:CGRectMake(0, 49.5, 320, 0.5)];
    }else {
    
        [cell.UILineBottomView setFrame:CGRectMake(35, 48.5, 285, 0.5)];
    }
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {

    UIView *temp = WEAK_OBJECT(UIView, init);
    [temp setBackgroundColor:[UIColor clearColor]];
    return temp;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)dealloc {
    
    [_rangeType release];
    [_adsType release];
    [_regionsId release];
    [_locationDataSource release];
    [_dataSource release];
    [_mainTable release];
    [_flashAdsButton release];
    [_bannerAdsButton release];
    [_recommandAdsButton release];
    [_redLine release];
    [_downArrowIcon release];
    [_locationLabel release];
    [_biddingTypeLabel release];
    [_locationView release];
    [_nodataView release];
    [_chooseLocationBtn release];
    [_grayBackGroundView release];
    [_dateLabel release];
    [_UILineView release];
    [_UILineView2 release];
    [_UITitleView release];
    [_tableHeadView release];
    [super dealloc];
}
@end
