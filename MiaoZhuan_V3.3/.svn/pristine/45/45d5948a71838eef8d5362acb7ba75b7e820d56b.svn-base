//
//  Preview_Commodity.m
//  UIAnimation
//
//  Created by apple on 14/12/31.
//
//

#import "Preview_Commodity.h"
#import "ModelData.h"
#import "RCScrollView.h"
#import "NetImageView.h"
#import "UIView+expanded.h"
//#import "CycleView.h"
#import "RoutineScrollView.h"

#import "ShippingConsultViewController.h"
#import "MerchantDetailViewController.h"

#import "ConfirmOrderViewController.h"

#import "KxMenu.h"
#import "ControlViewController.h"

#import "MallHistory.h"

#import "VipPriviliegeViewController.h"
#import "UserInfo.h"
#import "MallScanAdvertMain.h"
#import "BrowseRecordViewController.h"
#import "Share_Method.h"
#import "AppUtils.h"
#import "UIImage+LK.h"
#import "CRScrollController.h"
#import "PreviewViewController.h"
//#import "UIImageView+WebCache.h"

#import "RealNameAuthenticationViewController.h"

#import "Redbutton.h"

@class NetImageView;
@class Enterprise;

#define top1_btn_space          8

@interface Preview_Commodity ()<KxMenuDelegate>
{
    NSArray                 *_specifications;                   //产品
    NSArray                 *_pictures;                         //商品图片
    NSArray                 *_introductionPictures;             //商品介绍图片
    
    NSString                *_chooseSpecification;              //选中的型号，用于生成订单
    
    int                     _item_onhandQtyCount;               //当前选项库存量
    
    RoutineScrollView *_rsView;
    NSMutableArray          *_styleBtns;
    
    int interfaceCount;
    
    BOOL agree;
}

@property(nonatomic, retain) IBOutlet UIScrollView          *baseScroll;

@property(nonatomic, retain) IBOutlet UIView                *imageScroll;

@property(nonatomic, retain) IBOutlet UIView                *top0;
@property(nonatomic, retain) IBOutlet UILabel               *productName;           //商品名称
@property(nonatomic, retain) IBOutlet UILabel               *productFeature;        //商品特色
@property(nonatomic, retain) IBOutlet UILabel               *priceRange;            //价格范围
@property(nonatomic, retain) IBOutlet UIImageView           *freeShipping;          //包邮图片
@property(nonatomic, retain) IBOutlet UILabel               *onhandQty;             //库存

@property(nonatomic, retain) IBOutlet UIView                *top1;
@property(nonatomic, retain) IBOutlet UITextField           *tf_count;

@property(nonatomic, retain) IBOutlet UIView                *top2;
@property(nonatomic, retain) IBOutlet UIButton              *btn_consult;           //咨询
@property(nonatomic, retain) IBOutlet UIButton              *btn_shop;              //店铺
@property(nonatomic, retain) Enterprise                     *obj_enterprise;        //商家对象
@property(nonatomic, retain) IBOutlet UILabel               *postil;                //批注
@property(nonatomic, retain) IBOutlet UILabel               *enterpriseName;        //企业名称

@property(nonatomic, retain) IBOutlet UIView                *top3;
@property(nonatomic, retain) IBOutlet UILabel               *title_introduce;         //商品介绍
@property(nonatomic, retain) IBOutlet UILabel               *title_service;           //售后服务
@property(nonatomic, retain) IBOutlet UIView                *slipBar;                 //滑动条
@property(nonatomic, retain) IBOutlet NetImageView          *headImage;
@property(nonatomic, retain) IBOutlet UIView                *view_introduce;          //介绍页
@property(nonatomic, retain) IBOutlet UILabel               *lab_introduce;           //内容
@property(nonatomic, retain) IBOutlet UIView                *view_service;            //售后页
@property(nonatomic, retain) IBOutlet UILabel               *lab_service;             //内容
@property(nonatomic, retain) IBOutlet UIView                *view_illustrate;         //说明页

@property(nonatomic, retain) IBOutlet UIView                *view_tools;              //功能页，收藏，购买
@property(nonatomic, retain) IBOutlet UIImageView           *img_favorite;            //收藏图片
@property(nonatomic, retain) IBOutlet UIButton              *btn_favorite;            //收藏按钮

@property(nonatomic, retain) IBOutlet UIButton              *btn_plus;
@property(nonatomic, retain) IBOutlet UIButton              *btn_minus;

@property(nonatomic, retain) IBOutlet UIView                *centerLineView;

@property(nonatomic, retain) NSArray                        *pictures;
@property (retain, nonatomic) IBOutlet UIView *protocolView;
@property (retain, nonatomic) IBOutlet UILabel *protocolTitle;
@property (retain, nonatomic) IBOutlet UIWebView *protocolContent;

@property (retain, nonatomic) IBOutlet UIButton *agreeBtn;
@property (retain, nonatomic) IBOutlet Redbutton *protocolbtn;
@property (retain, nonatomic) IBOutlet UIImageView *agreeImage;
@property (retain, nonatomic) IBOutlet UIView *blackView;
@property (retain, nonatomic) IBOutlet UIButton *blackBtn;

- (IBAction)protocolBtn:(id)sender;
@end

@implementation Preview_Commodity

-(void)dealloc
{
    CRDEBUG_DEALLOC();
    
    [_baseScroll release];
    [_imageScroll release];
    [_top0 release];
    [_productName release];
    [_productFeature release];
    [_priceRange release];
    [_freeShipping release];
    [_onhandQty release];
    
    [_top1 release];
    [_tf_count release];
    
    [_top2 release];
    [_btn_consult release];
    [_btn_shop release];
    [_obj_enterprise release];
    [_postil release];
    [_enterpriseName release];
    [_title_introduce release];
    [_title_service release];
    [_slipBar release];
    [_headImage release];
    
    [_view_introduce release];
    [_lab_introduce release];
    [_view_service release];
    [_lab_service release];
    [_view_illustrate release];
    
    [_view_tools release];
    [_img_favorite release];
    [_btn_favorite release];
    
    [_btn_plus  release];
    [_btn_minus release];
    
    [_centerLineView release];
    [_pictures release];
    [_styleBtns release];
    
    [_protocolView release];
    [_protocolTitle release];
    [_agreeBtn release];
    [_protocolbtn release];
    [_agreeImage release];
    [_blackView release];
    [_blackBtn release];
    [_protocolContent release];
    [super dealloc];
}

-(void)viewDidUnload
{
    [super viewDidUnload];
    self.baseScroll = nil;
    self.imageScroll = nil;
    self.top0 = nil;
    self.productName = nil;
    self.productFeature = nil;
    self.priceRange = nil;
    self.freeShipping = nil;
    self.onhandQty = nil;
    
    self.top1 = nil;
    self.tf_count = nil;
    
    self.top2 = nil;
    self.btn_consult = nil;
    self.btn_shop = nil;
    self.obj_enterprise = nil;
    self.postil = nil;
    self.enterpriseName = nil;
    self.title_introduce = nil;
    self.title_service = nil;
    self.slipBar = nil;
    self.headImage = nil;
    
    self.view_introduce = nil;
    self.lab_introduce = nil;
    self.view_service = nil;
    self.lab_service = nil;
    self.view_illustrate = nil;
    
    self.view_tools = nil;
    self.img_favorite = nil;
    self.btn_favorite = nil;
    
    self.btn_plus = nil;
    self.btn_minus = nil;
    
    self.centerLineView = nil;
    self.pictures = nil;
}

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tf_count.userInteractionEnabled = NO;
    
    if(_whereFrom == 0)
    {
        if (_comeformCounsel == 1)
        {
            InitNav(@"");
        }
        else
        {
            self.navigationItem.hidesBackButton =YES;
            self.navigationItem.title = @"预览";
            [self setupMoveFowardButtonWithTitle:@"关闭"];
        }
        
        //隐藏购买功能
        _view_tools.hidden = YES;
        _btn_minus.userInteractionEnabled = NO;
        _btn_plus.userInteractionEnabled = NO;
        
        _btn_consult.enabled = NO;
        _btn_shop.enabled = NO;
    }
    else
    {
        InitNav(@"");
        [self setupMoveFowardButtonWithImage:@"more" In:@"morehover"];
        _btn_minus.enabled = NO;
    }
    
    [_headImage roundCornerBorder];
    _headImage.layer.cornerRadius = 11.0f;
    
    _tf_count.text = @"1";
    
    [_btn_consult roundCornerBorder];
    
    [_btn_shop roundCornerBorder];
    
    //底部toolBar
    CGRect frame = _view_tools.frame;
    frame.origin.y = [UIScreen mainScreen].bounds.size.height - frame.size.height - self.navigationController.navigationBar.frame.size.height - 20;
    
    _view_tools.frame = frame;
    [_view_tools addSubview:[AppUtils LineView:0.5f]];
    [self.view addSubview:_view_tools];
    
    //添加ScrollView
    _rsView = [[RoutineScrollView alloc] initWithParameters:_imageScroll.frame pictures:nil];
    _rsView.previe_obj = self;
    [_imageScroll addSubview:_rsView.view];
    
    _styleBtns = [[NSMutableArray alloc] init];
    
    ADAPI_PreviewCommodity([GLOBAL_DELEGATOR_MANAGER addDelegator:self selector:@selector(handleSucceed:)], _productId);
    
    agree = YES;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    _item_onhandQtyCount = 0;
    
    if(interfaceCount > 0)
        ADAPI_PreviewCommodity([GLOBAL_DELEGATOR_MANAGER addDelegator:self selector:@selector(refresh:)], _productId);
    else
        interfaceCount++;
}

-(void)refresh:(DelegatorArguments *)arguments
{
    if(_styleBtns && [_styleBtns count] > 0)
    {
        DictionaryWrapper *Datas = arguments.ret;
        DictionaryWrapper *wrapper = [Datas getDictionaryWrapper:@"Data"];
        
        if (!Datas.operationSucceed) return;
        
        _specifications = [[wrapper getArray:@"Specifications"] retain];
        
        //库存总数
        int allOnhandQty = 0;
        
        int i = 0;
        
        int chooseOnhandQty = 0;
        
        for(NSDictionary *dic in _specifications)
        {
            
            DictionaryWrapper *item = dic.wrapper;
            
            
            UIButton *btn = [_styleBtns objectAtIndex:i];
            
            if([item getInt:@"Remains"] == 0)
            {
                btn.enabled = NO;
                btn.alpha = 0.4f;
                btn.titleLabel.alpha = 0.4f;
                
                [btn roundCornerBorder];
                btn.layer.borderColor = [RGBCOLOR(204.0f, 204.0f, 204.0f) CGColor];
                [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                
                if([_chooseSpecification isEqualToString:btn.titleLabel.text])
                    _chooseSpecification = @"";
            }
            else
            {
                if([_chooseSpecification isEqualToString:btn.titleLabel.text])
                {
                    chooseOnhandQty = [item getInt:@"Remains"];
                }
            }
            
            _item_onhandQtyCount = [item getInt:@"Remains"];
            
//            [btn roundCornerBorder];
//            btn.layer.borderColor = [RGBCOLOR(204.0f, 204.0f, 204.0f) CGColor];
            
            if(_whereFrom == 0)
            {
                btn.enabled = NO;
                [btn setTitleColor:RGBCOLOR(204.0f, 204.0f, 204.0f) forState:UIControlStateNormal];
            }
            
            allOnhandQty += [item getInt:@"Remains"];
            
            i++;
        }
        
        if(chooseOnhandQty > 0)
            _onhandQty.text = [NSString stringWithFormat:@"库存：%d", chooseOnhandQty];
        else
            _onhandQty.text = [NSString stringWithFormat:@"库存：%d", allOnhandQty];
        
        _tf_count.text = @"1";
    }
}

//点击 --- 关闭
- (void)onMoveFoward:(UIButton *)sender
{
    if(_whereFrom == 0)
        [self.navigationController popViewControllerAnimated:YES];
    
    // show menu
    else
    {
        
        if(![KxMenu isOpen])
        {
            NSArray *menuItems =
            @[
              
              [KxMenuItem menuItem:@"秒赚首页"
                             image:[UIImage imageNamed:@"preview_menu_0_0"]
                            highlight:[UIImage imageNamed:@"preview_menu_0_1"]
                            target:self
                            action:@selector(pushMenuItem:)],
              
              [KxMenuItem menuItem:@"商城首页"
                             image:[UIImage imageNamed:@"preview_menu_1_0"]
                            highlight:[UIImage imageNamed:@"preview_menu_1_1"]
                            target:self
                            action:@selector(pushMenuItem:)],
              
              [KxMenuItem menuItem:@"浏览记录"
                             image:[UIImage imageNamed:@"preview_menu_2_0"]
                            highlight:[UIImage imageNamed:@"preview_menu_2_1"]
                            target:self
                            action:@selector(pushMenuItem:)],
              
              [KxMenuItem menuItem:@"分享给朋友"
                             image:[UIImage imageNamed:@"preview_menu_3_0"]
                            highlight:[UIImage imageNamed:@"preview_menu_3_1"]
                            target:self
                            action:@selector(pushMenuItem:)],
              ];
            
            
            CGRect rect = sender.frame;
            rect.origin.y = self.navigationController.navigationBar.frame.size.height;
            
            [KxMenu showMenuInView:self.navigationController.view
                          fromRect:rect
                         menuItems:menuItems
                         itemWidth:140.f];
            [KxMenu sharedMenu].delegate = self;
        }
        else
        {
            [KxMenu dismissMenu];
        }
    }
}

//打开Menu
- (void) pushMenuItem:(id)sender
{
    NSLog(@"%@", sender);
}

//生成订单 --- Call Back
-(void)handleCreatedOrder:(DelegatorArguments *)arguments
{
    DictionaryWrapper *Datas = arguments.ret;
    
    if ([arguments isEqualToOperation:ADOP_Payment_GoCommonOrderShow])
    {
        [arguments logError];
    
        DictionaryWrapper *dic = [Datas getDictionaryWrapper:@"Data"];
        
        if(Datas.operationSucceed)
        {
            
            PUSH_VIEWCONTROLLER(ConfirmOrderViewController);
            model.type = 2;
            
            
            NSString *serialNo = @"";
            
            if(![[dic getString:@"OrderSerialNo"] isEqualToString:@""] && [dic getString:@"OrderSerialNo"] != nil && ![[dic getString:@"OrderSerialNo"] isEqual:[NSNull null]])
                serialNo = [dic getString:@"OrderSerialNo"];
            
            model.orderInfoDic = dic.dictionary;
            model.payDic = @{@"OrderSerialNo" : serialNo, @"OrderType" : @"7", @"ItemCount" : _tf_count.text, @"ProductId" : [dic getString:@"ProductId"] , @"AdvertId" : [dic getString:@"AdvertId"], @"Specification" : [dic getString:@"Specification"]};
            
            [_blackView removeFromSuperview];
        }
        else if ([Datas getInt:@"Code"] == 5101)
        {
            ADAPI_GetContentByCode([self genDelegatorID:@selector(handleCreatedOrder:)], @"97f4476b542b60611188fc1377a7a1d9");
            return;
        }
        else if (Datas.operationErrorCode || Datas.operationPromptCode)
        {
            [HUDUtil showErrorWithStatus:[Datas getString:@"Desc"]];
        }
        else
        {
            [HUDUtil showErrorWithStatus:[Datas getString:@"Desc"]];
        }
        
        _blackView.hidden = YES;
    }
    else if ([arguments isEqualToOperation:ADOP_GetContentByCode])
    {
        [arguments logError];
        
        if(Datas.operationSucceed)
        {
            [_protocolView roundCornerBorder];
            
            [self.view addSubview:_blackView];
            _blackView.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height - 64);
            _protocolView.frame = CGRectMake(15, ([[UIScreen mainScreen] bounds].size.height - 64)/2 - _protocolView.size.height/2, 290, 363);
            
            _protocolTitle.text = [[Datas getDictionaryWrapper:@"Data"]getString:@"ContentName"];
            
            NSString * htmlTemplatePath = [[Datas getDictionaryWrapper:@"Data"]getString:@"ContentText"];
            
            [_protocolContent loadHTMLString:htmlTemplatePath baseURL:nil];
        }
        else if (Datas.operationErrorCode || Datas.operationPromptCode)
        {
            [HUDUtil showErrorWithStatus:Datas.operationMessage];
        }
    }
}

//添加收藏 --- Call Back
- (void)favoriteSucceed:(DelegatorArguments *)arguments
{
    DictionaryWrapper *Datas = arguments.ret;
    
    int Code = [Datas getInt:@"Code"];
    
    if(Code == 100)
    {
        [self favorite_status_change:YES];
        [HUDUtil showSuccessWithStatus:[Datas getString:@"Desc"]];
    }else
        [HUDUtil showErrorWithStatus:[Datas getString:@"Desc"]];
}

//取消收藏 --- Call Back
- (void)unFavoriteSucceed:(DelegatorArguments *)arguments
{
    DictionaryWrapper *Datas = arguments.ret;
    int Code = [Datas getInt:@"Code"];
    
    if(Code == 100)
    {
        [self favorite_status_change:NO];
        [HUDUtil showSuccessWithStatus:[Datas getString:@"Desc"]];
    }else
        [HUDUtil showErrorWithStatus:[Datas getString:@"Desc"]];
}

- (void)handleSucceed:(DelegatorArguments *)arguments
{
    
    for(UIButton *btn in [_top1 subviews])
    {
        if([btn isKindOfClass:[UIButton class]])
        {
            //代码添加的型号Button
            if(btn.tag > 1)
                [btn removeFromSuperview];
        }
    }
    // 每次 初始化后, 选择数量为1
    _tf_count.text = @"1";
    
    DictionaryWrapper *Datas = arguments.ret;
    DictionaryWrapper *wrapper = [Datas getDictionaryWrapper:@"Data"];
    
    if (!Datas.operationSucceed) return;
    
    [MallHistory_Manager newRecord:wrapper isYin:NO];
    
    if(_whereFrom == 1)
    {
        InitNav([wrapper getString:@"ProductName"]);
    }
    else
    {
        if (_comeformCounsel ==1)
        {
            InitNav([wrapper getString:@"ProductName"]);
        }
        else
        {
            self.navigationItem.hidesBackButton =YES;
        }
    }
    
    DictionaryWrapper *dic_enterprise = [wrapper getDictionaryWrapper:@"Enterprise"];
    _obj_enterprise = [[Enterprise alloc] init];
    _obj_enterprise.enterpriseId = [dic_enterprise getInt:@"EnterpriseId"];
    _obj_enterprise.enterpriseName = [dic_enterprise getString:@"EnterpriseName"];
    _obj_enterprise.enterpriseLogo = [dic_enterprise getString:@"EnterpriseLogo"];
    _obj_enterprise.isVip = [dic_enterprise getBool:@"IsVip"];
    _obj_enterprise.isSilver = [dic_enterprise getBool:@"IsSilver"];
    _obj_enterprise.isGold = [dic_enterprise getBool:@"IsGold"];
    
    _specifications = [[wrapper getArray:@"Specifications"] retain];
    
    _pictures = [[wrapper getArray:@"Pictures"] retain];
    
    _introductionPictures = [[wrapper getArray:@"IntroductionPictureUrls"] retain];
    
    //scrollView 刷新
    [_rsView refReshScrollView:_pictures];
    
    //收藏状态
    if([wrapper getBool:@"IsFavorite"])
    {
        //已收藏
        [self favorite_status_change:YES];
    }
    else
    {
        //未收藏
        [self favorite_status_change:NO];
    }
    
    //top0
    
    CGRect  frame = _imageScroll.frame;
    frame.origin.y += _imageScroll.frame.size.height;
    
    _productName.text = [wrapper getString:@"ProductName"];
    frame.origin.y += 15 - 5;
    frame.origin.x = _productName.frame.origin.x;
    frame.size.width = _productName.frame.size.width;
    frame.size.height = [AppUtils textHeightByChar:_productName.text width:_productName.frame.size.width fontSize:_productName.font];
    
    if(frame.size.height > 20)
        frame.size.height += 3;
    
    _productName.frame = frame;
    frame.origin.y += frame.size.height;
    
    _productFeature.text = [wrapper getString:@"Feature"];
    frame.origin.y += 10 - 3;
    
    int feature_height = [AppUtils textHeightByChar:_productFeature.text width:_productFeature.frame.size.width fontSize:_productFeature.font];
    if(feature_height > 20)
        frame.size.height = feature_height + 5;
    else
        frame.size.height = _productFeature.frame.size.height;
    
    _productFeature.frame = frame;
    
    frame.origin.y += frame.size.height;
    
    NSString *max_price = [UICommon getStringToTwoDigitsAfterDecimalPlacesPoint:[wrapper getString:@"PriceMax"] withAppendStr:@""];
    NSString *min_price = [UICommon getStringToTwoDigitsAfterDecimalPlacesPoint:[wrapper getString:@"PriceMin"] withAppendStr:@""];
    
    
    NSRange range_min = [[wrapper getString:@"PriceMin"] rangeOfString:@"."];
    NSRange range_max = [[wrapper getString:@"PriceMax"] rangeOfString:@"."];
    
    if(range_min.length)
    {
        NSString *str_min = [[wrapper getString:@"PriceMin"] substringFromIndex:range_min.location];
        
        if(str_min.length > 3)
        {
            double d=[wrapper getDouble:@"PriceMin"] ;
            d=d*100;
            float f=(int)d;
            f=f/100;
            min_price = [NSString stringWithFormat:@"%.2lf", f];
        }
    }
    else if(range_max.length)
    {
        NSString *str_max = [[wrapper getString:@"PriceMax"] substringFromIndex:range_max.location];
        
        if(str_max.length > 3)
        {
            double d=[wrapper getDouble:@"PriceMax"] ;
            d=d*100;
            float f=(int)d;
            f=f/100;
            max_price = [NSString stringWithFormat:@"%.2lf", f];
        }
    }
    
    if([max_price isEqualToString:min_price])
        _priceRange.text = min_price;
    else
        _priceRange.text = [NSString stringWithFormat:@"%@-%@",min_price, max_price];
    
    frame.origin.y += 10 - 3;
    frame.size.height = _priceRange.frame.size.height;
    frame.size.width = [AppUtils textWidthByChar:_priceRange.text height:_priceRange.frame.size.height fontSize:_priceRange.font] + 3;
    _priceRange.frame = frame;
    
    
    frame.origin.x += frame.size.width;
    frame.size.width = _freeShipping.frame.size.width;
    frame.size.height = _freeShipping.frame.size.height;
    _freeShipping.frame = frame;
    
    _freeShipping.frame = CGRectMake(frame.origin.x, frame.origin.y + 3, frame.size.width, frame.size.height);
    
    frame.origin.x = _onhandQty.frame.origin.x;
    frame.size.width = _onhandQty.frame.size.width;
    frame.size.height = _onhandQty.frame.size.height;
    frame.origin.y = _priceRange.origin.y + _priceRange.frame.size.height + 9;
    _onhandQty.frame = frame;
    
    _onhandQty.frame = CGRectMake(frame.origin.x, frame.origin.y + 4, frame.size.width, frame.size.height);
    
    frame.origin.y += frame.size.height;
    
    
    
    _top0.frame = CGRectMake(_top0.frame.origin.x, _top0.frame.origin.x, _top0.frame.size.width, frame.origin.y += 20 + 5);
    
    //top0 线条
    [_top0 addSubview:[AppUtils LineView:_top0.frame.origin.y + _top0.frame.size.height]];
    
    
    [_baseScroll addSubview:_top0];
    
    //库存总数
    int allOnhandQty = 0;
    
    //初始化按钮宽高及坐标
    CGRect btn_frame = CGRectMake(95, 7, 95, 35);
    int i = 2;
    
    CGFloat max_width = 0.f;
    
    for (NSDictionary *dic in _specifications) {
        
        DictionaryWrapper *item = dic.wrapper;
        
        max_width = MAX(max_width, [AppUtils textWidthByChar:[item getString:@"SpecificationName"] height:15 fontSize:[UIFont systemFontOfSize:14.0f]]);
    }
    
    max_width += 20;
    if(max_width < 95)
        max_width = 95;
    else if(max_width >= 210)
        max_width = 210;
    
    for(NSDictionary *dic in _specifications)
    {
        
        DictionaryWrapper *item = dic.wrapper;
        
        btn_frame.origin.y += 8;
        btn_frame.size.width = max_width;
        
        UIButton *btn = [[UIButton alloc] initWithFrame:btn_frame];
        [btn setFrame:btn_frame];
        [btn setTitle:[item getString:@"SpecificationName"] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        NSLog(@"count :%d", [item getInt:@"Remains"]);
        if([item getInt:@"Remains"] == 0)
        {
            btn.enabled = NO;
            btn.alpha = 0.4f;
            btn.titleLabel.alpha = 0.4f;
        }
        
        [btn addTarget:self action:@selector(Action_style:) forControlEvents:UIControlEventTouchUpInside];
    
            
        btn.tag = i;
        
        [_top1 addSubview:btn];
        
        [btn roundCornerBorder];
        btn.layer.borderColor = [RGBCOLOR(204.0f, 204.0f, 204.0f) CGColor];
        
        i ++;
        
        btn_frame.origin.y += btn_frame.size.height;
        
        if(_whereFrom == 0)
        {
            btn.enabled = NO;
            [btn setTitleColor:RGBCOLOR(204.0f, 204.0f, 204.0f) forState:UIControlStateNormal];
        }
        
//        [btn release];
        
        allOnhandQty += [item getInt:@"Remains"];
        
        [_styleBtns addObject:btn];
    }
    
    _onhandQty.text = [NSString stringWithFormat:@"库存：%d", allOnhandQty];
    
    frame.origin.x = _top1.frame.origin.x;
    frame.size.height = btn_frame.origin.y + 15 + 35 + 15;
    frame.size.width = _top1.frame.size.width;
    _top1.frame = frame;
    [_baseScroll addSubview:_top1];
    
    //top1 线条
    [_top1 addSubview:[AppUtils LineView:_top1.frame.size.height]];
    
    frame.origin.y += frame.size.height;
    
    [_headImage requestPic:_obj_enterprise.enterpriseLogo placeHolder:NO];
    _postil.text = [NSString stringWithFormat:@"本商品提供商 %@", _obj_enterprise.enterpriseName];
    _enterpriseName.text = _obj_enterprise.enterpriseName;
    
    CGRect icon_frame = CGRectMake(75, 66, 17, 17);
    
    if(_obj_enterprise.isVip)
    {
        UIImageView *icon = [[UIImageView alloc] initWithFrame:icon_frame];
        icon.image = [UIImage imageNamed:@"preview_attestation_0_1"];
        icon_frame.origin.x += icon_frame.size.width + 4;
        [_top2 addSubview:icon];
        [icon release];
    }
    else
    {
        UIImageView *icon = [[UIImageView alloc] initWithFrame:icon_frame];
        icon.image = [UIImage imageNamed:@"preview_attestation_0_0"];
        icon_frame.origin.x += icon_frame.size.width + 4;
        [_top2 addSubview:icon];
        [icon release];
    }
    
    if(_obj_enterprise.isSilver)
    {
        UIImageView *icon = [[UIImageView alloc] initWithFrame:icon_frame];
        icon.image = [UIImage imageNamed:@"preview_attestation_1_1"];
        icon_frame.origin.x += icon_frame.size.width + 4;
        [_top2 addSubview:icon];
        [icon release];
    }
    else
    {
        UIImageView *icon = [[UIImageView alloc] initWithFrame:icon_frame];
        icon.image = [UIImage imageNamed:@"preview_attestation_1_0"];
        icon_frame.origin.x += icon_frame.size.width + 4;
        [_top2 addSubview:icon];
        [icon release];
    }
    
    
    if(_obj_enterprise.isGold)
    {
        UIImageView *icon = [[UIImageView alloc] initWithFrame:icon_frame];
        icon.image = [UIImage imageNamed:@"preview_attestation_2_1"];
        icon_frame.origin.x += icon_frame.size.width + 4;
        [_top2 addSubview:icon];
        [icon release];
    }
    else
    {
        UIImageView *icon = [[UIImageView alloc] initWithFrame:icon_frame];
        icon.image = [UIImage imageNamed:@"preview_attestation_2_0"];
        icon_frame.origin.x += icon_frame.size.width + 4;
        [_top2 addSubview:icon];
        [icon release];
    }
    
    frame.size.width = _top2.frame.size.width;
    frame.size.height = _top2.frame.size.height;
    _top2.frame = frame;
    [_baseScroll addSubview:_top2];
    frame.origin.y += frame.size.height;
    
    
    
    //centerLineView 线条
    [_centerLineView addSubview:[AppUtils LineView:0.5f]];
    [_centerLineView addSubview:[AppUtils LineView:10]];
    
    
    //商品介绍
    CGRect top3_frame = _top3.frame;
    top3_frame.origin.y = frame.origin.y;
    [_baseScroll addSubview:_top3];
    
    
    _lab_introduce.text = [wrapper getString:@"Introduction"];
    frame = _lab_introduce.frame;
    frame.origin.y = 15;
    frame.size.height = [AppUtils textHeightByChar:_lab_introduce.text width:frame.size.width fontSize:_lab_introduce.font]+5;
    _lab_introduce.frame = frame;
    frame.origin.y += frame.size.height + 15;
    
    //    frame.origin.y = 15 + _lab_introduce.height + 15;
    frame.size.width = 290;
    frame.size.height = 150;
    
    for(int i = 0; i < [_introductionPictures count]; i++)
    {
//        NetImageView *iv = [[[NetImageView alloc] initWithFrame:frame] autorelease];
////        NetImageView *iv = [[NetImageView alloc] initWithFrame:frame];
//        UIImageView *iv = [[[UIImageView alloc] initWithFrame:frame] autorelease];
//        UIImageView *iv = [[UIImageView alloc] initWithFrame:frame];
//        [iv requestPicture:[_introductionPictures objectAtIndex:i]];
        NetImageView *iv = [[NetImageView alloc] initWithFrame:frame];
//        [iv setImageWithURL:[NSURL URLWithString:[_introductionPictures objectAtIndex:i]]];
        
        CGSize size = [UIImage downloadImageSizeWithURL:[NSURL URLWithString:[_introductionPictures objectAtIndex:i]] ];
        
        if(size.width == 0 && size.height == 0)
        {
            size.width = 627;
            size.height = 800;
        }
        
        CGFloat roate = size.width / frame.size.width;
        int height = size.height / roate;
        
        frame.size.height = height;
        iv.frame = frame;
        
        [iv requestPic:[_introductionPictures objectAtIndex:i] size:CGSizeMake(frame.size.width, frame.size.height) placeHolder:YES];
        
        [_view_introduce addSubview:iv];
        
        frame.origin.y += height + 15;
        [iv release];
    }
    
    
    frame.origin.y += 10;
    //图片bottom间隙，加分隔符View间隙
    
    _view_introduce.frame = CGRectMake(0, 0, _view_introduce.frame.size.width, frame.origin.y);
    
    _top3.frame = CGRectMake(_top3.frame.origin.x, top3_frame.origin.y, _top3.frame.size.width, frame.origin.y);
    
    [_top3 addSubview:_view_introduce];
    
    frame.origin.y = _top3.frame.origin.y + _top3.frame.size.height;
    
    
    int bootom_offset = _view_tools.frame.size.height;
    if(_whereFrom == 0)
        bootom_offset = 0;
    [_baseScroll setContentSize:CGSizeMake(_baseScroll.frame.size.width, frame.origin.y + bootom_offset)];
    
    
    //售后条款
    //起始y 45
    _lab_service.text = [wrapper getString:@"EnterpriseProtocol"];
    frame = _lab_service.frame;
    
    int service_height = 0;
    service_height = [AppUtils textHeightByChar:_lab_service.text width:_lab_service.frame.size.width fontSize:_lab_service.font];
    if(service_height > 20)
        service_height += 3;
    frame.size.height = service_height;
    _lab_service.frame = frame;
    
    frame.origin.y += frame.size.height;
    
    frame.origin.y += 30;
    
    
    frame.origin.x = 0;
    frame.size.height = _view_illustrate.frame.size.height;
    frame.size.width = _view_illustrate.frame.size.width;
    _view_illustrate.frame = frame;
    
    
    frame.origin.y = _view_service.frame.origin.y;
    frame.size.width = _view_service.frame.size.width;
    frame.size.height = _view_illustrate.frame.origin.y + _view_illustrate.frame.size.height;
    
    
    
    UIView *line_x0 = [[UIView alloc] initWithFrame:CGRectMake(58, 22+0.5, 52, 0.5)];
    line_x0.backgroundColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0f];
    [_view_service addSubview:line_x0];
    
    UIView *line_x1 = [[UIView alloc] initWithFrame:CGRectMake(204, 22+0.5, 52, 0.5)];
    line_x1.backgroundColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0f];
    [_view_service addSubview:line_x1];
    
    _view_service.frame = frame;
}

//样式选择事件
-(void)Action_style:(id)sender
{
    UIButton *chooseBtn = (UIButton *)sender;
    for(UIButton *btn in [_top1 subviews])
    {
        if(btn.tag > 1)                         //大于1，排除增加 减少数量的Button
        {
            if(btn.tag == chooseBtn.tag)
            {

                btn.layer.borderColor = [RGBCOLOR(240.0f, 5.0f, 0.0f) CGColor];
                [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
                
                NSDictionary *dic = [_specifications objectAtIndex:btn.tag - 2];
                DictionaryWrapper *item = dic.wrapper;
                
                //存储 所选的样式, 用于生成订单
                _chooseSpecification = [item getString:@"SpecificationName"];
                
                NSString *orig_price = [UICommon getStringToTwoDigitsAfterDecimalPlacesPoint:[item getString:@"Price"] withAppendStr:@""];
                
                NSRange range_pirce = [[item getString:@"Price"] rangeOfString:@"."];
                
                if(range_pirce.length)
                {
                    NSString *str_pirce = [[item getString:@"Price"] substringFromIndex:range_pirce.location];
                    
                    if(str_pirce.length > 3)
                    {
                        double d=[item getDouble:@"Price"] ;
                        d=d*100;
                        float f=(int)d;
                        f=f/100;
                        orig_price = [NSString stringWithFormat:@"%.2lf", f];
                    }
                }
                
                _priceRange.text = orig_price;
                
                _item_onhandQtyCount = [item getInt:@"Remains"];
                
                _onhandQty.text = [NSString stringWithFormat:@"库存：%d", _item_onhandQtyCount];
                
                _tf_count.text = @"1";
                
                
                
                CGRect frame = _priceRange.frame;
                frame.size.width = [AppUtils textWidthByChar:_priceRange.text height:_priceRange.frame.size.height fontSize:_priceRange.font];
                _priceRange.frame = frame;
                
                frame = _freeShipping.frame;
                frame.origin.x = _priceRange.frame.origin.x + _priceRange.frame.size.width + 3;
                _freeShipping.frame = frame;
                
                //禁用btn_minus
                _btn_minus.enabled = NO;
                if([_tf_count.text intValue] == _item_onhandQtyCount)
                    _btn_plus.enabled = NO;
                    
                
            }
            else
            {
                btn.layer.borderColor = [RGBCOLOR(204.0f, 204.0f, 204.0f) CGColor];
                [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            }
        }
    }
}


//按钮点击事件
-(IBAction)Action_Btn_Selected:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    
    //减
    if(btn.tag == 0)
    {
        if([_tf_count.text intValue] != 1)
            _tf_count.text = [NSString stringWithFormat:@"%d", [_tf_count.text intValue] - 1];
        if([_tf_count.text intValue] == 1)
            _btn_minus.enabled = NO;
        if([_tf_count.text intValue] < _item_onhandQtyCount)
            _btn_plus.enabled = YES;
            
    }
    
    //加
    else if(btn.tag == 1)
    {
        if([_tf_count.text intValue] < _item_onhandQtyCount)
            _tf_count.text = [NSString stringWithFormat:@"%d", [_tf_count.text intValue] + 1];
        if([_tf_count.text intValue] > 1)
            _btn_minus.enabled = YES;
        if([_tf_count.text intValue] == _item_onhandQtyCount)
            _btn_plus.enabled = NO;
    }
    
    //商品咨询
    else if(btn.tag == 2)
    {
        //3.3需求
        DictionaryWrapper * dic =[APP_DELEGATE.runtimeConfig getDictionary:RUNTIME_USER_LOGIN_INFO].wrapper;
        
        //判断是否商家
        if ([dic getInt:@"EnterpriseStatus"] == 4)//已激活商家
        {
            PUSH_VIEWCONTROLLER(ShippingConsultViewController);
            model.type = [NSString stringWithFormat:@"%d",5];
            model.proterId = [NSString stringWithFormat:@"%d",(int)_productId];
            model.enterName = _obj_enterprise.enterpriseName;
        }
        else
        {
            //实名认证非认证成功
            if ([dic getInt:@"IdentityStatus"] == 0 || [dic getInt:@"IdentityStatus"] == 2)
            {
                __block typeof(self) weakself = self;
                [AlertUtil showAlert:@"实名认证" message:@"通过实名认证才能咨询商家" buttons:@[@"确定",@{
                                                                                   @"title":@"去认证",
                                                                                   @"delegator":ALERT_VIEW_DELEGATOR_BLOCK
                                                                                   ({
                    [weakself.navigationController pushViewController:WEAK_OBJECT(RealNameAuthenticationViewController, init) animated:YES];
                })
                                                                                   }]];
            }
            else if ([dic getInt:@"IdentityStatus"] == 3)
            {
                [HUDUtil showErrorWithStatus:@"你的实名认证还在审核中！"];
            }
        }
    }
    
    //商家店铺
    else if(btn.tag == 3)
    {
        PUSH_VIEWCONTROLLER(MerchantDetailViewController)
        model.enId = [NSString stringWithFormat:@"%d",_obj_enterprise.enterpriseId];
        model.comefrom = @"4";
    }
    
    //商品介绍
    else if(btn.tag == 4)
    {
        [_view_service removeFromSuperview];
        
        [_top3 addSubview:_view_introduce];
        
        _top3.frame = CGRectMake(_top3.frame.origin.x, _top3.frame.origin.y, _top3.frame.size.width, _view_introduce.frame.size.height);
        
        int bottom_offset = _view_tools.frame.size.height;
        if(_whereFrom == 0)
            bottom_offset = 0;
        [_baseScroll setContentSize:CGSizeMake(_baseScroll.frame.size.width, _top3.frame.origin.y + _top3.frame.size.height + bottom_offset)];
        
        [self animation_slipBar_scroll:btn.tag];
    }
    
    //售后服务
    else if(btn.tag == 5)
    {
        [_view_introduce removeFromSuperview];
        [_top3 addSubview:_view_service];
        
        
        _top3.frame = CGRectMake(_top3.frame.origin.x, _top3.frame.origin.y, _top3.frame.size.width, _view_service.frame.size.height);
        
        int bottom_offset = _view_tools.frame.size.height;
        if(_whereFrom == 0)
            bottom_offset = 0;
        [_baseScroll setContentSize:CGSizeMake(_baseScroll.frame.size.width, _top3.frame.origin.y + _top3.frame.size.height + bottom_offset)];
        
        [self animation_slipBar_scroll:btn.tag];
    }
    
    //收藏
    else if(btn.tag == 6)
    {
        
        //取消
        if(btn.selected)
        {
            ADAPI_UnFavoriteCommodity([GLOBAL_DELEGATOR_MANAGER addDelegator:self selector:@selector(unFavoriteSucceed:)], _productId, 2);
        }
        //添加
        else
        {
            ADAPI_FavoriteCommodity([GLOBAL_DELEGATOR_MANAGER addDelegator:self selector:@selector(favoriteSucceed:)], _productId, 2);
        }
    }
    
    //立即购买 --- 生成订单
    else if(btn.tag == 7)
    {
        DictionaryWrapper *dic = [APP_DELEGATE.runtimeConfig getDictionary:RUNTIME_USER_LOGIN_INFO].wrapper;
        
        int VipLevel = [dic getInt:@"VipLevel"];
        
        int enterStatus = [dic getInt:@"EnterpriseStatus"];
        
        
        if (enterStatus != 4 && VipLevel < 7)
        {
            //没有创建商家
            [AlertUtil showAlert:@"只有商家或VIP7用户可以购买" message:@"是否立即升级成为VIP7?" buttons:@[@{
                                                                                           @"title":@"取消",
                                                                                           @"delegator":ALERT_VIEW_DELEGATOR_BLOCK
                                                                                           ({
            })
                                                                                           },
                                                                                       @{
                                                                                           @"title":@"确定",
                                                                                           @"delegator":ALERT_VIEW_DELEGATOR_BLOCK
                                                                                           ({
                PUSH_VIEWCONTROLLER(VipPriviliegeViewController);
            })
                                                                                           }
                                                                                       ]];
        }
        else
        {
//            NSString *speciName = @"";
            
            if([_chooseSpecification isEqualToString:@""] || _chooseSpecification == nil || [_chooseSpecification isEqual:[NSNull null]])
            {
//                //只有一个规格选项，未选中 默认选择第一个
//                if(_specifications && [_specifications count] == 1)
//                {
//                    NSDictionary *data = [_specifications objectAtIndex:0];
//                    DictionaryWrapper *item = data.wrapper;
//                    speciName = [item getString:@"SpecificationName"];
//                    
//                    if([item getInt:@"Remains"] == 0)
//                    {
//                        [HUDUtil showErrorWithStatus:@"该商品库存不足"];
//                        
//                        return;
//                    }
//                }
//                
//                //有多个选项
//                else if([_specifications count] > 1)
//                {
                    [HUDUtil showErrorWithStatus:@"请选择颜色/规格"];
//
                    return;
//                }
            }
//            else
//                speciName = _chooseSpecification;
            
            
            NSString *proId = [NSString stringWithFormat:@"%d", _productId];
            NSString *count = _tf_count.text;
            NSDictionary *dic = @{@"OrderType": @"7", @"ItemCount":count, @"ProductId":proId, @"Specification":_chooseSpecification,@"IsAgreement":@"false"};
            ADAPI_Payment_GoCommonOrderShow([GLOBAL_DELEGATOR_MANAGER addDelegator:self selector:@selector(handleCreatedOrder:)], dic);
        }
    }
}

- (IBAction)protocolBtn:(id)sender
{
    if (sender == _protocolbtn)
    {
        NSString *proId = [NSString stringWithFormat:@"%d", _productId];
        NSString *count = _tf_count.text;
        NSDictionary *dic = @{@"OrderType": @"7", @"ItemCount":count, @"ProductId":proId, @"Specification":_chooseSpecification,@"IsAgreement":@"true"};
        ADAPI_Payment_GoCommonOrderShow([GLOBAL_DELEGATOR_MANAGER addDelegator:self selector:@selector(handleCreatedOrder:)], dic);
    }
    else if (sender == _agreeBtn)
    {
        if (agree)
        {
            [_agreeImage setImage:[UIImage imageNamed:@"fashouweigou"]];
            _protocolbtn.backgroundColor = AppColorLightGray204;
            _protocolbtn.userInteractionEnabled = NO;
            agree= NO;
        }
        else
        {
            [_agreeImage setImage:[UIImage imageNamed:@"fashougou"]];
            _protocolbtn.backgroundColor = AppColorRed;
            _protocolbtn.userInteractionEnabled = YES;
            agree= YES;
        }
    }
    else if (sender == _blackBtn)
    {
        [_blackView removeFromSuperview];
    }
}


//收藏状态改变
-(void)favorite_status_change:(BOOL)selected
{
    if(selected)
    {
        _btn_favorite.selected = YES;
        _img_favorite.image = [UIImage imageNamed:@"ads_collectioned"];
    }
    else
    {
        _btn_favorite.selected = NO;
        _img_favorite.image = [UIImage imageNamed:@"ads_collection"];
    }
}

//商品介绍、售后服务 切换效果
-(void)animation_slipBar_scroll:(NSInteger)tag
{
    
    CGRect slipBarFrame = _slipBar.frame;
    
    if(tag == 4)
    {
        _title_introduce.font = [UIFont systemFontOfSize:17.0];
        _title_service.font = [UIFont systemFontOfSize:14.0];
        
        _title_introduce.textColor = [UIColor colorWithRed:240/255.0 green:5/255.0 blue:0/255.0 alpha:1.0f];
        _title_service.textColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0f];
        
        slipBarFrame.origin.x = 35+3;
    }
    else if(tag == 5)
    {
        _title_introduce.font = [UIFont systemFontOfSize:14.0];
        _title_service.font = [UIFont systemFontOfSize:17.0];
        
        _title_introduce.textColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0f];
        _title_service.textColor = [UIColor colorWithRed:240/255.0 green:5/255.0 blue:0/255.0 alpha:1.0f];
        
        slipBarFrame.origin.x = 190+2;
    }
    //slipBar 滑动效果
    
    [UIView animateWithDuration:0.3   animations:^{
        
        _slipBar.frame = slipBarFrame;
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 6.0) {
        //需要注意的是self.isViewLoaded是必不可少的，其他方式访问视图会导致它加载 ，在WWDC视频也忽视这一点。
        if (self.isViewLoaded && !self.view.window)// 是否是正在使用的视图
        {
            self.view = nil;// 目的是再次进入时能够重新加载调用viewDidLoad函数。
        }
    }
}

-(void)which_tag_clicked:(int)tag
{
    //秒赚首页
    if(tag == 0)
    {
        [UI_MANAGER.mainNavigationController pushViewController:WEAK_OBJECT(ControlViewController, init) animated:YES];
    }
    
    //商城首页
    else if(tag == 1)
    {
        [UI_MANAGER.mainNavigationController pushViewController:WEAK_OBJECT(MallScanAdvertMain, init) animated:YES];
    }
    
    //浏览记录
    else if(tag == 2)
    {
        [UI_MANAGER.mainNavigationController pushViewController:WEAK_OBJECT(BrowseRecordViewController, init) animated:YES];
    }
    
    //分享给朋友
    else if(tag == 3)
    {
        Share_Method *share = [Share_Method shareInstance];
        
        WDictionaryWrapper *dic = WEAK_OBJECT(WDictionaryWrapper, init);
        
        [dic set:@"product_name" string:_productName.text];
        
        NSString *image = @"";
        if(_pictures && [_pictures count] > 0)
        {
            NSDictionary *dic = [_pictures objectAtIndex:0];
            
            image = [dic.wrapper getString:@"PictureUrl"];
        }
        [share getShareDataWithShareData:@{@"Key":@"2a4c2657138247317d8979710e98f438", @"product_id":[NSString stringWithFormat:@"%d",_productId]}];
    }
}


@end
