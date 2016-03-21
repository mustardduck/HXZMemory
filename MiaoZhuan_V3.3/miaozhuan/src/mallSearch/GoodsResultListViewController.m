//
//  GoodsResultListViewController.m
//  miaozhuan
//
//  Created by 孙向前 on 15-3-11.
//  Copyright (c) 2015年 zdit. All rights reserved.
//

#import "GoodsResultListViewController.h"
#import "Preview_Commodity.h"
#import "CRSliverDetailViewController.h"
#import "MallGoodsCell.h"
#import "AppPopView.h"
#import "CRFlatButton.h"

@interface GoodsResultListViewController ()

@property (nonatomic, retain) NSMutableArray *dataArray;
@property (nonatomic, retain) NSMutableArray *tempDataArray;

@property (nonatomic, retain) AppPopView *pView;
@property (nonatomic, assign) BOOL isFirst;
@property (nonatomic, copy) NSString *minPrice;
@property (nonatomic, copy) NSString *maxPrice;
@property (nonatomic, assign) BOOL isOnlyVip;
@property (nonatomic, assign) int goodsType;
@property (nonatomic, assign) BOOL sortBySales;

@property (retain, nonatomic) IBOutlet UITableView *tableview;
@property (retain, nonatomic) IBOutlet UIView *resultsView;
@property (retain, nonatomic) IBOutlet UIView *noResultView;
@property (retain, nonatomic) IBOutlet UIButton *btnOrder;
@property (retain, nonatomic) IBOutlet UIButton *btnChoose;
@property (retain, nonatomic) IBOutlet UILabel *lblKeyWord;
@property (retain, nonatomic) IBOutlet UILabel *lblTotal;

@property (retain, nonatomic) IBOutlet UIView *chooseView;
@property (retain, nonatomic) IBOutlet UITextField *txtMaxPrice;
@property (retain, nonatomic) IBOutlet UITextField *txtMinPrice;

@end

@implementation GoodsResultListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigateTitle:@"搜索结果"];
    [self  setupMoveBackButton];
    
    self.dataArray = [NSMutableArray arrayWithCapacity:0];
    self.tempDataArray = [NSMutableArray arrayWithCapacity:0];
    
    _lblKeyWord.text = [NSString stringWithFormat:@"当前搜索:%@",_keyWord];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)loadData {
    
}

#pragma mark - UITableViewDelegate/UITableViewDatasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 110;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"Cell";
    MallGoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MallGoodsCell" owner:self options:nil] firstObject];
    }
    cell.dataDic = [_dataArray[indexPath.row] wrapper];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BOOL isGold = ([[_dataArray[indexPath.row] wrapper] getInt:@"ProductType"] == 2);
    if (isGold) {
        PUSH_VIEWCONTROLLER(Preview_Commodity);
        model.whereFrom = 1;
        model.productId = [[_dataArray[indexPath.row] wrapper] getInt:@"Id"];
    } else {
        PUSH_VIEWCONTROLLER(CRSliverDetailViewController);
        model.productId = [[_dataArray[indexPath.row] wrapper] getInt:@"Id"];
        model.advertId = [[_dataArray[indexPath.row] wrapper] getInt:@"AdvertId"];
    }
}

#pragma mark - actions
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
            
            if (!_txtMinPrice.text.length ) {
                [HUDUtil showErrorWithStatus:@"请输入起始价格"];return;
            }
            
            if (!_txtMaxPrice.text.length ) {
                [HUDUtil showErrorWithStatus:@"请输入终止价格"];return;
            }
            
            self.minPrice = _txtMinPrice.text.length ? _txtMinPrice.text : @"0";
            self.maxPrice = _txtMaxPrice.text.length ? _txtMaxPrice.text : @"0";
            
            if ([_minPrice floatValue] > [_maxPrice floatValue]) {
                [HUDUtil showErrorWithStatus:@"终止价格必须大于起始价格"];return;
            }
            
            [weakself.btnChoose setSelected:NO];
            [weakself.pView show:NO];
            [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
            
//            [weakself sendRequest];
        }];
        _pView.titleName = @"筛选";
        [_pView.contentView addSubview:_chooseView];
    }
    [APP_DELEGATE.window addSubview:_pView];
    [_pView show:YES];
}
//按销量排序
- (IBAction)orderBySale:(UIButton *)sender {
    _isFirst = NO;
    _btnOrder.selected = !_btnOrder.selected;
    self.sortBySales = _btnOrder.selected;
    NSMutableArray *temp = [NSMutableArray arrayWithArray:_tempDataArray];
    if (_btnOrder.selected) {
        
    } else {
        self.dataArray = self.tempDataArray;
    }
    [self.tableview reloadData];
}

#warning 3.1新增需求 （筛选功能需求改变）
//商品
- (IBAction)flatValueChanged:(CRFlatButton *)sender {
   self.goodsType = sender.selectedSegmentIndex;
}
//商家
- (IBAction)shopValueChanged:(CRFlatButton *)sender {
    NSInteger index = sender.selectedSegmentIndex;
    self.isOnlyVip = index;
}
//无数据
- (void)showViewWhenNoResults{
    _tableview.hidden = _resultsView.hidden = YES;
    _noResultView.hidden = NO;
}
//帅选商品
- (NSArray *)screeningData:(NSArray *)data
                 goodsType:(int)goodsType
                  shopType:(int)shopType
                  minPrice:(double)minPrice
                  maxPrice:(double)maxPrice {
    
    if (data.count) {
        return nil;
    }
    
    NSMutableArray *priceData = [NSMutableArray arrayWithCapacity:0];
    //筛选价格
    if (minPrice || maxPrice) {
        for (DictionaryWrapper *dic in data) {
            if ([dic getInt:@""]) {
                
            }
        }
    }
    
    return nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)dealloc {
    [_dataArray release];
    [_tempDataArray release];
    [_maxPrice release];
    [_minPrice release];
    [_btnOrder release];
    [_btnChoose release];
    [_lblKeyWord release];
    [_lblTotal release];
    [_txtMaxPrice release];
    [_txtMinPrice release];
    [_chooseView release];
    [_tableview release];
    [_resultsView release];
    [_noResultView release];
    [super dealloc];
}
@end
