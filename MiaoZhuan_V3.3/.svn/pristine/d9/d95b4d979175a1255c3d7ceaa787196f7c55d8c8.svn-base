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
#import "CycleView.h"

#import "ShippingConsultViewController.h"
#import "MerchantDetailViewController.h"

#import "ConfirmOrderViewController.h"


#define top1_btn_space          8

@interface Preview_Commodity ()

@end

@implementation Preview_Commodity

@synthesize productId = _productId;
@synthesize baseScroll = _baseScroll;
@synthesize imageScroll = _imageScroll;

@synthesize top0 = _top0;
@synthesize productName = _productName;
@synthesize productFeature = _productFeature;
@synthesize priceRange = _priceRange;
@synthesize onhandQty = _onhandQty;

@synthesize top1 = _top1;
@synthesize tf_count = _tf_count;

@synthesize top2 = _top2;
@synthesize btn_consult = _btn_consult;
@synthesize btn_shop = _btn_shop;
@synthesize obj_enterprise = _obj_enterprise;
@synthesize postil = _postil;
@synthesize enterpriseName = _enterpriseName;
@synthesize title_introduce = _title_introduce;
@synthesize title_service = _title_service;
@synthesize slipBar = _slipBar;
@synthesize headImage = _headImage;

@synthesize view_introduce = _view_introduce;
@synthesize lab_introduce = _lab_introduce;
@synthesize view_service = _view_service;
@synthesize lab_service = _lab_service;
@synthesize view_illustrate = _view_illustrate;

@synthesize view_tools   = _view_tools;
@synthesize img_favorite = _img_favorite;
@synthesize btn_favorite = _btn_favorite;

-(void)dealloc
{
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
    
//    self.specifications = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setupMoveBackButton];
    
    if(_whereFrom == 0)
    {
        InitNav(@"预览宝贝");
        [self setupMoveFowardButtonWithTitle:@"关闭"];
    }
    
    [_headImage roundCornerBorder];
    
    _tf_count.text = @"1";
    _tf_count.layer.borderWidth = 0.4f;
    _tf_count.layer.borderColor = [[UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:0.5f] CGColor];
    
    _btn_consult.layer.borderWidth = 0.5f;
    _btn_consult.layer.cornerRadius = 5.0f;
    _btn_consult.layer.borderColor = [[UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:0.5f] CGColor];
    
    _btn_shop.layer.borderWidth = 0.5f;
    _btn_shop.layer.cornerRadius = 5.0f;
    _btn_shop.layer.borderColor = [[UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:0.5f] CGColor];
    
    //底部toolBar
    CGRect frame = _view_tools.frame;
    frame.origin.y = [UIScreen mainScreen].bounds.size.height - frame.size.height - self.navigationController.navigationBar.frame.size.height - 20;
    _view_tools.frame = frame;
    [self.view addSubview:_view_tools];
    
    ADAPI_PreviewCommodity([GLOBAL_DELEGATOR_MANAGER addDelegator:self selector:@selector(handleSucceed:)], _productId);
}

//点击 --- 关闭
- (void)onMoveFoward:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

//生成订单 --- Call Back
-(void)handleCreatedOrder:(DelegatorArguments *)arguments
{
    DictionaryWrapper *Datas = arguments.ret;
    
    DictionaryWrapper *dic = [Datas getDictionaryWrapper:@"Data"];
    
    if(Datas.operationSucceed)
    {
        PUSH_VIEWCONTROLLER(ConfirmOrderViewController);
        model.type = 2;
        
        NSString *serialNo = @"";
        
        if(![[dic getString:@"OrderSerialNo"] isEqualToString:@""] && [dic getString:@"OrderSerialNo"] != nil && ![[dic getString:@"OrderSerialNo"] isEqual:[NSNull null]])
            serialNo = [dic getString:@"OrderSerialNo"];
        
        model.orderInfoDic = dic.dictionary;
        model.payDic = @{@"OrderSerialNo" : serialNo, @"OrderType" : @"7", @"ItemCount" : _tf_count.text};
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
    DictionaryWrapper *Datas = arguments.ret;
    DictionaryWrapper *wrapper = [Datas getDictionaryWrapper:@"Data"];
    
    if(_whereFrom == 1)
    {
        InitNav([wrapper getString:@"ProductName"]);
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
    
    CycleView *cycle = [[CycleView alloc] initWithParameter:0 imgWidth:_imageScroll.frame.size.width imageData:_pictures];
    [_imageScroll addSubview:cycle.view];
    
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
    frame.origin.y += 15;
    frame.origin.x = _productName.frame.origin.x;
    frame.size.width = _productName.frame.size.width;
    frame.size.height = [self textHeightByChar:_productName.text width:_productName.frame.size.width fontSize:_productName.font];
    _productName.frame = frame;
    frame.origin.y += frame.size.height;
    
    _productFeature.text = [wrapper getString:@"Feature"];
    frame.origin.y += 10;
    frame.size.height = [self textHeightByChar:_productFeature.text width:_productFeature.frame.size.width fontSize:_productFeature.font];
    _productFeature.frame = frame;
    frame.origin.y += frame.size.height;
    
    _priceRange.text = [NSString stringWithFormat:@"%.2f-%.2f金币", [wrapper getFloat:@"PriceMin"], [wrapper getFloat:@"PriceMax"]];
    frame.origin.y += 10;
    frame.size.height = _priceRange.frame.size.height;
    frame.size.width = [self textWidthByChar:_priceRange.text height:_priceRange.frame.size.height fontSize:_priceRange.font];
    _priceRange.frame = frame;
    
    
    frame.origin.x += frame.size.width + 5;
    frame.size.width = _freeShipping.frame.size.width;
    frame.size.height = _freeShipping.frame.size.height;
    _freeShipping.frame = frame;
    
    frame.origin.x = _onhandQty.frame.origin.x;
    frame.size.width = _onhandQty.frame.size.width;
    frame.size.height = _onhandQty.frame.size.height;
    _onhandQty.frame = frame;
    frame.origin.y += frame.size.height;
    
    _top0.frame = CGRectMake(_top0.frame.origin.x, _top0.frame.origin.x, _top0.frame.size.width, frame.origin.y += 20);
    
    [_baseScroll addSubview:_top0];
    
    //库存总数
    int allOnhandQty = 0;
    
    //初始化按钮宽高及坐标
    CGRect btn_frame = CGRectMake(87, 7, 95, 30);
    int i = 1;
    for(NSDictionary *dic in _specifications)
    {
        DictionaryWrapper *item = dic.wrapper;
        
        btn_frame.origin.y += 8;
        UIButton *btn = [[UIButton alloc] initWithFrame:btn_frame];
        btn.layer.borderWidth = 0.5f;
        btn.layer.cornerRadius = 5.0f;
        btn.layer.borderColor = [[UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:0.5f] CGColor];
        [btn setTitle:[item getString:@"SpecificationName"] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:10.0f];
        [btn addTarget:self action:@selector(Action_style:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = i;
        [_top1 addSubview:btn];
        i ++;
        
        btn_frame.origin.y += btn_frame.size.height;
        
        [btn release];
        
        allOnhandQty += [item getInt:@"Remains"];
    }
    
    _onhandQty.text = [NSString stringWithFormat:@"库存：%d", allOnhandQty];
    
    frame.origin.x = _top1.frame.origin.x;
    frame.size.height = btn_frame.origin.y + 15 + 35 + 15;
    frame.size.width = _top1.frame.size.width;
    _top1.frame = frame;
    [_baseScroll addSubview:_top1];
    frame.origin.y += frame.size.height;
    
    [_headImage requestPic:_obj_enterprise.enterpriseLogo placeHolder:NO];
    _postil.text = [NSString stringWithFormat:@"本商品提供商 %@", _obj_enterprise.enterpriseName];
    _enterpriseName.text = _obj_enterprise.enterpriseName;
    
    CGRect icon_frame = CGRectMake(75, 71, 17, 17);
    if(_obj_enterprise.isVip)
    {
        UIImageView *icon = [[UIImageView alloc] initWithFrame:icon_frame];
        icon.image = [UIImage imageNamed:@"preview_attestation_0_1"];
        icon_frame.origin.x += icon_frame.size.width + 5;
        [_top2 addSubview:icon];
    }
    if(_obj_enterprise.isSilver)
    {
        UIImageView *icon = [[UIImageView alloc] initWithFrame:icon_frame];
        icon.image = [UIImage imageNamed:@"preview_attestation_1_1"];
        icon_frame.origin.x += icon_frame.size.width + 5;
        [_top2 addSubview:icon];
    }
    if(_obj_enterprise.isGold)
    {
        UIImageView *icon = [[UIImageView alloc] initWithFrame:icon_frame];
        icon.image = [UIImage imageNamed:@"preview_attestation_2_1"];
        icon_frame.origin.x += icon_frame.size.width + 5;
        [_top2 addSubview:icon];
        [icon release];
    }
    
    frame.size.width = _top2.frame.size.width;
    frame.size.height = _top2.frame.size.height;
    _top2.frame = frame;
    [_baseScroll addSubview:_top2];
    frame.origin.y += frame.size.height;
    
    
    
    
    //商品介绍
    CGRect top3_frame = _top3.frame;
    top3_frame.origin.y = frame.origin.y;
    [_baseScroll addSubview:_top3];
    
    
    _lab_introduce.text = [wrapper getString:@"Introduction"];
    frame = _lab_introduce.frame;
    frame.origin.y = 15;
    frame.size.height = [self textHeightByChar:_lab_introduce.text width:frame.size.width fontSize:_lab_introduce.font];
    _lab_introduce.frame = frame;
    frame.origin.y += frame.size.height + 15;
    
    //    frame.origin.y = 15 + _lab_introduce.height + 15;
    frame.size.width = 290;
    frame.size.height = 150;
    
    for(int i = 0; i < [_introductionPictures count]; i++)
    {
        NetImageView *iv = [[[NetImageView alloc] initWithFrame:frame] autorelease];
        [iv requestPicture:[_introductionPictures objectAtIndex:i]];
        [_view_introduce addSubview:iv];
        
        [iv release];
        
        frame.origin.y += frame.size.height + 15;
    }
    
    
    frame.origin.y += 10;
    //图片bottom间隙，加分隔符View间隙
    
    _view_introduce.frame = CGRectMake(0, 0, _view_introduce.frame.size.width, frame.origin.y);
    
    _top3.frame = CGRectMake(_top3.frame.origin.x, top3_frame.origin.y, _top3.frame.size.width, frame.origin.y);
    
    [_top3 addSubview:_view_introduce];
    
    //    frame.origin.y += _top2.origin.y + _top2.frame.size.height;
    frame.origin.y = _top3.frame.origin.y + _top3.frame.size.height;
    
    
    
    [_baseScroll setContentSize:CGSizeMake(_baseScroll.frame.size.width, frame.origin.y + _view_tools.frame.size.height)];
    
    
    //售后条款
    //起始y 45
    _lab_service.text = [wrapper getString:@"商家售后条款"];
    frame = _lab_service.frame;
    frame.size.height = [self textHeightByChar:_lab_service.text width:_lab_service.frame.size.width fontSize:_lab_service.font];
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
    
    _view_service.frame = frame;
}

//样式选择事件
-(void)Action_style:(id)sender
{
    UIButton *chooseBtn = (UIButton *)sender;
    for(UIButton *btn in [_top1 subviews])
    {
        if(btn.tag > 0)                         //大于0，排除增加 减少数量的Button
        {
            if(btn.tag == chooseBtn.tag)
            {
                btn.layer.borderColor = [[UIColor redColor] CGColor];
                [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
                
                NSDictionary *dic = [_specifications objectAtIndex:btn.tag - 1];
                DictionaryWrapper *item = dic.wrapper;
                
                //存储 所选的样式, 用于生成订单
                _chooseSpecification = [item getString:@"SpecificationName"];
                
//                NSLog(@"item :%@", item);
//                
//                NSLog(@"productSpec: %@", [item getString:@"SpecificationName"]);
//                NSLog(@"Remains  : %d", [item getInt:@"Remains"]);
//                NSLog(@"Price  : %.2f", [item getFloat:@"Price"]);
                
                _priceRange.text = [NSString stringWithFormat:@"售价：%.2f金币", [item getFloat:@"Price"]];
                _onhandQty.text = [NSString stringWithFormat:@"库存：%d", [item getInt:@"Remains"]];
                
                CGRect frame = _priceRange.frame;
                frame.size.width = [self textWidthByChar:_priceRange.text height:_priceRange.frame.size.height fontSize:_priceRange.font];
                _priceRange.frame = frame;
                
                frame = _freeShipping.frame;
                frame.origin.x = _priceRange.frame.origin.x + _priceRange.frame.size.width + 5;
                _freeShipping.frame = frame;
                
            }
            else
            {
                btn.layer.borderColor = [[UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:0.5f] CGColor];
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
    }
    
    //加
    else if(btn.tag == 1)
    {
        _tf_count.text = [NSString stringWithFormat:@"%d", [_tf_count.text intValue] + 1];
    }
    
    //商品咨询
    else if(btn.tag == 2)
    {
        PUSH_VIEWCONTROLLER(ShippingConsultViewController);
        model.type = [NSString stringWithFormat:@"%d",5];
        model.proterId = [NSString stringWithFormat:@"%d",(int)_productId];
    }
    
    //商家店铺
    else if(btn.tag == 3)
    {
        PUSH_VIEWCONTROLLER(MerchantDetailViewController)
        model.enId = [NSString stringWithFormat:@"%d",_obj_enterprise.enterpriseId];
    }
    
    //商品介绍
    else if(btn.tag == 4)
    {
        [_view_service removeFromSuperview];
        [_top3 addSubview:_view_introduce];
        
        _top3.frame = CGRectMake(_top3.frame.origin.x, _top3.frame.origin.y, _top3.frame.size.width, _view_introduce.frame.size.height);
        
        
        [_baseScroll setContentSize:CGSizeMake(_baseScroll.frame.size.width, _top3.frame.origin.y + _top3.frame.size.height + _view_tools.frame.size.height)];
        
        [self animation_slipBar_scroll:btn.tag];
    }
    
    //售后服务
    else if(btn.tag == 5)
    {
        [_view_introduce removeFromSuperview];
        [_top3 addSubview:_view_service];
        
        _top3.frame = CGRectMake(_top3.frame.origin.x, _top3.frame.origin.y, _top3.frame.size.width, _view_service.frame.size.height);
        
        
        [_baseScroll setContentSize:CGSizeMake(_baseScroll.frame.size.width, _top3.frame.origin.y + _top3.frame.size.height + _view_tools.frame.size.height)];
        
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
//        PUSH_VIEWCONTROLLER(ConfirmOrderViewController);
//        model.type = 2;
        
        NSString *speciName = @"";
        
        if([_chooseSpecification isEqualToString:@""] || _chooseSpecification == nil || [_chooseSpecification isEqual:[NSNull null]])
        {
            //只有一个规格选项，未选中 默认选择第一个
            if(_specifications && [_specifications count] == 1)
            {
                NSDictionary *data = [_specifications objectAtIndex:0];
                DictionaryWrapper *item = data.wrapper;
                speciName = [item getString:@"SpecificationName"];
            }
            
            //有多个选项
            else if([_specifications count] > 1)
            {
                [HUDUtil showErrorWithStatus:@"请选择商品规格"];
            }
        }
        else
            speciName = _chooseSpecification;
        
        NSString *proId = [NSString stringWithFormat:@"%d", _productId];
        NSString *count = _tf_count.text;
        NSDictionary *dic = @{@"OrderType": @"7", @"ItemCount":count, @"ProductId":proId, @"Specification":speciName};
        ADAPI_Payment_GoCommonOrderShow([GLOBAL_DELEGATOR_MANAGER addDelegator:self selector:@selector(handleCreatedOrder:)], dic);
    }
}

//收藏状态改变
-(void)favorite_status_change:(BOOL)selected
{
    if(selected)
    {
        _btn_favorite.selected = YES;
        _img_favorite.image = [UIImage imageNamed:@"preview_favorite_1"];
    }
    else
    {
        _btn_favorite.selected = NO;
        _img_favorite.image = [UIImage imageNamed:@"preview_favorite_0"];
    }
}

//商品介绍、售后服务 切换效果
-(void)animation_slipBar_scroll:(NSInteger)tag
{
    
    CGRect slipBarFrame = _slipBar.frame;
    
    if(tag == 4)
    {
        _title_introduce.font = [UIFont systemFontOfSize:16.0];
        _title_service.font = [UIFont systemFontOfSize:14.0];
        
        _title_introduce.textColor = [UIColor redColor];
        _title_service.textColor = [UIColor blackColor];
        
        slipBarFrame.origin.x = 35;
    }
    else if(tag == 5)
    {
        _title_introduce.font = [UIFont systemFontOfSize:14.0];
        _title_service.font = [UIFont systemFontOfSize:16.0];
        
        _title_introduce.textColor = [UIColor blackColor];
        _title_service.textColor = [UIColor redColor];
        
        slipBarFrame.origin.x = 190;
    }
    //slipBar 滑动效果
    
    [UIView animateWithDuration:0.3   animations:^{
        
        _slipBar.frame = slipBarFrame;
        
    }];
}

//计算text的高度By Char
-(CGFloat)textHeightByChar:(NSString*)contentText width:(CGFloat)width fontSize:(UIFont *)font
{
    CGSize size=[contentText sizeWithFont:font constrainedToSize:CGSizeMake(width, 30000.0f) lineBreakMode:UILineBreakModeWordWrap];//UILineBreakModeCharacterWrap
    CGFloat height = size.height;
    return height;
}

//计算text的宽度By Char
-(CGFloat)textWidthByChar:(NSString*)contentText height:(CGFloat)height fontSize:(UIFont *)font
{
    CGSize size=[contentText sizeWithFont:font constrainedToSize:CGSizeMake(30000.0f, height) lineBreakMode:UILineBreakModeWordWrap];//UILineBreakModeCharacterWrap
    CGFloat width = size.width;
    return width;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
