//
//  SCNavTabBarController.m
//  SCNavTabBarController
//
//  Created by ShiCang on 14/11/17.
//  Copyright (c) 2014年 SCNavTabBarController. All rights reserved.
//

#import "SCNavTabBarController.h"
#import "CommonMacro.h"
#import "SCNavTabBar.h"
#import "RTLabel.h"
#import "SharedData.h"

#define kDefineErrorInfo @"你好，你发布的信息未能通过审核，失败原因不明"

@interface SCNavTabBarController () <UIScrollViewDelegate, SCNavTabBarDelegate>
{
    NSInteger       _currentIndex;              // current page index
    
    
    SCNavTabBar     *_navTabBar;                // NavTabBar: press item on it to exchange view
    UIScrollView    *_mainView;                 // content view
    
    float _alertErrorViewHeight;
}

@end

@implementation SCNavTabBarController

#pragma mark - Life Cycle
#pragma mark -

- (id)initWithCanPopAllItemMenu:(BOOL)can
{
    self = [super init];
    if (self)
    {
        _canPopAllItemMenu = can;
    }
    return self;
}

- (id)initWithSubViewControllers:(NSArray *)subViewControllers
{
    self = [super init];
    if (self)
    {
        _subViewControllers = subViewControllers;
    }
    return self;
}

- (id)initWithParentViewController:(UIViewController *)viewController
{
    self = [super init];
    if (self)
    {
        [self addParentController:viewController];
    }
    return self;
}

- (id)initWithSubViewControllers:(NSArray *)subControllers andParentViewController:(UIViewController *)viewController canPopAllItemMenu:(BOOL)can;
{
    self = [self initWithSubViewControllers:subControllers];
    
    _canPopAllItemMenu = can;
    [self addParentController:viewController];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleUpdateSuccessAction:) name:UpdateSuccessAction object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleUpdateFailureAction:) name:UpdateFailureAction object:nil];
    
    
    
    if(_forceOfflineId){
        
        if(_publishManagementType == AlreadyPublishManagementRecruitForceOffline){
            [[API_PostBoard getInstance] engine_outside_recruitmentManage_detailsId:_forceOfflineId];
        }else if (_publishManagementType == AlreadyPublishManagementAttractBusinessForceOffline){
            [[API_PostBoard getInstance] engine_outside_attractBusinessManage_detailsId:_forceOfflineId];
        }else if (_publishManagementType == AlreadyPublishManagementSellerDiscountForceOffline){
            [[API_PostBoard getInstance] engine_outside_discountManage_detailsId:_forceOfflineId];
        }
        
    }else{
        [self initConfig];
        [self viewConfig];
    }
    
    self.view.backgroundColor = RGBACOLOR(255, 255, 255, 1);
}

-(void)dealloc{
    [super dealloc];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UpdateSuccessAction object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UpdateFailureAction object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private Methods
#pragma mark -- 数据请求成功回调
-(void)handleUpdateSuccessAction:(NSNotification *)noti{
    NSDictionary *dict = [noti userInfo];
    update_type type = [[dict objectForKey:@"update"]intValue];
    int ret = [[dict objectForKey:@"ret"] intValue];
    
    if(ret == 1){
        if(type == ut_recruitmentManage_details){
            if(_forceOfflineId){
                [self initAlertErrorView:[SharedData getInstance].recruitmentDetailInfo.recruitmentAuditInfo];
            }
            
        }else if(type == ut_attractBusinessManage_details){
            if(_forceOfflineId){
                [self initAlertErrorView:[SharedData getInstance].attractBusinessDetalInfo.attractBusinessAuditInfo];
            }
            
        }else if(type == ut_discountManage_details){
            if(_forceOfflineId){
                [self initAlertErrorView:[SharedData getInstance].discountDetailInfo.discountAuditInfo];
            }
            
        }
        [self initConfig];
        [self viewConfig];
    }else{
        if(type == ut_recruitmentManage_details || type == ut_attractBusinessManage_details || type == ut_discountManage_details){
            [HUDUtil showErrorWithStatus:dict[@"msg"]];
        }
    }
}

#pragma mark -- 数据请求失败回调
-(void)handleUpdateFailureAction:(NSNotification *)noti{
//    [HUDUtil showErrorWithStatus:@"数据加载失败"];
    
    NSDictionary *dict = [noti userInfo];
    update_type type = [[dict objectForKey:@"update"]intValue];
    if(type == ut_postBoard_addCollection){
        [HUDUtil showErrorWithStatus:@"收藏失败"];
    }
}

#pragma mark -- 初始化错误信息界面
-(void)initAlertErrorView:(NSString *)error{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, SYSTEM_VERSION_LESS_THAN(@"7.0")? -20 :0, SCREENWIDTH, 50.f)];
    view.backgroundColor = RGBACOLOR(251, 251, 251, 1);
    [self.view addSubview:view];
    
    UIView *view_ = [[UIView alloc] initWithFrame:CGRectMake(0, SYSTEM_VERSION_LESS_THAN(@"7.0")? -20 :0, SCREENWIDTH, 40.f)];
    view_.backgroundColor = RGBACOLOR(254, 243, 217, 1);
    [view addSubview:view_];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(13, 0, 20, 20)];
    [imageView setImage:[UIImage imageNamed:@"applyToGetCash"]];
    [view addSubview:imageView];
    
    RTLabel *label = [[RTLabel alloc] initWithFrame:CGRectMake(imageView.right + 9.f, 10.f, view.width - (imageView.right + 9.f + imageView.left), 20.f)];
    [label setTextColor:RGBACOLOR(176, 130, 39, 1)];
    label.font = [UIFont systemFontOfSize:14.f];
    label.text = error.length > 0 ? error : kDefineErrorInfo;
    label.height = label.optimumSize.height;
    [view addSubview:label];
    
    imageView.center = CGPointMake(imageView.center.x, label.center.y);
    
    if(label.height > imageView.height){
        
        view_.height = label.bottom + label.top;
    }
    
    UILabel *label_line = [[UILabel alloc] initWithFrame:CGRectMake(0, view_.bottom, view_.width, 0.5f)];
    label_line.backgroundColor = RGBACOLOR(204, 204, 204, 1);
    [view addSubview:label_line];
    
    label.center = CGPointMake(label.center.x, view_.height / 2.f);
    imageView.center = CGPointMake(imageView.center.x, label.center.y);
    
    view.height = view_.height + 10.f;
    _alertErrorViewHeight = view.height;
    
}

#pragma mark -
- (void)initConfig
{
    // Iinitialize value
    _currentIndex = 1;
    //    _navTabBarColor = _navTabBarColor ? _navTabBarColor : NavTabbarColor;
    
    // Load all title of children view controllers
    //    _titles = [[NSMutableArray alloc] initWithCapacity:_subViewControllers.count];
    //    for (UIViewController *viewController in _subViewControllers)
    //    {
    //        NSLog(@"viewController.title:%@",viewController.title);
    ////        [_titles addObject:viewController.title];
    //        [_titles addObject:@"aa"];
    //    }
}

- (void)viewInit
{
    if ([UICommon getSystemVersion] < 7.0) {
        self.view.frame = CGRectMake(0,  0, SCREENWIDTH, self.view.frame.size.height + 20);
    }
    
    
    // Load NavTabBar and content view to show on window
    _navTabBar = [[SCNavTabBar alloc] initWithFrame:CGRectMake(DOT_COORDINATE, _alertErrorViewHeight, SCREEN_WIDTH, NAV_TAB_BAR_HEIGHT) canPopAllItemMenu:_canPopAllItemMenu];
    _navTabBar.delegate = self;
    _navTabBar.backgroundColor = _navTabBarColor;
    _navTabBar.lineColor = _navTabBarLineColor;
    _navTabBar.itemTitles = _titles;
    _navTabBar.arrowImage = _navTabBarArrowImage;
    [_navTabBar updateData];
    
    _mainView = [[UIScrollView alloc] initWithFrame:CGRectMake(DOT_COORDINATE, _navTabBar.frame.origin.y + _navTabBar.frame.size.height, SCREEN_WIDTH, SCREEN_HEIGHT - _navTabBar.frame.origin.y - _navTabBar.frame.size.height - STATUS_BAR_HEIGHT - NAVIGATION_BAR_HEIGHT)];
    _mainView.delegate = self;
    _mainView.pagingEnabled = YES;
    _mainView.bounces = _mainViewBounces;
    _mainView.showsHorizontalScrollIndicator = NO;
    //    _mainView.contentSize = CGSizeMake(SCREEN_WIDTH * _subViewControllers.count, DOT_COORDINATE);
    [self.view addSubview:_mainView];
    [self.view addSubview:_navTabBar];
}

- (void)viewConfig
{
    [self viewInit];
    
    // Load children view controllers and add to content view
    [_subViewControllers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop){
        
        UIViewController *viewController = (UIViewController *)_subViewControllers[idx];
        viewController.view.frame = CGRectMake(idx * SCREEN_WIDTH, DOT_COORDINATE, SCREEN_WIDTH, _mainView.frame.size.height);
        [_mainView addSubview:viewController.view];
        [self addChildViewController:viewController];
    }];
}

#pragma mark - Public Methods
#pragma mark -
- (void)setNavTabbarColor:(UIColor *)navTabbarColor
{
    // prevent set [UIColor clear], because this set can take error display
    CGFloat red, green, blue, alpha;
    if ([navTabbarColor getRed:&red green:&green blue:&blue alpha:&alpha] && !red && !green && !blue && !alpha)
    {
        navTabbarColor = NavTabbarColor;
    }
    _navTabBarColor = navTabbarColor;
}

- (void)addParentController:(UIViewController *)viewController
{
    // Close UIScrollView characteristic on IOS7 and later
    if ([viewController respondsToSelector:@selector(edgesForExtendedLayout)])
    {
        viewController.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    [viewController addChildViewController:self];
    [viewController.view addSubview:self.view];
}

#pragma mark - Scroll View Delegate Methods
#pragma mark -
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    _currentIndex = scrollView.contentOffset.x / SCREEN_WIDTH;
    _navTabBar.currentItemIndex = _currentIndex;
}

#pragma mark - SCNavTabBarDelegate Methods
#pragma mark -
- (void)itemDidSelectedWithIndex:(NSInteger)index
{
    [_mainView setContentOffset:CGPointMake(index * SCREEN_WIDTH, DOT_COORDINATE) animated:_scrollAnimation];
}

- (void)shouldPopNavgationItemMenu:(BOOL)pop height:(CGFloat)height
{
    if (pop)
    {
        [UIView animateWithDuration:0.5f animations:^{
            _navTabBar.frame = CGRectMake(_navTabBar.frame.origin.x, _navTabBar.frame.origin.y, _navTabBar.frame.size.width, height + NAV_TAB_BAR_HEIGHT);
        }];
    }
    else
    {
        [UIView animateWithDuration:0.5f animations:^{
            _navTabBar.frame = CGRectMake(_navTabBar.frame.origin.x, _navTabBar.frame.origin.y, _navTabBar.frame.size.width, NAV_TAB_BAR_HEIGHT);
        }];
    }
    [_navTabBar refresh];
}

@end
