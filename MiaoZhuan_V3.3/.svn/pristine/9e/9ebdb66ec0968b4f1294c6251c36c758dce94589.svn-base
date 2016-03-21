//
//  ShippingOrderDetailViewController.m
//  miaozhuan
//
//  Created by apple on 14/12/9.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "ShippingOrderDetailViewController.h"
#import "NetImageView.h"
#import "RRAttributedString.h"
#import "UIView+expanded.h"
#import "ChangeShippingAddressViewController.h"
#import "ShippingViewController.h"
#import "ItemViewController.h"
#import "RRLineView.h"
#import "MyMarketMyOrderWebViewController.h"
#import "PreviewViewController.h"

@interface ShippingOrderDetailViewController ()<UIScrollViewDelegate,ShippingDelegate,UIAlertViewDelegate>
{
    DictionaryWrapper * result;
    NSString * CustomerName;
    NSString * CustomerTel;
    NSArray * arrImage;
    CGFloat Height;
}
@property (retain, nonatomic) IBOutlet UIScrollView *mainScroller;
@property (retain, nonatomic) IBOutlet UIView *orderView;
@property (retain, nonatomic) IBOutlet UIView *takeGoodsView;
@property (retain, nonatomic) IBOutlet UIView *goodsView;

//订单
@property (retain, nonatomic) IBOutlet UILabel *orderNumber;
@property (retain, nonatomic) IBOutlet UILabel *orderTimeLable;
@property (retain, nonatomic) IBOutlet UILabel *orderUserNameLable;
@property (retain, nonatomic) IBOutlet UILabel *orderStateLable;
@property (retain, nonatomic) IBOutlet UILabel *orderMoneyLable;
@property (retain, nonatomic) IBOutlet UIButton *orderBtn;
@property (retain, nonatomic) IBOutlet UILabel *orderBtnLable;
@property (retain, nonatomic) IBOutlet UIButton *orderItemBtn;
@property (retain, nonatomic) IBOutlet UILabel *orderItemLable;
@property (retain, nonatomic) IBOutlet RRLineView *orderLine;
@property (retain, nonatomic) IBOutlet UIButton *orderArgeeTuiHuoBtn;
@property (retain, nonatomic) IBOutlet UILabel *orderArgeeTuiHuoLable;

//收货信息
@property (retain, nonatomic) IBOutlet UILabel *takeGoodsName;
@property (retain, nonatomic) IBOutlet UILabel *takeGoodsPhoneLable;
@property (retain, nonatomic) IBOutlet UILabel *takeGoodsAddressLable;
@property (retain, nonatomic) IBOutlet UIButton *taksGoodsBtn;
@property (retain, nonatomic) IBOutlet UILabel *takeGoodsBtnLable;
@property (retain, nonatomic) IBOutlet UIButton *takeGoodsCopyBtn;
@property (retain, nonatomic) IBOutlet RRLineView *takeGoodsLineOne;

//商品信息
@property (retain, nonatomic) IBOutlet UILabel *goodsNameLable;
@property (retain, nonatomic) IBOutlet NetImageView *goodsImage;
@property (retain, nonatomic) IBOutlet UILabel *goodsNumAndPrice;
@property (retain, nonatomic) IBOutlet UILabel *goodsPrice;
@property (retain, nonatomic) IBOutlet RRLineView *lineView;
@property (retain, nonatomic) IBOutlet RRLineView *goodsLineOne;

- (IBAction)touchUpInside:(id)sender;

//退款原因
@property (retain, nonatomic) IBOutlet UIView *tuikuanVIew;
@property (retain, nonatomic) IBOutlet UILabel *tuikuanYuanYinLable;
@property (retain, nonatomic) IBOutlet UILabel *tuikuanJinElable;
@property (retain, nonatomic) IBOutlet UILabel *bcsmContentLable;
@property (retain, nonatomic) IBOutlet UILabel *bcsmLable;
@property (retain, nonatomic) IBOutlet UILabel *tupianLable;
@property (retain, nonatomic) IBOutlet UILabel *jineLable;

@property (retain, nonatomic) NSArray * arrImage;

@end

@implementation ShippingOrderDetailViewController

-(void)viewWillAppear:(BOOL)animated
{
    [_orderBtn roundCorner];
    
    _orderBtn.layer.borderColor = [RGBCOLOR(240, 5, 0) CGColor];
    
    [_taksGoodsBtn roundCorner];
    
    _taksGoodsBtn.layer.borderColor = [RGBCOLOR(240, 5, 0) CGColor];

    [self setLoad];
}

-(void) setLoad
{
    if ([_OrderType isEqualToString:@"1"])
    {
        if ([_dealState isEqualToString:@"1"])
        {
            //等待用户付款 dealState = 1;
            _orderBtnLable.text = @"关闭交易";
            
            _taksGoodsBtn.hidden = YES;
            
            _takeGoodsCopyBtn.frame = CGRectMake(255, 5, 50, 30);
            
        }
        else if ([_dealState isEqualToString:@"2"])
        {
            //等待发货  dealState = 2;
            _orderBtnLable.text = @"发货";
            
            _takeGoodsBtnLable.text = @"更改收货地址";
            
            _orderBtn.backgroundColor = [UIColor whiteColor];
            
            _taksGoodsBtn.backgroundColor = [UIColor whiteColor];
            
            _orderBtnLable.frame = CGRectMake(260, 7, 45, 25);
            
            _orderBtn.frame = CGRectMake(260, 7, 45, 25);
            
            _taksGoodsBtn.frame =CGRectMake(220, 7, 85, 25);
            
            _takeGoodsBtnLable.frame = CGRectMake(220, 7, 85, 25);
            
            _takeGoodsCopyBtn.frame = CGRectMake(169, 5, 50, 30);
            
        }
        else if ([_dealState isEqualToString:@"3"])
        {
            //交易成功  dealState = 3;
            
            _orderBtn.hidden = YES;
            
            _orderBtnLable.text = @"";
            
            _takeGoodsBtnLable.text = @"查看物流";
            
            _taksGoodsBtn.backgroundColor = [UIColor whiteColor];
            
            _taksGoodsBtn.frame = CGRectMake(240, 7, 65, 25);
            
            _takeGoodsBtnLable.frame = CGRectMake(240, 7, 65, 25);
            
            _takeGoodsCopyBtn.frame = CGRectMake(189, 5, 50, 30);
        }
        else if ([_dealState isEqualToString:@"4"])
        {
            //交易关闭  dealState = 4;
            _orderBtn.hidden = YES;
            
            _orderBtnLable.text = @"";
            
            _takeGoodsBtnLable.text = @"查看物流";
            
            _taksGoodsBtn.backgroundColor = [UIColor whiteColor];
            
            _taksGoodsBtn.frame = CGRectMake(240, 7, 65, 25);
            
            _takeGoodsBtnLable.frame = CGRectMake(240, 7, 65, 25);
            
            _takeGoodsCopyBtn.frame = CGRectMake(189, 5, 50, 30);
        }
        
        ADAPI_adv3_ExchangeManagement_GetSilverOrderDetail([self genDelegatorID:@selector(HandleNotification:)], _EnterOrderNumber);
    }
    else
    {
        if ([_dealState isEqualToString:@"1"])
        {
            //等待用户付款 dealState = 1;
            _orderBtnLable.text = @"关闭交易";
            
            _orderBtnLable.backgroundColor = [UIColor whiteColor];
            
            _taksGoodsBtn.hidden = YES;
            
            _orderArgeeTuiHuoBtn.hidden = YES;
            
            _takeGoodsCopyBtn.frame = CGRectMake(255, 5, 50, 30);
            
        }
        else if ([_dealState isEqualToString:@"2"])
        {
            //等待发货  dealState = 2;
            _orderBtnLable.text = @"发货";
            
            _takeGoodsBtnLable.text = @"更改收货地址";
            
            _orderBtn.backgroundColor = [UIColor whiteColor];
            
            _taksGoodsBtn.backgroundColor = [UIColor whiteColor];
            
            _orderBtnLable.frame = CGRectMake(260, 7, 45, 25);
            
            _orderBtn.frame = CGRectMake(260, 7, 45, 25);
            
            _taksGoodsBtn.frame =CGRectMake(220, 7, 85, 25);
            
            _takeGoodsBtnLable.frame = CGRectMake(220, 7, 85, 25);
            
            _takeGoodsCopyBtn.frame = CGRectMake(169, 5, 50, 30);
            
        }
        else if ([_dealState isEqualToString:@"3"])
        {
            //已发货  dealState = 5;
            _orderBtn.hidden = YES;
            
            _orderArgeeTuiHuoBtn.hidden = YES;
            
            _orderBtnLable.text = @"";
            
            _takeGoodsBtnLable.text = @"查看物流";
            
            _taksGoodsBtn.backgroundColor = [UIColor whiteColor];
            
            _taksGoodsBtn.frame = CGRectMake(240, 7, 65, 25);
            
            _takeGoodsBtnLable.frame = CGRectMake(240, 7, 65, 25);
            
            _takeGoodsCopyBtn.frame = CGRectMake(189, 5, 50, 30);
        }
        else if ([_dealState isEqualToString:@"5"])
        {
            //交易成功  dealState = 5;
            
            _orderBtn.hidden = YES;
            
            _orderArgeeTuiHuoBtn.hidden = YES;
            
            _orderBtnLable.text = @"";
            
            _takeGoodsBtnLable.text = @"查看物流";
            
            _taksGoodsBtn.backgroundColor = [UIColor whiteColor];
            
            _taksGoodsBtn.frame = CGRectMake(240, 7, 65, 25);
            
            _takeGoodsBtnLable.frame = CGRectMake(240, 7, 65, 25);
            
            _takeGoodsCopyBtn.frame = CGRectMake(189, 5, 50, 30);
        }
        else if ([_dealState isEqualToString:@"6"])
        {
            //交易关闭  dealState = 6;
            _orderBtn.hidden = YES;
            
            _orderArgeeTuiHuoBtn.hidden = YES;
            
            _orderBtnLable.text = @"";
            
            _takeGoodsBtnLable.text = @"查看物流";
            
            _taksGoodsBtn.backgroundColor = [UIColor whiteColor];
            
            _taksGoodsBtn.frame = CGRectMake(240, 7, 65, 25);
            
            _takeGoodsBtnLable.frame = CGRectMake(240, 7, 65, 25);
            
            _takeGoodsCopyBtn.frame = CGRectMake(189, 5, 50, 30);
        }
        
        ADAPI_adv3_GoldOrder_GetOrderDetails([self genDelegatorID:@selector(HandleNotification:)], _EnterOrderNumber);
    }
}

- (void)HandleNotification:(DelegatorArguments *)arguments
{
    [arguments logError];
    
    DictionaryWrapper *wrapper = arguments.ret;
    
    if ([arguments isEqualToOperation:ADOP_adv3_ExchangeManagement_GetSilverOrderDetail])
    {
        if (wrapper.operationSucceed)
        {

            result = wrapper.data;
            [result retain];
            
            [self setDic:result];
            [self setViewAdd];
        }
        else if (wrapper.operationPromptCode)
        {
            [HUDUtil showErrorWithStatus:wrapper.operationMessage];
        }
    }
    else if ([arguments isEqualToOperation:ADOP_adv3_GoldOrder_GetOrderDetails])
    {
        if (wrapper.operationSucceed)
        {
            result = wrapper.data;
            [result retain];
            
            [self setDic:result];
            
            [self setViewAdd];
        }
        else if (wrapper.operationPromptCode)
        {
            [HUDUtil showErrorWithStatus:wrapper.operationMessage];
        }
    }
    else if ([arguments isEqualToOperation:ADOP_adv3_GoldOrder_EnterpriseOrderOperate])
    {
        [arguments logError];
        
        DictionaryWrapper *wrapper = arguments.ret;
        
        if (wrapper.operationSucceed)
        {
            [HUDUtil showSuccessWithStatus:wrapper.operationMessage];
            
            [self.navigationController popViewControllerAnimated:YES];
        }
        else if (wrapper.operationPromptCode)
        {
            [HUDUtil showErrorWithStatus:wrapper.operationMessage];
        }
    }
}

-(void) setDic : (DictionaryWrapper *) dic
{
    if ([_OrderType isEqualToString:@"1"])
    {
        _orderNumber.text = [NSString stringWithFormat:@"订单编号：%@",[dic getString:@"OrderNumber"]];
        
        NSString * endTime = [dic getString:@"PayDate"];
        
        endTime = [UICommon format19Time:endTime];
        
        _orderTimeLable.text = [NSString stringWithFormat:@"下单时间：%@",endTime];
        
        _orderUserNameLable.text = [NSString stringWithFormat:@"用户账户：%@",[dic getString:@"CustomerName"]];
        
        
        int orderstate = [dic getInt:@"ExchangeStatus"];
        
        NSString * state;
        
        if (orderstate == 0)
        {
            state = @"待发货";
        }else if (orderstate == 1)
        {
            state = @"已发货";
        }
        else if (orderstate == 2)
        {
            state = @"交易成功";
        }else if (orderstate == 3)
        {
            state = @"交易关闭";
        }
        
        _orderStateLable.text = [NSString stringWithFormat:@"订单状态：%@",state];
        
        NSAttributedString * attributedStringorderNum = [RRAttributedString setText:_orderNumber.text color:RGBCOLOR(153, 153, 153) range:NSMakeRange(0, 5)];
        
        _orderNumber.attributedText = attributedStringorderNum;
        
        NSAttributedString * attributedStringorderTime = [RRAttributedString setText:_orderTimeLable.text color:RGBCOLOR(153, 153, 153) range:NSMakeRange(0, 5)];
        
        _orderTimeLable.attributedText = attributedStringorderTime;
        
        NSAttributedString * attributedStringorderUserName = [RRAttributedString setText:_orderUserNameLable.text color:RGBCOLOR(153, 153, 153) range:NSMakeRange(0, 5)];
        
        _orderUserNameLable.attributedText = attributedStringorderUserName;
        
        NSAttributedString * attributedStringorderState = [RRAttributedString setText:_orderStateLable.text color:RGBCOLOR(153, 153, 153) range:NSMakeRange(0, 5)];
        
        _orderStateLable.attributedText = attributedStringorderState;
        
        //收货信息
        DictionaryWrapper * takeGood = [dic getDictionaryWrapper:@"DeliveryAddress"];
        
        _takeGoodsName.text = [NSString stringWithFormat:@"收货人：%@",[takeGood getString:@"ContactName"]];
        
        CustomerName = [takeGood getString:@"ContactName"];
        
        CustomerTel = [takeGood getString:@"ContactPhone"];
        
        _takeGoodsPhoneLable.text = [NSString stringWithFormat:@"电话：%@",[takeGood getString:@"ContactPhone"]];
        
#define CTJ_ISNIL_DIC(_key) [takeGood getString:_key]? [takeGood getString:_key]:@""
        
        NSString * Province = CTJ_ISNIL_DIC(@"Province");
        NSString * City = CTJ_ISNIL_DIC(@"City");
        NSString * District = CTJ_ISNIL_DIC(@"District");
        NSString * Address = CTJ_ISNIL_DIC(@"Address");
        
        _takeGoodsAddressLable.text = [NSString stringWithFormat:@"%@%@%@%@",Province,City,District,Address];
        
        if (_takeGoodsAddressLable.text.length <= 19)
        {
            _takeGoodsAddressLable.frame = CGRectMake(75, 150, 230, 15);
        }
        
        NSAttributedString * attributedStringtakeGoodsName = [RRAttributedString setText:_takeGoodsName.text color:RGBCOLOR(153, 153, 153) range:NSMakeRange(0, 4)];
        
        _takeGoodsName.attributedText = attributedStringtakeGoodsName;
        
        NSAttributedString * attributedStringtakeGoodsPhone = [RRAttributedString setText:_takeGoodsPhoneLable.text color:RGBCOLOR(153, 153, 153) range:NSMakeRange(0, 3)];
        
        _takeGoodsPhoneLable.attributedText = attributedStringtakeGoodsPhone;
        
        //商品信息
        NSArray * OrderProducts = [dic getArray:@"OrderProducts"];
        
        [_goodsImage requestCustom:[[[OrderProducts objectAtIndex:0]wrapper] getString:@"PictureUrl"] width:_goodsImage.width height:_goodsImage.height];
        
        _goodsNameLable.text = [[[OrderProducts objectAtIndex:0]wrapper] getString:@"ProductName"];
        
        if (_goodsNameLable.text.length <= 19)
        {
            _goodsNameLable.frame = CGRectMake(75, 63, 230, 13);
            
            _goodsNumAndPrice.frame = CGRectMake(75, 85, 230, 12);
        }
        
        NSString * num = [NSString stringWithFormat:@"%d",[[[OrderProducts objectAtIndex:0]wrapper] getInt:@"Qty"]];
        
        NSString * price = [NSString stringWithFormat:@"%d",[[[OrderProducts objectAtIndex:0]wrapper] getInt:@"UnitPrice"]];
        
        NSString * numAndPrice = [NSString stringWithFormat:@"数量：%@     银元：%@",num,price];

        NSMutableAttributedString *attributedStringgoodsNum = WEAK_OBJECT(NSMutableAttributedString, initWithString:numAndPrice);
        
        NSMutableDictionary *attDic = WEAK_OBJECT(NSMutableDictionary, init);
        
        [attDic setValue:RGBCOLOR(153, 153, 153) forKey:NSForegroundColorAttributeName];
        
        [attributedStringgoodsNum setAttributes:attDic range:NSMakeRange(0, 3)];
        
        [attDic setValue:RGBCOLOR(153, 153, 153) forKey:NSForegroundColorAttributeName];
        
        [attributedStringgoodsNum setAttributes:attDic range:NSMakeRange(num.length + 8, 3)];
        
        _goodsNumAndPrice.attributedText = attributedStringgoodsNum;
        
        
        //实付金额
        NSString * TotalPrice = [NSString stringWithFormat:@"%d",[dic getInt:@"OrderAmount"]];
        
        _orderMoneyLable.text = [NSString stringWithFormat:@"实付金额：%@ (邮费到付 用户自理)",TotalPrice];
        
        NSAttributedString * attributedStringorderMoney = [RRAttributedString setText:_orderMoneyLable.text color:RGBCOLOR(240, 5, 0) range:NSMakeRange(5, TotalPrice.length)];
        
        _orderMoneyLable.attributedText = attributedStringorderMoney;
        
        
        if ([_dealState isEqualToString:@"4"])
        {
            if ([dic getString:@"Notes"] == nil)
            {
                _orderItemLable.text = @"卖家备忘：还未备忘";
            }
            else
            {
                _orderItemLable.text = [NSString stringWithFormat:@"卖家备忘：%@",[dic getString:@"Notes"]];
            }
        }
    }
    else
    {
        _orderNumber.text = [NSString stringWithFormat:@"订单编号：%@",[dic getString:@"OrderId"]];
        
        NSString * endTime = [dic getString:@"PayDate"];
        
        endTime = [UICommon format19Time:endTime];
        
        _orderTimeLable.text = [NSString stringWithFormat:@"下单时间：%@",endTime];
        
        _orderUserNameLable.text = [NSString stringWithFormat:@"用户账户：%@",[dic getString:@"UserName"]];
        
        
        int orderstate = [dic getInt:@"OrderStatus"];
        
        NSString * state;
        
        if (100 <= orderstate && orderstate <= 200)
        {
            state = @"待付款";
        }else if (200 <= orderstate && orderstate  <= 300)
        {
            state = @"待发货";
        }
        else if (300 <= orderstate && orderstate  <= 400)
        {
            state = @"已发货";
            
        }
        else if (901 <= orderstate && orderstate  <= 999)
        {
            if (901 == orderstate)
            {
                state = @"交易成功";
            }
            else
            {
                state = @"交易关闭";
            }
        }
        
        _orderStateLable.text = [NSString stringWithFormat:@"订单状态：%@",state];
        
        NSAttributedString * attributedStringorderNum = [RRAttributedString setText:_orderNumber.text color:RGBCOLOR(153, 153, 153) range:NSMakeRange(0, 5)];
        
        _orderNumber.attributedText = attributedStringorderNum;
        
        NSAttributedString * attributedStringorderTime = [RRAttributedString setText:_orderTimeLable.text color:RGBCOLOR(153, 153, 153) range:NSMakeRange(0, 5)];
        
        _orderTimeLable.attributedText = attributedStringorderTime;
        
        NSAttributedString * attributedStringorderUserName = [RRAttributedString setText:_orderUserNameLable.text color:RGBCOLOR(153, 153, 153) range:NSMakeRange(0, 5)];
        
        _orderUserNameLable.attributedText = attributedStringorderUserName;
        
        NSAttributedString * attributedStringorderState = [RRAttributedString setText:_orderStateLable.text color:RGBCOLOR(153, 153, 153) range:NSMakeRange(0, 5)];
        
        _orderStateLable.attributedText = attributedStringorderState;
        
        //收货
        _takeGoodsName.text = [NSString stringWithFormat:@"收货人：%@",[dic getString:@"CustomerName"]];
        
        CustomerName = [dic getString:@"CustomerName"];
        
        CustomerTel = [dic getString:@"CustomerTel"];
        
        _takeGoodsPhoneLable.text = [NSString stringWithFormat:@"电话：%@",[dic getString:@"CustomerTel"]];
        
        _takeGoodsAddressLable.text = [dic getString:@"Address"];
        
        if (_takeGoodsAddressLable.text.length <= 19)
        {
            _takeGoodsAddressLable.frame = CGRectMake(75, 150, 230, 15);
        }
        
        NSAttributedString * attributedStringtakeGoodsName = [RRAttributedString setText:_takeGoodsName.text color:RGBCOLOR(153, 153, 153) range:NSMakeRange(0, 4)];
        
        _takeGoodsName.attributedText = attributedStringtakeGoodsName;
        
        NSAttributedString * attributedStringtakeGoodsPhone = [RRAttributedString setText:_takeGoodsPhoneLable.text color:RGBCOLOR(153, 153, 153) range:NSMakeRange(0, 3)];
        
        _takeGoodsPhoneLable.attributedText = attributedStringtakeGoodsPhone;
        
        //商品信息
        NSArray * Goods= [dic getArray:@"OrderProducts"];
        
        [_goodsImage requestCustom:[[[Goods objectAtIndex:0]wrapper] getString:@"PictureUrl"] width:_goodsImage.width height:_goodsImage.height];
        
        _goodsNameLable.text = [[[Goods objectAtIndex:0]wrapper] getString:@"ProductName"];
        
        _goodsNumAndPrice.text = [NSString stringWithFormat:@"颜色/参数：%@",[[[Goods objectAtIndex:0]wrapper] getString:@"ProdutSpce"]];
        
        NSAttributedString * attributedStringnumPrice = [RRAttributedString setText:_goodsNumAndPrice.text color:RGBCOLOR(153, 153, 153) range:NSMakeRange(0, 6)];
        
        _goodsNumAndPrice.attributedText = attributedStringnumPrice;
        
        NSString * num = [NSString stringWithFormat:@"%d",[[[Goods objectAtIndex:0]wrapper] getInt:@"Qty"]];
        
        NSString * price = [NSString stringWithFormat:@"%.2f",[[[Goods objectAtIndex:0]wrapper] getFloat:@"UnitPrice"]];
        
        NSString * numAndPrice = [NSString stringWithFormat:@"数量：%@     单价：%@",num,price];
        
        NSMutableAttributedString *attributedStringgoodsNum = WEAK_OBJECT(NSMutableAttributedString, initWithString:numAndPrice);
        
        NSMutableDictionary *attDic = WEAK_OBJECT(NSMutableDictionary, init);
        
        [attDic setValue:RGBCOLOR(153, 153, 153) forKey:NSForegroundColorAttributeName];
        
        [attributedStringgoodsNum setAttributes:attDic range:NSMakeRange(0, 3)];
        
        [attDic setValue:RGBCOLOR(153, 153, 153) forKey:NSForegroundColorAttributeName];
        
        [attributedStringgoodsNum setAttributes:attDic range:NSMakeRange(num.length + 8, 3)];
        
        _goodsPrice.attributedText = attributedStringgoodsNum;

        //订单信息金额
        NSString * TotalPrice = [NSString stringWithFormat:@"%.2f",[dic getFloat:@"OrderAmount"]];
        
        NSString * DeliveryPrice = [NSString stringWithFormat:@"%.2f",[dic getFloat:@"DeliveryPrice"]];
        
        _orderMoneyLable.text = [NSString stringWithFormat:@"实付金额：%@ (包含运费%@)",TotalPrice,DeliveryPrice];
        
        NSAttributedString * attributedStringorderMoney = [RRAttributedString setText:_orderMoneyLable.text color:RGBCOLOR(240, 5, 0) range:NSMakeRange(5, TotalPrice.length)];
        
        _orderMoneyLable.attributedText = attributedStringorderMoney;
        
//        _goodsNameLable.text = @"商品名称商品名称商品名称商品";
        
        if (_goodsNameLable.text.length <= 19)
        {
            _goodsNameLable.frame = CGRectMake(75, 55, 230, 13);
            
            _goodsNumAndPrice.frame = CGRectMake(75, 77, 230, 12);
            
            _goodsPrice.frame = CGRectMake(75, 93, 230, 12);
        }
        
        if ([_dealState isEqualToString:@"6"])
        {
            if ([dic getString:@"CloseComment"] == nil)
            {
                _orderItemLable.text = @"卖家备忘：还未备忘";
            }
            else
            {
                _orderItemLable.text = [NSString stringWithFormat:@"卖家备忘：%@",[dic getString:@"CloseComment"]];
            }
        }
        else if ([_dealState isEqualToString:@"2"])
        {
            //是否有同意退款
            if (_IsApplayReturn == 203)
            {
                _orderArgeeTuiHuoLable.text = @"同意退款";
                
                [_orderArgeeTuiHuoBtn roundCornerBorder];
                
                _orderArgeeTuiHuoBtn.backgroundColor = [UIColor whiteColor];
                
                _orderArgeeTuiHuoBtn.frame = CGRectMake(183, 7, 70, 25);
                
                _orderArgeeTuiHuoLable.frame = _orderArgeeTuiHuoBtn.frame;
                
                
                //退款原因
                _tuikuanYuanYinLable.text = [dic getString:@"ReturnReason"];
//                _tuikuanYuanYinLable.text = @"商家不发货商家不发货商家不发货商家不发货商家不发货商家不发货商家不发货商家不发货商家不发货商家不发货商家不发货商家不发货商家不发货商家不发货商家不发货商家不发货商家不发货";
                
                CGSize size = [UICommon getSizeFromString:_tuikuanYuanYinLable.text
                                                 withSize:CGSizeMake(229, MAXFLOAT)
                                                 withFont:12];
                _tuikuanYuanYinLable.height = size.height;
                
                //退款金额
                _jineLable.frame = CGRectMake(15, _tuikuanYuanYinLable.origin.y + _tuikuanYuanYinLable.height + 13, 62, 14);
                
                _tuikuanJinElable.text = [NSString stringWithFormat:@"%.2f",[dic getFloat:@"ReturnAmount"]];
                
                _tuikuanJinElable.frame = CGRectMake(76, _tuikuanYuanYinLable.origin.y + _tuikuanYuanYinLable.height + 13, 229, 14);
                
                CGSize bcsmsize;
                
                //补充说明
                _bcsmLable.frame = CGRectMake(15, _tuikuanJinElable.origin.y + _tuikuanJinElable.height + 13, 62, 14);
                
                _bcsmContentLable.text = [dic getString:@"ReturnComment"];
                
                bcsmsize = [UICommon getSizeFromString:_bcsmContentLable.text
                                              withSize:CGSizeMake(229, MAXFLOAT)
                                              withFont:12];
                
                _bcsmContentLable.frame = CGRectMake(76, _tuikuanJinElable.origin.y + _tuikuanJinElable.height + 13, 229, bcsmsize.height);
                
                //图片凭证
                arrImage = [dic getArray:@"ReturnCertificate"];
                
                [arrImage retain];
                
                int num = (int)[arrImage count]/2;
                
                RRLineView * line = WEAK_OBJECT(RRLineView, init);
                
                [_tuikuanVIew addSubview:line];

                //如果补充说明和图片都没有
                if ([dic getString:@"ReturnComment"] == nil && [arrImage count] == 0)
                {
                    _bcsmLable.hidden = YES;
                    _tupianLable.hidden = YES;
                    Height = _tuikuanYuanYinLable.origin.y + _tuikuanYuanYinLable.height + 13 + _tuikuanJinElable.height + 15;
                }
                //如果没有图片
                else if ([arrImage count] == 0)
                {
                    _tupianLable.hidden = YES;
                    
                    Height = _tuikuanYuanYinLable.origin.y + _tuikuanYuanYinLable.height + 13 + _tuikuanJinElable.height + 13 + _bcsmContentLable.height + 15;
                }
                //如果没有补充说明
                else if([dic getString:@"ReturnComment"] == nil || [_bcsmContentLable.text isEqualToString:@""])
                {
                    _bcsmLable.hidden = YES;
                    
                    _tupianLable.frame = CGRectMake(15, _tuikuanJinElable.origin.y + _tuikuanJinElable.height + 13, 62, 14);
                    
                    Height = _tuikuanYuanYinLable.origin.y + _tuikuanYuanYinLable.height + 13 + _tuikuanJinElable.height + 13 + (100 * num) - 5;
                    
                    
                    for (int i = 0; i < [arrImage count]; i ++)
                    {
                        CGFloat sizey = _tuikuanJinElable.origin.y + _tuikuanJinElable.height + 13;
                        
                        [self drawItem:arrImage[i] at:i orginY:sizey];
                        
                    }
                    //奇数
                    if ([arrImage count] %2 == 1)
                    {
                        
                        Height = _tuikuanYuanYinLable.origin.y + _tuikuanYuanYinLable.height + 13 + _tuikuanJinElable.height + 13 + (100 * num) + 100 + 25 ;
                        
                        int add = (int)[arrImage count];
                        
                        NetImageView * tuikuanimage = WEAK_OBJECT(NetImageView, initWithFrame:CGRectMake(add%2 == 0 ? 78:178, _tuikuanJinElable.origin.y + _tuikuanJinElable.height + 13 + MAX(0, (add/2)*100), 80, 100));
                        
                        [_tuikuanVIew addSubview:tuikuanimage];
                    }
                }
                //全部都有
                else
                {
                    _tupianLable.frame = CGRectMake(15, _bcsmContentLable.origin.y + _bcsmContentLable.height + 13, 62, 14);
                    
                    Height = _tuikuanYuanYinLable.origin.y + _tuikuanYuanYinLable.height + 13 + _tuikuanJinElable.height + 13 + _bcsmContentLable.height + 13 + (100 * num) - 5;
                    
                    for (int i = 0; i < [arrImage count]; i ++)
                    {
                        CGFloat sizey = _bcsmContentLable.origin.y + _bcsmContentLable.height + 13;
                        
                        [self drawItem:arrImage[i] at:i orginY:sizey];
                        
                    }
                    //奇数
                    if ([arrImage count] %2 == 1)
                    {
                        Height = _tuikuanYuanYinLable.origin.y + _tuikuanYuanYinLable.height + 13 + _tuikuanJinElable.height + 13 + (100 * num) + 100 + 25 ;
                        
                        int add = (int)[arrImage count];
                        
                        UIView *bgview = WEAK_OBJECT(UIView, initWithFrame:CGRectMake(add%2 == 0 ? 78:178, _tuikuanJinElable.origin.y + _tuikuanJinElable.height + 13 + MAX(0, (add/2)*100), 80, 100));
                        
                        NetImageView * tuikuanimage = WEAK_OBJECT(NetImageView, initWithFrame:CGRectMake(0, 0, 80, 80));
                        
                        [bgview addSubview:tuikuanimage];
                        
                        [_tuikuanVIew addSubview:bgview];
                        
                    }
                }
                
                line.frame = CGRectMake(0, Height, 320, 0.5);
            }
            else
            {
                _orderArgeeTuiHuoBtn.hidden = YES;
            }
        }
    }
}

- (void)drawItem:(NSString *)qq at:(NSInteger)index orginY : (CGFloat) orginy
{
    UIView *bgview = WEAK_OBJECT(UIView, initWithFrame:CGRectMake(index%2 == 0 ? 78:178, orginy + MAX(0, (index/2)*100), 80, 100));
    
    NetImageView * tuikuanimage = WEAK_OBJECT(NetImageView, initWithFrame:CGRectMake(0, 0, 80, 80));
    tuikuanimage.layer.borderWidth = 0.5;
    tuikuanimage.layer.borderColor = [RGBCOLOR(204, 204, 204) CGColor];
    [bgview addSubview:tuikuanimage];

    __block typeof(self) weakself = self;
    [tuikuanimage setTapActionWithBlock:^
    {
        //预览
        PreviewViewController *preview = WEAK_OBJECT(PreviewViewController, init);
        
        NSMutableArray *pics = [NSMutableArray array];
        for (NSString *url in arrImage)
        {
            [pics addObject:@{@"PictureUrl" : url}];
        }
        preview.dataArray = pics;

        preview.currentPage = index;
        
        [weakself presentViewController:preview animated:NO completion:nil];
        
    }];
    
    [tuikuanimage requestPic:qq placeHolder:YES];
    
    [_tuikuanVIew addSubview:bgview];
}

-(void) setViewAdd
{
    [_mainScroller addSubview:_orderView];
    
    [_mainScroller addSubview:_takeGoodsView];
    
    [_mainScroller addSubview:_goodsView];
    
    if ([_OrderType isEqualToString:@"1"])
    {
        _goodsView.frame = CGRectMake(0, 540, 320, 120);
        
        _goodsPrice.hidden = YES;
        
        _lineView.top = 119;
        
        RRLineView * lines = [[RRLineView alloc] initWithFrame:CGRectMake(0, 119.5, 320, 0.5)];
        
        lines.image = [UIImage imageNamed:@"line.png"];
        [_goodsView addSubview:lines];
        
        if ([_dealState isEqualToString:@"4"])
        {
            _orderLine.left = 15;
            
            _orderView.frame = CGRectMake(0, 10, 320, 320);
            
            _takeGoodsView.frame = CGRectMake(0, 340, 320, 190);
            
            _goodsView.frame = CGRectMake(0, 540, 320, 120);
            
            [_mainScroller setContentSize:CGSizeMake(320, 670)];
        }
        else
        {
            _orderView.frame = CGRectMake(0, 10, 320, 270);
            
            _takeGoodsView.frame = CGRectMake(0, 290, 320, 190);
            
            _goodsView.frame = CGRectMake(0, 490,320, 120);
            
            [_mainScroller setContentSize:CGSizeMake(320, 620)];
        }
    }
    else
    {
        _lineView.top = 133.5;
        
        if ([_dealState isEqualToString:@"2"])
        {
            //是否有同意退款
            if (_IsApplayReturn == 203)
            {
                [_mainScroller addSubview:_tuikuanVIew];
                
                _orderView.frame = CGRectMake(0, 10, 320, 270);
                
                _tuikuanVIew.frame = CGRectMake(0, 290, 320, Height);
                
                _takeGoodsView.frame = CGRectMake(0, Height + 300, 320, 190);
                
                _goodsView.frame = CGRectMake(0, Height + 10 + 190 + 300,320, 134);
                
                [_mainScroller setContentSize:CGSizeMake(320, 290 + Height + 10 + 190 + 10 + 134 + 10)];
                return;
            }
            else
            {
                
            }
        }
        
        
        
        if ([_dealState isEqualToString:@"6"])
        {
            _orderLine.left = 15;
            
            _orderView.frame = CGRectMake(0, 10, 320, 320);
            
            _takeGoodsView.frame = CGRectMake(0, 340, 320, 190);
            
            _goodsView.frame = CGRectMake(0, 540, 320, 134);
            
            [_mainScroller setContentSize:CGSizeMake(320, 684)];
        }
        else
        {
            _orderView.frame = CGRectMake(0, 10, 320, 270);
            
            _takeGoodsView.frame = CGRectMake(0, 290, 320, 190);
            
            _goodsView.frame = CGRectMake(0, 490,320, 134);
            
            [_mainScroller setContentSize:CGSizeMake(320, 634)];
        }
        
    }
}

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    InitNav(@"订单详情");
    
    _takeGoodsLineOne.top = 0;
    
    _goodsImage.layer.borderWidth = 0.5;
    
    _goodsImage.layer.borderColor = [RGBCOLOR(204, 204, 204) CGColor];
}

- (IBAction)touchUpInside:(id)sender
{
    if ([_OrderType isEqualToString:@"1"])
    {
        if (sender == _orderBtn)
        {
            if ([_dealState isEqualToString:@"1"])
            {
                //关闭交易
            }
            else if ([_dealState isEqualToString:@"2"])
            {
                //发货
                PUSH_VIEWCONTROLLER(ShippingViewController);
                model.OrderNumber = [result getString:@"OrderNumber"];
                model.orderType =  _OrderType;
                model.EnterpriseId = _EnterpriseId;
                model.delegate = self;
            }
        }
        else if (sender == _taksGoodsBtn)
        {
            if ([_dealState isEqualToString:@"1"])
            {
                
            }
            else if ([_dealState isEqualToString:@"2"])
            {
                //更改收货地址
                PUSH_VIEWCONTROLLER(ChangeShippingAddressViewController);
                model.OrderNumber = [result getString:@"OrderNumber"];
                model.orderType =  _OrderType;
            }
            else if ([_dealState isEqualToString:@"3"])
            {
                //查看物流
                PUSH_VIEWCONTROLLER(MyMarketMyOrderWebViewController);
                model.urlString = @"http://www.kuaidi100.com/all/index.shtml?from=newindex";
            }
            else if ([_dealState isEqualToString:@"4"])
            {
                //查看物流
                PUSH_VIEWCONTROLLER(MyMarketMyOrderWebViewController);
                model.urlString = @"http://www.kuaidi100.com/all/index.shtml?from=newindex";
            }
            else if ([_dealState isEqualToString:@"5"])
            {
                //查看物流
                PUSH_VIEWCONTROLLER(MyMarketMyOrderWebViewController);
                model.urlString = @"http://www.kuaidi100.com/all/index.shtml?from=newindex";
            }
        }
        else if (sender == _orderItemBtn)
        {
            //备忘录
            PUSH_VIEWCONTROLLER(ItemViewController);
            model.OrderNumber = [result getString:@"OrderNumber"];
            model.nots = [result getString:@"Notes"];
            model.orderType = _OrderType;
        }
        else if (sender == _takeGoodsCopyBtn)
        {
            [HUDUtil showSuccessWithStatus:@"复制成功"];
            //复制
            UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
            pasteboard.string = [NSString stringWithFormat:@"%@%@%@",CustomerName,CustomerTel,_takeGoodsAddressLable.text];
        }
    }
    else
    {
        if (sender == _orderBtn)
        {
            if ([_dealState isEqualToString:@"1"])
            {
                //关闭交易
            }
            else if ([_dealState isEqualToString:@"2"])
            {
                //发货
                PUSH_VIEWCONTROLLER(ShippingViewController);
                model.OrderNumber = [result getString:@"OrderId"];
                model.orderType =  _OrderType;
                model.EnterpriseId = _EnterpriseId;
                model.delegate = self;
                model.type = @"1";
            }
        }
        else if (sender == _taksGoodsBtn)
        {
            if ([_dealState isEqualToString:@"1"])
            {
                
            }
            else if ([_dealState isEqualToString:@"2"])
            {
                //更改收货地址
                PUSH_VIEWCONTROLLER(ChangeShippingAddressViewController);
                model.OrderNumber = [result getString:@"OrderId"];
                model.orderType =  _OrderType;
            }
            else if ([_dealState isEqualToString:@"3"])
            {
                //查看物流
                PUSH_VIEWCONTROLLER(MyMarketMyOrderWebViewController);
                model.urlString = @"http://www.kuaidi100.com/all/index.shtml?from=newindex";
            }
            else if ([_dealState isEqualToString:@"4"])
            {
                //查看物流
                PUSH_VIEWCONTROLLER(MyMarketMyOrderWebViewController);
                model.urlString = @"http://www.kuaidi100.com/all/index.shtml?from=newindex";
            }
            else if ([_dealState isEqualToString:@"5"])
            {
                //查看物流
                PUSH_VIEWCONTROLLER(MyMarketMyOrderWebViewController);
                model.urlString = @"http://www.kuaidi100.com/all/index.shtml?from=newindex";
            }
            else if ([_dealState isEqualToString:@"6"])
            {
                //查看物流
                PUSH_VIEWCONTROLLER(MyMarketMyOrderWebViewController);
                model.urlString = @"http://www.kuaidi100.com/all/index.shtml?from=newindex";
            }
        }
        else if (sender == _orderItemBtn)
        {
            //备忘录
            PUSH_VIEWCONTROLLER(ItemViewController);
            model.OrderNumber = [result getString:@"OrderId"];
            model.nots = [result getString:@"CloseComment"];
            model.orderType = _OrderType;
        }
        else if (sender == _takeGoodsCopyBtn)
        {
            [HUDUtil showSuccessWithStatus:@"复制成功"];
            //复制
            UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
            pasteboard.string = [NSString stringWithFormat:@"%@%@%@",CustomerName,CustomerTel,_takeGoodsAddressLable.text];
        }
        else if (sender == _orderArgeeTuiHuoBtn)
        {
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"同意退款吗" message:@"如同意，本订单将关闭，系统返回用户易货码" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"同意", nil];
            [alert show];
            [alert release];
        }
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        //同意退款
        ADAPI_adv3_GoldOrder_EnterpriseOrderOperate([self genDelegatorID:@selector(HandleNotification:)], _EnterOrderNumber, @"5");
    }
}

- (void)stateShouldBeChange:(NSString *)state
{
    _dealState = state;
    [_dealState retain];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


- (void)dealloc
{
    [_jineLable release];
    [_tupianLable release];
    [_bcsmLable release];
    [_bcsmContentLable release];
    [_tuikuanJinElable release];
    [_tuikuanYuanYinLable release];
    [_tuikuanVIew release];
    [result release];
    
    result = nil;
    
    [_mainScroller release];
    [_orderView release];
    [_takeGoodsView release];
    [_goodsView release];
    [_orderNumber release];
    [_orderTimeLable release];
    [_orderUserNameLable release];
    [_orderStateLable release];
    [_orderMoneyLable release];
    [_takeGoodsName release];
    [_takeGoodsPhoneLable release];
    [_takeGoodsAddressLable release];
    [_goodsNameLable release];
    [_goodsImage release];
    [_goodsNumAndPrice release];
    [_goodsPrice release];
    [_orderBtn release];
    [_orderBtnLable release];
    [_taksGoodsBtn release];
    [_takeGoodsBtnLable release];
    [_takeGoodsCopyBtn release];
    [_orderItemBtn release];
    [_orderItemLable release];
    [_orderLine release];
    [_lineView release];
    [_orderArgeeTuiHuoBtn release];
    [_orderArgeeTuiHuoLable release];
    [_takeGoodsLineOne release];
    [_goodsLineOne release];
    [super dealloc];
}

- (void)viewDidUnload {
    [self setMainScroller:nil];
    [self setOrderView:nil];
    [self setTakeGoodsView:nil];
    [self setGoodsView:nil];
    [self setOrderNumber:nil];
    [self setOrderTimeLable:nil];
    [self setOrderUserNameLable:nil];
    [self setOrderStateLable:nil];
    [self setOrderMoneyLable:nil];
    [self setTakeGoodsName:nil];
    [self setTakeGoodsPhoneLable:nil];
    [self setTakeGoodsAddressLable:nil];
    [self setGoodsNameLable:nil];
    [self setGoodsImage:nil];
    [self setGoodsNumAndPrice:nil];
    [super viewDidUnload];
}

@end
