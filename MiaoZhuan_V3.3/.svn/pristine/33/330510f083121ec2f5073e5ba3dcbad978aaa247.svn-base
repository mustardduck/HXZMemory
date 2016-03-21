//
//  ScreeningListVC.m
//  guanggaoban
//
//  Created by CQXianMai on 14-8-10.
//  Copyright (c) 2014年 Arvin. All rights reserved.
//

#import "ScreeningListVC.h"
#import "ScreeningListType.h"
#import "ScreenDeclareVC.h"
#import "ScreenedResultListVC.h"

#import "CRHtmlManager.h"
#import "WebhtmlViewController.h"

#define EXDATA_ARRAY(x) ([x count] > 0)

#define NODATA_TO_CHECK @"暂无选择项"

@interface ScreeningListVC ()
{
    NSMutableArray *_rankMonthsArr;
    NSMutableArray *_rankWeeksArr;
    
    NSMutableArray *_rankComNamesArr;
    NSMutableArray *_rankUserNamesArr;
    
    NSInteger _type;
    NSString *_startDayStr;
}

@property (copy, nonatomic) NSString *rankInfoTip;
@end

@implementation ScreeningListVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _rankMonthsArr = [[NSMutableArray alloc] init];
        _rankWeeksArr = [[NSMutableArray alloc] init];
        
        _rankUserNamesArr = [[NSMutableArray alloc] init];
        _rankComNamesArr = [[NSMutableArray alloc] init];
        
        if (_type == 0) _type = INIT_VAL_USER;
        if (_period == 0) _period = PERIOD_MONTH;
    }
    return self;
}

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    
    [self initNaviItem];
    
    if (_period == PERIOD_MONTH)
    {
        ADAPI_adv23_top_months([self genDelegatorID:@selector(onGetMonthsHandler:)],_type);
    }
    else if (_period == PERIOD_WEEK)
    {
        ADAPI_adv23_top_weeks([self genDelegatorID:@selector(onGetWeeksHandler:)], _type);
    }
    else
    {
        ADAPI_adv23_top_months([self genDelegatorID:@selector(onGetMonthsHandler:)], _type);
        ADAPI_adv23_top_weeks([self genDelegatorID:@selector(onGetWeeksHandler:)], _type);
    }
    
    [self layoutView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    
    [_dataListArr release];
    
    [_rankUserNamesArr release];
    [_rankComNamesArr release];
    [_rankMonthsArr release];
    [_rankWeeksArr release];
    _startDayStr = nil;
    
    [_userBtn release];
    [_comBtn release];
    [_rankNameBtn release];
    [_rankNameLbl release];
    [_monthBtn release];
    [_weekBtn release];
    [_rankTimeBtn release];
    [_searchBtn release];
    [_rankTimeLbl release];
    [super dealloc];
}

- (void)initNaviItem
{
    [self setNavigateTitle:@"榜单筛选"];
    [self setupMoveFowardButtonWithTitle:@"说明"];
    [self setupMoveBackButton];
}

- (void)layoutView
{
    if (![_dataListArr count])
    {
        return;
    }
    
    for (int i = 0; i < [_dataListArr count]; i++) {
        for (int j = 0; j < [_dataListArr[i] count]; j++) {
            //用户榜单
            if (i == 0) {
                NSDictionary *userRankDic = _dataListArr[i][j];
                NSString *userRankStr = [userRankDic.wrapper getString:@"Name"];
                [_rankUserNamesArr addObject:userRankStr];
            }
            // 商家榜单
            if (i == 1) {
                NSDictionary *comRankDic = _dataListArr[i][j];
                NSString *comRankStr = [comRankDic.wrapper getString:@"Name"];
                [_rankComNamesArr addObject:comRankStr];
            }
        }
    }
    
//    [UICommon setButtonCorner:_searchBtn];
    [self initDefaultRankName];
}

- (void)initDefaultRankName
{
    if (EXDATA_ARRAY(_rankUserNamesArr)) {
        
        if (_type == INIT_VAL_USER)
        {
            _userBtn.enabled = YES;
            _userBtn.selected = YES;
            _rankNameLbl.text = _rankUserNamesArr[0];
        }
        else
        {
            _comBtn.enabled = YES;
            _comBtn.selected = YES;
            _rankNameLbl.text = _rankComNamesArr[0];
        }
    }
    
}

- (void)initDefaultRankTime
{
    _monthBtn.enabled = NO;
    _weekBtn.enabled  = NO;
    
    if (EXDATA_ARRAY(_rankWeeksArr))
    {
        _weekBtn.selected = YES;
        _weekBtn.enabled  = YES;
        DictionaryWrapper *weekWrapper = ((NSDictionary *)_rankWeeksArr[0]).wrapper;
        _startDayStr = [weekWrapper getString:@"Value"];
        _rankTimeLbl.text = [weekWrapper getString:@"Text"];
    }
    
    if (EXDATA_ARRAY(_rankMonthsArr))
    {
        _monthBtn.enabled = YES;
        _monthBtn.selected = YES;
        DictionaryWrapper *monthWrapper = ((NSDictionary *)_rankMonthsArr[0]).wrapper;
        _startDayStr = [monthWrapper getString:@"Value"];
        _rankTimeLbl.text = [monthWrapper getString:@"Text"];
    }
    
    if (_period == 1 && _monthBtn.selected)
    {
        _weekBtn.selected = NO;
    }
//    else{
//
//        _period = PERIOD_WEEK;
//        
//        if (EXDATA_ARRAY(_rankWeeksArr)) {
//            DictionaryWrapper *weekWrapper = ((NSDictionary *)_rankWeeksArr[0]).wrapper;
//            _startDayStr = [weekWrapper getString:@"Value"];
//            _rankTimeLbl.text = [weekWrapper getString:@"Text"];
//        }
//        else{
//            _startDayStr = STARTDAY_WEEK;
//            _rankTimeLbl.text = NODATA_TO_CHECK;
//        }
//    }
}

- (IBAction)onMoveFoward:(UIButton *)sender
{
    PUSH_VIEWCONTROLLER(WebhtmlViewController);
    model.ContentCode = CRHtmlManager_Code_RankList;
//    ScreenDeclareVC* view = WEAK_OBJECT(ScreenDeclareVC, initWithNibName:@"ScreenDeclareVC" bundle:nil);
//    [self.navigationController pushViewController:view animated:YES];
}

- (void)onGetMonthsHandler:(DelegatorArguments *)arguments
{
    DictionaryWrapper *wrapper = arguments.ret;
    
    if(wrapper.operationSucceed)
    {
        [_rankMonthsArr removeAllObjects];
        if ([wrapper.data isKindOfClass:[NSArray class]]) {
            [_rankMonthsArr addObjectsFromArray:wrapper.data];
        }
    }
    else
    {
        [HUDUtil showErrorWithStatus:wrapper.operationMessage];
        return;
    }
}

- (void)onGetWeeksHandler:(DelegatorArguments *)arguments
{
    DictionaryWrapper *wrapper = arguments.ret;
    if(wrapper.operationSucceed)
    {
        [_rankWeeksArr removeAllObjects];
        [_rankWeeksArr addObjectsFromArray:wrapper.data];
        [self initDefaultRankTime];
    }
    else
    {
        [HUDUtil showErrorWithStatus:wrapper.operationMessage];
        return;
    }
}


- (IBAction)touchUpInsideOnBtn:(id)sender {
    
    if (sender == _userBtn)//选中用户
    {
        _userBtn.selected = YES;
        _comBtn.selected = NO;
        _type = INIT_VAL_USER;
        _rankNameLbl.text = EXDATA_ARRAY(_rankUserNamesArr) ?  _rankUserNamesArr[0] : NODATA_TO_CHECK;
        
    }
    else if (sender == _comBtn)
    {
        _comBtn.selected = YES;
        _userBtn.selected = NO;
        _type = INIT_VAL_COM;
        _rankNameLbl.text = EXDATA_ARRAY(_rankComNamesArr) ? _rankComNamesArr[0] : NODATA_TO_CHECK;
    }
    else if (sender == _rankNameBtn)
    {
        SelectListVC* view = WEAK_OBJECT(SelectListVC, initWithNibName:@"SelectListVC" bundle:nil);
        
        if (_userBtn.selected) {
            view.listArr = _rankUserNamesArr;
            view.listType = check_User_RankName;//默认 用户
        }
        else{
            view.listArr = _rankComNamesArr;
            view.listType = check_Com_RankName;// 商家
        }
    
        view.titleNameStr = @"榜单名称";
        view.delegate = self;
        view.selectTitle = _rankNameLbl.text;
        [self.navigationController pushViewController:view animated:YES];
    }
    else if (sender == _monthBtn)
    {
        _monthBtn.selected = YES;
        _weekBtn.selected = NO;
        _period = PERIOD_MONTH;

        if (_rankMonthsArr.count == 0)
        {
            ADAPI_adv23_top_months([self genDelegatorID:@selector(onGetMonthsHandler:)], _type);
            _startDayStr = STARTDAY_MONTH;
            _rankTimeLbl.text = NODATA_TO_CHECK;
        }
        else
        {
            _startDayStr = [_rankMonthsArr[0] valueForJSONStrKey:@"Value"];
            _rankTimeLbl.text = [_rankMonthsArr[0] valueForJSONStrKey:@"Text"];
        }
    }
    else if (sender == _weekBtn)
    {
        _weekBtn.selected = YES;
        _monthBtn.selected = NO;
        _period = PERIOD_WEEK;
        
        if (_rankWeeksArr.count == 0)
        {
            ADAPI_adv23_top_weeks([self genDelegatorID:@selector(onGetWeeksHandler:)], _type);
            _startDayStr = STARTDAY_WEEK;
            _rankTimeLbl.text = NODATA_TO_CHECK;
        }
        else
        {
            if (EXDATA_ARRAY(_rankWeeksArr)) {
                _startDayStr = [_rankWeeksArr[0] valueForJSONStrKey:@"Value"];
                _rankTimeLbl.text = [_rankWeeksArr[0] valueForJSONStrKey:@"Text"];
            }
        }
    }
    else if (sender == _rankTimeBtn)
    {
        SelectListVC* view = WEAK_OBJECT(SelectListVC, initWithNibName:@"SelectListVC" bundle:nil);
        if (_monthBtn.selected)
        {
            view.listArr = _rankMonthsArr;
            view.listType = check_Month_RankTime;// 月榜
        }
        else{
            view.listArr = _rankWeeksArr;
            view.listType = check_Week_RankTime;// 周榜
        }
        
        view.titleNameStr = @"榜单时间";
        view.delegate = self;
        view.selectTitle = _rankTimeLbl.text;
        [self.navigationController pushViewController:view animated:YES];

    }
    else if (sender == _searchBtn)
    {
        ScreenedResultListVC* view = WEAK_OBJECT(ScreenedResultListVC, initWithNibName:@"ScreenedResultListVC" bundle:nil);
        _rankInfoTip = [NSString stringWithFormat:@"%@ %@", _rankTimeLbl.text, _rankNameLbl.text];
        view.rankInfoStr = _rankInfoTip;
        NSDictionary *searchDic = @{@"type": @(_type), @"period":@(_period), @"startDay": _startDayStr};
        NSLog(@"%@",searchDic);
        view.searchDic = [searchDic copy];
        [searchDic release];
        [self.navigationController pushViewController:view animated:YES];
    }
}

#pragma mark - SelectRightInfoDelegate
- (void)checkRightInfoName:(NSString *)chooseStr ListType:(NSInteger)type andSearchType:(NSInteger)searchType andSelectDate:(NSString *)dateStr
{
    switch (type) {
        case check_User_RankName:
        case check_Com_RankName:
            self.rankNameLbl.text = chooseStr;
            _type = searchType;
            break;
        case check_Month_RankTime:
        case check_Week_RankTime:
            self.rankTimeLbl.text = chooseStr;
            _startDayStr = dateStr;
            break;
        default:
            break;
    }
}
@end
