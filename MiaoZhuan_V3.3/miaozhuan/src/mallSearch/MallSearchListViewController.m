//
//  MallSearchListViewController.m
//  miaozhuan
//
//  Created by 孙向前 on 14-12-26.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "MallSearchListViewController.h"
#import "MJRefreshController.h"
#import "BaseMallCell.h"
#import "BaserHoverView.h"
#import "AppPopView.h"
#import "MallRecommondCell.h"
#import "MerchantDetailViewController.h"
#import "Preview_Commodity.h"
#import "CRSliverDetailViewController.h"
#import "CRFlatButton.h"

typedef enum : NSUInteger {
    GAll = 0,
    GSilver,
    GGold,
} GoodsType;

typedef enum : NSUInteger {
    SAll = 0,
    SVip,
} ShopType;

@interface MallSearchListViewController ()<UITableViewDataSource, UITableViewDelegate>{
    
}
@property (retain, nonatomic) IBOutlet UIView *headerview;

@property (retain, nonatomic) IBOutlet UIView *orview;
@property (retain, nonatomic) IBOutlet UILabel *lblKeyWord;
@property (retain, nonatomic) IBOutlet UILabel *lblTotal;
@property (retain, nonatomic) IBOutlet UIButton *btnOrder;
@property (retain, nonatomic) IBOutlet UIButton *btnChoose;
@property (retain, nonatomic) IBOutlet UITableView *tableView;
@property (retain, nonatomic) IBOutlet UIView *topView;
@property (retain, nonatomic) IBOutlet UIView *goodErrorView;
@property (retain, nonatomic) IBOutlet UIView *shopErrorView;
@property (retain, nonatomic) IBOutlet UIImageView *line;

@property (nonatomic, retain) MJRefreshController *MJRefreshCon;

@property (nonatomic, retain) AppPopView *pView;
@property (retain, nonatomic) IBOutlet UIView *chooseView;
@property (retain, nonatomic) IBOutlet UITextField *txtMaxPrice;
@property (retain, nonatomic) IBOutlet UITextField *txtMinPrice;

@property (nonatomic, copy) NSString *onlyVip;
@property (nonatomic, copy) NSString *sortBySales;
@property (nonatomic, copy) NSString *filteByPrice;
@property (nonatomic, copy) NSString *minPrice;
@property (nonatomic, copy) NSString *maxPrice;
@property (nonatomic, copy) NSString *productFilter;
@property (nonatomic, assign) BOOL isFirst;
@property (retain, nonatomic) IBOutlet UILabel *lblReach;
@end

@implementation MallSearchListViewController

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigateTitle:@"搜索结果"];
    [self  setupMoveBackButton];
    
    _lblKeyWord.text = [NSString stringWithFormat:@"当前搜索:%@",_keyWord];
    
    self.productFilter = @"0";
    self.maxPrice = @"0";
    self.minPrice = @"0";
    self.onlyVip = @"false";
    self.sortBySales = @"false";
    self.filteByPrice = @"false";
    
    [self _initTableView];
    [self changePosition];
    
    _lblReach.textColor = AppColor(204);
    _line.width = 0.5;
    
    _isFirst = YES;
    
//    _txtMaxPrice.enabled = _txtMinPrice.enabled = NO;
}

- (void)_initTableView{
    
    [_MJRefreshCon release];
    _MJRefreshCon = nil;
    
    NSString *refreshName = [self getRefreshNameByType];
    self.MJRefreshCon = [MJRefreshController controllerFrom:_tableView name:refreshName];
//    _tableView.panGestureRecognizer.delaysTouchesBegan = YES;

    [self sendRequest];
//    [self setExtraCellLineHidden:_tableView];
}

- (void)changePosition{
    if (!_type) {
        _orview.hidden = NO;
        _tableView.top = 40;
        _topView.height = 70;
        _tableView.height -= 40;
    }
}

- (void)sendRequest{
    
    __block typeof(self) weakSelf = self;
    
    [_MJRefreshCon setURLGenerator:MJREFRESH_URL_GENERATOR_BLOCK{
        
        
        NSDictionary * dic = nil;
        if (weakSelf.type == 1) {
            dic = @{@"PageIndex":@(pageIndex), @"PageSize":@(pageSize), @"Keyword":weakSelf.keyWord};
        } else if (!weakSelf.type) {
            
            dic = @{@"PageIndex":@(pageIndex), @"PageSize":@(pageSize), @"Keyword":weakSelf.keyWord, @"SortBySales":weakSelf.sortBySales, @"OnlyVip":weakSelf.onlyVip, @"FilteByPrice":weakSelf.filteByPrice, @"MinPrice":weakSelf.minPrice, @"MaxPrice":weakSelf.maxPrice, @"ProductFilter":weakSelf.productFilter};
        } else {
            dic = @{@"PageIndex":@(pageIndex), @"PageSize":@(pageSize)};
        }
        
        NSDictionary *pramaDic= @{@"service":[NSString stringWithFormat:@"api/%@",[weakSelf getRefreshNameByType]],@"parameters":dic};
        return pramaDic.wrapper;
    }];
    
    MJRefreshOnRequestDone block = MJREFRESH_ON_REQUEST_DONE
    {
        NSLog(@"%@",netData.dictionary);
        
        if (!netData.data || [netData.data isKindOfClass:[NSNull class]]) {
            return;
        }
        
        int totalCount = [[netData getDictionaryWrapper:@"Data"] getInt:@"ExtraData"];
        weakSelf.lblTotal.text = [NSString stringWithFormat:@"%d个相关结果", totalCount];
        if(controller.refreshCount > 0){
            weakSelf.topView.hidden = NO;
            
            UIView *view = [weakSelf.view viewWithTag:1000000];
            if ([view superview]) {
                [view removeFromSuperview];
            }
            if (!weakSelf.type) {
                weakSelf.isFirst = YES;
            }
            weakSelf.tableView.hidden = NO;
        } else {
            if (weakSelf.type) {
                //商家
                weakSelf.shopErrorView.hidden = NO;
                if (weakSelf.isFirst) {
                    //推荐商家
                    _headerview.height = 0;
                    [_tableView setTableHeaderView:_headerview];
                    _tableView.tableHeaderView = _headerview;
                    _tableView.tableHeaderView.height = _headerview.height = 0;
                    
                    weakSelf.type = 2;
                    _tableView.top = _shopErrorView.height;
                    _tableView.height = self.view.height - _shopErrorView.height;
                    [weakSelf sendRequest];
                    weakSelf.isFirst = NO;
                } else {
                    weakSelf.topView.hidden = weakSelf.tableView.hidden = YES;
                    return;
                }
            } else {
                if (weakSelf.isFirst) {
                    //第一次进入
                    weakSelf.goodErrorView.hidden = NO;
                    weakSelf.topView.hidden = YES;
                    weakSelf.topView.hidden = weakSelf.tableView.hidden = YES;
                    return;
                } else {
                    UIView *view = [weakSelf.view viewWithTag:1000000];
                    if ([view superview]) {
                        return;
                    }
                    BaserHoverView *hover = WEAK_OBJECT(BaserHoverView, initWithTitle:@"" message:@"没有符合条件的商品，请重新筛选");
                    hover.lblTitle.hidden = YES;
                    hover.lblMessage.top = hover.imgView.bottom + 20;
                    hover.frame = CGRectMake(weakSelf.tableView.left, weakSelf.tableView.top + 30, weakSelf.tableView.width, weakSelf.tableView.height);
                    hover.tag = 1000000;
                    [weakSelf.view addSubview:hover];
                }
            }
        }
    };
    
    [_MJRefreshCon setOnRequestDone:block];
    [_MJRefreshCon setPageSize:50];
    
    [self refreshTableView];
    
}

- (NSString *)getRefreshNameByType{
    return @[@"Mall/SearchProduct",@"Mall/SearchEnterprise",@"Enterprise/GetRecommendList"][_type];
}

- (void) refreshTableView
{
    [_MJRefreshCon refreshWithLoading];
}

#pragma mark - 事件
-(void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = WEAK_OBJECT(UIView, initWithFrame:CGRectZero);
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}

#pragma mark - UITableViewDelegate/UITableViewDatasource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_type == 2) {
        UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
        return cell.height;
    } else {
        return 110;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _MJRefreshCon.refreshCount;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"Cell";
    BaseMallCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
       cell = [BaseMallCell createCell:_type withData:[_MJRefreshCon dataAtIndex:(int)indexPath.row]];
    }
    if (_type == 2) {
        DictionaryWrapper *dataDic = [_MJRefreshCon dataAtIndex:(int)indexPath.row];
        if ([[dataDic getArray:@"GoldProducts"] count] || [[dataDic getArray:@"SilverProducts"] count]) {
            ((MallRecommondCell *)cell).shopVIew.hidden = NO;
            ((MallRecommondCell *)cell).hoverview.hidden = YES;
        } else {
            ((MallRecommondCell *)cell).shopVIew.hidden = YES;
            ((MallRecommondCell *)cell).hoverview.hidden = NO;
        }
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DictionaryWrapper *dataDic = [_MJRefreshCon dataAtIndex:(int)indexPath.row];
    switch (_type) {
        case 0:
        {
            BOOL isGold = ([dataDic getInt:@"ProductType"] == 2);
            if (isGold) {
                PUSH_VIEWCONTROLLER(Preview_Commodity);
                model.whereFrom = 1;
                model.productId = [dataDic getInt:@"Id"];
            } else {
                PUSH_VIEWCONTROLLER(CRSliverDetailViewController);
                model.productId = [dataDic getInt:@"Id"];
                model.advertId = [dataDic getInt:@"AdvertId"];
            }
            
        }
            break;
        case 1:
        {
            PUSH_VIEWCONTROLLER(MerchantDetailViewController);
            model.enId = [dataDic getString:@"Id"];
            model.comefrom = @"0";
        }
           
            break;
        default:
        {
            PUSH_VIEWCONTROLLER(MerchantDetailViewController);
            model.enId = [dataDic getString:@"EnterpriseId"];
            model.comefrom = @"0";
        }
            break;
    }
}

#pragma mark - 事件
//销量排序
- (IBAction)orderBySalledNumClicked:(id)sender {
    _isFirst = NO;
    _btnOrder.selected = !_btnOrder.selected;
    self.sortBySales = _btnOrder.selected ? @"true" : @"false";
    [self sendRequest];
}
//筛选
- (IBAction)chooseButtonClicked:(id)sender {
    _isFirst = NO;
    _btnChoose.selected = YES;
    [self createPriceview];
}
//headerview
- (void)createPriceview{
    
    __block typeof(self) weakself = self;
    if (!_pView) {
        _pView = [[AppPopView alloc] initWithAnimateUpOn:self frame:_chooseView.bounds left:AppPopBlock{
            [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
            [weakself.btnChoose setSelected:NO];
        } right:AppPopBlock{
            
            _minPrice = _txtMinPrice.text.length ? _txtMinPrice.text : @"0";
            _maxPrice = _txtMaxPrice.text.length ? _txtMaxPrice.text : @"0";
            
            if ([_minPrice intValue] || [_maxPrice intValue]) {
                self.filteByPrice = @"true";
            } else {
                self.filteByPrice = @"flase";
            }
            
            [weakself.btnChoose setSelected:NO];
            [weakself.pView show:NO];
            [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
            
            [weakself sendRequest];
        }];
        _pView.titleName = @"筛选";
        [_pView.contentView addSubview:_chooseView];
    }
    [APP_DELEGATE.window addSubview:_pView];
    [_pView show:YES];
}

//商品
- (IBAction)flatValueChanged:(CRFlatButton *)sender {
    NSInteger index = sender.selectedSegmentIndex;
    self.productFilter = [NSString stringWithFormat:@"%d",index];
}
//商家
- (IBAction)shopValueChanged:(CRFlatButton *)sender {
    NSInteger index = sender.selectedSegmentIndex;
    self.onlyVip = index ? @"true" : @"false";
}


#pragma mark - 内存管理
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc {
    [_productFilter release];
    [_sortBySales release];
    [_onlyVip release];
    [_filteByPrice release];
    [_minPrice release];
    [_maxPrice release];
    [_keyWord release];
    [_lblKeyWord release];
    [_lblTotal release];
    [_btnOrder release];
    [_btnChoose release];
    [_tableView release];
    [_topView release];
    [_txtMinPrice release];
    [_txtMaxPrice release];
    [_line release];
    [_lblReach release];
    [_orview release];
    [_headerview release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setLblKeyWord:nil];
    [self setLblTotal:nil];
    [self setBtnOrder:nil];
    [self setBtnChoose:nil];
    [self setTableView:nil];
    [self setTopView:nil];
    [self setTxtMinPrice:nil];
    [self setTxtMaxPrice:nil];
    [self setLine:nil];
    [self setLblReach:nil];
    [self setOrview:nil];
    [self setHeaderview:nil];
    [super viewDidUnload];
}
@end
