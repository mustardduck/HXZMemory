//
//  AppDelegate+MJSetup.m
//  miaozhuan
//
//  Created by xm01 on 14-10-28.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "AppDelegate+Setup.h"
#import "LogonViewController.h"
#import "SystemUtil.h"
#import "MallHistory.h"
#import "PlaySound.h"

#import "YLGIFImage.h"
#import "YLImageView.h"
#import "RequestFailedView.h"

#import "CRHttpAddedManager.h"

#import "AppUtils.h"
#import "ControlViewController.h"
#import "HandleOutAdsViewController.h"
#import "PersonalCenterViewController.h"
#import "MallScanAdvertMain.h"
#import "MallSearchViewController.h"
#import "MyMallViewController.h"
#import "MallSearchListViewController.h"
//#import "Management_Index.h"
#import "Reachability.h"
#import "RequestFailed.h"
#import "DetailBannerAdvertViewController.h"
#import "WebhtmlViewController.h"
#import "MerchantHomePageViewController.h"
#import "EditImageViewController.h"

#import "IWManagementViewController.h"

@interface TestView : UIView<MJHeaderContentView>
{
    UILabel *_label;
    UILabel *_time;
    
    UIImageView *_imgN;
    YLImageView *_img;
    
    BOOL    _Once;
}

@end

@implementation TestView

- (instancetype) init
{
    if(!(self = [super init]))
    {
        return self;
    }
    
    _imgN = WEAK_OBJECT(UIImageView, initWithFrame:CGRectMake(110, 25, 30, 30));
    [self addSubview:_imgN];
    _imgN.image = [UIImage imageNamed:@"Loadicon.gif"];
    
    _label = WEAK_OBJECT(UILabel, initWithFrame:CGRectMake(150, 0, 100,80));
    _label.font = Font(15);
    _label.textColor = AppColor(43);
    _label.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_label];
    _label.text = @"下拉刷新";
    _label.backgroundColor = [UIColor clearColor];
    
    return self;
}

- (void) onSetState:(ERefreshState)state
{
    switch (state) {
        case STATE_PULLING:
        {
            _label.text = @"释放立即刷新";
            _Once = YES;
            
            UI_MANAGER.mainNavigationController.visibleViewController.view.userInteractionEnabled = NO;
            break;
        }
        case STATE_NORMAL:
        {
            _label.text = @"下拉刷新";
            [_img removeFromSuperview];
            _imgN.hidden = NO;
            
            UI_MANAGER.mainNavigationController.visibleViewController.view.userInteractionEnabled = YES;
            
            if (_Once) [PlaySound playRefreshVoice];
            _Once = NO;
            break;
        }
        case STATE_REFRESHING:
        {
            _label.text = @"刷新中";
            if (!_img)
            {
                _img = [[YLImageView alloc] initWithFrame:CGRectMake(110, 25, 30, 30)];
                _img.image = [YLGIFImage imageNamed:@"Loadicon.gif"];
            }
            [self addSubview:_img];
            _imgN.hidden = YES;
            
            break;
        }
        case STATE_WILL_REFRESHING:
        {
            break;
        }
    }
}

@end

@interface LoginInfo : NSObject<NSCoding>

@property (nonatomic, retain) NSString* currentUserName;
@property (nonatomic, retain) NSString* currentPassword;
@property (nonatomic, retain) NSString* anonymId;
@property (nonatomic, retain) NSString* curBusinessCard;

+ (LoginInfo* )sharedInstance;

- (void)save;

@end
#define USERDEFKEY_LOGINFO @"TouchShare_LoginInfo"

static LoginInfo* sharedObject = nil;

@interface LoginInfo()
+ (LoginInfo*)load;
@end

@implementation LoginInfo

@synthesize currentUserName;
@synthesize currentPassword;
@synthesize anonymId;
@synthesize curBusinessCard;

+ (LoginInfo* )sharedInstance
{
    @synchronized(self)
    {
        if (sharedObject == nil)
        {
            sharedObject = [self load];
        }
    }
    
    return sharedObject;
}

- (id)retain
{
    return self;
}

- (oneway void)release
{
    // Never release
}

- (id)autorelease
{
    return self;
}

#pragma mark -
#pragma mark NSCoding
- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.currentUserName forKey:@"currentUserName"];
    [encoder encodeObject:self.currentPassword forKey:@"currentPassword"];
    [encoder encodeObject:self.anonymId forKey:@"anonymId"];
    [encoder encodeObject:self.curBusinessCard forKey:@"curBusinessCard"];
}

- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init])
    {
        self.currentUserName = [decoder decodeObjectForKey:@"currentUserName"];
        self.currentPassword = [decoder decodeObjectForKey:@"currentPassword"];
        self.anonymId = [decoder decodeObjectForKey:@"anonymId"];
        self.curBusinessCard = [decoder decodeObjectForKey:@"curBusinessCard"];
        
    }
    
    return self;
}

+ (LoginInfo*)load {
    NSData* data = [[NSUserDefaults standardUserDefaults] objectForKey:USERDEFKEY_LOGINFO] ;
    return [NSKeyedUnarchiver unarchiveObjectWithData:data];
}

- (void)save {
    NSData* data = [NSKeyedArchiver archivedDataWithRootObject:self];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:USERDEFKEY_LOGINFO];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark -
#pragma mark Life Cycle
- (void)dealloc {
    
    [anonymId release];
    [currentUserName release];
    [currentPassword release];
    [curBusinessCard release];
    self.currentUserName = nil;
    self.currentPassword = nil;
    self.curBusinessCard = nil;
    [super dealloc];
}

@end

NSString* APP_EVENT_GPS_LOCATION_CHANGE = @"APP_EVENT_GPS_LOCATION_CHANGE";
NSString* APP_EVENT_ARGUMENT_GPS_LOCATION = @"APP_EVENT_ARGUMENT_GPS_LOCATION";

static MJRefreshURLGenerator s_defaultGenerator = MJREFRESH_URL_GENERATOR_BLOCK
{
    return @{
             @"service":[NSString stringWithFormat:@"%@%@", @"api/ad/v2.1/", refreshName ],
             @"parameters":@{@"customerId":@(1),@"pageIndex":@(pageIndex),@"pageSize":@(pageSize)}
             }.wrapper;
};

static MJRefreshNetData2MJData s_defaultConverter = MJREFRESH_NETDATA2MJDATA_BLOCK
{
    DictionaryWrapper* resultDic = refreshData.data;
    
    if ([resultDic isKindOfClass:[NSNull class]])
    {
        return nil;
    }
    
    APP_ASSERT(resultDic);
    NSArray * pageData   = [resultDic getArray:@"PageData"];
    pageData = pageData ? pageData : @[];
    int pageIndex  = [resultDic getInt:@"PageIndex"];
    
    return @{@"pageIndex":@(pageIndex), @"pageData":pageData}.wrapper;
};

static MJRefreshOnRequestDone s_defaultOnRequestDone = MJREFRESH_ON_REQUEST_DONE
{
    
};

void ADAPI_RefreshPagingData(DelegatorID delegatorID, DictionaryWrapper* params)
{
    DictionaryWrapper* requestParams = [params get:@"requestParams"];
    
    ServerRequestOption* option = [ServerRequestOption optionFromService:[requestParams getString:@"service"] parameters:[requestParams getDictionary:@"parameters"]];
    [option setDelegatorID:delegatorID];
    [option turnOn:OPTION_CHECK_URL_DUPLICATION];
    [option turnOn:OPTION_NEED_HANDLE_ERROR];
    
    if([params getBool:@"needLoading"])
    {
        [option turnOn:OPTION_NEED_LOADING_INDICATOR];
    }
    
    NSLog(@"ADAPI_RefreshPagingData \n%d\n",[params getInt:@"pageIndex"]);
    // Setup data for paging
    [option addOption:@"mjrefresh" value:@"yes"];
    [option addOption:@"pageIndex" value:[params get:@"pageIndex"]];
    [option addOption:@"refreshName" value:[params get:@"refreshName"]];
    
    [NET_SERVICE doRequest:@"APOP_RefreshPagingData" forModule:ADVERT_MODULE withOption:option];
}


static MJRefreshRequest s_defaultRequester = MJREFRESH_REQUEST_BLOCK
{
    ADAPI_RefreshPagingData(delegatorID, refreshData);
    
};

static MJRefreshPrevRequestHandler s_prefRequestHandler = MJREFRESH_PREV_REQUEST_HANDLER
{
    DictionaryWrapper* ret = [arguments getArgument:NET_ARGUMENT_RETOBJECT];
    NSString* message = ret.operationMessage;
//    message = message ? message : @"网络不给力，请检查后重试";
    
    if([arguments getArgument:NET_ARGUMENT_ERROR])
    {
//        [HUDUtil showErrorWithStatus:message];
        
        return FALSE;
    }
    else if(!ret.operationSucceed)
    {
//        [HUDUtil showErrorWithStatus:message];
        
        return FALSE;
    }
    
    return !([CRHttpAddedManager shouldUpdate:ret]);
//    return YES;
};

static MJRefreshPostRequestHandler s_postRequestHandler = MJREFRESH_POST_REQUEST_HANDLER
{
    
};

@implementation AppDelegate (Setup)

#pragma mark - RRRequestFailedDelegate
- (void)didClickRefreshBUtton
{
//    UIViewController *vc = UI_MANAGER.mainNavigationController.visibleViewController;
    [NET_SERVICE doRequest:self.request.operation forModule:self.request.module withOption:self.request.option];
    
}

- (void) onResponse:(DelegatorArguments*)arguments
{
    ServerRequest* request = [arguments getArgument:NET_ARGUMENT_REQUEST];
    DictionaryWrapper* ret = [arguments getArgument:NET_ARGUMENT_RETOBJECT];
    
    self.request = request;
    
    if(!request || (request.error && request.httpStatusCode != 401))
    {
        if(request.isClientError)
            return;
    }
    
    if(request.httpStatusCode == 401)
    {
        [HUDUtil showErrorWithStatus:@"正在尝试重新登录..."];
        dispatch_async(dispatch_get_main_queue(), ^
                       {
                           LGAPI_login([self genDelegatorID:@selector(onLogin:)], nil, nil, LOGIN_FROM_BACKGROUND);
                       });
        
        return ;
    }
    else if(request.error)
    {
        if(self.userState == USER_STATE_LOGIN && [self.request.module isEqualToString:ADVERT_MODULE])
        {
//            [self showRequestFailedView];
            //如果是首页并且有网络
            if([UI_MANAGER.mainNavigationController.visibleViewController isKindOfClass:[ControlViewController class]] && [[AppUtils getInstance] getNetStatus] != AFReachabilityStatusNotReachable)
            {
                
            }
            else
                [self showRequestFailedView];
        }
    }
    [CRHttpAddedManager checkDidshouldUpdate:ret];
}

#pragma mark - RequestFailedDelegate
- (void)didClickedRefresh{
    
    //有网络
    if([[AppUtils getInstance] getNetStatus] != AFReachabilityStatusNotReachable)
    {
        [self refreshCurrentView];
    }
    
}

-(void)refreshCurrentView
{
    UIViewController *ctro = (UIViewController *)self.lastController;
    
    NSString *className = NSStringFromClass([ctro class]);
    
    //关闭
    [[RequestFailed getInstance].view removeFromSuperview];
    [[AppUtils getInstance] setErrorIsShow:NO];
    
    //主页
    if([ctro isKindOfClass:[ControlViewController class]])
    {
        ControlViewController *cvc = (ControlViewController *)ctro;
        [cvc tabbarItemClicked:cvc.tabBtn];
        return;
    }
    
    //商城
    else if([ctro isKindOfClass:[MallScanAdvertMain class]])
    {
        MallScanAdvertMain *mam = (MallScanAdvertMain *)ctro;
        [mam swapPage:mam.tabBtn];
        if(mam.tabBtn.tag == 3)
        {
            [ctro viewDidLoad];
            [ctro viewWillAppear:YES];
            return;
        }
    }
    
    [ctro initWithNibName:className bundle:nil];
    [ctro loadView];
    [ctro viewDidLoad];
    [ctro viewWillLayoutSubviews];
    [ctro viewWillAppear:YES];
}

//Show 无网络，数据错误的页面
- (void)showRequestFailedView
{
    if(self.userState != USER_STATE_LOGIN)
        return;
    
    RequestFailed *requestFailed = [RequestFailed getInstance];
    requestFailed.delegate = self;
    
//    if (self.request.module != ADVERT_MODULE) return;
    
//    if(self.lastController && [UI_MANAGER.mainNavigationController.visibleViewController isKindOfClass:self.lastController])
    if(self.lastController && [NSStringFromClass([UI_MANAGER.mainNavigationController.visibleViewController class]) isEqualToString:NSStringFromClass([self.lastController class])])
        return;
    else if(self.lastController && ![UI_MANAGER.mainNavigationController.visibleViewController isKindOfClass:self.lastController])
    {
        [[AppUtils getInstance] setErrorIsShow:NO];
        [requestFailed.view removeFromSuperview];
    }
    
    int tabBarHeight = 0;
    int originY      = 0;
    
    CGRect frame = [UIScreen mainScreen].applicationFrame;
    frame.origin.y = originY;
    
    
    for (UIView *view in requestFailed.view.subviews) {
        if([view isKindOfClass:[UIView class]])
            [view removeFromSuperview];
    }
    
    
    //如果是网页
    if([UI_MANAGER.mainNavigationController.visibleViewController isKindOfClass:[WebhtmlViewController class]] ||
       [UI_MANAGER.mainNavigationController.visibleViewController isKindOfClass:[DetailBannerAdvertViewController class]] ||
       [UI_MANAGER.mainNavigationController.visibleViewController isKindOfClass:[MerchantHomePageViewController class]])
    {
        tabBarHeight = 0;
        frame.size.height -= UI_MANAGER.mainNavigationController.navigationBar.frame.size.height + tabBarHeight;
        requestFailed.view.frame = frame;
        [requestFailed.view addSubview:requestFailed.viewWeb];
        requestFailed.viewWeb.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        UI_MANAGER.mainNavigationController.visibleViewController.title = @"暂无内容";
    }
    
    //如果是首页
    else if([UI_MANAGER.mainNavigationController.visibleViewController isKindOfClass:[ControlViewController class]])
    {
        tabBarHeight = 50;
        frame.size.height = 20;
        requestFailed.view.frame = frame;
        requestFailed.viewIndex.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        [requestFailed.view addSubview:requestFailed.viewIndex];
    }
    
    else
    {
        //商城搜索 不显示
        if([UI_MANAGER.mainNavigationController.visibleViewController isKindOfClass:[MallSearchListViewController class]])
            return;
        
        //底部有导航条的，减去其导航条高度
        else if([UI_MANAGER.mainNavigationController.visibleViewController isKindOfClass:[HandleOutAdsViewController class]]    ||
                [UI_MANAGER.mainNavigationController.visibleViewController isKindOfClass:[PersonalCenterViewController class]]  ||
                [UI_MANAGER.mainNavigationController.visibleViewController isKindOfClass:[MallScanAdvertMain class]]            ||
                [UI_MANAGER.mainNavigationController.visibleViewController isKindOfClass:[MallSearchViewController class]]      ||
                [UI_MANAGER.mainNavigationController.visibleViewController isKindOfClass:[MyMallViewController class]]          ||
                [UI_MANAGER.mainNavigationController.visibleViewController isKindOfClass:[MallScanAdvertMain class]]
                )
            tabBarHeight = 50;
        else
            tabBarHeight = 0;
        
        frame.size.height -= UI_MANAGER.mainNavigationController.navigationBar.frame.size.height + tabBarHeight;
        
        requestFailed.view.frame = frame;
        
        requestFailed.viewNoNet.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        
        [requestFailed.view addSubview:requestFailed.viewNoNet];
    }
    
    
    [UI_MANAGER.mainNavigationController.visibleViewController.view addSubview:requestFailed.view];
    
    self.lastController = UI_MANAGER.mainNavigationController.visibleViewController;
}

- (void) onRequest:(DelegatorArguments*)arguments
{
    
    NSString* module    = [arguments getArgument:NET_ARGUMENT_MODULE];
    ServerRequestOption *option = [arguments getArgument:NET_ARGUMENT_OPTION];
    
    if(self.userState != USER_STATE_LOGIN)
    {
        if(![module isEqualToString:LOGIN_MODULE] && ![module isEqualToString:REGISTRATION_MODULE])
        {
            [option turnOn:OPTION_REQUEST_FILTERED];
            
            // Note : if you want to do this API if user not login, add your code above
            LOG_DBUG(@"Warning : %@ %@ is filtered and not send to server", module, [arguments getArgument:NET_ARGUMENT_OPERATION]);
        }
    }
    else
    {
        if([UI_MANAGER.mainNavigationController.visibleViewController isKindOfClass:[EditImageViewController class]])
        {
            AFReachabilityStatus status = [[AppUtils getInstance] getNetStatus];
            if(status == AFReachabilityStatusNotReachable)
            {
                [HUDUtil showErrorWithStatus:@"网络不给力，请检查后重试"];
            }
        }
    }
}

-(void)noNetStatus:(NSNotification *)ns
{
//    if([[ns.userInfo valueForKey:@"AFNetworkingReachabilityNotificationStatusItem"] intValue] == 0)
//        [[AppUtils getInstance] setNetStatus:AFReachabilityStatusNotReachable];
//    else if([[ns.userInfo valueForKey:@"AFNetworkingReachabilityNotificationStatusItem"] intValue] == 1)
//        [[AppUtils getInstance] setNetStatus:AFReachabilityStatusReachableViaWWAN];
//    else if([[ns.userInfo valueForKey:@"AFNetworkingReachabilityNotificationStatusItem"] intValue] == 2)
//        [[AppUtils getInstance] setNetStatus:AFReachabilityStatusReachableViaWiFi];
    
//    [self atIndexShowFailedView:[[ns.userInfo valueForKey:@"AFNetworkingReachabilityNotificationStatusItem"] intValue]];
}

-(void)noNetStatus2:(NSNotification *)ns
{
    AFReachabilityStatus status = [[AppUtils getInstance] getNetStatus];
    
    //网络状态变化，清空
    self.lastController = nil;
    
    //无网，页面未显示
    if(status == AFReachabilityStatusNotReachable && [UI_MANAGER.mainNavigationController.visibleViewController isKindOfClass:[ControlViewController class]]  && self.userState == USER_STATE_LOGIN)
    {
        BOOL isShow = NO;
        for (UIView *view in [UI_MANAGER.mainNavigationController.visibleViewController.view subviews]) {
            if([view isKindOfClass:[UIView class]])
            {
                if(view.tag == 999)
                    isShow = YES;
            }
        }
        if(!isShow)
        [self showRequestFailedView];
    }
    
    //有网, 已显示
    else if((status == AFReachabilityStatusReachableViaWiFi || status == AFReachabilityStatusReachableViaWWAN) && [UI_MANAGER.mainNavigationController.visibleViewController isKindOfClass:[ControlViewController class]]  && self.userState == USER_STATE_LOGIN)
    {
        BOOL isShow = NO;
        for (UIView *view in [UI_MANAGER.mainNavigationController.visibleViewController.view subviews]) {
            if([view isKindOfClass:[UIView class]])
            {
                if(view.tag == 999)
                    isShow = YES;
            }
        }
        if(isShow)
        [self refreshCurrentView];
    }
}

//在首页 无网络情况 弹出提示页
-(void)atIndexShowFailedView:(int)status
{
    if(status == 0)
    {
        if([UI_MANAGER.mainNavigationController.visibleViewController isKindOfClass:[ControlViewController class]])
        {
            if(![RequestFailed getInstance].isShow)
                [self showRequestFailedView];
        }
    }
}

- (void) onNetStatusChange:(DelegatorArguments*)arguments
{
    ENetStatus netStatus = [[arguments getArgument:NET_EVENT_ARGUMENT_NET_STATUS] intValue];
    switch (netStatus)
    {
        case NET_STATUS_DOWN:
        {
//            [HUDUtil showErrorWithStatus:@"网络不给力,请检查重试"];
            break;
        }
        case NET_STATUS_WWAN:
        {
            [HUDUtil showSuccessWithStatus:@"当前连接移动网络"];
            break;
        }
        case NET_STATUS_WIFI:
        {
            [HUDUtil showSuccessWithStatus:@"当前连接WIFI网络"];
            break;
        }
        default:
        {
            break;
        }
    }
    
    switch(netStatus)
    {
            
        case NET_STATUS_WWAN:
        {
//            [self.runtimeConfig set:HEADER_FIELDS".m-nw" value:@"WWAN"];
            [self.runtimeConfig set:HEADER_FIELDS".m-nw" value:[AppUtils getNetWorkStates]];
            NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
            [userDefault setObject:[AppUtils getNetWorkStates] forKey:@"kMZNetWorkStates"];
            [userDefault synchronize];
            
            break;
        }
        case NET_STATUS_WIFI:
        {
//            [self.runtimeConfig set:HEADER_FIELDS".m-nw" value:@"WIFI"];
            [self.runtimeConfig set:HEADER_FIELDS".m-nw" value:@"wifi"];
            NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
            [userDefault setObject:@"wifi" forKey:@"kMZNetWorkStates"];
            [userDefault synchronize];
        }
        default:
        {
            
        }
            
    }
}

- (void) setupDefautHeaderFields
{
    [self.runtimeConfig set:HEADER_FIELDS".m-iv" value:[GLOBAL_CONFIG getString:@"COMMON.SERVER_API_VERSION"]];
    [self.runtimeConfig set:HEADER_FIELDS".m-cv" value:[GLOBAL_CONFIG getString:@"COMMON.CLIENT_VERSION"]];
    [self.runtimeConfig set:HEADER_FIELDS".m-ct" value:@"2"];
    
    switch(NET_SERVICE.netStatus)
    {
        case NET_STATUS_WWAN:
        {
//            [self.runtimeConfig set:HEADER_FIELDS".m-nw" value:@"WWAN"];
            [self.runtimeConfig set:HEADER_FIELDS".m-nw" value:[AppUtils getNetWorkStates]];
            break;
        }
        case NET_STATUS_WIFI:
        {
            [self.runtimeConfig set:HEADER_FIELDS".m-nw" value:@"wifi"];
            break;
        }
        default:
        {
            
        }
    }
    
    int w = [UIScreen mainScreen].bounds.size.width;
    int h = [UIScreen mainScreen].bounds.size.height;
    [self.runtimeConfig set:HEADER_FIELDS".m-cw" value:@(w).description];
    [self.runtimeConfig set:HEADER_FIELDS".m-ch" value:@(h).description];
}

- (void) setupMJDefaultBlocks
{
    [MJRefreshController setDefaultURLGenerator:s_defaultGenerator];
    [MJRefreshController setDefaultRequester:s_defaultRequester];
    [MJRefreshController setDefaultPrevRequestHandler:s_prefRequestHandler];
    [MJRefreshController setDefaultPostRequestHandler:s_postRequestHandler];
    [MJRefreshController setDefaultOnRequestDone:s_defaultOnRequestDone];
    [MJRefreshController setDefaultDataConverter:s_defaultConverter];
    [MJRefreshController setDefaultHeaderContentViewClass:[TestView class]];
}

- (void) setupNetServiceEventListeners
{
    [NET_SERVICE on:NET_EVENT_RESPONSE object:self selector:@selector(onResponse:)];
    [NET_SERVICE on:NET_EVENT_REQUEST object:self selector:@selector(onRequest:)];
    [NET_SERVICE on:NET_EVENT_NET_STATUS_CHANGE object:self selector:@selector(onNetStatusChange:)];
}

- (void) onGPSLocationChange:(DelegatorArguments*)arguments
{
    DictionaryWrapper* location = [[arguments getArgument:APP_EVENT_ARGUMENT_GPS_LOCATION] wrapper];
    
    [self.runtimeConfig set:HEADER_FIELDS".m-lng" value:[location getString:@"m-lng"]];
    [self.runtimeConfig set:HEADER_FIELDS".m-lat" value:[location getString:@"m-lat"]];
    [self.runtimeConfig set:HEADER_FIELDS".m-lt" value:[location getString:@"m-lt"]];
}

//by Abyss 15-1-4
- (void) setGPSPositon:(DictionaryWrapper *)position
{
    NSString* lt  = nil;
    NSString* lng = nil;
    NSString* lat = nil;
    DelegatorArguments *arguments = nil;
    
    if ([position isKindOfClass:[DictionaryWrapper class]])
    {
        if (position.dictionary.allKeys == 0) return;
        
        lt  = [position getString:@"m-lt"];
        lng = [position getString:@"m-lng"];
        lat = [position getString:@"m-lat"];
        
        if ([lt isEqual:@"1"])
        {
            NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
            [userDefault setObject:lng forKey:@"kMZLongitude"];
            [userDefault setObject:lat forKey:@"kMZLatitude"];
            [userDefault setObject:lt forKey:@"kMZGPSType"];
            [userDefault synchronize];
            
            
            NSDictionary *resultDic = @{@"m-lt":lt,@"m-lng":lng?lng:@"0",@"m-lat":lat?lat:@"0"};
            arguments = [DelegatorArguments argumentsFrom:APP_EVENT_ARGUMENT_GPS_LOCATION arg:resultDic];
            
            [self fire:APP_EVENT_GPS_LOCATION_CHANGE arguments:arguments];
        }
    }
}

- (void) setupOnDifferentVersion
{
    if(![self.persistConfig getBool:OTHERS_3_0_LATER])
    {
        [self.persistConfig set:OTHERS_3_0_LATER bool:TRUE];
        
        // Fix user info part
        NSString* userName     = nil;
        NSString* userPassword = nil;
        LoginInfo* loginInfo = [LoginInfo load];
        if(loginInfo)
        {
            userName = loginInfo.currentUserName;
            userPassword = loginInfo.currentPassword;
        }
        
        if(userName.length > 0 && userPassword.length > 0)
        {
            [self.persistConfig set:USER_INFO_NAME value:userName];
            [self.persistConfig set:USER_INFO_PASSWORD value:userPassword];
        }
        
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:USERDEFKEY_LOGINFO];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (void) setup
{
    [self on:APP_EVENT_GPS_LOCATION_CHANGE object:self selector:@selector(onGPSLocationChange:)];
    [self on:APP_EVENT_USER_STATE_CHANGE object:self selector:@selector(onUserStateChange:)];
    
    [self setUserState:USER_STATE_UNKNOWN];
    
    [self setupOnDifferentVersion];
    
    [self setupDefautHeaderFields];
    
    [self setupNetServiceEventListeners];
    
    [self setupMJDefaultBlocks];
    
    //注册网络状态监听，容错率。用于监测无网络状态
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(noNetStatus:) name:@"com.alamofire.networking.reachability.change" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(noNetStatus2:) name:@"kReachabilityChangedNotification_DotC" object:nil];
}

@end


NSString* APP_EVENT_USER_STATE_CHANGE = @"APP_EVENT_USER_STATE_CHANGED";
NSString* APP_EVENT_ARGUMENT_USER_OLD_STATE = @"APP_EVENT_ARGUMENT_USER_OLD_STATE";
NSString* APP_EVENT_ARGUMENT_USER_STATE = @"APP_EVENT_ARGUMENT_USER_STATE";

@implementation AppDelegate (UserState)

- (void) onUserStateChange:(DelegatorArguments*)arguments
{
    NSLog(@"onUserStateChange %@ => %@", [arguments getArgument:APP_EVENT_ARGUMENT_USER_OLD_STATE], [arguments getArgument:APP_EVENT_ARGUMENT_USER_STATE]);
    
    EUserState state    = [[arguments getArgument:APP_EVENT_ARGUMENT_USER_STATE] intValue];
    if(state == USER_STATE_LOGIN)
    {
        NSString* name = [NSString stringWithFormat:@"__USER_CONFIG_%@", [self.persistConfig getString:USER_INFO_NAME]];
        
        self.userConfig = [WPDictionaryWrapper wrapperFromName:name];
    }
    if (state == USER_STATE_LOGOUT)
    {
        [APP_DELEGATE.runtimeConfig set:RUNTIME_USER_LOGIN_INFO value:@""];
        
        self.userConfig = nil;
    }
}

- (void) setUserState:(EUserState)state
{
    EUserState oldState = [self.runtimeConfig getInt:USER_STATE];
    
    if(oldState != state)
    {
        [self.runtimeConfig set:USER_STATE int:state];
        
        DelegatorArguments* arguments = [DelegatorArguments argumentsFrom:APP_EVENT_ARGUMENT_USER_OLD_STATE arg0:@(oldState)
                                                                    name1:APP_EVENT_ARGUMENT_USER_STATE arg1:@(state)];
        
        [self fire:APP_EVENT_USER_STATE_CHANGE arguments:arguments];
    }
}

- (EUserState) userState
{
    return [self.runtimeConfig getInt:USER_STATE];
}

@end

#import "HelpViewController.h"
#import "LoginViewController.h"
#import "ControlViewController.h"
#import "SharedData.h"

@implementation AppDelegate (Goto)

- (void) onLoginRequestSucceed:(DelegatorArguments*)arguments
{
    if(   [[arguments getArgument:NET_ARGUMENT_MODULE] isEqualToString:LOGIN_MODULE]
       && [[arguments getArgument:NET_ARGUMENT_OPERATION] isEqualToString:LGOP_login]
    )
    {
        NSLog(@"%@",[arguments.ret description]);
        NSString* phone = [arguments.ret.data getString:@"UserName"];
        ServerRequestOption* option = [arguments getArgument:NET_ARGUMENT_OPTION];
        ELoginFrom loginFrom = [[option option:@"LOGIN_FROM"] intValue];
        
        [[SharedData getInstance].personalInfo setupDataInfo:[arguments.ret.data dictionary]]; //cena
        
        switch(loginFrom)
        {
            case LOGIN_FROM_AUTO:
            {
                NSLog(@"Auto Login");
                
                [self.persistConfig set:USER_INFO_NAME value: [option option:@"LOGIN_USER_NAME" ]];
                [self.persistConfig set:USER_INFO_PASSWORD value: [option option:@"LOGIN_USER_PASSWORD"]];
                
                break;
            }
            case LOGIN_FROM_MANUAL:
            {
                NSLog(@"Manual Login");
                
                [self.persistConfig set:USER_INFO_NAME value: [option option:@"LOGIN_USER_NAME" ]];
                [self.persistConfig set:USER_INFO_PASSWORD value: [option option:@"LOGIN_USER_PASSWORD"]];
                
                break;
            }
            case LOGIN_FROM_BACKGROUND:
            {
                NSLog(@"Background Login");
                break;
            }
        }
    }
    else if ([[arguments getArgument:NET_ARGUMENT_MODULE] isEqualToString:REGISTRATION_MODULE]
             && [[arguments getArgument:NET_ARGUMENT_OPERATION] isEqualToString:LGOP_register])
    {
//        ServerRequestOption* option = [arguments getArgument:NET_ARGUMENT_OPTION];
    }
    
    [APP_DELEGATE.runtimeConfig set:RUNTIME_USER_LOGIN_INFO value:arguments.ret.data];
    [MallHistory_Manager reSet];
    [self setUserState:USER_STATE_LOGIN];
}

- (void) onLogin:(DelegatorArguments*)arguments
{
    if([arguments getArgument:NET_ARGUMENT_ERROR])
    {
        [self gotoLogin];
        
        return ;
    }
    
    DictionaryWrapper* ret = [arguments getArgument:NET_ARGUMENT_RETOBJECT];
    if(!ret.operationSucceed)
    {
        [HUDUtil showErrorWithStatus:ret.operationMessage];
        
        [self gotoLogin];
        
        return ;
    }
    
    [self onLoginRequestSucceed:arguments];
    [self sendToken];
}

- (void)sendToken
{
    NSString *a = [[NSUserDefaults standardUserDefaults] valueForKey:@"token"];
    NSString *b = [[NSUserDefaults standardUserDefaults] valueForKey:@"appid"];
    NSString *c = [[NSUserDefaults standardUserDefaults] valueForKey:@"userid"];
    NSString *d = [[NSUserDefaults standardUserDefaults] valueForKey:@"channelid"];
    NSString *e = [[NSUserDefaults standardUserDefaults] valueForKey:@"PushVersion"];
    
    if (!a||!b||!c||!d||!e) return;
    ADAPI_adv3_push_Update([GLOBAL_DELEGATOR_MANAGER addDelegator:self selector:@selector(responseReport:)],
                           a,
                           b,
                           c,
                           d,
                           e);
    //更新设备信息
}

- (void)responseReport:(DelegatorArguments *)arg
{
    NSLog(@"%@",arg.ret);
}

- (void) gotoWelcome
{
    [self setUserState:USER_STATE_LOGOUT];
    
    [self gotoLogin];
}

- (void) gotoAutoLogin
{
    [self setUserState:USER_STATE_LOGOUT];
    
    NSString* userName     = [self.persistConfig getString:USER_INFO_NAME];
    NSString* userPassword = [self.persistConfig getString:USER_INFO_PASSWORD];
    
    if(userName.length > 0 && userPassword.length > 0)
    {
        LGAPI_login([self genDelegatorID:@selector(onLogin:)], userName, userPassword, LOGIN_FROM_AUTO);
        
        [self gotoHome];
    }
    else
    {
        [self gotoLogin];
    }
}

- (void) gotoLogin
{
    [self setUserState:USER_STATE_LOGOUT];
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"NotFirst"])
        [UI_MANAGER startWithClass:[LoginViewController class] animated:TRUE];
    else
        [UI_MANAGER startWithClass:[HelpViewController class] animated:TRUE];
}

- (void) gotoHome
{
    [self getGPSLocationPosition];
    
    [UI_MANAGER startWithClass:[ControlViewController class] animated:TRUE];
}

- (void) gotoLogout
{
    [self setUserState:USER_STATE_LOGOUT];
    
    [self gotoLogin];
}

- (void)getGPSLocationPosition
{
    if (!self.locationManager)
    {
        self.locationManager = STRONG_OBJECT(CLLocationManager, init);
    }
    
    if (![CLLocationManager locationServicesEnabled] || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied)
    {
        [HUDUtil showErrorWithStatus:@"定位服务当前可能尚未打开，请去设置-隐私-定位服务里打开！"];
        
        return;
    }
    
    NSLog(@"%d",[CLLocationManager authorizationStatus]);
    //如果没有授权则请求用户授权
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined)
    {
        if ([SystemUtil aboveIOS8_0])
        {
            [self.locationManager requestWhenInUseAuthorization];
        }
    }
    //设置代理
    self.locationManager.delegate = self;
    //设置定位精度
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    //定位频率,每隔多少米定位一次
    CLLocationDistance distance = 100.0;
    self.locationManager.distanceFilter = distance;
    //启动跟踪定位
    [self.locationManager startUpdatingLocation];
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *location= [locations firstObject];//取出第一个位置
    CLLocationCoordinate2D newPosition = location.coordinate; //位置坐标
    
//    CLLocationCoordinate2D mars     = [self CRTranslateFromGPStoBMap:newPosition];
//    CLLocationCoordinate2D baidu    = [self bd_encrypt:mars.longitude andLon:mars.latitude];
    DictionaryWrapper *nowPosition = @{@"m-lng":[NSString stringWithFormat:@"%f",newPosition.longitude],
                                       @"m-lat":[NSString stringWithFormat:@"%f",newPosition.latitude],
                                       @"m-lt":@(1)}.wrapper;
    [self setGPSPositon:nowPosition];
    [self.locationManager stopUpdatingLocation];
}
@end

@implementation EnterpriseInfo

+ (int) ID
{
    return [APP_DELEGATE.runtimeConfig getInt:RUNTIME_USER_LOGIN_INFO".EnterpriseId"];
}

+ (NSString*) name
{

    NSString* ret = [APP_DELEGATE.runtimeConfig getString:RUNTIME_USER_LOGIN_INFO".EnterpriseName"];
    ret = ret ? ret : @"";
    return ret;
}







@end
