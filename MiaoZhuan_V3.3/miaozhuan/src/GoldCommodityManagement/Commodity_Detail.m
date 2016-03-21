//
//  Commodity_Detail.m
//  miaozhuan
//
//  Created by xm01 on 14-12-29.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "Commodity_Detail.h"
#import "Commodity_Update.h"
#import "ModelData.h"
#import "Preview_Commodity.h"
#import "UIView+expanded.h"

#define centerSpace         13
#define bottomSpace         15
#define fontHeight          16

@interface Commodity_Detail ()

@end

@implementation Commodity_Detail
@synthesize productId;

@synthesize scrollView = _scrollView;

@synthesize topView = _topView;
@synthesize centerView = _centerView;
@synthesize bottomView = _bottomView;

@synthesize lab_productName = _lab_productName;
@synthesize picture = _picture;
@synthesize lab_unitPrice = _lab_unitPrice;
@synthesize lab_deliveryPrice = _lab_deliveryPrice;
@synthesize lab_onhandQty = _lab_onhandQty;
@synthesize lab_offlineType = _lab_offlineType;

@synthesize lab_Info_producName = _lab_Info_producName;
@synthesize lab_catagoryName = _lab_catagoryName;
@synthesize lab_parameter = _lab_parameter;

@synthesize lab_feature = _lab_feature;
@synthesize lab_description = _lab_description;
@synthesize lab_promise = _lab_promise;
@synthesize title_feature = _title_feature;
@synthesize title_description = _title_description;
@synthesize title_promise = _title_promise;

@synthesize updateModel = _updateModel;

-(void)dealloc
{
    [_scrollView release];
    [_topView release];
    [_centerView  release];
    [_bottomView release];
    
    [_lab_productName release];
    [_picture release];
    [_lab_unitPrice release];
    [_lab_deliveryPrice release];
    [_lab_onhandQty release];
    [_lab_offlineType release];
    
    [_lab_Info_producName release];
    [_lab_catagoryName release];
    [_lab_parameter release];
    
    [_lab_feature release];
    [_lab_description release];
    [_lab_promise release];
    
    [_title_feature release];
    [_title_description release];
    [_title_promise release];
    
    [_updateModel release];
    
    [super dealloc];
}

-(void)viewDidUnload
{
    [super viewDidUnload];
    
    self.scrollView = nil;
    
    self.topView = nil;
    self.centerView = nil;
    self.bottomView = nil;
    
    self.lab_productName = nil;
    self.picture = nil;
    self.lab_unitPrice = nil;
    self.lab_deliveryPrice = nil;
    self.lab_onhandQty = nil;
    self.lab_offlineType = nil;
    
    self.lab_Info_producName = nil;
    self.lab_catagoryName = nil;
    self.lab_parameter = nil;
    
    self.lab_feature = nil;
    self.lab_description = nil;
    self.lab_promise = nil;
    
    self.title_feature = nil;
    self.title_description = nil;
    self.title_promise = nil;
    self.updateModel = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    InitNav(@"商品详情");
    [self setupMoveBackButton];
    
    [_picture roundCornerBorder];
    
    _scrollView.backgroundColor = [UIColor grayColor];
    //添加topView
    [_scrollView addSubview:_topView];
    
    //添加centerView
    CGRect centerFrame = _centerView.frame;
    
    centerFrame.origin.y = _topView.origin.y + _topView.size.height;
    
    _centerView.frame = centerFrame;
    
    [_scrollView addSubview:_centerView];
    
    //添加bottomView
    CGRect bottomFrame = _bottomView.frame;
    
    bottomFrame.origin.y = _centerView.origin.y + _centerView.size.height;
    
    _bottomView.frame = bottomFrame;
    
    [_scrollView addSubview:_bottomView];
    
    //边框
    _lab_feature.layer.cornerRadius = 3.0f;
    _lab_feature.layer.borderWidth = 0.4f;
    _lab_feature.layer.borderColor = [[UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:0.5f] CGColor];
    
    _lab_description.layer.cornerRadius = 5.0f;
    _lab_description.layer.borderWidth = 0.4f;
    _lab_description.layer.borderColor = [[UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:0.5f] CGColor];
    
    _lab_promise.layer.cornerRadius = 5.0f;
    _lab_promise.layer.borderWidth = 0.4f;
    _lab_promise.layer.borderColor = [[UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:0.5f] CGColor];
    
    
    
    _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width, _topView.frame.size.height + _centerView.frame.size.height + _bottomView.frame.size.height);
    
    ADAPI_GoldCommodityDetail([GLOBAL_DELEGATOR_MANAGER addDelegator:self selector:@selector(handleSucceed:)], productId);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)handleSucceed:(DelegatorArguments *)arguments
{
    DictionaryWrapper *Datas = arguments.ret;
    
    DictionaryWrapper *wrapper = [Datas getDictionaryWrapper:@"Data"];
    
    _lab_productName.text = [wrapper getString:@"ProductName"];

    _lab_deliveryPrice.text = [NSString stringWithFormat:@"%.1f",[wrapper getFloat:@"DeliveryPrice"]];
    
    NSArray *standardList = [wrapper getArray:@"StandardList"];
    
    int onhandQty = 0;                  //库存数量
    
    NSString *unitPrice = @"";          //价格
    
    NSString *productSpec =@"";         //规格型号
    
    
    int i = 0;
    for (NSDictionary *data in standardList) {
        
        DictionaryWrapper *item = data.wrapper;
        
        onhandQty += [item getInt:@"OnhandQty"];
        
       //计算是否最后一个 用于结尾是否加上"/"字符
        
        i++;
        if(i != [standardList count])
        {
            productSpec = [productSpec stringByAppendingString:[NSString stringWithFormat:@"%@\n",[item getString:@"ProductSpec"]]];
            
            unitPrice = [unitPrice stringByAppendingString:[NSString stringWithFormat:@"%.2f/",[item getFloat:@"UnitPrice"]]];
        }
        else
        {
            productSpec = [productSpec stringByAppendingString:[NSString stringWithFormat:@"%@",[item getString:@"ProductSpec"]]];
            
            unitPrice = [unitPrice stringByAppendingString:[NSString stringWithFormat:@"%.2f 金币",[item getFloat:@"UnitPrice"]]];
        }
    }
    
    _lab_unitPrice.text = unitPrice;
    _lab_onhandQty.text = [NSString stringWithFormat:@"%d",onhandQty];
    
    //下架方式
    if([wrapper getInt:@"OfflineType"] == 1)
        _lab_offlineType.text = @"售完下架";
    else if([wrapper getInt:@"OfflineType"] == 2)
        _lab_offlineType.text = @"指定日期下架";
    else
        _lab_offlineType.text = @"";
    
    //centerView
    
    [_picture requestPic:[wrapper getString:@"PictureUrl"] placeHolder:NO];
    
    //商品名称
    _lab_Info_producName.text = [wrapper getString:@"ProductName"];
    CGRect info_productName_frame = _lab_Info_producName.frame;
    info_productName_frame.size.height = [self textHeightByChar:_lab_Info_producName.text width:_lab_Info_producName.frame.size.width fontSize:_lab_Info_producName.font];
    
    _lab_Info_producName.frame = info_productName_frame;
    
    //商品类别
    _lab_catagoryName.text = [wrapper getString:@"CatagoryName"];
    CGRect catagoryName_frame =_lab_catagoryName.frame;
    catagoryName_frame.origin.y = _lab_Info_producName.frame.origin.y + _lab_Info_producName.frame.size.height + centerSpace;
    _lab_catagoryName.frame = catagoryName_frame;
    _title_catagoryName.frame = CGRectMake(_title_catagoryName.frame.origin.x, _lab_catagoryName.frame.origin.y, _title_catagoryName.frame.size.width, _title_catagoryName.frame.size.height);
    
    //商品参数
    
    _lab_parameter.text = productSpec;
    
    CGRect parameter_frame = _lab_parameter.frame;
    parameter_frame.origin.y = _lab_catagoryName.frame.origin.y + _lab_catagoryName.frame.size.height + centerSpace;
    parameter_frame.size.height = [self textHeightByChar:_lab_parameter.text width:_lab_parameter.frame.size.width fontSize:_lab_parameter.font];
//    parameter_frame.size.height = 60;
    _lab_parameter.frame = parameter_frame;
    _title_parameter.frame = CGRectMake(_title_parameter.frame.origin.x, _lab_parameter.frame.origin.y, _title_parameter.frame.size.width, _title_parameter.frame.size.height);
    
    //bottomView 高度设置
    CGRect centerFrame = _centerView.frame;
    centerFrame.size.height = parameter_frame.origin.y + parameter_frame.size.height + 20;
    _centerView.frame = centerFrame;
    
    
    //bottomView
    
    _lab_feature.text = [wrapper getString:@"ProductFeature"];
    _lab_description.text = [wrapper getString:@"ProductDesciption"];
    _lab_promise.text = [wrapper getString:@"EnterprisePromise"];
    
    int space = 0;
    
    //特色卖点
    CGRect featureFrame = _lab_feature.frame;
    CGFloat feature_height = [self textHeightByChar:_lab_feature.text width:_lab_feature.frame.size.width fontSize:_lab_feature.font];
    featureFrame.size.height = feature_height;
    _lab_feature.frame = featureFrame;
    
    if(feature_height > fontHeight)
        space = 6;
    else
        space = 0;
    _title_feature.frame = CGRectMake(_title_feature.frame.origin.x, _lab_feature.origin.y + space, _title_feature.frame.size.width, _title_feature.frame.size.height);
    
    
    //商品描述
    CGRect descriptionFrame = _lab_description.frame;
    CGFloat description_height = [self textHeightByChar:_lab_description.text width:_lab_description.frame.size.width fontSize:_lab_description.font];
    descriptionFrame.size.height = description_height;
    descriptionFrame.origin.y = featureFrame.origin.y + featureFrame.size.height + bottomSpace;
    _lab_description.frame = descriptionFrame;
    
    if( description_height > 16 )
        space = 6;
    else
        space = 0;
    _title_description.frame = CGRectMake(_title_description.frame.origin.x, descriptionFrame.origin.y + space, _title_description.frame.size.width, _title_description.frame.size.height);
    
    //售后服务
    CGRect promiseFrame = _lab_promise.frame;
    CGFloat promise_height = [self textHeightByChar:_lab_promise.text width:_lab_promise.frame.size.width fontSize:_lab_promise.font];
    promiseFrame.size.height = promise_height;
    promiseFrame.origin.y = descriptionFrame.origin.y + descriptionFrame.size.height + bottomSpace;
    _lab_promise.frame = promiseFrame;
    
    if( promise_height > fontHeight )
        space = 6;
    else
        space = 0;
    _title_promise.frame = CGRectMake(_title_promise.frame.origin.x, promiseFrame.origin.y + space, _title_promise.frame.size.width, _title_promise.frame.size.height);
    
    //bottomView 高度设置
    CGRect bottomFrame = _bottomView.frame;
    bottomFrame.origin.y = _centerView.frame.origin.y + _centerView.frame.size.height;
    bottomFrame.size.height = promiseFrame.origin.y + promiseFrame.size.height + bottomSpace*2;
    _bottomView.frame = bottomFrame;
    
    //scrollView 滑动范围
    _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width, _topView.frame.size.height + _centerView.frame.size.height + _bottomView.frame.size.height);
    
    _updateModel = [[UpdateModel alloc] init];
    _updateModel.standardList = standardList;
    _updateModel.productId = [wrapper getInt:@"ProductId"];
    _updateModel.deliveryPrice = [wrapper getFloat:@"DeliveryPrice"];
    _updateModel.offlineType = [wrapper getInt:@"OfflineType"];
}



//计算text的高度By Char
-(CGFloat)textHeightByChar:(NSString*)contentText width:(CGFloat)width fontSize:(UIFont *)font
{
    //    UIFont * font=[UIFont  systemFontOfSize:fontSize];
    CGSize size=[contentText sizeWithFont:font constrainedToSize:CGSizeMake(width, 30000.0f) lineBreakMode:UILineBreakModeWordWrap];//UILineBreakModeCharacterWrap
    CGFloat height = size.height;
    return height;
}

//预览、修改
-(IBAction)Action_Jump:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    
    //预览
    if(btn.tag == 0)
    {
        PUSH_VIEWCONTROLLER(Preview_Commodity);
        model.productId = productId;
        model.whereFrom = 0;
    }
    
    //修改
    else if(btn.tag == 1)
    {
        PUSH_VIEWCONTROLLER(Commodity_Update);
        model.updateModel = _updateModel;
    }
    
}

@end
