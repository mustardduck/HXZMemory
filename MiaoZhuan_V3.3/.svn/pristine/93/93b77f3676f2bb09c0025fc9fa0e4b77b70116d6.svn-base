//
//  MerchantListViewController.m
//  miaozhuan
//
//  Created by 孙向前 on 14-11-3.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "MerchantListViewController.h"
#import "MJRefreshController.h"
#import "BaseMerchatCell.h"
#import "OrderViewController.h"
#import "BaserHoverView.h"
#import "AppPopView.h"
#import "MJRefreshController.h"
#import "RRNavBarDrawer.h"
#import "AdsDetailViewController.h"
#import "CRSliverDetailViewController.h"
#import "Preview_Commodity.h"

#import "PutInCell.h"
#import "SilverGoodsCell.h"
#import "GoldGoodsCell.h"
#import "kxMenu.h"

@interface MerchantListViewController ()<UITextFieldDelegate, RRNavBarDrawerDelegate>{
    RRNavBarDrawer *navBarDrawer;
    /** 是否已打开抽屉 */
    BOOL _isOpen;
}

@property (retain, nonatomic) IBOutlet UITableView *tableview;
@property (retain, nonatomic) IBOutlet UIButton *btnTime;
@property (retain, nonatomic) IBOutlet UIButton *btnPrice;
@property (retain, nonatomic) IBOutlet UIView *priceView;
@property (retain, nonatomic) IBOutlet CommonTextField *txtMinPrice;
@property (retain, nonatomic) IBOutlet CommonTextField *txtMaxPrice;
@property (retain, nonatomic) IBOutlet UIView *headerView;
@property (retain, nonatomic) IBOutlet RRLineView *topline;

@property (nonatomic, retain) BaserHoverView *hover;
@property (nonatomic, retain) AppPopView *pView;
@property (nonatomic, retain) OrderViewController *orderview;//时间排序视图
@property (retain, nonatomic) IBOutlet UIView *resetView;

@property (nonatomic, retain) MJRefreshController *MJRefreshCon;
@property (assign, nonatomic) int orderType;

@end

@implementation MerchantListViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setExtraCellLineHidden:self.tableview];
}

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _line.width = 0.5;
    _topline.top = 39.5;
    
    _txtMaxPrice.clearButtonMode = _txtMinPrice.clearButtonMode = UITextFieldViewModeNever;
    
    [self setNavigateTitle:_titleName];
    [self setupMoveBackButton];
    
    [self setupMoveFowardButtonWithImage:@"more.png" In:@"morehover.png"];
    
    NSArray *array = @[@{@"normal":@"ads_home",@"hilighted":@"ads_homehover",@"title":@"首页"}];
    
    navBarDrawer = STRONG_OBJECT(RRNavBarDrawer, initWithView:self.view andInfoArray:array);
    navBarDrawer.delegate = self;
    
    if (![_type intValue]) {
        _headerView.hidden = YES;
        _tableview.frame = self.view.frame;
    }
    
    NSString * refreshName = [self getUrlByOrderType:_type];
    
    [_MJRefreshCon release];
    _MJRefreshCon = nil;
    _MJRefreshCon = [[MJRefreshController controllerFrom:_tableview name:refreshName] retain];
    
    [self initTableView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getRequestData:) name:@"orderbytime" object:nil];
}

- (void)createMenu{
    
}

#pragma mark - RRNavBarDrawerDelegate
/** 关闭按钮 代理回调方法 */
- (void)didClickItem:(RRNavBarDrawer *)drawer atIndex:(NSInteger)index{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction) onMoveFoward:(UIButton*) sender{
    _isOpen = !_isOpen;
    if (!_isOpen) {
        [navBarDrawer openNavBarDrawer];
    } else {
        [navBarDrawer closeNavBarDrawer];
    }
}

- (void)getRequestData:(NSNotification *)noti{
    NSLog(@"%@",noti.object);
    NSArray *infos = noti.object;
    [_btnTime setTitle:infos[1] forState:UIControlStateNormal];
    CGSize size = [UICommon getSizeFromString:infos[1] withSize:CGSizeMake(MAXFLOAT, 21) withFont:15];
    [_btnTime setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -(size.width * 2 + 30))];
    
    if ([_orderview.view superview]) {
        [_orderview.view removeFromSuperview];
    }
    _btnTime.selected = NO;
    
    _orderType = [noti.object[0] intValue];
    
    [self initTableView];//刷新表格
}

- (void)initTableView
{
    NSString * refreshName = [self getUrlByOrderType:_type];
    __block __typeof(self)weakself = self;
    
    __block NSString *min = _txtMinPrice.text.length ? _txtMinPrice.text : @"0";
    __block NSString *max = _txtMaxPrice.text.length ? _txtMaxPrice.text : @"0";
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:@{@"service":[NSString stringWithFormat:@"%@%@", @"api/", refreshName]}];
    
    [_MJRefreshCon setURLGenerator:MJREFRESH_URL_GENERATOR_BLOCK{
        
        switch ([weakself.type intValue]) {
            case 0:
                [dic setValue:@{@"EnterpriseId":weakself.enId, @"PageIndex":@(pageIndex), @"PageSize":@(pageSize)} forKey:@"parameters"];
                break;
            case 1:
            case 2:
            case 3:
                [dic setValue:@{@"EnterpriseId":weakself.enId, @"MinPrice":min, @"MaxPrice":max, @"OrderType":@(weakself.orderType), @"PageIndex":@(pageIndex), @"PageSize":@(pageSize)} forKey:@"parameters"];
                break;
            default:
                break;
        }
        return dic.wrapper;
    }];
    
    MJRefreshOnRequestDone block = MJREFRESH_ON_REQUEST_DONE
    {
        [weakself createHoverViewWhenNoData];
        if(controller.refreshCount > 0)
        {
            weakself.headerView.hidden = NO;
            weakself.tableview.hidden = NO;
            _resetView.hidden = YES;
        }
        else
        {
            [weakself.tableview reloadData];
        }
    };
    
    [_MJRefreshCon setOnRequestDone:block];
    [_MJRefreshCon setPageSize:30];
    
    [self refreshTableView];
}

- (void) refreshTableView
{
    [_MJRefreshCon refreshWithLoading];
}

#pragma mark - 数据请求
- (NSString *)getUrlByOrderType:(NSString *)type{
    switch ([_type intValue]) {
        case 0:
            return @"Enterprise/GetPlayingAdverts";
            break;
        case 1:
            return @"Enterprise/GetSilverProducts";
            break;
        case 2:
            return @"Enterprise/GetGoldProducts";
            break;
        case 3:
            return @"Enterprise/GetDirectBuyProducts";
            break;
        default:
            return @"";
            break;
    }
}

#pragma mark - UITableViewDelegate/UITableViewDatasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [_type intValue] ? 110 : 145;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _MJRefreshCon.refreshCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier;
    identifier = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    BaseMerchatCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [BaseMerchatCell createCell:[_type integerValue] WithData:[_MJRefreshCon dataAtIndex:(int)indexPath.row]];
    }
    
    switch ([_type intValue]) {
        case 0:
        {
            if (indexPath.row == _MJRefreshCon.refreshCount - 1) {
                
                ((PutInCell *)cell).line.top = 144.5;
                ((PutInCell *)cell).line.left = 0;
                
            } else {
                ((PutInCell *)cell).line.top = 144.5;
                ((PutInCell *)cell).line.left = 15;
            }
        }
            
            break;
        case 1:
        {
            if (indexPath.row == _MJRefreshCon.refreshCount - 1) {
                ((SilverGoodsCell *)cell).line.top = 109.5;
                ((SilverGoodsCell *)cell).line.left = 0;
                
            } else {
                ((SilverGoodsCell *)cell).line.top = 109.5;
                ((SilverGoodsCell *)cell).line.left = 15;
            }
        }
            break;
        case 2:
        {
            if (indexPath.row == _MJRefreshCon.refreshCount - 1) {
                ((GoldGoodsCell *)cell).line.top = 109.5;
                ((GoldGoodsCell *)cell).line.left = 0;

                
            } else {
                ((GoldGoodsCell *)cell).line.top = 109.5;
                ((GoldGoodsCell *)cell).line.left = 15;
            }
        }
            break;
        case 3:
            
            break;
        default:
            break;
    }

    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    DictionaryWrapper *dic = [_MJRefreshCon dataAtIndex:(int)indexPath.row];
    switch ([_type intValue]) {
        case 0:
            //投放中广告
        {

            PUSH_VIEWCONTROLLER(AdsDetailViewController);
            model.adId = [[dic wrapper] getString:@"Id"];
            model.isMerchant = YES;
            model.notShow = YES;
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
            //直购广告
            break;
        default:
            break;
    }
}

#pragma mark - 事件
-(void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = WEAK_OBJECT(UIView, initWithFrame:CGRectZero);
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}
//headerview
- (void)createPriceview{
    
    __block MerchantListViewController *weakself = self;
    if (!_pView) {
        NSLog(@"%@",NSStringFromCGRect(_priceView.bounds));
        _pView = [[AppPopView alloc] initWithAnimateUpOn:self frame:_priceView.bounds left:AppPopBlock{
            [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
            _btnPrice.selected = NO;
        } right:AppPopBlock{
            [weakself initTableView];
            [weakself.pView show:NO];
            _btnPrice.selected = NO;
            [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
        }];
        _pView.titleName = @"价格筛选";
        [_pView.contentView addSubview:_priceView];
    }
    [APP_DELEGATE.window addSubview:_pView];
    [_pView show:YES];
}
//无数据hoverview
- (void)createHoverViewWhenNoData{
    
    if ([_type intValue]) {
        _resetView.hidden = NO;
    } else {
        if ([_hover superview]) {
            [_hover removeFromSuperview];
        }
        if (_MJRefreshCon.refreshCount) {
            return;
        }
        _hover = nil;
        _hover = STRONG_OBJECT(BaserHoverView, initWithTitle:@"抱歉" message:@"没有符合条件的广告，请重新筛选");
        _hover.frame = CGRectMake(0, 40, SCREENWIDTH, self.view.bounds.size.height - 40);
        [self.view addSubview:_hover];
    }
    
}
//点击排序弹出对应的弹框
- (IBAction)orderByTime:(UIButton *)sender {
    
    if ([sender isEqual:_btnTime]) {
        _btnPrice.selected = NO;
        sender.selected = !sender.selected;
        if (sender.selected) {
            if (!_orderview) {
                _orderview = STRONG_OBJECT(OrderViewController, init);
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBg:)];
                [_orderview.hview addGestureRecognizer:tap];
            }
            
            _orderview.dataArray = @[@"时间排序",@"销售排序",@"收藏排序",@"价格从低到高",@"价格从高到低"];
            _orderview.view.frame = /*_type ? self.view.bounds : */CGRectMake(0.f, 40.f, SCREENWIDTH, _orderview.view.height);
            [self.view addSubview:_orderview.view];
        } else{
            if ([_orderview.view superview]) {
                [_orderview.view removeFromSuperview];
            }
        }
        
    } else {//价格排序
        _btnTime.selected = NO;
        if ([_orderview.view superview]) {
            [_orderview.view removeFromSuperview];
        }
        sender.selected = !sender.selected;
        [self createPriceview];
    }
    
}

- (void)tapBg:(id)sender{
    _btnTime.selected = NO;
    if ([_orderview.view superview]) {
        [_orderview.view removeFromSuperview];
    }
}

- (IBAction)resetClicked:(id)sender {
    [self orderByTime:_btnPrice];
}

#pragma makr - uitextfiled delegate
- (void)textFieldDidEndEditing:(UITextField *)textField{
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    return YES;
}

#pragma mark - 内存管理

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_hover release];
    [_titleName release];
    [_enId release];
    [_type release];
    [_MJRefreshCon release];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [_orderview release];
    [_tableview release];
    [_btnTime release];
    [_btnPrice release];
    [_priceView release];
    [_txtMinPrice release];
    [_txtMaxPrice release];
    [_pView release];
    [_headerView release];
    [_line release];
    [_topline release];
    [_resetView release];
    [super dealloc];
}
@end
