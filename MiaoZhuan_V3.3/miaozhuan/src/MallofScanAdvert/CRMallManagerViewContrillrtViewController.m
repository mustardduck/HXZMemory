//
//  CRMallManagerViewContrillrtViewController.m
//  miaozhuan
//
//  Created by Abyss on 15-1-10.
//  Copyright (c) 2015年 zdit. All rights reserved.
//

#import "CRMallManagerViewContrillrtViewController.h"
#import "MJRefreshController.h"
#import "CRSegHeader.h"
#import "CRSliverDetailViewController.h"
#import "CRScrollController.h"
#import "AppPopView.h"
//#import "ProductMsgViewController.h"
#import "Preview_Commodity.h"
#import "CRSelectTable.h"
#import "CRHeaderView.h"
#import "CRButtonBox_ArrowButton.h"
#import "CRAreViewController.h"
#import "NetImageView.h"
#import "CRShoppingContentView.h"

#import "CRShoppingTableViewCell.h"

#define cr_mmvvc_isYin (_pageIndex == 0)
@interface CRMallManagerViewContrillrtViewController () <UITableViewDelegate,UITableViewDataSource,cr_SegHeaderDelegate,CRAreViewControllerDelegate,CRSeletctTableDelegate,CRHeaderViewDelegate,ArrowButtonAdditionDelegate,CRShoppingContentViewDelegate>
{
    DictionaryWrapper*      _yinWrapper;
    DictionaryWrapper*      _jinWrapper;
    MJRefreshController*    _MJRefreshCon;
    
    CRScrollController*     _yinScrollCon;
    CRScrollController*     _jinScrollCon;
    
    CGFloat                 _ContentTopType;
    
    BOOL                    _notFisrst;
    BOOL                    _needRefresh;
    UIView*                 _cover;
    NSArray*                _netArray; //兑换商城table
    NSMutableArray*         _selectArray; //兑换商城已经选择cell
    CRButtonBox_ArrowButton*_selectbutton; //兑换商城当前button
    
    AppPopView*             _appPopView;
}
@property (assign, nonatomic) BOOL needRefresh;
@property (assign, nonatomic) int pageIndex;
@property (retain, nonatomic) CRButtonBox_ArrowButton* selectbutton;


@property (retain, nonatomic) IBOutlet UIButton *topButton;
@property (retain, nonatomic) UIView* cover;
@property (retain, nonatomic) IBOutlet UITableView *tableView;
@property (retain, nonatomic) IBOutlet CRSegHeader *topHeader;
@property (retain, nonatomic) IBOutlet UIView *yinyuan;
@property (retain, nonatomic) IBOutlet UIView *jinbi;
@property (retain, nonatomic) IBOutlet UIScrollView *jin_scrollView;
@property (retain, nonatomic) IBOutlet NetImageView *jin_topImage;
@property (retain, nonatomic) IBOutlet UIScrollView *yin_scrollView;
//yin
@property (retain, readonly) CRSelectTable* selectTable;
@property (retain, readonly) CRHeaderView*  contentSection;

//jin
@property (retain, nonatomic) IBOutlet AppPopView *appPopView;
@property (retain, nonatomic) IBOutlet UIView *popVIew;
@property (retain, nonatomic) CRShoppingContentView* shoppingContent;
@property (retain, nonatomic) IBOutlet UIButton *selectBt;
@property (retain, nonatomic) IBOutlet CommonTextField *textF1;
@property (retain, nonatomic) IBOutlet CommonTextField *textF2;
@end

@implementation CRMallManagerViewContrillrtViewController

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initTableView];
    [self initHeaderView];
    
    [self initYinHeader];  //兑换商城
    [self initJinHeader];  //易货商城
}

- (void)initYinHeader
{
    //init
    {
        _ContentTopType = 110.f;
        _contentSection = [[[CRHeaderView alloc] initWithFrame:CGRectMake(0, _ContentTopType, 320, 35)
                                                          with:@[@"全部",@"全部类别",@"全部范围"]
                                                      delegate:self] autorelease];
        _contentSection.hasLine            = NO;
        _contentSection.cancelAutoAwak     = YES;
        _contentSection.needCheckReTouch   = NO;
        
        _selectTable = [[[CRSelectTable alloc] initWithFrame:CGRectMake(0, 110 + 35, 320, 300) delegate:self] autorelease];
        _selectTable.hidden = YES;
    }
    // 筛选
    {
        NSMutableArray *array = [NSMutableArray arrayWithArray:[APP_DELEGATE.runtimeConfig getArray:RUNTIME_USER_LOGIN_INFO".IndustryCategoryDataSource"]];
        if (!array || array.count == 0)
        {
            ADAPI_GetIndustryCategoryList([GLOBAL_DELEGATOR_MANAGER addDelegator:self selector:@selector(isDone:)], 0);
            array = [NSMutableArray new];
        }
        //        [array insertObject: @{@"Name":@"全部类别",@"IndustryId":@"0"} atIndex:0];
        
        _netArray = @[ @[ @{@"Name":@"全部",@"IndustryId":@"#1_0"}
                          ,@{@"Name":@"附近",@"IndustryId":@"#1_1"}
                          ,@{@"Name":@"邮寄商品",@"IndustryId":@"#1_2"}
                          ,@{@"Name":@"按城市",@"IndustryId":@"#1_3"}],
                       array,
                       @[@{@"Name":@"全部范围",@"IndustryId":@"#3_0"},
                         @{@"Name":@"2000以下",@"IndustryId":@"#3_1"},
                         @{@"Name":@"2000~4999",@"IndustryId":@"#3_2"},
                         @{@"Name":@"5000~9999",@"IndustryId":@"#3_3"},
                         @{@"Name":@"10000~49999",@"IndustryId":@"#3_4"},
                         @{@"Name":@"50000~99999",@"IndustryId":@"#3_5"},
                         @{@"Name":@"100000以上",@"IndustryId":@"#3_6"}]];
        
        _selectArray = [NSMutableArray arrayWithArray: @[@0,@0,@0]];
        [_selectArray retain];
        [_netArray retain];

    }
    //cover
    {
        _cover = [[UIView alloc] init];
        [_cover setAlpha:0.6];
        [_cover setUserInteractionEnabled:NO];
        [_cover setBackgroundColor:[UIColor blackColor]];
        [_cover setOrigin:CGPointMake(0, SCREENHEIGHT)];
        [_cover setSize:CGSizeMake(SCREENWIDTH, SCREENHEIGHT)];
        __block CRMallManagerViewContrillrtViewController* weakself = self;
        [_cover setTapActionWithBlock:^(void)
         {
             weakself.selectTable.hidden = YES;
             
             weakself.cover.top      = weakself.tableView.bottom;
             weakself.cover.height   = 0;
             weakself.needRefresh    = NO;
             [(CRButtonBox_ArrowButton *)weakself.selectbutton setSelected:NO];
         }];
        [_cover setHidden:YES];
    }
    
    [_yinyuan addSubviews:_contentSection,_cover,_selectTable, nil];
}

- (void)initJinHeader
{
    {
        _shoppingContent = [[CRShoppingContentView alloc] initWithFrame:CGRectMake(0, 200, 320, 40) with:nil delegate:self];
    }
    
    [_jinbi addSubviews:_shoppingContent, nil];
}

- (void)initHeaderView
{
    _yinyuan.height = 145.f;
    _jinbi.height = 240.f;
    _topHeader.delegate = self;
    _topHeader.height = 40;
    _topHeader.buttonArray = @[@"兑换商城",@"易货商城"];
    
    //jin
    _jinScrollCon = [CRScrollController controllerFromView:_jin_scrollView];
    _jinScrollCon.picArray = @[@""];
    [_jin_topImage requestPic:@"" placeHolder:NO];
    
    //yin
    _yinScrollCon = [CRScrollController controllerFromView:_yin_scrollView];
    _yinScrollCon.isBackWhite = YES;
    _yinScrollCon.picArray = @[@""];
    

    ADAPI_adv3_Operator_GetBannerListByCategoryCode([self genDelegatorID:@selector(yinBanner:)], @"0abf9dc16c6d36fa35ae167992d227ef");
    ADAPI_adv3_Operator_GetBannerListByCategoryCode([self genDelegatorID:@selector(jininBanner:)], @"7510cd8ab9ddc9c2ad3115576d61fcb3");
    ADAPI_adv3_Operator_GetBannerListByCategoryCode([self genDelegatorID:@selector(jininTop:)], @"b2ebaba401c9b7d0060c9f34359bf077");
}

- (void)shoppingContentView:(CRShoppingContentView *)view button:(id)button didTouchAt:(NSInteger)buttonIndex data:(NSString *)data
{
    self.textF1.text = @"";
    self.textF2.text = @"";
    self.selectBt.selected = YES;
    self.OrderType = 0;
    [self select:self.selectBt];
    
    
    self.ProductCatagoryId = data.intValue;
    [self refreshTableView];
}

- (void)yinBanner:(DelegatorArguments *)arg
{
    if (arg.ret.operationSucceed)
    {
        if (((NSArray *)arg.ret.data).count > 0)
        {
            _jinScrollCon.picArray = arg.ret.data;
        }
    }
}

- (void)jininBanner:(DelegatorArguments *)arg
{
    if (arg.ret.operationSucceed)
    {
        if (((NSArray *)arg.ret.data).count > 0)
        {
            _yinScrollCon.picArray = arg.ret.data;
        }
    }
}

- (void)jininTop:(DelegatorArguments *)arg
{
    if (arg.ret.operationSucceed)
    {
        //
    }
}

- (void)isDone:(DelegatorArguments *)arg
{
    if (arg.ret.operationSucceed)
    {
        NSMutableArray *array = [NSMutableArray arrayWithArray:arg.ret.data];
        [array insertObject: @{@"Name":@"全部类别",@"IndustryId":@"0"} atIndex:0];
        [APP_DELEGATE.runtimeConfig set:RUNTIME_USER_LOGIN_INFO".IndustryCategoryDataSource" value:array];
        
        _netArray = @[ @[ @{@"Name":@"全部",@"IndustryId":@"#1_0"}
                          ,@{@"Name":@"附近",@"IndustryId":@"#1_1"}
                          ,@{@"Name":@"邮寄商品",@"IndustryId":@"#1_2"}
                          ,@{@"Name":@"按城市",@"IndustryId":@"#1_3"}],
                       array,
                       @[@{@"Name":@"全部范围",@"IndustryId":@"#3_0"},
                         @{@"Name":@"2000以下",@"IndustryId":@"#3_1"},
                         @{@"Name":@"2000~4999",@"IndustryId":@"#3_2"},
                         @{@"Name":@"5000~9999",@"IndustryId":@"#3_3"},
                         @{@"Name":@"10000~49999",@"IndustryId":@"#3_4"},
                         @{@"Name":@"50000~99999",@"IndustryId":@"#3_5"},
                         @{@"Name":@"100000以上",@"IndustryId":@"#3_6"}]];
        
        [_netArray retain];
    }
}

- (UIButton *)headerView:(CRHeaderView *)header buttonNeedCustomAt:(CGFloat)height
{
    if (header.top == 110)
    {
        CRButtonBox_ArrowButton *button = [[[CRButtonBox_ArrowButton alloc] init] autorelease];
        button.add_delegate = self;
        
        UIImageView *line = nil;
        {
            line = WEAK_OBJECT(UIImageView, initWithFrame:CGRectMake(106, 10, 1, 15));
            line.backgroundColor = AppColor(220);
        }
        
        [button addSubview:line];
        [button setBackgroundColor:AppColor(247)];
        
        return button;
    }
    else return nil;
}

- (void)initTableView
{
    {
        self.Province = @"";
        self.City     = @"";
        self.District = @"";
        
        _minYinPoint  = -1;
        _maxYinPoint  = -1;
        _minJinPoint  = -1;
        _maxJinPoint  = -1;
    }
    
    _tableView.delegate     = self;
    _tableView.dataSource   = self;
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    CRMJRefreshFast_Init(cr_mmvvc_isYin?@"api/SilverMall/Search":@"api/GoldMall/ProductList",CRMallManagerViewContrillrtViewController);
    CRMJRefreshFast_Request( return [weakself getRequestDicBy:pageIndex at:pageSize refresh:refreshName];);
    CRMJRefreshFast_Done
    (
        if(controller.refreshCount == 0)   [weakself.tableView reloadData];
        weakself.needRefresh = NO;
        if (weakself.appPopView) [weakself.appPopView show:NO];
     );
}

- (DictionaryWrapper *)getRequestDicBy:(NSInteger)pageIndex at:(NSInteger)pageSize refresh:(NSString *)refreshName
{
    __block CRMallManagerViewContrillrtViewController* weakself = self;
    
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
    DictionaryWrapper *dic = cr_mmvvc_isYin?_yinWrapper:_jinWrapper;
    return  dic;
}

//兑换商城 0 易货商城 1
- (void)button:(UIButton *)button didBetouch:(NSInteger)buttonIndex
{
    if(cr_mmvvc_isYin)
    {
    }
    else
    {
        [_tableView bringSubviewToFront:_shoppingContent];
        //银元还原
        __block CRMallManagerViewContrillrtViewController *weakself = self;
        {
            weakself.selectTable.hidden = YES;
            
            weakself.cover.top      = weakself.tableView.bottom;
            weakself.cover.height   = 0;
            weakself.needRefresh    = NO;
            [(CRButtonBox_ArrowButton *)weakself.selectbutton setSelected:NO];
        }
    }
    
    self.pageIndex = (int)buttonIndex;
}

- (void)setPageIndex:(int)pageIndex
{
    _pageIndex = pageIndex;
    _tableView.tableHeaderView = pageIndex==0?_yinyuan:_jinbi;
    
    if (_notFisrst)
    {
        [self refreshTableView];
    }
    _notFisrst = YES;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section\
{
    return _MJRefreshCon.refreshCount;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath\
{
    return 110;
}

- (void)refreshTableView { [_MJRefreshCon refreshWithLoading];}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath\
{
    NSString *CellIdentifier = @"CRShoppingTableViewCell";
    CRShoppingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[NSBundle mainBundle] loadNibNamed:CellIdentifier owner:nil options:nil].lastObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }

    cell.isYinCell  = cr_mmvvc_isYin? YES:NO;
    cell.data       = [_MJRefreshCon dataAtIndex:(int)indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ( cr_mmvvc_isYin )
    {
        DictionaryWrapper* dic = [_MJRefreshCon dataAtIndex:(int)indexPath.row];
        CRSliverDetailViewController *model = WEAK_OBJECT(CRSliverDetailViewController, init);
        model.advertId = [dic getLong:@"AdvertId"];
        model.productId = [dic getLong:@"Id"];
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
    [_topHeader release];
    [_tableView release];
    [_yinyuan release];
    [_jinbi release];
    [_jin_topImage release];
    [_jin_scrollView release];
    [_yin_scrollView release];
    [_topButton release];
    [_popVIew release];
    [_selectBt release];
    [_textF1 release];
    [_textF2 release];
    [super dealloc];
}

- (void)viewDidUnload
{
    [self setTopHeader:nil];
    [self setTableView:nil];
    [self setYinyuan:nil];
    [self setJinbi:nil];
    [super viewDidUnload];
}

//yin

- (void)button:(CRButtonBox_ArrowButton *)buttonResponse
{
    if (!_netArray || _netArray.count == 0) return;
    
    if (buttonResponse.selected)
    {
        _selectbutton               = buttonResponse;
        _selectTable.top            = _contentSection.bottom;
        _selectTable.buttonArray    = _netArray[_selectbutton.tag - 1];
        _selectTable.selectCell     = ((NSNumber *)_selectArray[_selectbutton.tag - 1]).integerValue;
        _selectTable.height         = MIN(SCREENHEIGHT > 500?5:3, [_selectTable.buttonArray count]) * 45 + 10;
        _selectTable.hidden         = NO;
        
        _cover.hidden   = NO;
        _cover.top      = _selectTable.bottom;
        _cover.height   = SCREENHEIGHT - _selectTable.bottom - 50;
        
        [self.tableView scrollsToTop];
        [self.tableView setScrollEnabled:NO];
    }
    else
    {
        _selectTable.hidden = YES;
        
        _cover.hidden   = YES;
        _cover.top      = _tableView.bottom;
        _cover.height   = 0;
        
        self.tableView.scrollEnabled = YES;
        if (_needRefresh)
        {
            [self refreshTableView];
            _needRefresh = NO;
        }
    }
}

- (void)selectTable:(CRSelectTable *)table didSelectedAt:(NSInteger)index with:(NSString *)data
{
    _needRefresh = YES;
    NSLog(@"%@",data);
    NSString *flag = nil;
    int       temp = 0;
    
    _selectbutton.titleLabel.text = data;
    [_selectbutton.layer needsDisplay];
    
    _selectArray[_selectbutton.tag - 1] = @(index);
    flag = [[_netArray[_selectbutton.tag - 1][index] wrapper] getString:@"IndustryId"];
    
    if ([flag hasPrefix:@"#1_"])
    {
        flag = [flag substringFromIndex:3];
        temp = flag.intValue;
        
        if (temp == 3)
        {
            CRAreViewController *model = WEAK_OBJECT(CRAreViewController, init);
            model.delegate = self;
            [UI_MANAGER.mainNavigationController pushViewController:model animated:YES];
        }
        self.searchType = temp;
    }
    else if ([flag hasPrefix:@"#3_"])
    {
        flag = [flag substringFromIndex:3];
        temp = flag.intValue;
        
        if(0 == temp)
        {
            self.minYinPoint = -1;
            self.maxYinPoint = -1;
        }
        else if (1 == temp)
        {
            self.minYinPoint = 0;
            self.maxYinPoint = 2000;
        }
        else if (2 == temp)
        {
            self.minYinPoint = 2000;
            self.maxYinPoint = 4999;
        }
        else if (3 == temp)
        {
            self.minYinPoint = 5000;
            self.maxYinPoint = 9999;
        }
        else if (4 == temp)
        {
            self.minYinPoint = 10000;
            self.maxYinPoint = 49999;
        }
        else if (5 == temp)
        {
            self.minYinPoint = 50000;
            self.maxYinPoint = 99999;
        }
        else
        {
            self.minYinPoint = 100000;
            self.maxYinPoint = MAXFLOAT;
        }
    }
    else
    {
        self.CategoryId = flag.integerValue;
    }
    
    [self.tableView reloadData];
    self.selectTable.hidden = YES;
    
    self.cover.top      = self.tableView.bottom;
    self.cover.height   = 0;
    [(CRButtonBox_ArrowButton *)self.selectbutton setSelected:NO];
}

- (void)AreControl:(CRAreViewController *)view select:(NSString *)city
{
    self.City = city;
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
                _topButton.bottom = SCREENHEIGHT - 50 - 50;
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
    
    _topButton.bottom = scrollView.contentOffset.y - 200 + SCREENHEIGHT;
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

- (void)goldButton:(UIButton *)sender
{
    if(sender.tag == 1)
    {
        if(_OrderType == 1) _OrderType = 0;
        else _OrderType = 1;
        
        [self refreshTableView];
    }
    else if (sender.tag == 2)
    {
        if(_OrderType == 2) _OrderType = 3;
        else if (_OrderType == 3) _OrderType = 2;
        else _OrderType = 2;
        
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
            __block CRMallManagerViewContrillrtViewController *weakSelf = self;
            _appPopView = [[AppPopView alloc] initWithAnimateUpOn:self frame:CGRectMake(0, 0, 320, _popVIew.height) left:^{} right:^{
                [weakSelf hiddenKeyboard];
                [weakSelf refreshTableView];
            }];
            NSLog(@"%@  %@ \n",_textF1.text,_textF2.text);
            _appPopView.titleName = @"筛选";
            [_appPopView.contentView addSubview:_popVIew];
        }
        [_appPopView show:YES];
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

@end
