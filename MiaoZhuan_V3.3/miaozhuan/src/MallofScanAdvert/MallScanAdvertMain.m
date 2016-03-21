//
//  MallScanAdvertMain.m
//  miaozhuan
//
//  Created by abyss on 14/12/19.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "MallScanAdvertMain.h"

#import "MallSearchViewController.h"
#import "CRShoppingViewController.h"
#import "MyMallViewController.h"

#import "MainSupportor.h"

#import "RRNavBarDrawer.h"
#import "KxMenu.h"

@interface MallScanAdvertMain () <RRNavBarDrawerDelegate, KxMenuDelegate>
{
    NSInteger           _page;
    NSInteger           _curPage;
//    UILabel*            _navTitle;
    NSArray*            _viewArray;
    
    MainSupportor*      _supportor;

    /** 是否已打开抽屉 */
    BOOL _isOpen;
    RRNavBarDrawer *navBarDrawer;
    int _currentRow;
    
}
@property (retain) UIView *presentView;

@property (retain) CRShoppingViewController*    viewCon1;
@property (retain) MallSearchViewController*    viewCon2;
@property (retain) MyMallViewController*        viewCon3;

@property (retain, nonatomic) IBOutlet UIView *search_titleView;
@property (retain, nonatomic) IBOutlet UIButton *btnType;
@property (retain, nonatomic) IBOutlet UITextField *txtSearchKey;

@end

@implementation MallScanAdvertMain

- (void)dealloc
{
    CRDEBUG_DEALLOC();
    
    [_viewCon1 release];
    [_viewCon2 release];
    [_viewCon3 release];
    [_supportor release];
    [_controllerBar release];
    
    [_search_titleView release];
    [_txtSearchKey release];
    [_btnType release];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        _viewCon1   = STRONG_OBJECT(CRShoppingViewController, init);
        _viewCon2   = STRONG_OBJECT(MallSearchViewController, init);
        _viewCon3   = STRONG_OBJECT(MyMallViewController, init);
        _supportor  = STRONG_OBJECT(MainSupportor, initWith:self);
        
        [_supportor setViewConArray:@[_viewCon1,_viewCon2,_viewCon3]];

        CRGetValue    (_curPage, 0);
        CRGetValue    (_page, _supportor.type);
        CRGetValue    (_viewArray, _supportor.viewConArray);
        [APP_DELEGATE.locationManager startUpdatingLocation];
    }
    return self;
}

//MTA_viewDidAppear()
//MTA_viewDidDisappear()
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self addDoneToKeyboard:_txtSearchKey];
    
    [self setupMoveBackButton];
    
    [self.view              addSubview:_controllerBar];
    [self.navigationItem    setTitleView:_supportor.bar];
    
    _viewCon1.startPage = _startPage;
    if (_isJin)
    {
        //
    }
}

- (void)viewWillLayoutSubviews
{
    if (_page == _curPage) return;
    
    {
        if (_presentView.superview) [_presentView removeFromSuperview];
        
        CRGetValue(_presentView, [_viewArray[_page - 1] view]);
        
        
        if(_page == CRPageTypeShoppingPage)
        {
            [self setupMoveBackButton];
            self.navigationItem.titleView = _supportor.bar;
            CRGetValue(_supportor.search.hidden, NO);
//            [self setupMoveFowardButtonWithTitle:@" "];
            self.navigationItem.rightBarButtonItem = nil;
        }
        else if (_page == CRPageTypeMallSearch)
        {
            [_search_titleView setRoundCorner];
            self.navigationItem.hidesBackButton = YES;
            self.navigationItem.leftBarButtonItem = nil;
            _search_titleView.width = 245;
            self.navigationItem.titleView = _search_titleView;
            [self setupMoveFowardButtonWithTitle:@"搜索"];
        }
        else if (_page == CRPageTypeMyMall)
        {
            [self setupMoveBackButton];
            self.navigationItem.titleView = _supportor.bar;
            CRGetValue(_supportor.navTitle.text, @"我的商城");
            CRGetValue(_supportor.search.hidden, YES);
            [self setupMoveFowardButtonWithTitle:@" "];
        }
        
        [self.view.layer needsDisplay];
        [self.view addSubview:_presentView];
    }
    
    //keep controllerBar in view
    {
        CRGetValue(_controllerBar.bottom, self.view.height);
        [self.view bringSubviewToFront:_controllerBar];
    }
    
    CRGetValue(_curPage, _page);
}

#pragma makr --------------搜索 start----------------

- (void)hiddenKeyboard{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}

//search titleview 筛选
- (IBAction)typeClicked:(UIButton*)sender {
//    if (!navBarDrawer) {
//        NSArray *array = @[@{@"normal":@"mall_gs",@"hilighted":@"mall_gshover",@"title":@"商品"},@{@"normal":@"mall_shoper",@"hilighted":@"mall_shoperhover",@"title":@"商家"}];
//        navBarDrawer = STRONG_OBJECT(RRNavBarDrawer, initWithView:self.view andInfoArray:array);
//        navBarDrawer.delegate = self;
//        navBarDrawer.frameX = 20;
//    }
//    _isOpen = !_isOpen;
//    if (!_isOpen) {
//        [navBarDrawer openNavBarDrawer];
//    } else {
//        [navBarDrawer closeNavBarDrawer];
//    }
    
    // show menu
    if(![KxMenu isOpen])
    {
        NSArray *menuItems =
        @[
          
          [KxMenuItem menuItem:@"商品"
                         image:[UIImage imageNamed:@"mall_gs"]
                     highlight:[UIImage imageNamed:@"mall_gshover"]
                        target:self
                        action:@selector(pushMenuItem:)],
          
          [KxMenuItem menuItem:@"商家"
                         image:[UIImage imageNamed:@"mall_shoper"]
                     highlight:[UIImage imageNamed:@"mall_shoperhover"]
                        target:self
                        action:@selector(pushMenuItem:)],
          ];
    
        CGRect rect = CGRectMake(30, -5, 50, 50);
        
        [KxMenu showMenuInView:self.navigationController.view
                      fromRect:rect
                     menuItems:menuItems
                     itemWidth:85];
        [KxMenu sharedMenu].delegate = self;
    }
    else
    {
        [KxMenu dismissMenu];
    }
}

- (void)pushMenuItem:(id)sender{
    
}

- (void)which_tag_clicked:(int)tag{
    
    _currentRow = tag;
    [_btnType setTitle:_currentRow ? @"商家" : @"商品" forState:UIControlStateNormal];
    [self typeClicked:nil];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"MallType" object:@(_currentRow)];
}

- (void)didClickItem:(RRNavBarDrawer *)drawer atIndex:(NSInteger)index{
    _currentRow = (int)index;
    [_btnType setTitle:_currentRow ? @"商家" : @"商品" forState:UIControlStateNormal];
    [self typeClicked:nil];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"MallType" object:@(_currentRow)];
}

- (void)onMoveFoward:(UIButton *)sender
{
    if (_curPage != 2)
    {
        return;
    }
    
    //搜索
     NSString *key = @"";
    if (_txtSearchKey.text.length) {
        NSString *correctStr = [_txtSearchKey.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        if (!correctStr.length) {
            [HUDUtil showErrorWithStatus:@"请输入正确的关键字"];return;
        }
        key = correctStr;
    } else {
        [HUDUtil showErrorWithStatus:@"请输入搜索内容"];return;
    }
    
    [self hiddenKeyboard];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"MallSearch" object:@[@(_currentRow),key]];
}

#pragma makr --------------搜索 end----------------

- (void)viewWillAppear:(BOOL)animated
{
    APP_ASSERT(_viewArray);
    
    id objct = _viewArray[_page - 1];
    if (objct) [objct viewWillAppear:YES];
}

- (IBAction)swapPage:(UIButton *)sender
{
    CRGetValue(_page, sender.tag);
    
    for (UIButton *button in _controllerBar.subviews)
    {
        if (button.tag > 0) button.selected = NO;
        if (button.tag == sender.tag) button.selected = YES;
    }
    
    [self viewWillLayoutSubviews];
    
    _tabBtn = (UIButton *)sender;
}

@end
