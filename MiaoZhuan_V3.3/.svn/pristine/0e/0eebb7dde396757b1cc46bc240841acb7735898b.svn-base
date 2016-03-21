//
//  Commodity_Detail.m
//  miaozhuan
//
//  Created by xm01 on 14-12-29.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "Commodity_Detail.h"
#import "ModelData.h"
#import "Preview_Commodity.h"
#import "UIView+expanded.h"
#import "Commodity_Update.h"
#import "AppUtils.h"

#define centerSpace         13
#define bottomSpace         15
#define fontHeight          16
#define boderMargin         4
//#define labMargin           6

@interface Commodity_Detail ()<Commodity_Update_Delegate>
{
    BOOL            _canEqual;
}


@property(nonatomic, retain) IBOutlet UIScrollView  *scrollView;

@property(nonatomic, retain) IBOutlet UIView        *topView;
@property(nonatomic, retain) IBOutlet UIView        *centerView;
@property(nonatomic, retain) IBOutlet UIView        *bottomView;


//topView
@property(nonatomic, retain) IBOutlet UILabel       *lab_productName;           //商品名称
@property(nonatomic, retain) IBOutlet NetImageView  *picture;
@property(nonatomic, retain) IBOutlet UILabel       *title_unitPrice;
@property(nonatomic, retain) IBOutlet UILabel       *lab_unitPrice;             //单价
@property(nonatomic, retain) IBOutlet UILabel       *title_deliveryPrice;
@property(nonatomic, retain) IBOutlet UILabel       *lab_deliveryPrice;         //邮寄费用
@property(nonatomic, retain) IBOutlet UILabel       *title_onhandQty;
@property(nonatomic, retain) IBOutlet UILabel       *lab_onhandQty;             //库存数量
@property(nonatomic, retain) IBOutlet UILabel       *title_offlineType;
@property(nonatomic, retain) IBOutlet UILabel       *lab_offlineType;           //下架方式          1, 售完下架   2, 到期下架
@property(nonatomic, retain) IBOutlet UIView        *top_mark;

@property(nonatomic, retain) IBOutlet UIButton      *btn_update;

//centerView
@property(nonatomic, retain) IBOutlet UILabel       *lab_Info_producName;       //商品名称
@property(nonatomic, retain) IBOutlet UILabel       *lab_catagoryName;          //商品类别
@property(nonatomic, retain) IBOutlet UILabel       *lab_parameter;             //颜色/参数

@property(nonatomic, retain) IBOutlet UILabel       *title_producName;       //商品名称

@property(nonatomic, retain) IBOutlet UIView        *center_mark;
@property(nonatomic, retain) IBOutlet UILabel       *sale_comment;              //销售属性

@property(nonatomic, retain) IBOutlet UILabel       *title_catagoryName;        //标题 - 商品类别
@property(nonatomic, retain) IBOutlet UILabel       *title_parameter;           //标题 - 颜色/参数
@property(nonatomic, retain) IBOutlet UILabel       *base_comment0;
@property(nonatomic, retain) IBOutlet UILabel       *base_comment1;

//bottomView
@property(nonatomic, retain) IBOutlet UILabel       *lab_feature;            //特色卖点
@property(nonatomic, retain) IBOutlet UILabel       *lab_description;        //商品描述
@property(nonatomic, retain) IBOutlet UILabel       *lab_promise;            //售后条款
@property(nonatomic, retain) IBOutlet UILabel       *title_feature;
@property(nonatomic, retain) IBOutlet UILabel       *title_description;      //标题 - 商品描述
@property(nonatomic, retain) IBOutlet UILabel       *title_promise;          //标题 - 售后条款

@property(nonatomic, retain) IBOutlet UIView        *resendView;

@property(nonatomic, retain) IBOutlet UIScrollView  *view_boder0;
@property(nonatomic, retain) IBOutlet UIScrollView  *view_boder1;
@property(nonatomic, retain) IBOutlet UIScrollView  *view_boder2;

@property(nonatomic, retain) IBOutlet UIButton      *btn_review;

@property(nonatomic, retain) UpdateModel            *updateModel;

@end

@implementation Commodity_Detail

-(void)dealloc
{
    [_scrollView release];
    [_topView release];
    [_centerView  release];
    [_bottomView release];
    
    [_lab_productName release];
    [_picture release];
    [_title_unitPrice release];
    [_lab_unitPrice release];
    [_title_deliveryPrice release];
    [_lab_deliveryPrice release];
    [_title_onhandQty release];
    [_lab_onhandQty release];
    [_title_offlineType release];
    [_lab_offlineType release];
    [_top_mark release];
    [_sale_comment release];
    [_btn_update release];
    
    [_lab_Info_producName release];
    [_lab_catagoryName release];
    [_lab_parameter release];
    [_center_mark release];
    [_base_comment0 release];
    [_base_comment1 release];
    [_title_producName release];
    [_title_catagoryName release];
    [_title_parameter   release];
    
    [_lab_feature release];
    [_lab_description release];
    [_lab_promise release];
    
    [_title_feature release];
    [_title_description release];
    [_title_promise release];
    
    [_view_boder0 release];
    [_view_boder1 release];
    [_view_boder2 release];
    
    [_updateModel release];
    
    [_resendView release];
    
    [_btn_review release];
    
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
    self.title_unitPrice = nil;
    self.lab_unitPrice = nil;
    self.title_deliveryPrice = nil;
    self.lab_deliveryPrice = nil;
    self.title_onhandQty = nil;
    self.lab_onhandQty = nil;
    self.title_offlineType = nil;
    self.lab_offlineType = nil;
    self.top_mark = nil;
    self.sale_comment = nil;
    self.btn_update = nil;
    
    self.lab_Info_producName = nil;
    self.lab_catagoryName = nil;
    self.lab_parameter = nil;
    self.center_mark = nil;
    self.base_comment0 = nil;
    self.base_comment1 = nil;
    self.title_producName = nil;
    self.title_catagoryName = nil;
    self.title_parameter = nil;
    
    self.lab_feature = nil;
    self.lab_description = nil;
    self.lab_promise = nil;
    
    self.title_feature = nil;
    self.title_description = nil;
    self.title_promise = nil;
    
    self.view_boder0 = nil;
    self.view_boder1 = nil;
    self.view_boder2 = nil;
    
    self.updateModel = nil;
    
    self.resendView = nil;
    
    self.btn_review = nil;
}

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad {
    [super viewDidLoad];
    
    InitNav(@"商品详情");
    [self setupMoveBackButton];
    
    [_picture roundCornerBorder];
    _picture.layer.cornerRadius = 0.0f;
    
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
    
    [_btn_review roundCornerBorder];
    
    //边框
    
    _view_boder0.layer.cornerRadius = 5.0f;
    _view_boder0.layer.borderWidth = 0.4f;
    _view_boder0.layer.borderColor = [[UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:0.5f] CGColor];
    
    _view_boder1.layer.cornerRadius = 5.0f;
    _view_boder1.layer.borderWidth = 0.4f;
    _view_boder1.layer.borderColor = [[UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:0.5f] CGColor];
    
    _view_boder2.layer.cornerRadius = 5.0f;
    _view_boder2.layer.borderWidth = 0.4f;
    _view_boder2.layer.borderColor = [[UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:0.5f] CGColor];

    
    
    
    _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width, _topView.frame.size.height + _centerView.frame.size.height + _bottomView.frame.size.height);
    
    //等待上架,无修改按钮
    if(_whereFrom == 1 || _whereFrom == 3)
    {
        _btn_update.hidden = YES;
    }
    
    [_btn_update roundCornerBorder];
    
    _btn_update.layer.borderColor = [[UIColor colorWithRed:240.0/255.0 green:5.0/255.0 blue:0.0/255.0 alpha:0.5f] CGColor];
    
    //重新上架
    CGRect frame = _resendView.frame;
    frame.origin.y = [UIScreen mainScreen].bounds.size.height - frame.size.height - self.navigationController.navigationBar.frame.size.height - 20;
    _resendView.frame = frame;
    [_resendView addSubview:[AppUtils LineView:0.5f]];
    [self.view addSubview:_resendView];
    
    _resendView.hidden = YES;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    ADAPI_GoldCommodityDetail([GLOBAL_DELEGATOR_MANAGER addDelegator:self selector:@selector(handleSucceed:)], _productId);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)handleSucceed:(DelegatorArguments *)arguments
{
    DictionaryWrapper *Datas = arguments.ret;
    
    DictionaryWrapper *wrapper = [Datas getDictionaryWrapper:@"Data"];
    
    CGRect name_frame = _lab_productName.frame;
    
    
    _lab_productName.text = [wrapper getString:@"ProductName"];
    
    int name_height = 0;
    
    name_height = [AppUtils textHeightByChar:_lab_productName.text width:_lab_productName.frame.size.width fontSize:_lab_productName.font];
    
    if(name_height > 20)
    {
        name_frame.size.height = 38;

        _lab_productName.frame = name_frame;
    }

    if([wrapper getFloat:@"DeliveryPrice"] == 0)
        _lab_deliveryPrice.text = @"0 易货码";
    else
        _lab_deliveryPrice.text = [NSString stringWithFormat:@"%.2f 易货码",[wrapper getFloat:@"DeliveryPrice"]];
    
    NSArray *standardList = [wrapper getArray:@"StandardList"];

    [_top_mark addSubview:[AppUtils LineView:0.5f]];

    CGRect frame = _top_mark.frame;
    
    _sale_comment.text = [wrapper getString:@"SaleComment"];
    
    //审核失败
    if(_whereFrom == 2 && _sale_comment.text.length > 0)
    {
        _sale_comment.hidden = NO;
        
        int _sale_height = [AppUtils textHeightByChar:_sale_comment.text width:frame.size.width fontSize:_sale_comment.font];
        
        if(_sale_height > 15)
            _sale_height += 5;
        
        _sale_comment.frame = CGRectMake(_sale_comment.frame.origin.x, 40,  _sale_comment.frame.size.width, _sale_height);
        
        frame.size.height = _sale_comment.frame.origin.y + _sale_comment.frame.size.height + 10;
        
        _top_mark.frame = frame;
        
    }
    else
        _sale_comment.hidden = YES;
    
    if(_whereFrom == 2 || _whereFrom == 5)
        _resendView.hidden = NO;
    else
        _resendView.hidden = YES;
    
    frame.origin.y += _top_mark.frame.size.height;
    
    
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
            
            unitPrice = [unitPrice stringByAppendingString:[NSString stringWithFormat:@"%@/",[UICommon getStringToTwoDigitsAfterDecimalPlacesPoint:[item getString:@"UnitPrice"] withAppendStr:@""]]];
        }
        else
        {
            productSpec = [productSpec stringByAppendingString:[NSString stringWithFormat:@"%@",[item getString:@"ProductSpec"]]];
            
            unitPrice = [unitPrice stringByAppendingString:[NSString stringWithFormat:@"%@ 易货码",[UICommon getStringToTwoDigitsAfterDecimalPlacesPoint:[item getString:@"UnitPrice"] withAppendStr:@""]]];
        }
    }
    
    
    frame.origin.y += 17;
    frame.origin.x = _title_unitPrice.frame.origin.x;
    frame.size.width = _title_unitPrice.frame.size.width;
    frame.size.height = _title_unitPrice.frame.size.height;
    
    _title_unitPrice.frame = frame;
    
    
    _lab_unitPrice.text = unitPrice;
    frame.origin.x = _lab_unitPrice.frame.origin.x;
    frame.size.width = _lab_unitPrice.frame.size.width;
    
    int height = [AppUtils textHeightByChar:_lab_unitPrice.text width:frame.size.width fontSize:_lab_unitPrice.font];
    if(height > 16)
    {
        frame.origin.y = _title_unitPrice.frame.origin.y-3;
        frame.size.height = height+5;
       
    }
     _lab_unitPrice.frame = frame;
    
    frame.origin.y += frame.size.height + 10;
    
    frame.origin.x = _title_deliveryPrice.frame.origin.x;
    frame.size.width = _title_deliveryPrice.frame.size.width;
    frame.size.height = _title_deliveryPrice.frame.size.height;
    _title_deliveryPrice.frame = frame;
    
    frame.origin.x = _lab_deliveryPrice.frame.origin.x;
    frame.size.width = _lab_deliveryPrice.frame.size.width;
    _lab_deliveryPrice.frame = frame;
    
    frame.origin.y += frame.size.height + 10;
    
    frame.origin.x = _title_onhandQty.frame.origin.x;
    frame.size.width = _title_onhandQty.frame.size.width;
    _title_onhandQty.frame = frame;
    
    frame.origin.x = _lab_onhandQty.frame.origin.x;
    frame.size.width = _lab_onhandQty.frame.size.width;
    _lab_onhandQty.frame = frame;
    
    frame.origin.y += frame.size.height + 10;
    frame.origin.x = _title_offlineType.frame.origin.x;
    frame.size.width = _title_offlineType.frame.size.width;
    _title_offlineType.frame = frame;
    
    frame.origin.x = _lab_offlineType.frame.origin.x;
    frame.size.width = _lab_offlineType.frame.size.width;
    _lab_offlineType.frame = frame;
    
    frame.origin.y += frame.size.height + 20;
    
    _topView.frame = CGRectMake(_topView.frame.origin.x, _topView.frame.origin.y, _topView.frame.size.width, frame.origin.y);
    
    _lab_onhandQty.text = [NSString stringWithFormat:@"%d",onhandQty];
    
    //下架方式
    if([wrapper getInt:@"OfflineType"] == 1)
        _lab_offlineType.text = @"售完下架";
    else if([wrapper getInt:@"OfflineType"] == 2)
        _lab_offlineType.text = @"指定日期下架";
    else
        _lab_offlineType.text = @"";
    
    
    
    
    //centerView
    
    [_center_mark addSubview:[AppUtils LineView:0.5f]];
    
    frame = _center_mark.frame;
    
    _base_comment0.text = @"如需编辑本项，请用电脑访问\nhttp://www.xxxxxxx.com";
    _base_comment1.text = [wrapper getString:@"BaseComment"];
    
    
    //审核失败 || 已下架
    if(_whereFrom == 2 || _whereFrom == 5)
    {
        frame.origin.y = 25 + 6;
        
        BOOL canAdd = NO;
        
        if(_base_comment0.text.length >0)
        {
            _base_comment0.hidden = NO;
            
            frame.origin.x = 15;
            
            frame.origin.y += 15;
            
            int b0_height = [AppUtils textHeightByChar:_base_comment0.text width:_base_comment0.frame.size.width fontSize:_base_comment0.font];
            
            if(b0_height > 15)
                b0_height += 5;
            
            frame.size.height = b0_height;
            
            _base_comment0.frame = frame;
            
            frame.origin.y += frame.size.height + 10;
            
            canAdd = YES;
        }
        
        if(_base_comment1.text.length >0)
        {
            _base_comment1.hidden = NO;
            
            frame.origin.x = 15;
            int b1_height = [AppUtils textHeightByChar:_base_comment1.text width:_base_comment1.frame.size.width fontSize:_base_comment1.font];
            
            if(b1_height > 15)
                b1_height += 5;
            
            frame.size.height = b1_height;
            frame.size.width = _base_comment1.frame.size.width;
            _base_comment1.frame = frame;
            frame.origin.y += frame.size.height + 10;
            
            
            canAdd = YES;
        }
        
        if(canAdd)
        {
            frame.origin.y += 10;
        }
        else
        {
            frame.origin.y += 15;
        }
        
        
    }
    else
    {
        _base_comment0.hidden = YES;
        _base_comment1.hidden = YES;
        
        frame.origin.y += frame.size.height;
    }
    
    _center_mark.frame = CGRectMake(0, _center_mark.frame.origin.y, _center_mark.frame.size.width, frame.origin.y-10);
    
    
    [_picture requestPic:[wrapper getString:@"PictureUrl"] placeHolder:NO];
    
    //商品名称
    
    frame.origin.y += 17;
    frame.origin.x = _title_producName.frame.origin.x;
    frame.size.width = _title_producName.frame.size.width;
    frame.size.height = _title_producName.frame.size.height;
    _title_producName.frame = frame;
    
    
    _lab_Info_producName.text = [wrapper getString:@"ProductName"];
    frame.origin.x = _lab_Info_producName.frame.origin.x;
    frame.size.width = _lab_Info_producName.frame.size.width;
    int info_height = [AppUtils textHeightByChar:_lab_Info_producName.text width:_lab_Info_producName.frame.size.width fontSize:_lab_Info_producName.font];
    
    if(info_height > 20)
        frame.size.height = info_height+3;
    _lab_Info_producName.frame = frame;
    
    _lab_catagoryName.text = [wrapper getString:@"CatagoryName"];
    
    
    frame.origin.y += frame.size.height + 13;
    frame.origin.x = _title_catagoryName.frame.origin.x;
    frame.size.width = _title_catagoryName.frame.size.width;
    frame.size.height = _title_catagoryName.frame.size.height;
    _title_catagoryName.frame = frame;
    
    frame.origin.x = _lab_catagoryName.frame.origin.x;
    frame.size.width = _lab_catagoryName.frame.size.width;
    frame.size.height = _lab_catagoryName.frame.size.height;
    _lab_catagoryName.frame = frame;
    
    frame.origin.y += frame.size.height + 13;
    frame.origin.x = _title_parameter.frame.origin.x;
    frame.size.width = _title_parameter.frame.size.width;
    frame.size.height = _title_parameter.frame.size.height;
    _title_parameter.frame = frame;
    
    _lab_parameter.text = productSpec;
    
    frame.origin.x = _lab_parameter.frame.origin.x;
    frame.size.width = _lab_parameter.frame.size.width;
    frame.size.height = [AppUtils textHeightByChar:_lab_parameter.text width:_lab_parameter.frame.size.width fontSize:_lab_parameter.font]+3;
    _lab_parameter.frame = frame;
    
    
    
    
    
    frame.origin.y += frame.size.height + 19;
    
    
    _centerView.frame = CGRectMake(0, _topView.frame.origin.y + _topView.frame.size.height, _centerView.frame.size.width, frame.origin.y);
    
    [_centerView addSubview:[AppUtils LineView:0.5f]];
    
    //bottomView
    
    _lab_feature.text = [wrapper getString:@"ProductFeature"];
    _lab_description.text = [wrapper getString:@"ProductDesciption"];
    _lab_promise.text = [wrapper getString:@"EnterprisePromise"];
    
    //特色卖点
    
    CGRect featureFrame = _lab_feature.frame;
    CGFloat feature_height = [AppUtils textHeightByChar:_lab_feature.text width:_lab_feature.frame.size.width fontSize:_lab_feature.font];
    int offset_height = 0;
    
    if(feature_height > 15)
        offset_height = 5;
    
    featureFrame.size.height = feature_height + offset_height;
    
    _lab_feature.frame = featureFrame;
    
    _view_boder0.contentSize = CGSizeMake(_view_boder0.frame.size.width, _lab_feature.frame.size.height + boderMargin * 2);
    
    //商品描述
    CGRect descriptionFrame = _lab_description.frame;
    CGFloat description_height = [AppUtils textHeightByChar:_lab_description.text width:_lab_description.frame.size.width fontSize:_lab_description.font];
    
    offset_height = 0;
    if(description_height > 15)
        offset_height = 5;
    
    descriptionFrame.size.height = description_height + offset_height;
    _lab_description.frame = descriptionFrame;
    _view_boder1.contentSize = CGSizeMake(_view_boder1.frame.size.width, _lab_description.frame.size.height + boderMargin * 2);
    CGRect promiseFrame = _lab_promise.frame;
    CGFloat promise_height = [AppUtils textHeightByChar:_lab_promise.text width:_lab_promise.frame.size.width fontSize:_lab_promise.font];
    
    offset_height = 0;
    if(promise_height > 15)
        offset_height = 5;
    
    promiseFrame.size.height = promise_height + offset_height;
    _lab_promise.frame = promiseFrame;
    
    _view_boder2.contentSize = CGSizeMake(_view_boder2.frame.size.width, _lab_promise.frame.size.height + boderMargin * 2);
    
    //bottomView 高度设置
    CGRect bottomFrame = _bottomView.frame;
    bottomFrame.origin.y = _centerView.frame.origin.y + _centerView.frame.size.height;
    _bottomView.frame = bottomFrame;
    
    [_bottomView addSubview:[AppUtils LineView:355.f]];
    
    //scrollView 滑动范围
    //是否有重新上架
    int resendView_height = 0;
    if(_whereFrom == 2 || _whereFrom == 5)
        resendView_height = _resendView.frame.size.height;
    _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width, _topView.frame.size.height + _centerView.frame.size.height + _bottomView.frame.size.height + resendView_height);
    
    _updateModel = [[UpdateModel alloc] init];
    _updateModel.standardList = standardList;
    _updateModel.productId = [wrapper getInt:@"ProductId"];
    _updateModel.deliveryPrice = [[UICommon getStringToTwoDigitsAfterDecimalPlacesPoint:[wrapper getString:@"DeliveryPrice"] withAppendStr:@""] intValue];
    _updateModel.offlineType = [wrapper getInt:@"OfflineType"];
    _updateModel.offlineDate = [wrapper getString:@"OfflineDate"];
}


//预览、修改
-(IBAction)Action_Jump:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    
    //预览
    if(btn.tag == 0)
    {
        PUSH_VIEWCONTROLLER(Preview_Commodity);
        model.productId = _productId;
        model.whereFrom = 0;
        model.navigationItem.hidesBackButton = YES;
    }
    
    //修改
    else if(btn.tag == 1)
    {
        PUSH_VIEWCONTROLLER(Commodity_Update);
        model.updateModel = _updateModel;
        model.delegate = self;
    }
    
}


//重新发起上架
-(IBAction)Action_resend:(id)sender
{
        
        [AlertUtil showAlert:@"" message:@"确定要发起重新上架申请吗" buttons:@[@{
                                                                                       @"title":@"取消",
                                                                                       @"delegator":ALERT_VIEW_DELEGATOR_BLOCK
                                                                                       ({
        })
                                                                                       },
                                                                                   @{
                                                                                       @"title":@"确定",
                                                                                       @"delegator":ALERT_VIEW_DELEGATOR_BLOCK
                                                                                       ({
            
            
            NSMutableArray *resendList = [[AppUtils getInstance] getResendList];
            
            BOOL canResend = NO;
            
            for(resendObject *obj in resendList)
            {
                if(_productId == obj.productId)
                    canResend = YES;
            }
            
//            if(!canResend)
//            {
//                [HUDUtil showErrorWithStatus:@"销售属性，尚未更改"];
//                return;
//            }
//            else if([_lab_onhandQty.text intValue] == 0)
//            {
//                [HUDUtil showErrorWithStatus:@"请修改发布数量"];
//                return;
//            }
//            //审核失败, 并且有商品信息错误描述
//            else if(_whereFrom == 2 && _base_comment1.text.length > 0)
//            {
//                [HUDUtil showErrorWithStatus:@"商品信息，尚未更改"];
//                return;
//            }
//            else
//            {
            
                ADAPI_ResendPutaway([GLOBAL_DELEGATOR_MANAGER addDelegator:self selector:@selector(resendSucceed:)], _productId);
//            }
            
//            if(!_canEqual)
//            {
////                    [HUDUtil showErrorWithStatus:@"销售属性，尚未更改"];
////                return;
//            }
//            else if([_lab_onhandQty.text intValue] == 0)
//            {
//                [HUDUtil showErrorWithStatus:@"请修改发布数量"];
//                return;
//            }
//            //审核失败, 并且有商品信息错误描述
//            else if(_whereFrom == 2 && _base_comment1.text.length > 0)
//            {
//                [HUDUtil showErrorWithStatus:@"商品信息，尚未更改"];
//                return;
//            }
//            else
//            {
//                
//                ADAPI_ResendPutaway([GLOBAL_DELEGATOR_MANAGER addDelegator:self selector:@selector(resendSucceed:)], _productId);
//            }
        })
                                                                                       }
                                                                                   ]];
    
}

- (void)resendSucceed:(DelegatorArguments *)arguments
{
    DictionaryWrapper *dic = arguments.ret;
    
    if([dic getInt:@"Code"] == 100)
    {
        int i = 0;
        for(resendObject *obj in [[AppUtils getInstance] getResendList])
        {
            if(_productId == obj.productId)
            {
                [[[AppUtils getInstance] getResendList] removeObjectAtIndex:i];
            }
            i ++;
        }
        
        [AlertUtil showAlert:@"" message:@"已申请成功，请等待审核" buttons:@[
                                                                   @{
                                                                       @"title":@"确定",
                                                                       @"delegator":ALERT_VIEW_DELEGATOR_BLOCK
                                                                       ({
            [self.navigationController popViewControllerAnimated:YES];
        })
        }
        ]];
        
    }
    else
        [HUDUtil showErrorWithStatus:[dic getString:@"Desc"]];
}

// Update's CallBack
// is Can show resendView
-(void)resendPutaway:(BOOL)isEqual allOnhandQty:(int)allOnhandQty
{
    //审核失败 || 已下架
    if(_whereFrom == 2 || _whereFrom == 5)
    {
        if(allOnhandQty == 0)
            _canEqual = NO;
        else
            _canEqual = isEqual;
    }
}

@end
