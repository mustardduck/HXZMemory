//
//  SilverListViewController.m
//  miaozhuan
//
//  Created by 孙向前 on 14-12-1.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "MyGoldListController.h"
#import "BaseMyGoldCell.h"
#import "MJRefreshController.h"
#import "BaserHoverView.h"
#import "RRButton.h"
#import "JSONKit.h"
#import "RRAttributedString.h"
#import "AppPopView.h"
#import "UIView+expanded.h"
#import "RRLineView.h"
#import "IWGoldAdvertTableViewCell.h"
#import "IWExploitTableViewCell.h"
#import "WebhtmlViewController.h"
#import "MyGoldSystemSendCell.h"
#import "UserInfo.h"
#import "QTMoneyTableViewCell.h"
@interface MyGoldListController ()
{
    __block BOOL _isChoosed;
    
    BOOL _isResetFilter;

}

@property (retain, nonatomic) IBOutlet UITableView *tableView;
@property (retain, nonatomic) IBOutlet UILabel *lblSilver;
@property (retain, nonatomic) IBOutlet UILabel *lblDj;
@property (retain, nonatomic) IBOutlet UILabel *lblTime;
@property (retain, nonatomic) IBOutlet UIButton *btnLeft;
@property (retain, nonatomic) IBOutlet UIButton *btnRight;
@property (retain, nonatomic) IBOutlet UIButton *btnChoose;

@property (nonatomic, retain) MJRefreshController *MJRefreshCon;
@property (nonatomic, copy) NSString *day;
@property (nonatomic, assign) int type;
@property (nonatomic, retain) NSString * orderNumber;
@property (nonatomic, retain) NSString * userName;
@property (nonatomic, retain) AppPopView *appPopView;
@property (nonatomic, retain) UIButton *curButton;
@property (nonatomic, retain) NSMutableArray *dataArray;

@property (retain, nonatomic) IBOutlet UIButton *btnFront;
@property (retain, nonatomic) IBOutlet UIButton *btnMiddle;
@property (retain, nonatomic) IBOutlet UIButton *btnLast;
@property (retain, nonatomic) IBOutlet UIView *filterView;


@property (retain, nonatomic) IBOutlet UIView *shooseView;

@property (retain, nonatomic) IBOutlet UIImageView *imgIcon;
@property (retain, nonatomic) IBOutlet UILabel *lblTIshi;
@property (retain, nonatomic) IBOutlet RRButton *btnRefresh;
@property (retain, nonatomic) IBOutlet UIView *hoverView;
@property (retain, nonatomic) IBOutlet UIButton *helpBtn;
@property (retain, nonatomic) IBOutlet UITextField *orderNumField;
@property (retain, nonatomic) IBOutlet UITextField *phoneNumField;
@property (retain, nonatomic) IBOutlet RRLineView *line;
@property (retain, nonatomic) IBOutlet UIView *topView;
@property (retain, nonatomic) IBOutlet UIImageView *topImg;
@property (retain, nonatomic) NSDate * lastDate;

@end

@implementation MyGoldListController

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupMoveBackButton];

    [self.tableView registerNib:[UINib nibWithNibName:@"IWExploitTableViewCell" bundle:nil] forCellReuseIdentifier:@"IWExploitTableViewCell"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"IWGoldAdvertTableViewCell" bundle:nil] forCellReuseIdentifier:@"IWGoldAdvertTableViewCell"];
    
    _line.top = 111.5;
    
    NSArray *titles = @[@"发银元广告消耗的", @"兑换商品消耗的", @"竞价广告消耗的", @"系统赠送的", @"易货商城的货款", @"流通记录", @"其他收支",@"发商家优惠信息消耗的",@"发招聘信息消耗的",@"发招商信息消耗的",@"拓展商家赚的",@"购买广告金币获得的",@"其他收支"];
    [self setNavigateTitle:titles[_cellType]];
    
    if(_cellType == 10)
    {
        [self setupMoveFowardButtonWithTitle:@"说明"];
    }
    
    [_btnRefresh roundCornerBorder];
    
    if(_cellType == DuihuanProdConsume )
    {
        NSLog(@"----time%@",USER_MANAGER.GoldOrderLastDate);
        
        NSDate * goldOrderDate = [self formatDataStr:USER_MANAGER.GoldOrderLastDate];
        
//        NSDate * goldOrderDate = [self formatDataStr: @"2015年05月"];
        if (goldOrderDate == nil)
        {
            goldOrderDate = [NSDate date];
        }
        
        self.lastDate = goldOrderDate;

        _lblTime.text = [self formatDate:goldOrderDate];
    }
    else if (_cellType == GoldMarketMoney )
    {
        NSDate * merchGoldOrderDate = [self formatDataStr:USER_MANAGER.MerchantGoldOrderLastDate];
        
        if(merchGoldOrderDate == nil){
            self.lastDate = [NSDate date];
        }else{
            self.lastDate = merchGoldOrderDate;
        }
        
        _lblTime.text = [self formatDate:self.lastDate];
    }
    else
    {
        self.lastDate = [NSDate date];
        
        _lblTime.text = [self formatDate: _lastDate];
    }
    
    _btnRight.enabled = [self btnEnable];
    
    
    
    _btnChoose.hidden = (_cellType != LiutongRecord && _cellType != GoldMarketMoney);
    
    [self setExtraCellLineHidden:_tableView];
    
    [_MJRefreshCon release];
    _MJRefreshCon = nil;
    
    NSArray *names = @[@"CustomerGold/GetSilverAdvertGoldList", @"CustomerGold/GetBuyProductGoldList", @"CustomerGold/GetBindingAdvertGoldList",@"CustomerGold/GetSystemPresentGoldList", @"CustomerGold/GetSellProductGoldList", @"CustomerGold/GetTransferGoldList", @"CustomerGold/GetOtherBalance", @"CustomerGold/GetDiscountGoldList",@"CustomerGold/GetRecruitmentGoldList",@"CustomerGold/GetInvestmentGoldList",@"CustomerCash/EarnedByExploitEnterprise",@"CustomerCash/BuyGoldList",@"CustomerCash/OtherIncomeCashes"];
    
    _MJRefreshCon = [[MJRefreshController controllerFrom:_tableView name:names[_cellType]] retain];
    
    NSArray *array = @[@"当月消耗 ", @"当月消耗 ", @"当月消耗 ", @"当月获赠 ", @"当月货款 ", @"当月获赠 ", @"当月收支 ", @"当月消耗 ", @"当月消耗 ", @"当月消耗 ",@"当月赚的 ",@"共计   ",@"当月总计 "];

    NSString * str = [NSString stringWithFormat:@"%@0.00广告金币",array[_cellType]];
    
    CGSize size = [UICommon getSizeFromString:str
                                     withSize:CGSizeMake(MAXFLOAT, 21)
                                     withFont:14];
    _lblSilver.width = size.width;
    NSAttributedString *attribute = [RRAttributedString setText:str
                                                          color:RGBCOLOR(240, 5, 0)
                                                          range:NSMakeRange(5, str.length - 5)];
    _lblSilver.attributedText = attribute;
    
    //是否显示冻结
    _lblDj.hidden = (_cellType == JingjiaADsConsume || _cellType == systemBonus || _cellType == GoldMarketMoney || _cellType == OtherIncome || _cellType == DiscountGoldConsume || _cellType == RecruitmentGoldConsume || _cellType == InvestmentGoldConsume || _cellType == ExploitGoldConsume || _cellType == GetBuyAdvertGold || _cellType == QT_MONEY);
    
    if(_cellType == AdvertConsume || _cellType == DuihuanProdConsume)
    {
        _lblDj.text = @"包含冻结 0.00广告金币";

    }
    else if(_cellType == LiutongRecord)
    {
        _lblDj.text = @"赠送 0.00广告金币";
    }
    
    [self _initTableView];
    
}

#pragma mark -- 说明
- (void)onMoveFoward:(UIButton*) sender{
//        PUSH_VIEWCONTROLLER(WebhtmlViewController);
    WebhtmlViewController *vc = [[WebhtmlViewController alloc] initWithNibName:NSStringFromClass([WebhtmlViewController class]) bundle:nil];
    vc.ContentCode = @"34c0f9753f828f78202512c70eed503f";
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)_initTableView{
    
    if(_isResetFilter)
    {
        _type = 0;
        _btnFront.selected = _btnMiddle.selected = _btnLast.selected = NO;
    }
    
    [self createHoverViewWhenNoData];
    
    if(_cellType == ExploitGoldConsume)
    {
        
        NSString *str = [NSString stringWithFormat:@"当月赚的 ￥0.00"];
        
        CGSize size = [UICommon getSizeFromString:str
                                         withSize:CGSizeMake(MAXFLOAT, 21)
                                         withFont:14];
        _lblSilver.width = size.width;
        NSAttributedString *attribute = [RRAttributedString setText:str
                                                              color:RGBCOLOR(240, 5, 0)
                                                              range:NSMakeRange(5, str.length - 5)];
        _lblSilver.attributedText = attribute;

    }
    if(_cellType == QT_MONEY)
    {
        NSString *str = [NSString stringWithFormat:@"当月共计 ￥0.00"];
        
        CGSize size = [UICommon getSizeFromString:str
                                         withSize:CGSizeMake(MAXFLOAT, 21)
                                         withFont:14];
        _lblSilver.width = size.width;
        NSAttributedString *attribute = [RRAttributedString setText:str
                                                              color:RGBCOLOR(240, 5, 0)
                                                              range:NSMakeRange(5, str.length - 5)];
        _lblSilver.attributedText = attribute;
        
    }

    
    __block typeof(self) weakSelf = self;
    
    //0.发广告消耗的，1.兑换商品消耗的，2.竞价广告消耗的，3.系统赠送的，4.易货商城的货款 5.流通记录
    
    [_MJRefreshCon setURLGenerator:MJREFRESH_URL_GENERATOR_BLOCK{
        
        NSArray *names = @[@"CustomerGold/GetSilverAdvertGoldList", @"CustomerGold/GetBuyProductGoldList", @"CustomerGold/GetBindingAdvertGoldList",@"CustomerGold/GetSystemPresentGoldList", @"CustomerGold/GetSellProductGoldList", @"CustomerGold/GetTransferGoldList", @"CustomerGold/GetOtherBalance", @"CustomerGold/GetDiscountGoldList",@"CustomerGold/GetRecruitmentGoldList",@"CustomerGold/GetInvestmentGoldList",@"CustomerCash/EarnedByExploitEnterprise",@"CustomerGold/BuyGoldList",@"CustomerCash/OtherIncomeCashes"];

        NSDictionary * dic =@{@"SearchMonth":weakSelf.day, @"PageIndex":@(pageIndex), @"PageSize":@(pageSize)};
        NSMutableDictionary *pdic = [NSMutableDictionary dictionaryWithDictionary:dic];
        if (_cellType == LiutongRecord) {
            [pdic setValue:@(weakSelf.type) forKey:@"Type"];
        }
        else if (_cellType == GoldMarketMoney)
        {
            [pdic setValue:weakSelf.orderNumber forKey:@"OrderNumber"];
            
            [pdic setValue:weakSelf.userName forKey:@"UserName"];
            
        }
        else if(_cellType == ExploitGoldConsume )
        {
            dic = @{@"Month":weakSelf.day, @"PageIndex":@(pageIndex), @"PageSize":@(pageSize)};
            pdic = [NSMutableDictionary dictionaryWithDictionary:dic];
        }
        else if ( _cellType == QT_MONEY)
        {
            dic = @{@"Month":[UICommon formatDate:weakSelf.day], @"PageIndex":@(pageIndex), @"PageSize":@(20)};
            pdic = [NSMutableDictionary dictionaryWithDictionary:dic];
        }
        
        NSDictionary *pramaDic = @{@"service":[NSString stringWithFormat:@"api/%@",names[weakSelf.cellType]],@"parameters":pdic};
        return pramaDic.wrapper;
    }];
    MJRefreshOnRequestDone block = MJREFRESH_ON_REQUEST_DONE
    {
        if(netData.operationSucceed)
        {
            NSLog(@"%@___%d ___",netData.dictionary, netData.operationSucceed);
            DictionaryWrapper *dic = [[[netData.data getString:@"ExtraData"] objectFromJSONString] wrapper];
            NSArray *array = @[@"当月消耗 ", @"当月消耗 ", @"当月消耗 ", @"当月获赠 ", @"当月货款 ", @"当月获赠 ", @"当月收支 ", @"当月消耗 ", @"当月消耗 ", @"当月消耗 ",@"当月赚的 ",@"共计   ",@"当月共计 "];
            
            NSString *str = @"";
            
            if(_cellType == LiutongRecord)
            {
                double giftedFromGold = [dic getDouble:@"MonthGiftedFromGold"];
                
                if(giftedFromGold != 0)
                {
                    str = [NSString stringWithFormat:@"%@%0.2f广告金币",array[_cellType], giftedFromGold];
                    
                    CGSize size = [UICommon getSizeFromString:str
                                                     withSize:CGSizeMake(MAXFLOAT, 21)
                                                     withFont:14];
                    _lblSilver.width = size.width;
                    NSAttributedString *attribute = [RRAttributedString setText:str
                                                                          color:RGBCOLOR(240, 5, 0)
                                                                          range:NSMakeRange(5, str.length - 5)];
                    _lblSilver.attributedText = attribute;
                }
            }
            else if(_cellType == ExploitGoldConsume || _cellType == QT_MONEY)
            {
                double Total = [dic getDouble:@"Total"];
                
                str = [NSString stringWithFormat:@"%@￥%0.2f",array[_cellType],Total];
                
                CGSize size = [UICommon getSizeFromString:str
                                                 withSize:CGSizeMake(MAXFLOAT, 21)
                                                 withFont:14];
                _lblSilver.width = size.width;
                NSAttributedString *attribute = [RRAttributedString setText:str
                                                                      color:RGBCOLOR(240, 5, 0)
                                                                      range:NSMakeRange(5, str.length - 5)];
                _lblSilver.attributedText = attribute;
            }
            else
            {
                double monthTotalGold = [dic getDouble:@"MonthTotalGold"];
                
                
                if(monthTotalGold != 0)
                {
                    str = [NSString stringWithFormat:@"%@%0.2f广告金币",array[_cellType],monthTotalGold];
                    
                    CGSize size = [UICommon getSizeFromString:str
                                                     withSize:CGSizeMake(MAXFLOAT, 21)
                                                     withFont:14];
                    _lblSilver.width = size.width;
                    NSAttributedString *attribute = [RRAttributedString setText:str
                                                                          color:RGBCOLOR(240, 5, 0)
                                                                          range:NSMakeRange(5, str.length - 5)];
                    _lblSilver.attributedText = attribute;
                }
            }
            
            //是否显示冻结
            _lblDj.hidden = (_cellType == JingjiaADsConsume || _cellType == systemBonus || _cellType == GoldMarketMoney || _cellType == OtherIncome || _cellType == DiscountGoldConsume || _cellType == RecruitmentGoldConsume || _cellType == InvestmentGoldConsume || _cellType == ExploitGoldConsume || _cellType == GetBuyAdvertGold || _cellType == QT_MONEY);
            if (!_lblDj.hidden) {
                if(_cellType == AdvertConsume || _cellType == DuihuanProdConsume)
                {
                    _helpBtn.hidden = NO;
                    
                    double frozenGold = [dic getDouble:@"MonthFrozenGold"];
                    
                    if(frozenGold != 0)
                    {
                        _lblDj.text = [NSString stringWithFormat:@"包含冻结 %0.2f广告金币", frozenGold];
                    }
                }
                else if(_cellType == LiutongRecord)
                {
                    double giftedToGold = [dic getDouble:@"MonthGiftedToGold"];
                    
                    if(giftedToGold != 0)
                    {
                        _lblDj.text = [NSString stringWithFormat:@"赠送 %0.2f广告金币", giftedToGold];
                    }
                }
            }
            else
            {
                _topView.height = 97;
                _topImg.height = 97;
                _line.top = 96.5;
                _tableView.top = 97;
                _hoverView.top = 97;

            }
            self.dataArray = [self configDateArray];
            [self.tableView reloadData];
            
            if(controller.refreshCount > 0)
            {
                _hoverView.hidden = YES;
                
                if(_cellType == LiutongRecord || _cellType == GoldMarketMoney)
                {
                    _btnChoose.hidden = NO;
                }
            }
            else
            {
                [weakSelf createHoverViewWhenNoData];
            }
        }
    };
    
    [_MJRefreshCon setOnRequestDone:block];
    [_MJRefreshCon setPageSize:50];
    
    [self refreshTableView];
    
    _tableView.panGestureRecognizer.delaysTouchesBegan = YES;
    [self setExtraCellLineHidden:_tableView];
}

-(void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = WEAK_OBJECT(UIView, initWithFrame:CGRectZero);
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}
//无数据hoverview
- (void)createHoverViewWhenNoData{
    _hoverView.hidden = NO;
    
    if(_isChoosed && (_cellType == LiutongRecord || _cellType == GoldMarketMoney))
    {
        _btnChoose.hidden = YES;
        _btnRefresh.hidden = NO;
        _lblTIshi.text = @"没有符合条件的记录，请重新筛选";
    }
    else
    {
        NSArray *array = @[@"暂无发广告消耗的广告金币", @"暂无消耗的广告金币", @"暂无竞价广告消耗的金币", @"暂无系统赠送的广告金币", @"暂无易货商城的货款", @"暂无流通记录", @"暂无其他收支",@"暂无发商家优惠信息消耗的广告金币",@"暂无发招聘信息消耗的广告金币",@"暂无发招商消耗的广告金币",@"暂无拓展商家赚的现金",@"暂无购买广告金币获得的广告金币",@"暂无其他收支的金额"];
        NSArray *images = @[[UIImage imageNamed:@"myGoldIcon"],
                            [UIImage imageNamed:@"myGoldIcon"],
                            [UIImage imageNamed:@"myGoldIcon"],
                            [UIImage imageNamed:@"myGoldIcon"],
                            [UIImage imageNamed:@"myGoldIcon"],
                            [UIImage imageNamed:@"myGoldIcon"],
                            [UIImage imageNamed:@"myGoldIcon"],
                            [UIImage imageNamed:@"myGoldIcon"],
                            [UIImage imageNamed:@"myGoldIcon"],
                            [UIImage imageNamed:@"myGoldIcon"],
                            [UIImage imageNamed:@"noCashFromRedPacke@2x"],[UIImage imageNamed:@"myGoldIcon"],[UIImage imageNamed:@"noCashFromRedPacke"]
                            ];
        _lblTIshi.text = array[_cellType];
        _imgIcon.image = images[_cellType];
    }
}

- (void) refreshTableView
{
    [_MJRefreshCon refreshWithLoading];
}

//配置时间并排序
- (NSMutableArray*)configDateArray {
    
    //时间set
    NSMutableSet* dateSet = WEAK_OBJECT(NSMutableSet, init);
    WDictionaryWrapper* dataIndex = WEAK_OBJECT(WDictionaryWrapper, init);
    NSMutableArray* configedArray = WEAK_OBJECT(NSMutableArray, init);
    
    for (NSDictionary *dic in _MJRefreshCon.refreshData) {
        
        DictionaryWrapper *wrapper = dic.wrapper;
        
        //配置元素日期
        NSString *dateStr;
        if(_cellType == ExploitGoldConsume || _cellType == QT_MONEY)
        {
            NSArray *array = [[wrapper getString:@"Time"] componentsSeparatedByString:@" "];
            if ([array count] == 2) {
                
                dateStr = array[0];
            }
        }
        else
        {
            NSArray *array = [[wrapper getString:@"RecordTime"] componentsSeparatedByString:@"T"];
            if ([array count] == 2) {
                
                dateStr = array[0];
            }
        }
        
        //配置日期字典
        if ([dateSet containsObject:dateStr]) {
            
            NSMutableArray *multaTempArray = [dataIndex get:dateStr];
            NSArray *resultArray = [multaTempArray arrayByAddingObject:dic];
            [dataIndex set:dateStr value:resultArray];
        }else {
            
            [dateSet addObject:dateStr];
            [dataIndex set:dateStr value:[NSArray arrayWithObject:dic]];
        }
    }
    //配置结果数组
    for (NSString *string in dateSet) {
        
        WDictionaryWrapper *item = WEAK_OBJECT(WDictionaryWrapper, init);
        [item set:@"date" string:string];
        [item set:@"subArray" value:[dataIndex get:string]];
        [configedArray addObject:item.dictionary];
    }
    //原始数组 configedArray
    //排序
    NSSortDescriptor *sorter = WEAK_OBJECT(NSSortDescriptor, initWithKey:@"date" ascending:NO);//yes升序  no降序
    NSMutableArray *sortDescriptors = WEAK_OBJECT(NSMutableArray, initWithObjects:&sorter count:1);
    return [NSMutableArray arrayWithArray:[configedArray sortedArrayUsingDescriptors:sortDescriptors]];
}

#pragma mark - UITableViewDelegate/UITableViewDatasource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_cellType == AdvertConsume) {
        return 95;
    }
    else if (_cellType == GoldMarketMoney)
    {
        return 106;
    }else if (_cellType == DiscountGoldConsume || _cellType == RecruitmentGoldConsume || _cellType == InvestmentGoldConsume){
        IWGoldAdvertTableViewCell *iw_cell = [tableView dequeueReusableCellWithIdentifier:@"IWGoldAdvertTableViewCell"];
        
        NSArray *array = [[_dataArray[indexPath.section] wrapper] getArray:@"subArray"];
        DictionaryWrapper *dic = [array[indexPath.row] wrapper];
        return [iw_cell updateConstraintsSelf:dic Type:_cellType];
    }else if (_cellType == systemBonus){
        
        MyGoldSystemSendCell *cell = [MyGoldSystemSendCell newInstance];
        NSArray *array = [[_dataArray[indexPath.section] wrapper] getArray:@"subArray"];
         return [cell getCellHeight:[array[indexPath.row] wrapper]];
    }
    else {
        return 80;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 22;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = WEAK_OBJECT(UIView, initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 22));
    UILabel *lblTime = WEAK_OBJECT(UILabel, initWithFrame:CGRectMake(15, 0, SCREENWIDTH, 22));
    lblTime.font = Font(11);
    lblTime.textColor = AppColorGray153;
    lblTime.text = [[_dataArray[section] wrapper] getString:@"date"];
    lblTime.backgroundColor = [UIColor clearColor];
    [view addSubview:lblTime];
    view.backgroundColor = AppColor(247);
    
    return view;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _dataArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[_dataArray[section] wrapper] getArray:@"subArray"].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSArray *array = [[_dataArray[indexPath.section] wrapper] getArray:@"subArray"];
    
    BaseMyGoldCell *cell = [BaseMyGoldCell createCell:_cellType WithData:array[indexPath.row]];
    
    if (_cellType == AdvertConsume) {
        
        if ([array count] == indexPath.row +1)
        {
            RRLineView * line = [[RRLineView alloc] initWithFrame:CGRectMake(0, 94.5, 320, 0.5)];
            [cell.contentView addSubview:line];
        }
    }
    else if (_cellType == GoldMarketMoney)
    {
        if ([array count] == indexPath.row +1)
        {
            RRLineView * line = [[RRLineView alloc] initWithFrame:CGRectMake(0, 105.5, 320, 0.5)];
            [cell.contentView addSubview:line];
        }
    }
    else if(_cellType == DiscountGoldConsume || _cellType == RecruitmentGoldConsume || _cellType == InvestmentGoldConsume){
        IWGoldAdvertTableViewCell *iw_cell = [tableView dequeueReusableCellWithIdentifier:@"IWGoldAdvertTableViewCell"];
        
        DictionaryWrapper *dic = [array[indexPath.row] wrapper];
        
        
        
        [iw_cell updateConstraintsSelf:dic Type:_cellType];
        
        return iw_cell;
    }
    else if (_cellType == ExploitGoldConsume)
    {
        IWExploitTableViewCell *iw_cell = [tableView dequeueReusableCellWithIdentifier:@"IWExploitTableViewCell"];
        
        DictionaryWrapper *dic = [array[indexPath.row] wrapper];
        
        [iw_cell updateContent:dic];
        
        return iw_cell;
    }
//    else if (_cellType == QT_MONEY)
//    {
//        QTMoneyTableViewCell *iw_cell = [tableView dequeueReusableCellWithIdentifier:@"QTMoneyTableViewCell"];
//        
//        DictionaryWrapper *dic = [array[indexPath.row] wrapper];
//        
//        [iw_cell setDataDic:dic];
//        
//        return iw_cell;
//    }
    else if (_cellType == systemBonus)
    {
        MyGoldSystemSendCell *systemCell = (MyGoldSystemSendCell *)cell;
        [systemCell getCellHeight:[array[indexPath.row] wrapper]];
    }
    else {
        if ([array count] == indexPath.row +1)
        {
            RRLineView * line = [[RRLineView alloc] initWithFrame:CGRectMake(0, 79.5, 320, 0.5)];
            [cell.contentView addSubview:line];
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

#pragma mark - 事件
//获取上个月、下个月
- (NSString *)getMounthWithString:(NSString *)mounth  orDate:(NSDate *)date next:(BOOL)next{
    
    NSDate *curDate = nil;
    NSDateFormatter *formatter = WEAK_OBJECT(NSDateFormatter, init);
    [formatter setDateFormat:@"yyyy年MM月"];
    if (mounth.length) {
        curDate = [formatter dateFromString:mounth];
    } else {
        curDate = date;
    }
    
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *components = [cal components:NSMonthCalendarUnit | NSYearCalendarUnit fromDate:curDate];
    
    if (next) {
        //下个月
        [components setMonth:([components month] + 1)];
        NSDate *thisMonth = [cal dateFromComponents:components];
        return [formatter stringFromDate:thisMonth];
    } else {
        //上个月
        [components setMonth:([components month] - 1)];
        NSDate *lastMonth = [cal dateFromComponents:components];
        return [formatter stringFromDate:lastMonth];
    }
}

- (BOOL)checkAboveSixMonth:(NSString *)month{
    
    NSString *dateStr=month;
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSUInteger unitFlags = NSMonthCalendarUnit | NSDayCalendarUnit;
    NSDateFormatter *format=[[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy年MM月"];
    NSDate *fromdate=[format dateFromString:dateStr];
    NSTimeZone *fromzone = [NSTimeZone systemTimeZone];
    NSInteger frominterval = [fromzone secondsFromGMTForDate: fromdate];
    NSDate *fromDate = [fromdate  dateByAddingTimeInterval: frominterval];
    NSLog(@"fromdate=%@",fromDate);
    [format release];
    NSDate *date = _lastDate;
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: date];
    NSDate *localeDate = [date  dateByAddingTimeInterval: interval];
    NSLog(@"enddate=%@",localeDate);
    NSDateComponents *components = [gregorian components:unitFlags fromDate:fromDate toDate:localeDate options:0];
    NSInteger months = [components month];
    
    return months >= 6;
}

- (NSDate *)getFirstDay:(NSDate *)date{
    NSDate *now = date;
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *comps = [cal
                               components:NSYearCalendarUnit | NSMonthCalendarUnit
                               fromDate:now];
    comps.day = 1;
    NSDate *firstDay = [cal dateFromComponents:comps];
    return firstDay;
}

- (NSString *)formatDate:(NSDate *)date{
    self.day = [UICommon usaulFormatTime:[self getFirstDay:date] formatStyle:@"yyyy-MM-dd hh:mm:ss"];
    NSDateFormatter *formatter = WEAK_OBJECT(NSDateFormatter, init);
    [formatter setDateFormat:@"yyyy年MM月"];
    return [formatter stringFromDate:date];
}

- (NSDate *)formatDataStr:(NSString *)dateStr{
    NSDateFormatter *formatter = WEAK_OBJECT(NSDateFormatter, init);
    [formatter setDateFormat:@"yyyy年MM月"];
    NSDate *date = [formatter dateFromString:dateStr];
    return date;
}

//禁用右边button
- (BOOL)btnEnable{
    NSString *dateStr1 = [self getMounthWithString:_lblTime.text orDate:nil next:NO];
    NSString *dateStr2 = [self getMounthWithString:@"" orDate:_lastDate next:NO];
    if ([dateStr1 isEqualToString:dateStr2]) {
        return NO;
    }
    return YES;
}

//左
- (IBAction)leftClicked:(id)sender {
    NSString *dateStr = [self getMounthWithString:_lblTime.text orDate:nil next:NO];
    if ([self checkAboveSixMonth:dateStr]) {
        _btnLeft.enabled = NO;
        return;
    }
    _lblTime.text = dateStr;
    _btnRight.enabled = [self btnEnable];
    self.day = [UICommon usaulFormatTime:[self formatDataStr:dateStr] formatStyle:@"yyyy-MM-dd hh:mm:ss"];
    
    [self clearMoneyCount];
    
    _type = 0;
    _isResetFilter = YES;
    
    [self _initTableView];
}

- (void) clearMoneyCount
{
   NSArray *array = @[@"当月消耗 ", @"当月消耗 ", @"当月消耗 ", @"当月获赠 ", @"当月货款 ", @"当月获赠 ", @"当月收支 ", @"当月消耗 ", @"当月消耗 ", @"当月消耗 ",@"当月赚的 ",@"共计   ",@"当月共计 "];
    NSString *str = [NSString stringWithFormat:@"%@0.00广告金币",array[_cellType]];
    
    CGSize size = [UICommon getSizeFromString:str
                                     withSize:CGSizeMake(MAXFLOAT, 21)
                                     withFont:14];
    _lblSilver.width = size.width;
    NSAttributedString *attribute = [RRAttributedString setText:str
                                                          color:RGBCOLOR(240, 5, 0)
                                                          range:NSMakeRange(5, str.length - 5)];
    _lblSilver.attributedText = attribute;
    
    //是否显示冻结
    _lblDj.hidden = (_cellType == JingjiaADsConsume || _cellType == systemBonus || _cellType == GoldMarketMoney || _cellType == OtherIncome || _cellType == DiscountGoldConsume || _cellType == RecruitmentGoldConsume || _cellType == InvestmentGoldConsume || _cellType == ExploitGoldConsume || _cellType == GetBuyAdvertGold || _cellType == QT_MONEY);
    if (!_lblDj.hidden) {
        if(_cellType == AdvertConsume || _cellType == DuihuanProdConsume)
        {
            _helpBtn.hidden = NO;
            
            _lblDj.text = @"包含冻结 0.00广告金币";
        }
        else if(_cellType == LiutongRecord)
        {
            _lblDj.text = @"赠送 0.00广告金币";
        }
    }
}

//右
- (IBAction)rightClicked:(id)sender {
    _btnLeft.enabled = YES;
    NSString *dateStr = [self getMounthWithString:_lblTime.text orDate:nil next:YES];
    _lblTime.text = dateStr;
    _btnRight.enabled = [self btnEnable];
    self.day = [UICommon usaulFormatTime:[self formatDataStr:dateStr] formatStyle:@"yyyy-MM-dd hh:mm:ss"];
    
    [self clearMoneyCount];
    
    _type = 0;
    _isResetFilter = YES;
    
    [self _initTableView];
}
//求助问号
- (IBAction)helpClicked:(id)sender {
    if(_cellType == AdvertConsume)
        [AlertUtil showAlert:@"" message:@"冻结广告金币是商家用于广告播放时所需消耗的广告金币。若播放完毕后广告金币尚未使用完，则退回到该广告金币账户中。" buttons:@[@"我知道了"]];
    else if (_cellType == DuihuanProdConsume)
    {
        [AlertUtil showAlert:@"" message:@"广告冻结金币是用于易货时所需消耗的广告金币。若交易成功，则扣除广告金币；若申请退货，则退回到该广告金币账户中。" buttons:@[@"我知道了"]];
        
    }
}
//重新筛选
- (IBAction)reChooseClicked:(id)sender {
    _btnChoose.hidden = NO;
    [self chooseClicked:nil];
}
//筛选
- (IBAction)chooseClicked:(id)sender {
    if(_cellType == LiutongRecord)
    {
        if (!_appPopView)
        {
            __block typeof(self) weakSelf = self;
            _appPopView = [[AppPopView alloc] initWithAnimateUpOn:self frame:CGRectMake(0, 0, 320, _filterView.height) left:^{} right:^{
                [_appPopView show:NO];
                _isChoosed = YES;
                [weakSelf _initTableView];
            }];
            [_appPopView.contentView addSubview:_filterView];
            _appPopView.titleName = @"筛选";
        }
        [_appPopView show:YES];
        
    }
    else{
        if (!_appPopView)
        {
            __block typeof(self) weakSelf = self;
            _appPopView = [[AppPopView alloc] initWithAnimateUpOn:self frame:CGRectMake(0, 0, 320, _shooseView.height) left:^{} right:^{
                
                [weakSelf filterOkBtn];
                [_appPopView show:NO];
                _isChoosed = YES;
                [weakSelf _initTableView];
            }];
            [_appPopView.contentView addSubview:_shooseView];
            _appPopView.titleName = @"筛选";
        }
        [_appPopView show:YES];
    }
}

//筛选完成
- (void) filterOkBtn
{
    self.orderNumber = _orderNumField.text;
    
    self.userName = _phoneNumField.text;
}

//筛选选项
- (IBAction)itemClicked:(UIButton *)sender {
    _btnFront.selected = _btnMiddle.selected = _btnLast.selected = NO;
    sender.selected = YES;
    self.type = (int)sender.tag;
    _isResetFilter = NO;
}

#pragma mark - 内存管理
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc {
    [_appPopView release];
    [_MJRefreshCon release];
    [_day release];
    [_tableView release];
    [_lblSilver release];
    [_lblDj release];
    [_lblTime release];
    [_btnLeft release];
    [_btnRight release];
    [_btnFront release];
    [_btnMiddle release];
    [_btnLast release];
    [_filterView release];
    
    [_shooseView release];
    [_imgIcon release];
    [_lblTIshi release];
    [_btnRefresh release];
    [_hoverView release];
    [_btnChoose release];
    [_helpBtn release];
    [_orderNumField release];
    [_phoneNumField release];
    [_line release];
    [_topView release];
    [_topImg release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setTableView:nil];
    [self setLblSilver:nil];
    [self setLblDj:nil];
    [self setLblTime:nil];
    [self setBtnLeft:nil];
    [self setBtnRight:nil];
    [self setBtnFront:nil];
    [self setBtnMiddle:nil];
    [self setBtnLast:nil];
    [self setFilterView:nil];
    
    [self setShooseView:nil];
    [self setImgIcon:nil];
    [self setLblTIshi:nil];
    [self setBtnRefresh:nil];
    [self setHoverView:nil];
    [self setBtnChoose:nil];
    [super viewDidUnload];
}
@end
