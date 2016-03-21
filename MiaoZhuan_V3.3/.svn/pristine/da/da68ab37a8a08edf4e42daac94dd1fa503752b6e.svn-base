//
//  MyBiddingViewController.m
//  miaozhuan
//
//  Created by Santiago on 14-11-7.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "MyBiddingViewController.h"
#import "MyBiddingTableViewCell.h"

typedef void (^GetAddPriceStringBlock)(NSString *string);
@interface MyBiddingViewController ()<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate> {

    BOOL _locationShow;
    BOOL _stateViewShow;
    NSString *_addPriceString;
    
    int _statusType;//0全部状态，1已启用，2未启用
    int _locationType;//0全部地区，1全国，2省级，3市级，4区级
    
    double _postPrice;
}

@property (retain, nonatomic) IBOutlet UITableView *mainTable;

@property (retain, nonatomic) IBOutlet UIView *locationView;

@property (retain, nonatomic) IBOutlet UIView *stateView;

@property (retain, nonatomic) IBOutlet UIButton *locationButton;

@property (retain, nonatomic) IBOutlet UIButton *stateButton;

@property (retain, nonatomic) IBOutlet UILabel *locationLabel;

@property (retain, nonatomic) IBOutlet UILabel *stateLabel;

@property (retain, nonatomic) IBOutlet UIButton *flashScreenButton;

@property (retain, nonatomic) IBOutlet UIButton *bannerAdsButton;

@property (retain, nonatomic) IBOutlet UIButton *recommandMerchantButton;
@property (retain, nonatomic) IBOutlet UIView *redlineView;
@property (retain, nonatomic) IBOutlet UIImageView *downArrowLeft;
@property (retain, nonatomic) IBOutlet UIImageView *downArrowRight;

@property (retain, nonatomic) IBOutlet UIImageView *statementCheck1;
@property (retain, nonatomic) IBOutlet UIImageView *statementCheck2;
@property (retain, nonatomic) IBOutlet UIImageView *statementCheck3;

@property (retain, nonatomic) IBOutlet UILabel *statementTitle1;
@property (retain, nonatomic) IBOutlet UILabel *statementTitle2;
@property (retain, nonatomic) IBOutlet UILabel *statementTitle3;

@property (retain, nonatomic) IBOutlet UIImageView *locationCheckIcon1;
@property (retain, nonatomic) IBOutlet UIImageView *locationCheckIcon2;
@property (retain, nonatomic) IBOutlet UIImageView *locationCheckIcon3;
@property (retain, nonatomic) IBOutlet UIImageView *locationCheckIcon4;
@property (retain, nonatomic) IBOutlet UIImageView *locationCheckIcon5;

@property (retain, nonatomic) IBOutlet UILabel *locationCheckTitle1;
@property (retain, nonatomic) IBOutlet UILabel *locationCheckTitle2;
@property (retain, nonatomic) IBOutlet UILabel *locationCheckTitle3;
@property (retain, nonatomic) IBOutlet UILabel *locationCheckTitle4;
@property (retain, nonatomic) IBOutlet UILabel *locationCheckTitle5;

@property (retain, nonatomic) IBOutlet UIView *lightGrayBackGroundView;
@property (retain, nonatomic) IBOutlet UIView *lightGrayBackGroundColor2;
@property (retain, nonatomic) IBOutlet UIView *lightGrayBackGroundcolor3;



@property (retain, nonatomic) IBOutlet UIView *noContentView;
//没有内容时显示

@property (retain, nonatomic) IBOutlet UIView *addPriceView;

@property (retain, nonatomic) IBOutlet UITextField *addPriceTextField;

@property (strong, nonatomic) NSString* apiString;

@property (strong, nonatomic) MJRefreshController* mjCon;

@property (retain, nonatomic) IBOutlet UIView *allLocationView;

@property (retain, nonatomic) IBOutlet UIView *allStatusView;

@property (nonatomic, strong) NSArray *dataSource;

@property (nonatomic, strong) WDictionaryWrapper *wrapper;

@property (nonatomic, strong) NSMutableArray *updatedCellArray;

@property (nonatomic, assign) float goldCoinCount;

@property (retain, nonatomic) IBOutlet UIView *UITitleView;

@property (retain, nonatomic) IBOutlet UIView *UILineView1;

@property (retain, nonatomic) IBOutlet UIView *UILineView2;

@property (retain, nonatomic) IBOutlet UIView *UILineView3;
@property (retain, nonatomic) IBOutlet UIView *UILineView4;



@end

@implementation MyBiddingViewController
@synthesize mainTable = _mainTable;
@synthesize locationView = _locationView;
@synthesize locationButton = _locationButton;
@synthesize stateButton = _stateButton;
@synthesize flashScreenButton = _flashScreenButton;
@synthesize bannerAdsButton = _bannerAdsButton;
@synthesize recommandMerchantButton = _recommandMerchantButton;
@synthesize redlineView = _redlineView;
@synthesize statementCheck1 = _statementCheck1;
@synthesize statementCheck2 = _statementCheck2;
@synthesize statementCheck3 = _statementCheck3;
@synthesize statementTitle1 = _statementTitle1;
@synthesize statementTitle2 = _statementTitle2;
@synthesize statementTitle3 = _statementTitle3;
@synthesize locationLabel = _locationLabel;
@synthesize stateLabel = _stateLabel;
@synthesize addPriceView = _addPriceView;
@synthesize addPriceTextField = _addPriceTextField;
@synthesize apiString = _apiString;
@synthesize noContentView = _noContentView;
@synthesize mjCon = _mjCon;
@synthesize allLocationView = _allLocationView;
@synthesize allStatusView = _allStatusView;
@synthesize dataSource = _dataSource;
@synthesize wrapper = _wrapper;
@synthesize lightGrayBackGroundView = _lightGrayBackGroundView;
@synthesize lightGrayBackGroundColor2 = _lightGrayBackGroundColor2;
@synthesize updatedCellArray = _updatedCellArray;
@synthesize goldCoinCount = _goldCoinCount;

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupMoveBackButton];
    [self setTitle:@"我的竞价广告"];
    [_mainTable registerNib:[UINib nibWithNibName:@"MyBiddingTableViewCell" bundle:nil] forCellReuseIdentifier:@"MyBiddingTableViewCell"];
    self.apiString = @"api/BiddingAdvert/GetMySplashAdvertList";
    _statusType = 0;
    _locationType = 0;

    self.allLocationView.layer.borderWidth = 0.5;
    self.allLocationView.layer.borderColor = [RGBCOLOR(204, 204, 204) CGColor];
    
    self.allStatusView.layer.borderWidth = 0.5;
    self.allStatusView.layer.borderColor = [RGBCOLOR(204, 204, 204) CGColor];
    
    [self setUpRefreshItem];
    
    [self addDoneToKeyboard:_addPriceTextField];
    
    [self.UILineView1 setFrame:CGRectMake(15, 39.5, 305, 0.5)];
    [self.UILineView2 setFrame:CGRectMake(0, 44.5, 320, 0.5)];
    [self.UILineView3 setFrame:CGRectMake(0, 0, 320, 0.5)];
    [self.UILineView4 setFrame:CGRectMake(0, 0, 320, 0.5)];
    
    self.wrapper = WEAK_OBJECT(WDictionaryWrapper, init);
    self.updatedCellArray = WEAK_OBJECT(NSMutableArray, init);
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
    
    _mainTable.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)hiddenKeyboard{

    [_addPriceTextField resignFirstResponder];
}

- (void)setUpRefreshItem{
    
    self.mjCon = [MJRefreshController controllerFrom:_mainTable name:_apiString];
    
    __block MyBiddingViewController *weakSelf = self;
    [self.mjCon setURLGenerator:MJREFRESH_URL_GENERATOR_BLOCK{
    
        return @{
                 
                 @"service":_apiString,
                 @"parameters":@{
                         @"StatusType":[NSString stringWithFormat:@"%d",_statusType],
                         @"RegionType":[NSString stringWithFormat:@"%d",_locationType],
                         @"PageIndex":@(pageIndex),
                         @"PageSize":@(pageSize)
                         }
                 }.wrapper;
    }];
    
    MJRefreshOnRequestDone block = MJREFRESH_ON_REQUEST_DONE {
    
        if (netData.operationSucceed) {
            
            DictionaryWrapper *item = netData.data;
            weakSelf.dataSource = [item getArray:@"PageData"];
            
            if ([_dataSource count] == 0) {
                
                self.UITitleView.hidden = YES;
                self.noContentView.hidden = NO;
                self.UITitleView.hidden = YES;
            }else {
                self.noContentView.hidden = YES;
                self.UITitleView.hidden = NO;
                self.UITitleView.hidden = NO;
            }
            [_mainTable reloadData];
        }else {
            self.UITitleView.hidden = YES;
            self.noContentView.hidden = NO;
            self.UITitleView.hidden = YES;
            [HUDUtil showErrorWithStatus:netData.operationMessage];
        }
        [_mainTable reloadData];
    };
    
    [self.mjCon setOnRequestDone:block];
    [self.mjCon setPageSize:10];
    [_mjCon refreshWithLoading];
}

//选择类型31,32,33闪屏，轮切，推荐商家
- (IBAction)adsType:(UIButton*)sender {

    switch (sender.tag) {
        case 31:
            
            [_flashScreenButton setTitleColor: [UIColor redColor]forState:UIControlStateNormal];
            [_bannerAdsButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [_recommandMerchantButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
            [_flashScreenButton.titleLabel setFont:[UIFont systemFontOfSize:17]];
            [_bannerAdsButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
            [_recommandMerchantButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
            
            [UIView animateWithDuration:0.3 animations:^{
                
                [_redlineView setFrame:CGRectMake(15, 38, 75, 2)];
            }];
            
            self.apiString = @"api/BiddingAdvert/GetMySplashAdvertList";
            [_mjCon refreshWithLoading];

            break;
        case 32:
            
            [_flashScreenButton setTitleColor: [UIColor blackColor]forState:UIControlStateNormal];
            [_bannerAdsButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            [_recommandMerchantButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

            [_flashScreenButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
            [_bannerAdsButton.titleLabel setFont:[UIFont systemFontOfSize:17]];
            [_recommandMerchantButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
            
            [UIView animateWithDuration:0.3 animations:^{
  
                [_redlineView setFrame:CGRectMake(111, 38, 103, 2)];
            }];
            
            self.apiString = @"api/BiddingAdvert/GetMyBannerAdvertList";
            [_mjCon refreshWithLoading];
            
            break;
        case 33:
            
            [_flashScreenButton setTitleColor: [UIColor blackColor]forState:UIControlStateNormal];
            [_bannerAdsButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [_recommandMerchantButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];


            [_flashScreenButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
            [_bannerAdsButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
            [_recommandMerchantButton.titleLabel setFont:[UIFont systemFontOfSize:17]];
            
            [UIView animateWithDuration:0.3 animations:^{
                
                [_redlineView setFrame:CGRectMake(230, 38, 70, 2)];
            }];
            
            self.apiString = @"api/BiddingAdvert/GetMyRecommendEnterpriseList";
            [_mjCon refreshWithLoading];
            
            break;
        default:
            break;
    }
}

//选择地区
- (IBAction)locationBtnClicked:(UIButton*)sender {
    
    _locationShow = !_locationShow;
    _locationView.hidden = !_locationShow;
    _stateButton.enabled = !_locationShow;
    _flashScreenButton.enabled = !_locationShow;
    _bannerAdsButton.enabled = !_locationShow;
    _recommandMerchantButton.enabled = !_locationShow;

    if (_locationShow) {
        
        [_downArrowLeft setImage:[UIImage imageNamed:@"littleUp.png"]];
        [_locationView becomeFirstResponder];
        self.lightGrayBackGroundColor2.hidden = NO;
        [_locationLabel setTextColor:RGBCOLOR(240, 5, 0)];
    }else {
        self.lightGrayBackGroundColor2.hidden = YES;
        [_downArrowLeft setImage:[UIImage imageNamed:@"littleDown.png"]];
        [_locationLabel setTextColor:RGBCOLOR(34, 34, 34)];
    }
    
    switch (sender.tag) {
            
        case 90:
            
            break;

        case 11:
            
            _locationType = 0;
            
            _locationCheckIcon1.hidden = NO;
            _locationCheckIcon2.hidden = YES;
            _locationCheckIcon3.hidden = YES;
            _locationCheckIcon4.hidden = YES;
            _locationCheckIcon5.hidden = YES;
            
            
            [_locationCheckTitle1 setTextColor:[UIColor redColor]];
            [_locationCheckTitle2 setTextColor:[UIColor blackColor]];
            [_locationCheckTitle3 setTextColor:[UIColor blackColor]];
            [_locationCheckTitle4 setTextColor:[UIColor blackColor]];
            [_locationCheckTitle5 setTextColor:[UIColor blackColor]];
            
            [_locationLabel setText:@"全部地区"];
            [_mjCon refreshWithLoading];
            break;
        case 12:
            
            _locationType = 1;
            
            _locationCheckIcon1.hidden = YES;
            _locationCheckIcon2.hidden = NO;
            _locationCheckIcon3.hidden = YES;
            _locationCheckIcon4.hidden = YES;
            _locationCheckIcon5.hidden = YES;

            [_locationCheckTitle1 setTextColor:[UIColor blackColor]];
            [_locationCheckTitle2 setTextColor:[UIColor redColor]];
            [_locationCheckTitle3 setTextColor:[UIColor blackColor]];
            [_locationCheckTitle4 setTextColor:[UIColor blackColor]];
            [_locationCheckTitle5 setTextColor:[UIColor blackColor]];

            [_locationLabel setText:@"全国"];
            [_mjCon refreshWithLoading];
            break;
        case 13:
            
            _locationType = 2;
            
            _locationCheckIcon1.hidden = YES;
            _locationCheckIcon2.hidden = YES;
            _locationCheckIcon3.hidden = NO;
            _locationCheckIcon4.hidden = YES;
            _locationCheckIcon5.hidden = YES;
            
            [_locationCheckTitle1 setTextColor:[UIColor blackColor]];
            [_locationCheckTitle2 setTextColor:[UIColor blackColor]];
            [_locationCheckTitle3 setTextColor:[UIColor redColor]];
            [_locationCheckTitle4 setTextColor:[UIColor blackColor]];
            [_locationCheckTitle5 setTextColor:[UIColor blackColor]];

            [_locationLabel setText:@"省级"];
            [_mjCon refreshWithLoading];
            break;
        case 14:
            
            _locationType = 3;
            
            _locationCheckIcon1.hidden = YES;
            _locationCheckIcon2.hidden = YES;
            _locationCheckIcon3.hidden = YES;
            _locationCheckIcon4.hidden = NO;
            _locationCheckIcon5.hidden = YES;

            [_locationCheckTitle1 setTextColor:[UIColor blackColor]];
            [_locationCheckTitle2 setTextColor:[UIColor blackColor]];
            [_locationCheckTitle3 setTextColor:[UIColor blackColor]];
            [_locationCheckTitle4 setTextColor:[UIColor redColor]];
            [_locationCheckTitle5 setTextColor:[UIColor blackColor]];

            [_locationLabel setText:@"市级"];
            [_mjCon refreshWithLoading];
            break;
        case 15:
            
            _locationType = 4;
            
            _locationCheckIcon1.hidden = YES;
            _locationCheckIcon2.hidden = YES;
            _locationCheckIcon3.hidden = YES;
            _locationCheckIcon4.hidden = YES;
            _locationCheckIcon5.hidden = NO;
            
            [_locationCheckTitle1 setTextColor:[UIColor blackColor]];
            [_locationCheckTitle2 setTextColor:[UIColor blackColor]];
            [_locationCheckTitle3 setTextColor:[UIColor blackColor]];
            [_locationCheckTitle4 setTextColor:[UIColor blackColor]];
            [_locationCheckTitle5 setTextColor:[UIColor redColor]];
            
            [_locationLabel setText:@"区级"];
            [_mjCon refreshWithLoading];
            break;

        default:
            break;
    }
}

//选择状态

- (IBAction)statementBtnClicked:(UIButton*)sender {
    
    _stateViewShow = !_stateViewShow;
    _stateView.hidden = !_stateViewShow;
    _locationButton.enabled = !_stateViewShow;
    _flashScreenButton.enabled = !_stateViewShow;
    _bannerAdsButton.enabled = !_stateViewShow;
    _recommandMerchantButton.enabled = !_stateViewShow;
    
    if (_stateViewShow) {
        [_downArrowRight setImage:[UIImage imageNamed:@"littleUp.png"]];
        [_stateLabel setTextColor:RGBCOLOR(240, 5, 0)];
        [_stateView becomeFirstResponder];
        self.lightGrayBackGroundcolor3.hidden = NO;
    }else {
    
        [_downArrowRight setImage:[UIImage imageNamed:@"littleDown.png"]];
        [_stateLabel setTextColor:RGBCOLOR(34, 34, 34)];
        self.lightGrayBackGroundcolor3.hidden = YES;
    }
    
    switch (sender.tag) {
        case 90:
            
            break;
        case 20:
            
            break;
        case 21:
            //全部状态
            
            _statusType = 0;
            
            _statementCheck1.hidden = NO;
            _statementCheck2.hidden = YES;
            _statementCheck3.hidden = YES;
            
            [_statementTitle1 setTextColor:[UIColor redColor]];
            [_statementTitle2 setTextColor:[UIColor blackColor]];
            [_statementTitle3 setTextColor:[UIColor blackColor]];
            
            [_stateLabel setText:@"全部状态"];
            [_mjCon refreshWithLoading];
            break;
        case 22:
            //未启用
            
            _statusType = 1;
            
            _statementCheck1.hidden = YES;
            _statementCheck2.hidden = NO;
            _statementCheck3.hidden = YES;
            
            [_statementTitle1 setTextColor:[UIColor blackColor]];
            [_statementTitle2 setTextColor:[UIColor redColor]];
            [_statementTitle3 setTextColor:[UIColor blackColor]];

            [_stateLabel setText:@"未启用"];
            [_mjCon refreshWithLoading];
            break;
        case 23:
            //已启用
            
            _statusType = 2;
            
            _statementCheck1.hidden = YES;
            _statementCheck2.hidden = YES;
            _statementCheck3.hidden = NO;
            
            [_statementTitle1 setTextColor:[UIColor blackColor]];
            [_statementTitle2 setTextColor:[UIColor blackColor]];
            [_statementTitle3 setTextColor:[UIColor redColor]];

            [_stateLabel setText:@"已启用"];
            [_mjCon refreshWithLoading];
            break;
        default:
            break;
    }
}

//键盘出现
- (void)keyboardWillShow:(NSNotification*)aNotify {
    
    //获取键盘的高度
    NSDictionary *userInfo = [aNotify userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    int height = keyboardRect.size.height;
    
    [UIView animateWithDuration:0.25 animations:^{
        _addPriceView.frame = CGRectMake(0, self.view.frame.size.height - _addPriceView.frame.size.height-height, self.view.frame.size.width, _addPriceView.frame.size.height);
    }];
}

//键盘消失
- (void)keyboardWillHide:(NSNotification*)aNotify {

    [UIView animateWithDuration:0.25 animations:^{
        _addPriceView.frame = CGRectMake(0, self.view.frame.size.height - _addPriceView.frame.size.height, self.view.frame.size.width, _addPriceView.frame.size.height);
    }];
}

#pragma mark - UpdatePriceDelegate

- (void)oprationToUpdatingPrice:(UIButton*)sender {
    
    self.locationButton.enabled = NO;
    self.stateButton.enabled = NO;
    self.flashScreenButton.enabled = NO;
    self.bannerAdsButton.enabled = NO;
    self.recommandMerchantButton.enabled = NO;
    self.lightGrayBackGroundView.hidden = NO;

    [UIView animateWithDuration:0.3 animations:^{
        _addPriceView.frame = CGRectMake(0, self.view.frame.size.height - _addPriceView.frame.size.height, self.view.frame.size.width, _addPriceView.frame.size.height);
    }];

    for (NSDictionary *dic in _dataSource) {
        
        DictionaryWrapper *item = dic.wrapper;
        
        if (sender.tag == [item getInt:@"BiddingId"]) {
            
            [self.wrapper set:@"BiddingId" string:[NSString stringWithFormat:@"%d",[item getInt:@"BiddingId"]]];
            [self.wrapper set:@"Count" string:[NSString stringWithFormat:@"%d", [item getInt:@"Count"]]];
        }
    }
}

//取消更新竞价
- (IBAction)cancleAddingPrice:(id)sender {
    
    self.locationButton.enabled = YES;
    self.stateButton.enabled = YES;
    self.flashScreenButton.enabled = YES;
    self.bannerAdsButton.enabled = YES;
    self.recommandMerchantButton.enabled = YES;
    self.lightGrayBackGroundView.hidden = YES;
    
    [_addPriceTextField resignFirstResponder];
    
    [UIView animateWithDuration:0.3 animations:^{
        _addPriceView.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, _addPriceView.frame.size.height);
    }];
}

//确定更新竞价
- (IBAction)ensureAddingPrice:(id)sender {
    
    self.locationButton.enabled = YES;
    self.stateButton.enabled = YES;
    self.flashScreenButton.enabled = YES;
    self.bannerAdsButton.enabled = YES;
    self.recommandMerchantButton.enabled = YES;
    self.lightGrayBackGroundView.hidden = YES;
    
    [_addPriceTextField resignFirstResponder];
    
    if ([_addPriceTextField.text floatValue] > 0) {
    
        ADAPI_UpdateBiddingPrice([self genDelegatorID:@selector(postUpdatePriceEnd:)], [_wrapper getString:@"BiddingId"], [_wrapper getString:@"Count"], _postPrice);
    }else {
        
        [HUDUtil showErrorWithStatus:@"您尚未输入任何竞价！"];
    }
}

- (void)postUpdatePriceEnd:(DelegatorArguments*)arguments {

    DictionaryWrapper *wrapper = arguments.ret;
    DictionaryWrapper *item = wrapper.data;
    
    
    if ([item getBool:@"Success"]) {
        
        [HUDUtil showSuccessWithStatus:@"更新竞价成功"];
        [self.updatedCellArray addObject:[_wrapper getString:@"BiddingId"]];
        [_mjCon refresh];
    }else {
        [HUDUtil showErrorWithStatus:[item getString:@"Message"]];
    }
    [UIView animateWithDuration:0.3 animations:^{
        _addPriceView.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, _addPriceView.frame.size.height);
    }];
}

#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _mjCon.refreshCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MyBiddingTableViewCell *cell = [_mainTable dequeueReusableCellWithIdentifier:@"MyBiddingTableViewCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.adName.text = [[[_mjCon dataAtIndex:(int)indexPath.row] wrapper] getString:@"AdvertName"];
    cell.biddingCount.text = [NSString stringWithFormat:@"%d", [[[_mjCon dataAtIndex:(int)indexPath.row] wrapper]getInt:@"Count"]];
    cell.price.text = [NSString stringWithFormat:@"%.2f",[[[_mjCon dataAtIndex:(int)indexPath.row] wrapper] getFloat:@"Price"]];

    if ([_updatedCellArray containsObject:[NSString stringWithFormat:@"%d",[[[_mjCon dataAtIndex:(int)indexPath.row] wrapper] getInt:@"BiddingId"]]]||![[[_mjCon dataAtIndex:(int)indexPath.row] wrapper] getBool:@"TodayCanUpdate"]) {

        [cell.updatePriceBtn setTitleColor:[UIColor colorWithRed:204.0/255 green:204.0/255 blue:204.0/255 alpha:1] forState:UIControlStateNormal];
        [cell.updatePriceBtn setTitle:@"已更新" forState:UIControlStateNormal];
        cell.updatePriceBtn.layer.borderWidth = 1;
        cell.updatePriceBtn.layer.borderColor = [[UIColor colorWithRed:204.0/255 green:204.0/255 blue:204.0/255 alpha:1] CGColor];
        [cell.updatePriceBtn setBackgroundColor:[UIColor colorWithRed:239.0/255 green:239.0/255 blue:244.0/255 alpha:1]];
        cell.updatePriceBtn.enabled = NO;
    }else {
        
        if ([[[_mjCon dataAtIndex:(int)indexPath.row] wrapper] getInt:@"Status"] == 0) {
                
            [cell.updatePriceBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            [cell.updatePriceBtn setTitle:@"更新竞价" forState:UIControlStateNormal];
            cell.updatePriceBtn.layer.borderWidth = 1;
            cell.updatePriceBtn.layer.borderColor = [RGBCOLOR(240, 5, 0) CGColor];
            [cell.updatePriceBtn setBackgroundColor:[UIColor whiteColor]];
            cell.updatePriceBtn.enabled = YES;
        }else {
            
            [cell.updatePriceBtn setTitleColor:[UIColor colorWithRed:204.0/255 green:204.0/255 blue:204.0/255 alpha:1] forState:UIControlStateNormal];
            [cell.updatePriceBtn setTitle:@"更新竞价" forState:UIControlStateNormal];
            cell.updatePriceBtn.layer.borderWidth = 1;
            cell.updatePriceBtn.layer.borderColor = [[UIColor colorWithRed:204.0/255 green:204.0/255 blue:204.0/255 alpha:1] CGColor];
            [cell.updatePriceBtn setBackgroundColor:[UIColor colorWithRed:239.0/255 green:239.0/255 blue:244.0/255 alpha:1]];
            cell.updatePriceBtn.enabled = NO;
            }
    }
    
    cell.updatePriceBtn.tag = [[[_mjCon dataAtIndex:(int)indexPath.row] wrapper] getInt:@"BiddingId"];
    [cell.updatePriceBtn addTarget:self action:@selector(oprationToUpdatingPrice:) forControlEvents:UIControlEventTouchUpInside];
    
    if (indexPath.row == _mjCon.refreshCount - 1) {
        
        [cell.UIBottomLineView setFrame:CGRectMake(0, 49.5, 320, 0.5)];
    }else {
    
        [cell.UIBottomLineView setFrame:CGRectMake(15, 49.5, 305, 0.5)];
    }
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    UIView *temp = WEAK_OBJECT(UIView, init);
    [temp setBackgroundColor:[UIColor clearColor]];
    return temp;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 50;
}

#pragma mark - TextFieldDelegate 
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NSString * aString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    _postPrice = [aString doubleValue];
    if ([aString containsString:@"."]) {
        NSArray *array = [aString componentsSeparatedByString:@"."];
        if (([aString length]-[array[0] length]) >= 4) {
            
            [HUDUtil showErrorWithStatus:@"最多输入15位数字，且小数点后保留两位，且小数点后保留两位"];
            return NO;
        }else {
            
            return YES;
        }
    }
    if ([aString length] > 15) {
        
        [HUDUtil showErrorWithStatus:@"最多输入15位数字，且小数点后保留两位"];
        return NO;
    }
    return YES;
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    [_apiString release];
    [_wrapper release];
    [_dataSource release];
    [_mjCon release];
    [_mainTable release];
    [_locationView release];
    [_stateView release];
    [_locationButton release];
    [_stateButton release];
    [_flashScreenButton release];
    [_bannerAdsButton release];
    [_recommandMerchantButton release];
    [_redlineView release];
    [_downArrowLeft release];
    [_downArrowRight release];
    [_statementCheck1 release];
    [_statementCheck2 release];
    [_statementCheck3 release];
    [_statementTitle1 release];
    [_statementTitle2 release];
    [_statementTitle3 release];
    [_locationCheckIcon1 release];
    [_locationCheckIcon2 release];
    [_locationCheckIcon3 release];
    [_locationCheckIcon4 release];
    [_locationCheckIcon5 release];
    [_locationCheckTitle1 release];
    [_locationCheckTitle2 release];
    [_locationCheckTitle3 release];
    [_locationCheckTitle4 release];
    [_locationCheckTitle5 release];
    [_locationLabel release];
    [_stateLabel release];
    [_addPriceView release];
    [_addPriceTextField release];
    [_noContentView release];
    [_allLocationView release];
    [_allStatusView release];
    [_lightGrayBackGroundView release];
    [_lightGrayBackGroundColor2 release];
    [_UITitleView release];
    [_UILineView1 release];
    [_lightGrayBackGroundcolor3 release];
    [_UILineView2 release];
    [_UILineView3 release];
    [_UILineView4 release];
    [super dealloc];
}
@end
