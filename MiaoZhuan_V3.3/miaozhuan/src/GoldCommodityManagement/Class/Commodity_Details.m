//
//  Commodity_Details.m
//  miaozhuan
//
//  Created by Nick on 15/5/9.
//  Copyright (c) 2015年 zdit. All rights reserved.
//

#import "Commodity_Details.h"
#import "AppUtils.h"
#import "Commodity_Info_Update.h"
#import "Commodity_Update.h"
#import "PreviewViewController.h"
#import "NetImageView.h"
#import "Preview_Commodity.h"

#define image_Space     20
#define image_Width     80
#define image_Height    80
#define image_start_X   20
#define image_Top_Space 15

@interface Commodity_Details ()<Commodity_Update_Delegate, UINavigationControllerDelegate>
{
    
}
@property(nonatomic, retain) IBOutlet UIScrollView  * scrollView;

@property(nonatomic, retain) IBOutlet UIView        * topView;
@property(nonatomic, retain) IBOutlet UILabel       * lab_othermsg;

@property(nonatomic, retain) IBOutlet UIView        * editView;

@property(nonatomic, retain) IBOutlet UIView        * infoView;
@property(nonatomic, retain) IBOutlet UIView        * infoMark;
@property(nonatomic, retain) IBOutlet UILabel       * lab_proComment;
@property(nonatomic, retain) IBOutlet UILabel       * lab_proError;
@property(nonatomic, retain) IBOutlet UILabel       * title_producName;
@property(nonatomic, retain) IBOutlet UILabel       * lab_Info_producName;
@property(nonatomic, retain) IBOutlet UILabel       * title_catagoryName;
@property(nonatomic, retain) IBOutlet UILabel       * lab_catagoryName;
@property(nonatomic, retain) IBOutlet UILabel       * title_parameter;
@property(nonatomic, retain) IBOutlet UILabel       * lab_parameter;

@property(nonatomic, retain) IBOutlet UIView        * pictureView;
@property(nonatomic, retain) IBOutlet UIView        * pictureMark;
@property(nonatomic, retain) IBOutlet UILabel       * lab_picture_error;

@property(nonatomic, retain) IBOutlet UIView        * propertyView;              //销售属性
@property(nonatomic, retain) IBOutlet UIView        * propertyMark;
@property(nonatomic, retain) IBOutlet UILabel       * lab_propertyComment;
@property(nonatomic, retain) IBOutlet UILabel       * title_unitPrice;
@property(nonatomic, retain) IBOutlet UILabel       * lab_unitPrice;             //单价
@property(nonatomic, retain) IBOutlet UILabel       * title_deliveryPrice;
@property(nonatomic, retain) IBOutlet UILabel       * lab_deliveryPrice;         //邮寄费用
@property(nonatomic, retain) IBOutlet UILabel       * title_onhandQty;
@property(nonatomic, retain) IBOutlet UILabel       * lab_onhandQty;             //库存数量
@property(nonatomic, retain) IBOutlet UILabel       * title_offlineType;
@property(nonatomic, retain) IBOutlet UILabel       * lab_offlineType;           //下架方式          1, 售完下架   2, 到期下架

@property(nonatomic, retain) IBOutlet UIView        * specialView;               //特色卖点
@property(nonatomic, retain) IBOutlet UIView        * specialMark;
@property(nonatomic, retain) IBOutlet UILabel       * lab_specialComment;
@property(nonatomic, retain) IBOutlet UILabel       * lab_specialError;
@property(nonatomic, retain) IBOutlet UILabel       * lab_specialContent;

@property(nonatomic, retain) IBOutlet UIView        * descView;                  //商品描述
@property(nonatomic, retain) IBOutlet UIView        * descMark;
@property(nonatomic, retain) IBOutlet UILabel       * lab_descComment;
@property(nonatomic, retain) IBOutlet UILabel       * lab_descError;
@property(nonatomic, retain) IBOutlet UILabel       * lab_descContent;

@property(nonatomic, retain) IBOutlet UIView        * promiseView;               //售后条款
@property(nonatomic, retain) IBOutlet UIView        * promiseMark;
@property(nonatomic, retain) IBOutlet UILabel       * lab_promiseContent;

@property(nonatomic, retain) UpdateModel            *updateModel;


@end

@implementation Commodity_Details

-(void)dealloc
{
    [_scrollView release];
    [_topView release];
    [_infoView release];
    [_infoMark release];
    
    [super dealloc];
}

-(void)viewDidUnload
{
    [super viewDidUnload];
    
    self.scrollView = nil;
    self.topView = nil;
    self.infoView = nil;
    self.infoMark = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    InitNav(@"商品详情");
    [self setupMoveBackButton];
    [self setupMoveFowardButtonWithTitle:@"预览"];
    
    [_scrollView addSubview:_topView];
    
    
    CGRect editFrame = _editView.frame;
    editFrame.origin.y = _topView.origin.y + _topView.size.height;
    _editView.frame = editFrame;
    [_scrollView addSubview:_editView];
    
    
    //添加InfoView
    CGRect infoFrame = _infoView.frame;
    
    infoFrame.origin.y = _editView.origin.y + _editView.size.height;
    
    _infoView.frame = infoFrame;
    
    [_scrollView addSubview:_infoView];
    
    //添加PictureView
    CGRect pictureFrame = _pictureView.frame;
    
    infoFrame.origin.y = _infoView.origin.y + _infoView.size.height;
    
    _pictureView.frame = pictureFrame;
    
    [_scrollView addSubview:_pictureView];
    
    //添加PropertyView
    CGRect propertyFrame = _propertyView.frame;
    
    propertyFrame.origin.y = _pictureView.origin.y + _pictureView.size.height;
    
    _propertyView.frame = propertyFrame;
    
    [_scrollView addSubview:_propertyView];
    
    //添加 SpecialView
    CGRect specialFrame = _specialView.frame;
    
    specialFrame.origin.y = _propertyView.origin.y + _propertyView.size.height;
    
    _specialView.frame = specialFrame;
    
    [_scrollView addSubview:_specialView];
    
    //添加DescView
    CGRect descFrame = _descView.frame;
    
    descFrame.origin.y = _specialView.origin.y + _specialView.size.height;
    
    _descView.frame = descFrame;
    
    [_scrollView addSubview:_descView];
    
    //添加PropertyView
    CGRect promiseFrame = _promiseView.frame;
    
    promiseFrame.origin.y = _descView.origin.y + _descView.size.height;
    
    _promiseView.frame = promiseFrame;
    
    [_scrollView addSubview:_promiseView];
    
}

//点击事件 预览
- (void)onMoveFoward:(UIButton *)sender
{
    PUSH_VIEWCONTROLLER(Preview_Commodity);
    model.productId = _productId;
    model.whereFrom = 0;
    model.navigationItem.hidesBackButton = YES;
}

- (void)viewWillAppear:(BOOL)animated
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
//
    DictionaryWrapper *wrapper = [Datas getDictionaryWrapper:@"Data"];
//
    
    NSArray *pictures = [wrapper getArray:@"Pictures"];
//
//    NSArray *ProductSpecs = [wrapper getArray:@"ProductSpecList"];
//    
    DictionaryWrapper *AuditMessage = [wrapper getDictionaryWrapper:@"AuditMessage"];
    
    
    _lab_Info_producName.text = [wrapper getString:@"ProductName"];
    _lab_catagoryName.text = [wrapper getString:@"CatagoryName"];
    
    int onhandQty = 0;                  //库存数量
    
    NSString *unitPrice = @"";          //价格
    
    NSString *productSpec =@"";         //规格型号
    
    NSArray *productSpecList = [wrapper getArray:@"ProductSpecList"];
    
    int i = 0;
    for (NSDictionary *data in productSpecList) {
        
        DictionaryWrapper *item = data.wrapper;
        
        onhandQty += [item getInt:@"OnhandQty"];
        
        //计算是否最后一个 用于结尾是否加上"/"字符
        
        i++;
        if(i != [productSpecList count])
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
    
    _lab_parameter.text = productSpec;
    _lab_unitPrice.text = unitPrice;
    
    if([wrapper getFloat:@"DeliveryPrice"] == 0)
    _lab_deliveryPrice.text = @"0 易货码";
    else
    _lab_deliveryPrice.text = [NSString stringWithFormat:@"%.2f 易货码",[wrapper getFloat:@"DeliveryPrice"]];
    
    _lab_onhandQty.text = [NSString stringWithFormat:@"%d",onhandQty];
    
    //下架方式
    if([wrapper getInt:@"OfflineType"] == 1)
    _lab_offlineType.text = @"售完下架";
    else if([wrapper getInt:@"OfflineType"] == 2)
    _lab_offlineType.text = @"指定日期下架";
    else
    _lab_offlineType.text = @"";
    
    // TopView
    //-----------------------------------------------------------------------------------------------------------------------------------------------
    CGRect frame = _lab_othermsg.frame;
    _lab_othermsg.text = [AuditMessage getString:@"OtherErrmsg"];
//    _lab_othermsg.text = @"有你嘛个情节，付金额挖了访客里瓦加咖啡挖掘浪费；ewjalfjelwahgehafewfdfge'arfewasfdsfgasfewa,fewakfejwafjewafewalkfejwlajfewfhasdofhdwaferwahfoiewjafjewafewaf覅哦啊好废物哈佛额外";
    frame.size.height = [AppUtils textHeightByChar:_lab_othermsg.text width:_lab_othermsg.frame.size.width fontSize:_lab_othermsg.font];
    _lab_othermsg.frame = frame;
    
    CGRect topView_Frame = _topView.frame;
    topView_Frame.size.height = _lab_othermsg.frame.origin.y + _lab_othermsg.frame.size.height + 15 + 10;
 
    
    if(_whereFrom == 2/* || _whereFrom == 5*/)
    {
        _topView.frame = topView_Frame;
        
        [_topView addSubview:[AppUtils LineView:_topView.frame.size.height - 10.0f]];
        [_topView addSubview:[AppUtils LineView:_topView.frame.size.height]];
        
        if(_lab_othermsg.text == nil || [_lab_othermsg.text isKindOfClass:[NSNull class]] || [_lab_othermsg.text isEqualToString:@""])
        {
            topView_Frame.size.height = 0;
            _topView.frame = topView_Frame;
            _topView.hidden = YES;
        }
    }
    else
    {
        topView_Frame.size.height = 0;
        _topView.frame = topView_Frame;
        _topView.hidden = YES;
    }
    
    CGRect editFrame = _editView.frame;
    
    if(_whereFrom == 2 || _whereFrom == 4 || _whereFrom == 5)
    {
        editFrame = _editView.frame;
        _editView.frame = CGRectMake(0, _topView.frame.origin.y + _topView.frame.size.height, _editView.frame.size.width, editFrame.size.height);
    }
    else
    {
        editFrame = _editView.frame;
        
        _editView.frame = CGRectMake(0, _topView.frame.origin.y + _topView.frame.size.height, _editView.frame.size.width, 0);
//        _editView.hidden = YES;
    }
//    frame = _editView.frame;
//    frame.origin.y = frame.origin.y + frame.size.height;
//    _editView.frame =

    // InfoView
    //-----------------------------------------------------------------------------------------------------------------------------------------------
    [_infoMark addSubview:[AppUtils LineView:0.5f]];
    frame = _infoMark.frame;
    
//    _lab_proError.text = @"如需编辑本项，请用电脑访问\nhttp://www.xxxxxxx.com;如需编辑本项，请用电脑访问\nhttp://www.xxxxxxx.com";
//    _lab_proError.text = [AuditMessage getString:@"BasicErrmsg"];
//    if(_lab_proError.text != nil && ![_lab_proError.text isKindOfClass:[NSNull class]] && _lab_proError.text.length > 0)
//        _lab_proComment.text = @"如需编辑本项，请用电脑访问\nhttp://gold.inkey.com";
//    else
    _lab_proComment.text = [AuditMessage getString:@"BasicErrmsg"];
    _lab_proError.text = @"";
//    _lab_proComment.text = @"";
    
    //审核失败 || 已下架
    if(_whereFrom == 2 || _whereFrom == 5)
    {
        frame.origin.y = 25 + 6;
        
        BOOL canAdd = NO;
        
        if(_lab_proComment.text.length >0)
        {
            _lab_proComment.hidden = NO;
            
            frame.origin.x = 15;
            
            frame.origin.y += 15;
            
            int b0_height = [AppUtils textHeightByChar:_lab_proComment.text width:_lab_proComment.frame.size.width fontSize:_lab_proComment.font];
            
            if(b0_height > 15)
                b0_height += 5;
            
            frame.size.height = b0_height;
            
            _lab_proComment.frame = frame;
            
            frame.origin.y += frame.size.height + 10;
            
            canAdd = YES;
        }
        
        if(_lab_proError.text.length >0)
        {
            _lab_proError.hidden = NO;
            
            frame.origin.x = 15;
            int b1_height = [AppUtils textHeightByChar:_lab_proError.text width:_lab_proError.frame.size.width fontSize:_lab_proError.font];
            
            if(b1_height > 15)
                b1_height += 5;
            
            frame.size.height = b1_height;
            frame.size.width = _lab_proError.frame.size.width;
            _lab_proError.frame = frame;
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
        _lab_proComment.hidden = YES;
        _lab_proError.hidden = YES;
        
        frame.origin.y += frame.size.height;
    }
    
     _infoMark.frame = CGRectMake(0, _infoMark.frame.origin.y, _infoMark.frame.size.width, frame.origin.y-10);
    [_infoMark addSubview:[AppUtils LineView:_infoMark.frame.size.height]];
    
    //商品名称
    
//    frame.origin.y += 17;
    frame.origin.y += 10;
    frame.origin.x = _title_producName.frame.origin.x;
    frame.size.width = _title_producName.frame.size.width;
    frame.size.height = _title_producName.frame.size.height;
    _title_producName.frame = frame;
    
    
//    _lab_Info_producName.text = [wrapper getString:@"ProductName"];
    frame.origin.x = _lab_Info_producName.frame.origin.x;
    frame.size.width = _lab_Info_producName.frame.size.width;
    int info_height = [AppUtils textHeightByChar:_lab_Info_producName.text width:_lab_Info_producName.frame.size.width fontSize:_lab_Info_producName.font];
    
    if(info_height > 20)
        frame.size.height = info_height+3;
    _lab_Info_producName.frame = frame;
    
//    _lab_catagoryName.text = [wrapper getString:@"CatagoryName"];
    
    
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
    
//    _lab_parameter.text = productSpec;
    _lab_parameter.text = productSpec;
    
    frame.origin.x = _lab_parameter.frame.origin.x;
    frame.size.width = _lab_parameter.frame.size.width;
    frame.size.height = [AppUtils textHeightByChar:_lab_parameter.text width:_lab_parameter.frame.size.width fontSize:_lab_parameter.font]+3;
    _lab_parameter.frame = frame;
    
    frame.origin.y += frame.size.height + 19;
    
    
    _infoView.frame = CGRectMake(0, _editView.frame.origin.y + _editView.frame.size.height, _infoView.frame.size.width, frame.origin.y);
//    [_infoView addSubview:[AppUtils LineView:0.5f]];
    [_infoView addSubview:[AppUtils LineView:_infoView.frame.size.height]];
    
    
    // PictureView
    //-----------------------------------------------------------------------------------------------------------------------------------------------
    [_pictureMark addSubview:[AppUtils LineView:0.5f]];
    frame = _pictureMark.frame;
//    _lab_picture_error.text = @"编辑你大爷，有你吗个情节。fhsahfelkwajflewalfewlaflewaklfwealfelflwe发货的萨芬撒来看积分挖坟了瓦拉分了哇发了瓦";
    _lab_picture_error.text = [AuditMessage getString:@"PicErrmsg"];
    
    //审核失败 || 已下架
    if(_whereFrom == 2 || _whereFrom == 5)
    {
        frame.origin.y = 25 + 6;
        
        BOOL canAdd = NO;
        
        if(_lab_picture_error.text.length >0)
        {
            _lab_picture_error.hidden = NO;
            
            frame.origin.x = 15;
            
            frame.origin.y += 15;
            
            int b0_height = [AppUtils textHeightByChar:_lab_picture_error.text width:_lab_picture_error.frame.size.width fontSize:_lab_picture_error.font];
            
            if(b0_height > 15)
                b0_height += 5;
            
            frame.size.height = b0_height;
            
            _lab_picture_error.frame = frame;
            
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
        _lab_picture_error.hidden = YES;
        
        frame.origin.y += frame.size.height;
    }
    
    _pictureMark.frame = CGRectMake(0, _pictureMark.frame.origin.y, _pictureMark.frame.size.width, frame.origin.y-10);
    [_pictureMark addSubview:[AppUtils LineView:_pictureMark.frame.size.height]];
    
    
    CGRect imageFrame = CGRectMake(image_start_X, _pictureMark.frame.origin.y + _pictureMark.frame.size.height + image_Top_Space, image_Width, image_Height);
    int y = 0;
    
    for (NSDictionary *data in pictures) {
        DictionaryWrapper *item = data.wrapper;
        
        NetImageView *iv = [[NetImageView alloc] initWithFrame:imageFrame];
        iv.layer.borderWidth = 0.5f;
        iv.layer.borderColor = [[UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:0.5f] CGColor];
        
        [iv requestPic:[item getString:@"PictureUrl"] size:CGSizeMake(imageFrame.size.width, imageFrame.size.height) placeHolder:YES];
        
        [_pictureView addSubview:iv];
        
        
        
        if(y == 3)
        {
            imageFrame.origin.x = image_start_X;
            imageFrame.origin.y = imageFrame.origin.y + imageFrame.size.height + image_Space;
        }
        else
        {
            imageFrame.origin.x = imageFrame.origin.x + imageFrame.size.width + image_Space;
        }
        y++;
    }
    
    _pictureView.frame = CGRectMake(0, _infoView.frame.origin.y + _infoView.frame.size.height, _pictureView.frame.size.width, imageFrame.origin.y + imageFrame.size.height + image_Space);
    //    [_infoView addSubview:[AppUtils LineView:0.5f]];
//    [_pictureView addSubview:[AppUtils LineView:_pictureView.frame.size.height]];
    
    
    
    // PropertyView
    //-----------------------------------------------------------------------------------------------------------------------------------------------
//    _lab_deliveryPrice.text = @"421.00金币";
    
    
    frame = _propertyMark.frame;
    
    [_propertyMark addSubview:[AppUtils LineView:0.5f]];
    
    [_propertyView addSubview:[AppUtils LineView:0.5f]];
    
    _lab_propertyComment.text = [AuditMessage getString:@"BasicErrmsg"];
    
    
    
    
    if(_whereFrom == 2 || _whereFrom == 5)
    {
        frame.origin.y = 25 + 6;
        
        BOOL canAdd = NO;
        
        if(_lab_propertyComment.text.length >0)
        {
            _lab_propertyComment.hidden = NO;
            
            frame.origin.x = 15;
            
            frame.origin.y += 15;
            
            int b0_height = [AppUtils textHeightByChar:_lab_propertyComment.text width:_lab_propertyComment.frame.size.width fontSize:_lab_propertyComment.font];
            
            if(b0_height > 15)
                b0_height += 5;
            
            frame.size.height = b0_height;
            
            _lab_propertyComment.frame = frame;
            
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
        _lab_propertyComment.hidden = YES;
        
        frame.origin.y += frame.size.height;
    }
    
    _propertyMark.frame = CGRectMake(0, _propertyMark.frame.origin.y, _propertyMark.frame.size.width, frame.origin.y-10);
    [_propertyMark addSubview:[AppUtils LineView:_propertyMark.frame.size.height]];
    
    frame.origin.y += 17;
//    frame.origin.y = frame.origin.y + frame.size.height + 17;
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
    
//    _topView.frame = CGRectMake(_topView.frame.origin.x, _topView.frame.origin.y, _topView.frame.size.width, frame.origin.y);
    
//    _lab_onhandQty.text = @"500000000";
    
    //下架方式
//    if([wrapper getInt:@"OfflineType"] == 1)
//        _lab_offlineType.text = @"售完下架";
//    else if([wrapper getInt:@"OfflineType"] == 2)
//        _lab_offlineType.text = @"指定日期下架";
//    else
//        _lab_offlineType.text = @"";
//    _lab_offlineType.text = @"售完下架";
    
    
    [_propertyView addSubview:[AppUtils LineView:.5f]];
    _propertyView.frame = CGRectMake(0, _pictureView.frame.origin.y + _pictureView.frame.size.height, _propertyView.frame.size.width, frame.origin.y);
    
    
    
    
    //Speicalview
    //-----------------------------------------------------------------------------------------------------------------------------------------------
    [_specialView addSubview:[AppUtils LineView:0.5f]];
    frame = _specialMark.frame;
    
    [_specialMark addSubview:[AppUtils LineView:0.5f]];
    
//    _lab_specialComment.text = @"如需编辑本项，请用电脑访问\nhttp://gold.inkey.com";
//    _lab_specialError.text = @"如需编辑本项，请用电脑访问\nhttp://www.xxxxxxx.com;如需编辑本项，请用电脑访问\nhttp://www.xxxxxxx.com";
    _lab_specialComment.text = [AuditMessage getString:@"FeatureErrmsg"];
    
//    if(_lab_specialError.text != nil && ![_lab_specialError.text isKindOfClass:[NSNull class]] && _lab_specialError.text.length > 0)
//    _lab_specialComment.text = @"如需编辑本项，请用电脑访问\nhttp://gold.inkey.com";
//    else
    _lab_specialError.text = @"";
    
    //审核失败 || 已下架
    if(_whereFrom == 2 || _whereFrom == 5)
    {
        frame.origin.y = 25 + 6;
        
        BOOL canAdd = NO;
        
        if(_lab_specialComment.text.length >0)
        {
            _lab_specialComment.hidden = NO;
            
            frame.origin.x = 15;
            
            frame.origin.y += 15;
            
            int b0_height = [AppUtils textHeightByChar:_lab_specialComment.text width:_lab_specialComment.frame.size.width fontSize:_lab_specialComment.font];
            
            if(b0_height > 15)
            b0_height += 5;
            
            frame.size.height = b0_height;
            
            _lab_specialComment.frame = frame;
            
            frame.origin.y += frame.size.height + 10;
            
            canAdd = YES;
        }
        
        if(_lab_specialError.text.length >0)
        {
            _lab_specialError.hidden = NO;
            
            frame.origin.x = 15;
            int b1_height = [AppUtils textHeightByChar:_lab_specialError.text width:_lab_specialError.frame.size.width fontSize:_lab_specialError.font];
            
            if(b1_height > 15)
            b1_height += 5;
            
            frame.size.height = b1_height;
            frame.size.width = _lab_specialError.frame.size.width;
            _lab_specialError.frame = frame;
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
        _lab_specialComment.hidden = YES;
        _lab_specialError.hidden = YES;
        
        frame.origin.y += frame.size.height;
    }
    
    _specialMark.frame = CGRectMake(0, _specialMark.frame.origin.y, _specialMark.frame.size.width, frame.origin.y-10);
    [_specialMark addSubview:[AppUtils LineView:_specialMark.frame.size.height]];
    
//    _lab_specialContent.text = @"特色卖点aA，特色卖点aA，特色卖点aA，特色卖点aA，特色卖点aA，特色卖点aA，特色卖点aA，特色卖点aA，特色卖点aA，";
    _lab_specialContent.text = [wrapper getString:@"ProductFeature"];
    
    //特色卖点
    frame.origin.y += 17;
    frame.origin.x = _lab_specialContent.frame.origin.x;
    frame.size.width = _lab_specialContent.frame.size.width;
    frame.size.height = [AppUtils textHeightByChar:_lab_specialContent.text width:_lab_specialContent.frame.size.width fontSize:_lab_specialContent.font]+3;
    _lab_specialContent.frame = frame;
    frame.origin.y += frame.size.height + 19;
    
    _specialView.frame = CGRectMake(0, _propertyView.frame.origin.y + _propertyView.frame.size.height, _specialView.frame.size.width, frame.origin.y);
    [_specialView addSubview:[AppUtils LineView:_specialView.frame.size.height]];
    
    
    
    //DescView
    //-----------------------------------------------------------------------------------------------------------------------------------------------
//    [_descView addSubview:[AppUtils LineView:0.5f]];
    frame = _descMark.frame;
    
    [_descMark addSubview:[AppUtils LineView:0.5f]];
    
//    _lab_descComment.text = @"如需编辑本项，请用电脑访问\nhttp://gold.inkey.com";
//    _lab_descError.text = @"如需编辑本项，请用电脑访问\nhttp://www.xxxxxxx.com;如需编辑本项，请用电脑访问\nhttp://www.xxxxxxx.com";
    _lab_descComment.text = [AuditMessage getString:@"IntroductionErrmsg"];
    
//    if(_lab_descError.text != nil && ![_lab_descError.text isKindOfClass:[NSNull class]] && _lab_descError.text.length > 0)
//    _lab_descComment.text = @"如需编辑本项，请用电脑访问\nhttp://gold.inkey.com";
//    else
    _lab_descError.text = @"";
    
    //审核失败 || 已下架
    if(_whereFrom == 2 || _whereFrom == 5)
    {
        frame.origin.y = 25 + 6;
        
        BOOL canAdd = NO;
        
        if(_lab_descComment.text.length >0)
        {
            _lab_descComment.hidden = NO;
            
            frame.origin.x = 15;
            
            frame.origin.y += 15;
            
            int b0_height = [AppUtils textHeightByChar:_lab_descComment.text width:_lab_descComment.frame.size.width fontSize:_lab_descComment.font];
            
            if(b0_height > 15)
            b0_height += 5;
            
            frame.size.height = b0_height;
            
            _lab_descComment.frame = frame;
            
            frame.origin.y += frame.size.height + 10;
            
            canAdd = YES;
        }
        
        if(_lab_descError.text.length >0)
        {
            _lab_descError.hidden = NO;
            
            frame.origin.x = 15;
            int b1_height = [AppUtils textHeightByChar:_lab_descError.text width:_lab_descError.frame.size.width fontSize:_lab_descError.font];
            
            if(b1_height > 15)
            b1_height += 5;
            
            frame.size.height = b1_height;
            frame.size.width = _lab_descError.frame.size.width;
            _lab_descError.frame = frame;
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
        _lab_descComment.hidden = YES;
        _lab_descError.hidden = YES;
        
        frame.origin.y += frame.size.height;
    }
    
    _descMark.frame = CGRectMake(0, _descMark.frame.origin.y, _descMark.frame.size.width, frame.origin.y-10);
    [_descMark addSubview:[AppUtils LineView:_descMark.frame.size.height]];
    
//    _lab_descContent.text = @"商品描述，商品描述，商品描述，商品描述，商品描述，商品描述，商品描述，商品描述，商品描述，商品描述，商品描述，商品描述，商品描述，商品描述，商品描述，商品描述，商品描述，商品描述，商品描述，商品描述，商品描述，商品描述，商品描述，商品描述，商品描述，商品描述，商品描述，商品描述，商品描述，商品描述，商品描述，商品描述，商品描述，商品描述，商品描述，商品描述，";
    _lab_descContent.text = [wrapper getString:@"ProductDesciption"];
    
    //商品描述
    frame.origin.y += 17;
    frame.origin.x = _lab_descContent.frame.origin.x;
    frame.size.width = _lab_descContent.frame.size.width;
    frame.size.height = [AppUtils textHeightByChar:_lab_descContent.text width:_lab_descContent.frame.size.width fontSize:_lab_descContent.font]+3;
    _lab_descContent.frame = frame;
    frame.origin.y += frame.size.height + 19;
    
    _descView.frame = CGRectMake(0, _specialView.frame.origin.y + _specialView.frame.size.height, _descView.frame.size.width, frame.origin.y);
    [_descView addSubview:[AppUtils LineView:_descView.frame.size.height]];
    
    
    //PromiseView
    //-----------------------------------------------------------------------------------------------------------------------------------------------
//    [_promiseView addSubview:[AppUtils LineView:0.5f]];
    frame = _promiseMark.frame;
    frame.origin.y += frame.size.height;
    [_promiseMark addSubview:[AppUtils LineView:0.5f]];
    
    [_promiseMark addSubview:[AppUtils LineView:_promiseMark.frame.size.height]];
    
//    _lab_promiseContent.text = @"售后条款，售后条款，售后条款，售后条款，售后条款，售后条款，售后条款，售后条款，售后条款，售后条款，";
    _lab_promiseContent.text = [wrapper getString:@"EnterprisePromise"];
    
    //售后条款
    frame.origin.y += 17;
    frame.origin.x = _lab_promiseContent.frame.origin.x;
    frame.size.width = _lab_promiseContent.frame.size.width;
    frame.size.height = [AppUtils textHeightByChar:_lab_promiseContent.text width:_lab_promiseContent.frame.size.width fontSize:_lab_promiseContent.font]+3;
    _lab_promiseContent.frame = frame;
    frame.origin.y += frame.size.height + 19 + 10;
    
    _promiseView.frame = CGRectMake(0, _descView.frame.origin.y + _descView.frame.size.height, _promiseView.frame.size.width, frame.origin.y);
    [_promiseView addSubview:[AppUtils LineView:_promiseView.frame.size.height - 10]];
//    [_promiseView addSubview:[AppUtils LineView:_promiseView.frame.size.height]];
    
    
    
    
    
    _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width, _topView.frame.size.height + _editView.frame.size.height + _infoView.frame.size.height + _pictureView.frame.size.height + _propertyView.frame.size.height + _specialView.frame.size.height + _descView.frame.size.height + _promiseView.frame.size.height);
    
    
    
    _updateModel = [[UpdateModel alloc] init];
    _updateModel.standardList = productSpecList;
    _updateModel.productId = [wrapper getInt:@"ProductId"];
    _updateModel.productName = [wrapper getString:@"ProductName"];
    _updateModel.categoryName = [wrapper getString:@"CatagoryName"];
    _updateModel.deliveryPrice = [[UICommon getStringToTwoDigitsAfterDecimalPlacesPoint:[wrapper getString:@"DeliveryPrice"] withAppendStr:@""] intValue];
    _updateModel.offlineType = [wrapper getInt:@"OfflineType"];
    _updateModel.offlineDate = [wrapper getString:@"OfflineDate"];
}

//修改事件
-(IBAction)action_Update:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    
    //修改商品信息
    if(btn.tag == 0)
    {
        PUSH_VIEWCONTROLLER(Commodity_Info_Update);
        model.updateModel = _updateModel;
    }
    
    //修改销售属性
    else if(btn.tag == 1)
    {
        PUSH_VIEWCONTROLLER(Commodity_Update);
        model.updateModel = _updateModel;
        model.delegate = self;
    }
}


// Update's CallBack
// is Can show resendView
-(void)resendPutaway:(BOOL)isEqual allOnhandQty:(int)allOnhandQty
{
    //审核失败 || 已下架
    if(_whereFrom == 2 || _whereFrom == 5)
    {
//        if(allOnhandQty == 0)
//        _canEqual = NO;
//        else
//        _canEqual = isEqual;
    }
}


@end
