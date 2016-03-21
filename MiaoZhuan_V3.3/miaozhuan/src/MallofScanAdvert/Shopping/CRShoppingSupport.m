//
//  CRShoppingSupport.m
//  miaozhuan
//
//  Created by abyss on 14/12/20.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "CRWebSupporter.h"
#import "CRShoppingSupport.h"
#import "CRHeaderView.h"
#import "CRSelectTable.h"
#import "CRButtonBox_ArrowButton.h"
#import "CRShoppingViewController.h"
#import "CRShoppingContentView.h"
#import "CRAreViewController.h"
#import "CRScrollController.h"
#import "NetImageView.h"
#import "WebhtmlViewController.h"
#import "MallScanAdvertMain.h"
#import "WebhtmlViewController.h"
#import "Preview_Commodity.h"

//欢快钢琴曲Children Of The Earth - Ayur
//True Love -S.E.N.S 神思者
@interface CRShoppingSupport () <CRHeaderViewDelegate,CRSeletctTableDelegate,ArrowButtonAdditionDelegate,CRShoppingContentViewDelegate,CRAreViewControllerDelegate,CRSCDelegate>
{
    CGFloat     _headerTopType;
    CGFloat     _ContentTopType;
    
    UIView*     _cover;
    UIView*     _cover2;
    
    UIView*     _sliverHeader;
    UIView*     _goldHeader;
    NetImageView*     _todayTop;
    
    UIButton*   _holderForContentSection;
    
    NSInteger   _selectTableList;
    
    BOOL        _needRefresh;
    
    CRScrollController* _scrollCon1;
    CRScrollController* _scrollCon2;
    NSArray* _webArray1;
    NSArray* _webArray2;
    NSArray *_wrapper1;
    NSArray *_wrapper2;
    UIScrollView *_banner1;
    UIScrollView *_banner2;
    
    NSMutableArray*    _selectArray;
    
    __block UIButton    *_holderButton;
}
@property (retain) UIView*      cover;
@property (retain) UIButton*    holderForContentSection;
@end
@implementation CRShoppingSupport

- (void)dealloc
{
    CRDEBUG_DEALLOC();
    
    _cr_delegate = nil;
    
    [_scrollCon1 remove];
    [_scrollCon2 remove];
    
    [_cover removeFromSuperview];
    _cover = nil;
    [_cover2 removeFromSuperview];
    _cover2 = nil;
    [_selectTable removeFromSuperview];
    _selectTable = nil;
    
    [_netArray release];
    [_tableView release];
    [_goldHeader release];
    [_headerView release];
    [_sliverHeader release];
    [_contentSection release];
    [_shoppingContent release];
    
    [super dealloc];
}

- (instancetype)init
{
    self = [super init];
    if (self)
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
        
        _cover = [[UIView alloc] init];
        [_cover setAlpha:0.6];
        [_cover setUserInteractionEnabled:NO];
        [_cover setBackgroundColor:[UIColor blackColor]];
        [_cover setOrigin:CGPointMake(0, SCREENHEIGHT)];
        [_cover setSize:CGSizeMake(SCREENWIDTH, SCREENHEIGHT)];
        [_cover setHidden:YES];
        __block CRShoppingSupport* weakself = self;
        [_cover setTapActionWithBlock:^(void)
         {
             weakself.selectTable.hidden = YES;
             
             weakself.cover.top      = weakself.tableView.bottom;
             weakself.cover.height   = 0;
             [(CRButtonBox_ArrowButton *)weakself.holderForContentSection setSelected:NO];
         }];
        
        _cover2 = [[UIView alloc] init];
        [_cover2 setUserInteractionEnabled:NO];
        [_cover2 setBackgroundColor:[UIColor clearColor]];
        [_cover2 setOrigin:CGPointMake(0, 0)];
        [_cover2 setSize:CGSizeMake(SCREENWIDTH, SCREENHEIGHT)];
        [_cover2 setHidden:YES];
        [_cover2 setTapActionWithBlock:^(void)
         {
             weakself.selectTable.hidden = YES;
             
             weakself.cover.top      = weakself.tableView.bottom;
             weakself.cover.height   = 0;
             [(CRButtonBox_ArrowButton *)weakself.holderForContentSection setSelected:NO];
         }];
        
        _shoppingContent = [[CRShoppingContentView alloc] initWithFrame:CGRectMake(0, 200, 320, 35) with:nil delegate:self];
        
        [self initBanner1];
        [self initBanner2];
    }
    return self;
}

- (void)initBanner1
{
    _banner1 = WEAK_OBJECT(UIScrollView, initWithFrame:CGRectMake(0, 0, 320, 110));
    _scrollCon1 = [CRScrollController controllerFromView:_banner1];
    _scrollCon1.isBackWhite = YES;
    _scrollCon1.delegate = self;
    _scrollCon1.positon = CRSC_PCPMiddle;
    
    ADAPI_adv3_Operator_GetBannerListByCategoryCode([GLOBAL_DELEGATOR_MANAGER addDelegator:self selector:@selector(yinBanner:)],@"0abf9dc16c6d36fa35ae167992d227ef");
}

- (void)initBanner2
{
    _banner2 = WEAK_OBJECT(UIScrollView, initWithFrame:CGRectMake(0, 130, 320, 70));
    _scrollCon2 = [CRScrollController controllerFromView:_banner2];
    _scrollCon2.isBackWhite = YES;
    _scrollCon2.picZoom = 0.5f;
    _scrollCon2.delegate = self;
    
    ADAPI_adv3_Operator_GetBannerListByCategoryCode([GLOBAL_DELEGATOR_MANAGER addDelegator:self selector:@selector(jininBanner:)], @"7510cd8ab9ddc9c2ad3115576d61fcb3");
    
//    ADAPI_adv3_PrimaryProduct([GLOBAL_DELEGATOR_MANAGER addDelegator:self selector:@selector(topAdvert:)]);
    _todayTop = WEAK_OBJECT(NetImageView, initWithFrame:CGRectMake(0, 0, 320, 120));
    _todayTop.holderColor = AppColorWhite;
    _todayTop.zoom = 0.5;
//    {
//        UIImage* image = [UIImage imageNamed:@"crs_008.png"];
//        UIImageView * view = WEAK_OBJECT(UIImageView, initWithFrame:CGRectMake(30, 0, image.size.width/2, image.size.height/2));
//        view.image = image;
//        [_todayTop addSubview:view];
//    }
    _todayTop.backgroundColor = AppColor(246);
    [_todayTop requestPic:nil placeHolder:NO];
    ADAPI_adv3_Operator_GetBannerListByCategoryCode_top([GLOBAL_DELEGATOR_MANAGER addDelegator:self selector:@selector(jininTop:)], @"b2ebaba401c9b7d0060c9f34359bf077");
}

- (void)yinBanner:(DelegatorArguments *)arg
{
    if (arg.ret.operationSucceed)
    {
        if (((NSArray *)arg.ret.data).count > 0)
        {
            _scrollCon1.picArray = arg.ret.data;
            
//            NSMutableArray *array = [NSMutableArray array];
//            for (NSDictionary * dic in arg.ret.data)
//            {
//                [array addObject:[dic.wrapper getString:@"Code"]];
//            }
//            
//            _webArray1 = array;
//            [_webArray1 retain];
            _wrapper1 = [arg.ret getArray:@"Data"];
        }
        else
        {
            _scrollCon1.picArray = @[@""];
        }
    }
}

- (void)scrollView:(CRScrollController *)view didSelectPage:(NSInteger)index
{
//    NSArray *array = view == _scrollCon1? _webArray1:_webArray2;
//    if (!array || array.count == 0) return;
//    
//    [CRWebSupporter responeseEventFrom:[array objectAtIndex:index]];
    
    
    
    NSDictionary *dic = view == _scrollCon1 ? _wrapper1[index] : _wrapper2[index];
    if(!dic) return;
    [CRWebSupporter responeseEventFrom:dic];
    
    
//    WebhtmlViewController* model = WEAK_OBJECT(WebhtmlViewController, init);
//    model.navTitle = @"";
//    NSString* code = [array objectAtIndex:index];
//    model.ContentCode = code;
//    [UI_MANAGER.mainNavigationController pushViewController:model animated:YES];
}

- (void)jininBanner:(DelegatorArguments *)arg
{
    if (arg.ret.operationSucceed)
    {
        if (((NSArray *)arg.ret.data).count > 0)
        {
            _scrollCon2.picArray = arg.ret.data;
            
//            NSMutableArray *array = [NSMutableArray array];
//            for (NSDictionary * dic in arg.ret.data)
//            {
//                [array addObject:[dic.wrapper getString:@"Code"]];
//            }
//            
//            _webArray2 = array;
//            [_webArray2 retain];
            
            _wrapper2 = [arg.ret getArray:@"Data"];
        }
        else
        {
            _scrollCon2.picArray = @[@""];
        }
        
    }
}

- (void)jininTop:(DelegatorArguments *)arg
{
    if (arg.ret.operationSucceed)
    {
        NSArray* array = arg.ret.data;
        [array retain];
        if (array && array.count >0)
        {
            [_todayTop requestCustom:[((NSDictionary *)array[0]).wrapper getString:@"Image"] width:_todayTop.width*2 height:_todayTop.height*2];
            [_todayTop setTapActionWithBlock:^{
                Preview_Commodity *model = WEAK_OBJECT(Preview_Commodity, init);
                model.whereFrom = 1;
                model.productId = (int)[((NSDictionary *)array[0]).wrapper getLong:@"Id"];
                [UI_MANAGER.mainNavigationController pushViewController:model animated:YES];
            }];
            
#warning !!
        }
        [array autorelease];
    }
    else
    {
        [HUDUtil showErrorWithStatus:arg.ret.operationMessage];
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

- (void)setHeaderView
{
    CRHeaderView *view = nil;
    
    _headerTopType = 0;
    view = [[[CRHeaderView alloc] initWithFrame:CGRectMake(0, _headerTopType, 320, 38)
                                          with:@[@"兑换商城",@"易货商城"]
                                      delegate:self] autorelease];
    view.startPage = _startPage;
    view.backgroundColor = AppColorWhite;
    _headerView = view;
    [_headerView retain];
}

- (void)setContentSection
{
    CRHeaderView *view = nil;
    
    _ContentTopType = 110;
    view = [[[CRHeaderView alloc] initWithFrame:CGRectMake(0, _ContentTopType, 320, 35)
                                                    with:@[@"全部",@"全部类别",@"全部范围"]
                                                delegate:self] autorelease];
    view.hasLine            = NO;
    view.cancelAutoAwak     = YES;
    view.needCheckReTouch   = NO;
    
    _contentSection = view;
    [_contentSection retain];
}

- (void)setSelectTable
{
    CRSelectTable* view = nil;

    CGFloat bottom = self.headerView.height + 3 + 105;
    view = [[[CRSelectTable alloc] initWithFrame:CGRectMake(0, bottom, 320, 300) delegate:self] autorelease];
    
    _selectTable        = view;
    _selectTable.hidden = YES;
    [_selectTable retain];
}

- (UIButton *)headerView:(CRHeaderView *)header buttonNeedCustomAt:(CGFloat)height
{
    if (header.top == 110)
    {
        CRButtonBox_ArrowButton *button = [[[CRButtonBox_ArrowButton alloc] init] autorelease];
        button.add_delegate = self;
        
        UIImageView *line = nil;
        {
            line = WEAK_OBJECT(UIImageView, initWithFrame:CGRectMake(106, 10, 0.5, 15));
            line.backgroundColor = AppColor(204);
        }
        
        [button addSubview:line];
        [button setBackgroundColor:AppColor(247)];
        
        return button;
    }
    else return nil;
}

- (UITableView *)configureTableView:(UITableView *)tableView
{
    CGRect frame = CGRectZero;
    
    CGFloat height = SCREENHEIGHT - 50;
    
    frame  = CGRectMake(0, 0, SCREENWIDTH, height);
    
    [tableView setFrame:frame];
    
    _tableView = tableView;
    [_tableView retain];
    
    __block CRShoppingSupport* weakself = self;
    [_selectTable.cover setTapActionWithBlock:^(void)
     {
         weakself.selectTable.hidden = YES;
         
         weakself.cover.top      = weakself.tableView.bottom;
         weakself.cover.height   = 0;
         [(CRButtonBox_ArrowButton *)weakself.holderForContentSection setSelected:NO];
     }];
    [APP_DELEGATE.window addSubview:_cover2];
    [APP_DELEGATE.window addSubview:_cover];
    [APP_DELEGATE.window addSubview:_selectTable];
    
    return tableView;
}

#pragma mark - Event
#define cr_shoppingsuppor_isSliverPage() _pageIndex == 1
- (void)headerView:(CRHeaderView *)header button:(UIButton *)button didTouchedAt:(NSInteger)buttonIndex
{
    if(_sliverHeader == nil)
    {
        _sliverHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 39.5, 320, 144.5)];
        [_sliverHeader addSubviews:_contentSection, _banner1, nil];
    }
    if (_goldHeader == nil)
    {
        [_goldHeaderp setFrame:CGRectMake(0, 235, 320, 35)];
        _goldHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 39.5, 320, 270.5)];
        _goldHeader.backgroundColor = AppColorBackground;
        [_goldHeader addSubviews:_goldHeaderp, _todayTop,_banner2, nil];
        
        [_tableView addSubview:_shoppingContent];
    }
    
    if (header.top == _headerTopType)
    {
        _pageIndex = buttonIndex;
        if (_cr_delegate && [_cr_delegate respondsToSelector:@selector(shouldChangePageViewTo:)])
        {
            [_cr_delegate shouldChangePageViewTo:_pageIndex - 1];
            [((CRShoppingViewController *)_father).tableView setContentOffset:CGPointMake(0, 0)];
            
            [_tableView setTableHeaderView:cr_shoppingsuppor_isSliverPage() ? _sliverHeader:_goldHeader];
            //sliver page
            if (cr_shoppingsuppor_isSliverPage())
            {
                _shoppingContent.hidden = YES;
            }
            //glod page
            else
            {
                _selectTable.hidden = YES;
                
                _cover2.hidden  = YES;
                _cover.top      = _tableView.bottom;
                _cover.height   = 0;
                [(CRButtonBox_ArrowButton *)_holderForContentSection setSelected:NO];
                
                _shoppingContent.hidden = NO;
                [_tableView bringSubviewToFront:_shoppingContent];
            }
            
            //all
            [_tableView scrollsToTop];
            [_tableView setScrollEnabled:YES];
        }
    }
}

- (void)button:(CRButtonBox_ArrowButton *)buttonResponse
{
    if (!_netArray || _netArray.count == 0) return;
    
    _holderForContentSection    = buttonResponse;
    
    if (buttonResponse.selected)
    {
        _holderButton               = buttonResponse;
        _selectTableList            = buttonResponse.tag - 1;
        _selectTable.top            = _contentSection.bottom + 43 + 64;
        _selectTable.buttonArray    = _netArray[_selectTableList];
        _selectTable.selectCell     = ((NSNumber *)_selectArray[_selectTableList]).integerValue;
        CGFloat height = MIN(CRSeletctTable_CellHeight * [((NSArray *)_netArray[_selectTableList]) count], SCREENHEIGHT - _selectTable.top);
        _selectTable.height         = height;
        _selectTable.hidden         = NO;
        
        _cover2.hidden  = NO;
        _cover.hidden   = NO;
        _cover.top      = _selectTable.top;
        _cover.height   = SCREENHEIGHT;
        
        [((CRShoppingViewController *)_father).tableView setContentOffset:CGPointMake(0, 0)];
        [((CRShoppingViewController *)_father).tableView setScrollEnabled:NO];
    }
    else
    {
        _selectTable.hidden         = YES;
        _cover2.hidden  = YES;
        _cover.hidden   = YES;
        _cover.top      = _tableView.bottom;
        _cover.height   = 0;
        
        ((CRShoppingViewController *)_father).tableView.scrollEnabled = YES;
        if (buttonResponse.tag == _selectTableList + 1 && _needRefresh)
            [((CRShoppingViewController *)_father).MJRefreshCon refreshWithLoading];
    }
}

- (void)selectTable:(CRSelectTable *)table didSelectedAt:(NSInteger)index with:(NSString *)data
{
    _needRefresh = YES;
    NSString *flag = nil;
    BOOL      needLoad = YES;
    int       temp = 0;
    
    [_holderButton setTitle:data forState:nil];
    
    _selectArray[_selectTableList] = @(index);
    flag = [[_netArray[_selectTableList][index] wrapper] getString:@"IndustryId"];
    
    if ([flag hasPrefix:@"#1_"])
    {
        flag = [flag substringFromIndex:3];
        temp = flag.intValue;
        
        if (temp == 3)
        {
            CRAreViewController *model = WEAK_OBJECT(CRAreViewController, init);
            model.delegate = self;
            [UI_MANAGER.mainNavigationController pushViewController:model animated:YES];
            needLoad = NO;
        }
        ((CRShoppingViewController *)_father).searchType = temp;
    }
    else if ([flag hasPrefix:@"#3_"])
    {
        flag = [flag substringFromIndex:3];
        temp = flag.intValue;
        
        if(0 == temp)
        {
            ((CRShoppingViewController *)_father).minYinPoint = -1;
            ((CRShoppingViewController *)_father).maxYinPoint = -1;
        }
        else if (1 == temp)
        {
            ((CRShoppingViewController *)_father).minYinPoint = 0;
            ((CRShoppingViewController *)_father).maxYinPoint = 2000;
        }
        else if (2 == temp)
        {
            ((CRShoppingViewController *)_father).minYinPoint = 2000;
            ((CRShoppingViewController *)_father).maxYinPoint = 4999;
        }
        else if (3 == temp)
        {
            ((CRShoppingViewController *)_father).minYinPoint = 5000;
            ((CRShoppingViewController *)_father).maxYinPoint = 9999;
        }
        else if (4 == temp)
        {
            ((CRShoppingViewController *)_father).minYinPoint = 10000;
            ((CRShoppingViewController *)_father).maxYinPoint = 49999;
        }
        else if (5 == temp)
        {
            ((CRShoppingViewController *)_father).minYinPoint = 50000;
            ((CRShoppingViewController *)_father).maxYinPoint = 99999;
        }
        else
        {
            ((CRShoppingViewController *)_father).minYinPoint = 100000;
            ((CRShoppingViewController *)_father).maxYinPoint = MAXFLOAT;
        }
    }
    else
    {
        ((CRShoppingViewController *)_father).CategoryId = flag.integerValue;
    }
    
    if (needLoad) [((CRShoppingViewController *)_father).tableView reloadData];
    self.selectTable.hidden = YES;
    
    self.cover.top      = self.tableView.bottom;
    self.cover.height   = 0;
    
    _holderButton.selected = NO;
}

- (void)AreControl:(CRAreViewController *)view select:(NSString *)city
{
    if (city == nil || [city isEqualToString:@""])
    {
        city = @"全国";
        ((CRShoppingViewController *)_father).City = @"";
    }
    else ((CRShoppingViewController *)_father).City = city;
    [_holderButton setTitle:city forState:nil];
    _holderButton.selected = NO;
    
    [((CRShoppingViewController *)_father).MJRefreshCon refreshWithLoading];
}

- (void)shoppingContentView:(CRShoppingContentView *)view button:(id)button didTouchAt:(NSInteger)buttonIndex data:(NSString *)data
{
    [_tableView bringSubviewToFront:_shoppingContent];
    [_tableView.layer needsDisplay];
    
    ((CRShoppingViewController *)_father).textF1.text = @"";
    ((CRShoppingViewController *)_father).textF2.text = @"";
    ((CRShoppingViewController *)_father).selectBt.selected = YES;
    ((CRShoppingViewController *)_father).OrderType = 0;
    [((CRShoppingViewController *)_father) select:((CRShoppingViewController *)_father).selectBt];
    
    
    ((CRShoppingViewController *)_father).ProductCatagoryId = data.intValue;
    [((CRShoppingViewController *)_father).MJRefreshCon refreshWithLoading];
}

@end
