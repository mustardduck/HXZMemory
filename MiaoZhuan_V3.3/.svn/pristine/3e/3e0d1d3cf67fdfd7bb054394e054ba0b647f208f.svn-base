//
//  AdsViewController.m
//  miaozhuan
//
//  Created by 孙向前 on 14-10-23.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "AdsViewController.h"
#import "HeaderManageCenterViewController.h"
#import "UIView+expanded.h"
#import "DictionaryWrapper.h"
#import "AdsDetailViewController.h"
#import "NetImageView.h"
#import "JSONKit.h"
#import "NSDictionary+expanded.h"
#import "PSAsDetailController.h"

@interface AdsViewController ()<UIScrollViewDelegate>{
    NSInteger _currentIndex;//选中类型下标
    BOOL _isLast;
}

@property (retain, nonatomic) IBOutlet UIScrollView     *scrollView;
@property (retain, nonatomic) IBOutlet NetImageView  *advertImgView;
@property (retain, nonatomic) IBOutlet UIImageView      *line;
@property (retain, nonatomic) IBOutlet UIView *addView;
@property (retain, nonatomic) IBOutlet UIImageView *bottomLine;

@property (nonatomic, retain) NSArray *showTypes;//展示的分类
@property (nonatomic, retain) NSMutableArray *allAds;//某个类型的所有广告

@end

//宏取KEY
static NSString *UserMarkDefaults = @"UserMarkDefaults";

@implementation AdsViewController
MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad {
    
    _bottomLine.top = 39.5;
    
    [super viewDidLoad];
    //注册通知，监听看广告回调
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showNextAds:) name:@"lookNextAds" object:nil];
    //注册通知，监听分类列表返回
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showCurtypeAds:) name:@"categories" object:nil];
    
    [self setupMoveBackButton];
    [self setNavigateTitle:@"分类查看广告"];
    [self setupMoveFowardButtonWithTitle:@"进入"];
    
    //判断是否拉取了广告类型
    NSDictionary *dic = [[NSUserDefaults standardUserDefaults] valueForKey:UserMarkDefaults];
    if (dic.count) {
        //拉取了
        [self _initAlltypesAndCreateTypeButton];
        //拉取广告，判断是否缓存了，缓存是否过期
        NSArray *temp = [[dic wrapper] getArray:@"isShow"];
        if (!temp.count) {
            return;
        }
        NSString *aid = [[temp[0] wrapper] getString:@"Id"];
        NSArray *ids = @[aid];
        [self pullAds:ids];
    } else {
        //未拉取，拉取完成再拉取分类广告
        [self pullAds:@[@"-3"]];
        ADAPI_adv24_advert_categories([GLOBAL_DELEGATOR_MANAGER addDelegator:self selector:@selector(handleAllSettingDataNotification:)]);
    }

    _scrollView.panGestureRecognizer.delaysTouchesBegan = YES;
}

- (void)_initAlltypesAndCreateTypeButton {
    self.showTypes = [[[NSUserDefaults standardUserDefaults] valueForKey:UserMarkDefaults] objectForKey:@"isShow"];
    _currentIndex = 1;
    [self createTypeButtonInScrollView:self.showTypes];
}

- (void)_initShowAds:(NSDictionary *)adsDic{
    if (!adsDic.count) {
        return;
    }
    
    //广告数据
    self.allAds = [NSMutableArray arrayWithArray:[[adsDic wrapper] get:@"Adverts"]];
    if (self.allAds.count) {
        _addView.hidden = YES;
        //每次拉取广告下来，默认显示第一条
        NSLog(@"%@",[[_allAds[0] wrapper] getString:@"PictureUrl"]);
        [_advertImgView requestWithRecommandSize:[[_allAds[0] wrapper] getString:@"PictureUrl"] placeHolder:@""];
    }
}
- (void)_initCategory:(NSArray *)alltypes{

    NSMutableArray *isShow = [NSMutableArray arrayWithCapacity:10];
    NSMutableArray *isOff = [NSMutableArray arrayWithCapacity:10];
    for (NSDictionary *type in alltypes) {
        if ([[type wrapper] getBool:@"IsFavored"]) {
            [isShow addObject:type];
        } else {
            [isOff addObject:type];
        }
    }
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithObjects:@[isShow,isOff] forKeys:@[@"isShow",@"offShow"]];
    [[NSUserDefaults standardUserDefaults] setValue:dic forKey:UserMarkDefaults];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self _initAlltypesAndCreateTypeButton];//初始化分类
}

#pragma mark - 获取分类类型
- (void)handleAllSettingDataNotification:(DelegatorArguments*)arguments
{
    DictionaryWrapper* dic = arguments.ret;
    NSArray *array = [dic getArray:@"Data"];
    if (dic.operationSucceed)
    {
        //传入请求返回所有类型
        [self _initCategory:array];
    }
    else
    {
        [HUDUtil showErrorWithStatus:dic.operationMessage];
        return;
    }
}
#pragma mark - 拉取类型广告
- (void)pullAds:(NSArray *)type{
     NSString *key = [[self.showTypes[_currentIndex - 1] wrapper] getString:@"Id"];
    if (key.length) {
        self.allAds = [[NSUserDefaults standardUserDefaults] valueForKey:key];
    }
    
    if ([self checkCacheIsValiable] || _allAds.count == 1 || !_allAds.count) {
        NSDictionary *dic = @{@"CategoryIds":type};
        ADAPI_adv24_advert_pull([GLOBAL_DELEGATOR_MANAGER addDelegator:self selector:@selector(handlePullAds:)], dic);
    } else {
     
        NSMutableArray *tempMutDic = [NSMutableArray arrayWithCapacity:0];
        for (NSDictionary *dic in _allAds) {
            NSDictionary *tempdic = [self cr_getSafeDic:dic];
            [tempMutDic addObject:tempdic];
        }
        [[NSUserDefaults standardUserDefaults] setValue:tempMutDic forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [self _initShowAds:@{@"Adverts":_allAds}];
    }
}

//判断缓存是否过期,是否需要重新拉取数据
- (BOOL)checkCacheIsValiable{
    
    if (!self.showTypes.count) {
        return YES;
    }
    
    NSString *k = [[self.showTypes[_currentIndex - 1] wrapper] getString:@"Id"];
    NSString *key = [NSString stringWithFormat:@"%@",[k stringByAppendingString:@"cache"]];
    NSDictionary *dic = [[NSUserDefaults standardUserDefaults] valueForKey:key];
    if (!dic.count) {
        return YES;
    }
    
    //判断两个时间差
    NSDate *cacheDate = [[dic wrapper] get:@"date"];
    CGFloat result = [self intervalSinceNow:cacheDate];
    return result > [[[NSUserDefaults standardUserDefaults] valueForKey:@"DataCacheTime"] floatValue];
}

//计算某个时间与当前时间的时间差
- (CGFloat)intervalSinceNow: (NSDate *)theDate {
    NSTimeInterval  timeInterval = [theDate timeIntervalSinceNow];
    timeInterval = -timeInterval;
    return timeInterval;
}
- (void)handlePullAds:(DelegatorArguments*)arguments
{
    DictionaryWrapper* dic = arguments.ret;
    NSArray *data = dic.data;
    
    if (dic.operationSucceed)
    {
        _addView.hidden = YES;
        if (![[[data[0] wrapper] get:@"Adverts"] count]) {
            _addView.hidden = NO;
            return;
        }
        
        //缓存
        NSString *k = [[self.showTypes[_currentIndex - 1] wrapper] getString:@"Id"];
        NSString *key = [NSString stringWithFormat:@"%@",[k stringByAppendingString:@"cache"]];

        NSMutableArray *tempData = [NSMutableArray array];
        for (NSDictionary *dic in [[data[0] wrapper] get:@"Adverts"]) {
            
            NSArray *allkeys = dic.allKeys;
            NSMutableDictionary *mdic = [NSMutableDictionary dictionary];
            for (NSString *key in allkeys) {
                NSString *str = [dic valueForJSONStrKey:key];
                if (str.length && ![str isKindOfClass:[NSNull class]]) {
                    [mdic setValue:str forKey:key];
                } else {
                    [mdic setValue:@"" forKey:key];
                }
            }
            [tempData addObject:mdic];
        }
        NSDictionary *temp = @{@"date" : [NSDate date], @"value" : @[@{@"Adverts":tempData}]};
        
        [[NSUserDefaults standardUserDefaults] setValue:temp forKey:key];
        
        [[NSUserDefaults standardUserDefaults] setValue:@([[data[0] wrapper] getInt:@"CacheTime"]) forKey:@"DataCacheTime"];
        
        NSMutableArray *tempMutDic = [NSMutableArray arrayWithCapacity:0];
        for (NSDictionary *dic in tempData) {
            NSDictionary *tempdic = [self cr_getSafeDic:dic];
            [tempMutDic addObject:tempdic];
        }
        [[NSUserDefaults standardUserDefaults] setValue:tempMutDic forKey:k];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [self _initShowAds:data[0]];
    }
    else
    {
        [HUDUtil showErrorWithStatus:dic.operationMessage];
        return;
    }
}

#pragma mark - 创建type button
- (void)createTypeButtonInScrollView:(NSArray *)types{
    int count = 0;
    CGFloat contentWidth = 0.0;
    
    for (UIView *btn in _scrollView.subviews) {
        if ([btn isKindOfClass:[UIButton class]]) {
            [btn removeFromSuperview];
        }
    }
    
    for (NSDictionary *dic in types) {
        
        UIButton *button = WEAK_OBJECT(UIButton, init);
        button.tag = count + 1;
        
        //获取内容宽度
        NSString *title = [dic valueForKey:@"Text"];
        float width = [UICommon getSizeFromString:title withSize:CGSizeMake(MAXFLOAT, _scrollView.height) withFont:14].width;
        
        [button setTitle:title forState:UIControlStateNormal];
        [button setFrame:CGRectMake(10 + contentWidth, 0, width + 12, _scrollView.frameHeight)];
        
        [button addTarget:self action:@selector(tapTypeButton:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:button];
        
        if (!count) {
            [self setLineWidth:width + 12 frameX:button.frameX];//线条位置
            [self setBtnTypeSelectedStatus:button];//button选中
        } else {
            [self setBtnTypeNormalStatus:button];
        }
        
        contentWidth = button.frameRight;
        count++;
    }
    _scrollView.contentSize = CGSizeMake(contentWidth + 50, _scrollView.frameHeight);
    _bottomLine.frameWidth = contentWidth + 100;
}
#pragma mark - 事件
//点击type button
- (void)tapTypeButton:(UIButton *)btnType{
    NSLog(@"%ld",(long)btnType.tag);
    //线条和button的位置
    [self setLineAndButtonStatus:btnType];
    //拉取广告
    [self pullAds:@[[[self.showTypes[btnType.tag - 1] wrapper] getString:@"Id"]]];

}
//swipe imageview
- (IBAction)swipeOnImageView:(UISwipeGestureRecognizer *)sender {
    
    int offset = (sender.direction == UISwipeGestureRecognizerDirectionLeft ? 1:-1 );
    _currentIndex += offset;
    
    if (_currentIndex == 0 || _currentIndex > _showTypes.count)
    {
        _currentIndex -= offset;
        return;
    }
    
    //拉取广告
    [self pullAds:@[[[self.showTypes[_currentIndex - 1] wrapper] getString:@"Id"]]];
    UIButton *btnType = (UIButton *)[_scrollView viewWithTag:_currentIndex];
    [self setLineAndButtonStatus:btnType];
    
}
#pragma mark - 查看下一个广告
- (void)showNextAds:(NSNotification *)noti{
     NSString *key = [[self.showTypes[_currentIndex - 1] wrapper] getString:@"Id"];
    if (_allAds.count == 1) {

        [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
        //拉取广告
        [self pullAds:@[[[_showTypes[_currentIndex - 1] wrapper] getString:@"Id"]]];

        return;
    }
    
    [_allAds removeObjectAtIndex:0];
    NSMutableArray *tempMutDic = [NSMutableArray arrayWithCapacity:0];
    for (NSDictionary *dic in _allAds) {
        NSDictionary *tempdic = [self cr_getSafeDic:dic];
        [tempMutDic addObject:tempdic];
    }
    [[NSUserDefaults standardUserDefaults] setValue:tempMutDic forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [_advertImgView requestWithRecommandSize:[[_allAds[0] wrapper] getString:@"PictureUrl"] placeHolder:@""];
}

- (NSMutableDictionary *)cr_getSafeDic:(NSDictionary *)dic
{
    NSMutableDictionary *dataDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    
    for (id object in dataDic.allKeys)
    {
        id ret = [dataDic objectForKey:object];
        
        if ([ret isKindOfClass:[NSNull class]])
        {
            [dataDic setValue:@"" forKey:object];
        }
        
        if ([ret isKindOfClass:[NSDictionary class]])
        {
            ret =  [self cr_getSafeDic:ret];
            [dataDic setObject:ret forKey:object];
        }
    }
    
    return dataDic;
}

//跳转广告分类管理/** 下个页面的布局 */
- (PSTCollectionViewFlowLayout *)initManagerCenterInterface
{
    PSTCollectionViewFlowLayout *attributes = WEAK_OBJECT(PSTCollectionViewFlowLayout, init);
    
    [attributes setItemSize:CGSizeMake(90.f, 35.f)];
    [attributes setHeaderReferenceSize:CGSizeMake(320.f, 40.f)];
    [attributes setFooterReferenceSize:CGSizeMake(320.f, 0.f)];
    [attributes setMinimumInteritemSpacing:15.f];
    [attributes setMinimumLineSpacing:10.f];
    [attributes setSectionInset:UIEdgeInsetsMake(10.f, 10.f, 10.f, 10.f)];
    return attributes;
}
//跳转广告分类管理
- (IBAction)arrowButtonClicked:(id)sender
{
    [self initManagerCenterInterface];
    
    HeaderManageCenterViewController *manageCenter = WEAK_OBJECT(HeaderManageCenterViewController, initWithCollectionViewLayout:[self initManagerCenterInterface]);
    manageCenter.curLineTag  = _currentIndex - 1;
    [self.navigationController pushViewController:manageCenter animated:NO];
}
//点击分类列表类型返回
- (void)showCurtypeAds:(NSNotification *)noti{
    self.showTypes = nil;
    self.showTypes = [[[NSUserDefaults standardUserDefaults] valueForKey:UserMarkDefaults] objectForKey:@"isShow"];
    //刷新分类scrollview并拉取广告
    NSNumber *number = [[NSUserDefaults standardUserDefaults] valueForKey:@"HeaderManageCenterCurLineTag"];
    NSInteger curindex = [number integerValue];
    _currentIndex = curindex;
    
    //拉取广告
    [self pullAds:@[[[self.showTypes[curindex - 1] wrapper] getString:@"Id"]]];
    
    //刷新分类scrollview
    [self _initAlltypesAndCreateTypeButton];
    //line和button高亮位置
    
    if (curindex) {
        UIButton *btnType = (UIButton *)[_scrollView viewWithTag:curindex];
        [self setLineAndButtonStatus:btnType];
    }

}
//tap imageview
- (IBAction)tapImageView:(UITapGestureRecognizer *)sender {
    if (_addView.hidden) {
        
        BOOL isPsAds = [[_allAds[0] wrapper] getBool:@"IsPublicServiceAdvert"];
        if (isPsAds) {
            PSAsDetailController *adsDetail = WEAK_OBJECT(PSAsDetailController, init);
            adsDetail.adId = [[_allAds[0] wrapper] getString:@"Id"];
            [self.navigationController pushViewController:adsDetail animated:YES];
        } else {
            AdsDetailViewController *adsDetail = WEAK_OBJECT(AdsDetailViewController, init);
            adsDetail.adId = [[_allAds[0] wrapper] getString:@"Id"];
            [self.navigationController pushViewController:adsDetail animated:YES];
        }
    }
}
//点击进入
- (void)onMoveFoward:(UIButton *)sender{
    
    [self tapImageView:nil];
}

#pragma mark - 不同状态下按钮和线条的状态
- (void)setLineAndButtonStatus:(UIButton *)btnType{
    for (UIView *view in _scrollView.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            [self setBtnTypeNormalStatus:(UIButton *)view];
        }
    }
    _currentIndex = btnType.tag;
    //设置线条
    [self setLineWidth:btnType.frameWidth frameX:btnType.frameX];
    //设置button
    [self setBtnTypeSelectedStatus:btnType];
    //获取line的center
    CGPoint lineCenter = self.line.center;
    //设置偏移量
    if (lineCenter.x > SCREENWIDTH/2 && ((_scrollView.contentSize.width - _line.frameX) > SCREENWIDTH/2)) {
        _scrollView.contentOffset = CGPointMake(lineCenter.x - SCREENWIDTH/2, 0);
    } else {
        if (btnType.tag <= 3) {
            _scrollView.contentOffset = CGPointMake(0, 0);
        } else {
            _scrollView.contentOffset = CGPointMake(lineCenter.x - SCREENWIDTH + btnType.width, 0);
        }
    }
}
//line的位置和宽度
- (void)setLineWidth:(float)width frameX:(float)frameX {
    
    [UIView animateWithDuration:.1 animations:^{
        _line.width = width;
        _line.frameX = frameX;
    }];
    
}
//selelcted状态的button
- (void)setBtnTypeSelectedStatus:(UIButton *)btnType{
    [UIView animateWithDuration:.1 animations:^{
        [btnType setTitleColor:RGBACOLOR(240, 5, 0, 1) forState:UIControlStateNormal];
        btnType.titleLabel.font = [UIFont systemFontOfSize:17.f];
    }];
}
//normal状态的button
- (void)setBtnTypeNormalStatus:(UIButton *)button{
    button.titleLabel.textAlignment     = NSTextAlignmentCenter;
    button.titleLabel.font              = [UIFont systemFontOfSize:14.f];
    [button setTitleColor:RGBACOLOR(34 , 34, 34, 1) forState:UIControlStateNormal];
}

#pragma mark - 管理内存
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [_allAds release];
    [_showTypes release];
    [_scrollView release];
    [_addView release];
    [_advertImgView release];
    [_line release];
    [_bottomLine release];
    [super dealloc];
}

@end
