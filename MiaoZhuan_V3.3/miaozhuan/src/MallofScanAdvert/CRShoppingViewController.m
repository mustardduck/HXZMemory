//
//  CRShoppingViewController.m
//  miaozhuan
//
//  Created by abyss on 14/12/19.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "CRShoppingViewController.h"
#import "CRShoppingSupport.h"
#import "MJRefreshController.h"
#import "CRShoppingTableViewCell.h"
#import "CRSliverDetailViewController.h"
#import "AppPopView.h"
#import "ProductMsgViewController.h"
#import "Preview_Commodity.h"
#import "CRHolderView.h"

@interface CRShoppingViewController ()<CRShoppingSupportDeledate,UITableViewDataSource,UITableViewDelegate>
{
    DictionaryWrapper*      _yinWrapper;
    DictionaryWrapper*      _jinWrapper;
    
    CGFloat                 _cellHeight;
    AppPopView*             _appPopView;
    MJRefreshController*    _MJRefreshCon;
    
    BOOL                    _isNotFirst;
    BOOL                    _pageCount;
    
    UIButton*               _holderPrice;
    UIView*                 _holder;
}
@property (retain, nonatomic) IBOutlet UIView *ll2;
@property (retain, nonatomic) IBOutlet UIView *ll1;
@property (retain, nonatomic) IBOutlet UIView *holder;
@property (retain, nonatomic) AppPopView *appPopView;
@property (retain, nonatomic) CRShoppingSupport* supportor;
@property (retain, nonatomic) IBOutlet UIView *goldView;
@property (retain, nonatomic) IBOutlet UIButton *sort;
@property (retain, nonatomic) IBOutlet UIButton *sortSell;
@property (retain, nonatomic) IBOutlet UIButton *sortPrice;

@property (retain) NSString* refreshName;
@property (retain, nonatomic) IBOutlet UIButton *topButton;
@property (retain, nonatomic) IBOutlet UIView *popView;

@end

CRMJRefreshFastViewControllerImplementation(CRShoppingViewController,CRShoppingTableViewCell)

- (void)dealloc
{
    CRDEBUG_DEALLOC();
    
    [_viewArray release];
    [_tableView release];
    [_supportor release];
    [_yinWrapper release];
    [_jinWrapper release];
    [_MJRefreshCon release];
    
    [super dealloc];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    _pageCount ++;
    [MTA trackPageViewBegin:NSStringFromClass([self class])];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    if (_pageCount > 0)
    {
        [MTA trackPageViewEnd:NSStringFromClass([self class])];
        _pageCount --;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    _tableView      = [[UITableView alloc] init];
    _supportor      = [[CRShoppingSupport alloc] init];
    _supportor.startPage = _startPage;
    
    {
        _cellHeight   = 110;
        
        self.Province = @"";
        self.City     = @"";
        self.District = @"";
        
        _minYinPoint  = -1;
        _maxYinPoint  = -1;
        _minJinPoint  = -1;
        _maxJinPoint  = -1;
        
        _ll1.width = .5f;
        _ll2.width = .5f;
    }
    
    __block CRShoppingViewController* weakself = self;
    [_supportor setHeaderView];
    [_supportor setSelectTable];
    [_supportor setFather:weakself];
    [_supportor setContentSection];
    [_supportor setCr_delegate:self];
    {
        UIView* view = WEAK_OBJECT(UIView, initWithFrame:CGRectMake(0, _goldView.height - 0.5, 320, 0.5));
        view.backgroundColor = AppColor(204);
        [_goldView addSubview:view];
    }
    [_supportor setGoldHeaderp:_goldView];

    //configureTableView
    {
        _tableView  = [_supportor configureTableView:_tableView];
        [self configureTableView];
        [_tableView setFrame:CGRectMake(0, 40.5, 320, SCREENHEIGHT - 50 - 43 - 60)];
        [self.view addSubview:_tableView];
    }
    
    [self configureGoldView];
    
    [self.view addSubview:(UIView *)_supportor.headerView];
}

- (void)configureTableView
{
    [_tableView setDelegate:self];
    [_tableView setDataSource:self];
    [_tableView setScrollEnabled:YES];
    [_tableView setUserInteractionEnabled:YES];
    [_tableView setBackgroundColor:AppColorWhite];
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    //MJRefresh
    CRTestMode_close
    {
        CRMJRefreshFast_Init(_supportor.pageIndex == 1?@"api/SilverMall/Search":@"api/GoldMall/ProductList", CRShoppingViewController);
        CRMJRefreshFast_Request( return [weakself getRequestDicBy:pageIndex at:pageSize refresh:refreshName];);
        CRMJRefreshFast_Done
        (
         weakself.supportor.needRefresh = NO;
         if(controller.refreshCount == 0)
         {
             [weakself.tableView setTableFooterView:weakself.holder];
             [weakself.tableView reloadData];
         }
         else
         {
             weakself.tableView.tableFooterView = nil;
         }
         
         if (weakself.appPopView) [weakself.appPopView show:NO];
        );
    }
}

- (void)select:(UIButton *)sender
{
    sender.selected = !sender.selected;
    if(sender.selected)
    {
        _IsVipRequired = 1;
    }
    else
    {
        _IsVipRequired = 0;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(scrollView == _tableView)
    {
        if(_tableView.contentOffset.y > 600.f)
        {
            if(![_tableView containsSubView:_topButton])
            {
                [_tableView addSubview:_topButton];
                _topButton.left = 260;
                [_topButton addTarget:self action:@selector(top) forControlEvents:UIControlEventTouchUpInside];
                _topButton.bottom = SCREENHEIGHT - 100 + 30;
            }
            else
            {
                _topButton.hidden = NO;
            }
        }
        else
        {
            _topButton.hidden = YES;
        }
    }
    
    _topButton.bottom = scrollView.contentOffset.y - 200 + SCREENHEIGHT + 30;
}

- (void)top
{
    [self.tableView setContentOffset:CGPointMake(0,0) animated:YES];
}

- (void)viewWillLayoutSubviews
{
    if([_tableView containsSubView:_topButton])
    {
        _topButton.bottom = SCREENHEIGHT - 50 - 25;
    }
}


//数据请求
- (DictionaryWrapper *)getRequestDicBy:(NSInteger)pageIndex at:(NSInteger)pageSize refresh:(NSString *)refreshName
{
    __block CRShoppingViewController* weakself = self;
    
    _yinWrapper = nil;
    _yinWrapper = @{@"service":@"api/SilverMall/Search",
                    @"parameters":@{@"PageIndex":           @(pageIndex),
                                    @"PageSize":            @(pageSize),
                                    @"SearchType":          @(weakself.searchType),
                                    @"Province":            weakself.Province,
                                    @"City":                weakself.City,
                                    @"District":            weakself.District,
                                    @"CategoryId":          @(weakself.CategoryId),
                                    @"MinPoint":            @(weakself.minYinPoint),
                                    @"MaxPoint":            @(weakself.maxYinPoint)}}.wrapper;
    
    _jinWrapper = nil;
    _jinWrapper = @{@"service":@"api/GoldMall/ProductList",
                    @"parameters":@{@"PageIndex":            @(pageIndex),
                                    @"PageSize":             @(pageSize),
                                    @"OrderType":            @(weakself.OrderType),
                                    @"ProductCatagoryId":    @(weakself.ProductCatagoryId),
                                    @"IsVipRequired":        BOOLREAL(weakself.IsVipRequired),
                                    @"PriceMin":             @(weakself.minJinPoint),
                                    @"PriceMax":             @(weakself.maxJinPoint)
                                    }}.wrapper;
    
    [_yinWrapper retain];
    [_jinWrapper retain];
    DictionaryWrapper *dic = _supportor.pageIndex == 1?_yinWrapper:_jinWrapper;
    return  dic;
}

- (void)configureGoldView
{
    [_sort      addTarget:self action:@selector(goldButton:) forControlEvents:UIControlEventTouchUpInside];
    [_sortSell  addTarget:self action:@selector(goldButton:) forControlEvents:UIControlEventTouchUpInside];
    [_sortPrice addTarget:self action:@selector(goldButton:) forControlEvents:UIControlEventTouchUpInside];
    [_selectBt  addTarget:self action:@selector(select:) forControlEvents:UIControlEventTouchUpInside];
    
    [_textF1 setBorderWithColor:AppColor(220)];
    [_textF1 setKeyboardType:UIKeyboardTypeNumberPad];
    [_textF2 setBorderWithColor:AppColor(220)];
    [_textF2 setKeyboardType:UIKeyboardTypeNumberPad];
}

#pragma mark - Event

- (void)shouldChangePageViewTo:(NSInteger)pageIndex
{
    if(_isNotFirst) [self refreshTableView];
    
    _isNotFirst = YES;
}

#pragma mark - tableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ( _supportor.pageIndex == 1)
    {
        DictionaryWrapper* dic = [_MJRefreshCon dataAtIndex:(int)indexPath.row];
        CRSliverDetailViewController *model = WEAK_OBJECT(CRSliverDetailViewController, init);
        model.advertId = [dic getLong:@"AdvertId"];
        model.productId = [dic getLong:@"Id"];
        model.comeFromOtherPlace = YES;
        [UI_MANAGER.mainNavigationController pushViewController:model animated:YES];
    }
    else
    {
        DictionaryWrapper* dic = [_MJRefreshCon dataAtIndex:(int)indexPath.row];
        Preview_Commodity *model = WEAK_OBJECT(Preview_Commodity, init);
        model.whereFrom = 1;
        model.productId = (int)[dic getLong:@"ProductId"];
        [UI_MANAGER.mainNavigationController pushViewController:model animated:YES];
    }
}

- (void)goldButton:(UIButton *)sender
{
    if(sender.tag == 1)
    {
        if(_OrderType == 1) _OrderType = 0;
        else _OrderType = 1;
        
        [_holderPrice setTitle:@"价格排序" forState:UIControlStateNormal];
        [self refreshTableView];
    }
    else if (sender.tag == 2)
    {
        _holderPrice = sender;
        if(_OrderType == 2)
        {
            [_holderPrice setTitle:@"价格降序" forState:UIControlStateNormal];
            _OrderType = 3;
        }
        else if (_OrderType == 3)
        {
            [_holderPrice setTitle:@"价格升序" forState:UIControlStateNormal];
            _OrderType = 2;
        }
        else
        {
            [_holderPrice setTitle:@"价格升序" forState:UIControlStateNormal];
            _OrderType = 2;
        }
        
        [self refreshTableView];
    }
    else
    {
        if (!_appPopView)
        {    __block UIWindow *weakWindow = APP_DELEGATE.window;
            [_textF1 setShouldReturnBlock:CommonTextFieldBlockBOOL{
                [weakWindow endEditing:YES];
                return YES;
            }];
            [_textF2 setShouldReturnBlock:CommonTextFieldBlockBOOL{
                [weakWindow endEditing:YES];
                return YES;
            }];
            __block CRShoppingViewController *weakSelf = self;
            _appPopView = [[AppPopView alloc] initWithAnimateUpOn:self frame:CGRectMake(0, 0, 320, _popView.height) left:^{} right:^{
                [weakSelf hiddenKeyboard];
                [weakSelf.MJRefreshCon refreshWithLoading];
            }];
            NSLog(@"%@  %@ \n",_textF1.text,_textF2.text);
            _appPopView.titleName = @"筛选";
            [_appPopView.contentView addSubview:_popView];
        }
        [_appPopView show:YES];
    }
}

//筛选结束执行
- (void)hiddenKeyboard
{
    [APP_DELEGATE.window endEditing:YES];
    
    if(_textF1.text && _textF1.text.length > 0) _minJinPoint = _textF1.text.integerValue;
        else _minJinPoint = -1;
    if(_textF2.text && _textF2.text.length > 0) _maxJinPoint = _textF2.text.integerValue;
        else _maxJinPoint = -1;
    
    if(_maxJinPoint < _minJinPoint) [HUDUtil showErrorWithStatus:@"最大值过小"];
    [_appPopView show:NO];
}

- (void)layoutCell:(CRShoppingTableViewCell *)cell at:(NSIndexPath *)indexPath
{
    cell.isYinCell  = _supportor.pageIndex == 1? YES:NO;
    cell.data       = [_MJRefreshCon dataAtIndex:(int)indexPath.row];
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    CRShoppingTableViewCell *cell = (CRShoppingTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.contentView.backgroundColor = AppColor(220);
    return YES;
}
- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    CRShoppingTableViewCell *cell = (CRShoppingTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor whiteColor];
}
@end
