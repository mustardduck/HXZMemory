//
//  ProductOrderMsgTableViewCell.m
//  miaozhuan
//
//  Created by abyss on 14/12/5.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "ProductOrderMsgTableViewCell.h"
#import "UserInfo.h"
#import "CRWebSupporter.h"
//跳转
#import "WatingShippingViewController.h"
#import "AllSiteExchangeViewController.h"
#import "YinYuanProdListController.h"
#import "Management_Index.h"
#import "MyMarketMyOrderListController.h"
#import "VIPPrivilegeViewController.h"
#import "HandleOutAdsViewController.h"
#import "CRSliverDetailViewController.h"
#import "Commodity_Detail.h"
#import "SalesReturnAndAfterSaleViewController.h"
#import "MySaleReturnAndAfterSaleViewController.h"
#import "TypicalURLViewController.h"
#import "SilverListViewController.h"
#import "PhoneAuthenticationViewController.h"
#import "MyGoldListController.h"
#import "CircurateViewController.h"
#import "MyGoldCircurateViewController.h"
#import "YinYuanManageMainController.h"
@interface ProductOrderMsgTableViewCell ()
{
    CGSize _size;
}
@property (retain, nonatomic) IBOutlet UIView *lineAdd;
@property (retain, nonatomic) IBOutlet UIView *bottomView;
@property (retain, nonatomic) IBOutlet UIView *lineADD1;
@end
@implementation ProductOrderMsgTableViewCell

- (void)awakeFromNib
{
    UIView* view = WEAK_OBJECT(UIView, initWithFrame:CGRectMake(0, 9.5, 320, 0.5));
    view.backgroundColor = AppColor(204);
    [_lineAdd addSubview:view];
    
    UIView* view1 = WEAK_OBJECT(UIView, initWithFrame:CGRectMake(0, 80.5, 320, 0.5));
    view1.backgroundColor = AppColor(204);
    [_lineADD1 addSubview:view1];
}

- (void)layoutSubviews
{
    _contentL.height = MAX(32, _size.height + 5);
    _bottomView.top += _exFloat;
    
    
    DictionaryWrapper *itemData = [_data getDictionaryWrapper:@"RelatedDataInfo"];
    int type = [itemData getInt:@"ProductType"];
    self.add_001.text = @"价格:";
    if (type == 1) //兑换商品
    {
        self.add_001.textAlignment = NSTextAlignmentLeft;
        self.priceL.left = 105;
        
        self.add_002.hidden = YES;
        self.colorL.hidden = YES;
        
        if (self.priceL.text.length > 0)
        {
            if(![self.priceL.text containsString:@"银元"]) self.priceL.text =  [self.priceL.text stringByAppendingString:@"银元"];
        }
    }
    if(type == 2)
    {
        if (self.priceL.text.length > 0)
        {
            if(![self.priceL.text containsString:@"金币"]) self.priceL.text =  [self.priceL.text stringByAppendingString:@"易货码"];
        }
    }
    
    
    [super layoutSubviews];
}

- (void)setCRcontent:(NSAttributedString *)CRcontent
{
    _CRcontent = CRcontent;
    [_CRcontent retain];
    if (_CRcontent)
    {
        _contentL.attributedText = _CRcontent;
        _size = [_contentL.text sizeWithFont:Font(12) constrainedToSize:CGSizeMake(290, MAXFLOAT) lineBreakMode:NSLineBreakByCharWrapping];
        _exFloat = MAX(0, (_size.height - 32));
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    [_deleteBt addTarget:self action:@selector(deleteBT:) forControlEvents:UIControlEventTouchUpInside];
    [_touchBt addTarget:self action:@selector(touchBT:) forControlEvents:UIControlEventTouchUpInside];
    // Configure the view for the selected state
}

- (void)deleteBT:(id)sender
{
    ADAPI_adv3_MessageDelete([GLOBAL_DELEGATOR_MANAGER addDelegator:self selector:@selector(isSuccess:)],_MsgIds,_deleteType);
}

- (void)isSuccess:(DelegatorArguments *)arg
{
    [arg logError];
    if (arg.ret.operationSucceed)
    {
        if (_delegate)
        {
            [_delegate cell:self DidBeDelete:_fatherIndex];
        }
    }
}

- (void)touchBT:(id)sender
{
    id model = nil;
    
    //邮寄兑换
    if (_type & CRENUM_NCContentTypePostOrder)
    {
        model = WEAK_OBJECT(WatingShippingViewController , init);
        
        DictionaryWrapper *itemData = [_data getDictionaryWrapper:@"RelatedDataInfo"];
        int type = [itemData getInt:@"ProductType"];
        int retType = [itemData getInt:@"OrderStatus"];
        int orderType = 0;
        
        if (retType == 201) { orderType = type==1?2:2;} //收款
        else if (retType == 901) { orderType = type==1?3:5;} //确认收货
        else if (retType == 911) { orderType = type==1?4:6;} //交易关闭
        else if (retType == 202) {  orderType = type==1?2:2;} //提醒发货
        else
        {
            return;
        }
        
        ((WatingShippingViewController *)model).orderType = [NSString stringWithFormat:@"%d",type];
        ((WatingShippingViewController *)model).dealState = [NSString stringWithFormat:@"%d",orderType];
        ((WatingShippingViewController *)model).EnterpriseId = USER_MANAGER.EnterpriseId;
    }
    //退货消息
    else if (_type & CRENUM_NCContentTypePostOrderRefund)
    {
        //1发起退货
        //2待退货
        //3待确认退货
        //4退货成功
        //5申诉中
        //6申诉完毕
        DictionaryWrapper *itemData = [_data getDictionaryWrapper:@"RelatedDataInfo"];
        int statu = [itemData getInt:@"OrderStatus"];
        int i;
        if (statu == 401)
        {
            i = 1;
        }
        else if (statu >= 400 && statu < 500)
        {
            i = 3;
        }
        else if (statu == 502)
        {
            i = 5;
        }
        else if (statu == 941)
        {
            i = 6;
        }
        
        model = WEAK_OBJECT(SalesReturnAndAfterSaleViewController ,init);
        ((SalesReturnAndAfterSaleViewController *)model).type = i;
    }
    //现场订单
    else if (_type & CRENUM_NCContentTypeLiveOrder)
    {
        model = WEAK_OBJECT(AllSiteExchangeViewController ,init);
        ((AllSiteExchangeViewController *)model).EnterpriseId = USER_MANAGER.EnterpriseId;
    }
    //银元广告审核
    else if (_type & CRENUM_NCContentTypeSilverProduct)
    {
        DictionaryWrapper *itemData = [_data getDictionaryWrapper:@"RelatedDataInfo"];
        int type = [itemData getInt:@"OrderStatus"];
        
        model = WEAK_OBJECT(YinYuanProdListController ,init);
        
        if(type == 0 || type == 3) return;
        if(type == 1) ((YinYuanProdListController *)model).queryType = 4;
        if(type == 2) ((YinYuanProdListController *)model).queryType = 3;
    }
    //金币广告审核
    else if (_type & CRENUM_NCContentTypeGoldProduct)
    {
        DictionaryWrapper *itemData = [_data getDictionaryWrapper:@"RelatedDataInfo"];
        int type = [itemData getInt:@"OrderStatus"];
        int jump;
        model = WEAK_OBJECT(Management_Index ,init);
        if (type == 1)
        {
            jump = 3;
        }
        else if (type == 2)
        {
            jump = 2;
        }
        else if (type == 3)
        {
            jump = 5;
        }
//        1-审核成功，2-审核失败，3-已售完
//        4:出售中, 3:等待上架, 5:已下架, 1:审核中, 2:审核失败
        ((Management_Index *)model).statusTag = jump;
    //交易消息
    }else if (_type & CRENUM_NCContentTypeTradeMsg) {
    
        DictionaryWrapper *wrapper = [_data getDictionaryWrapper:@"RelatedDataInfo"];
        int requestType = 0;
        int netNumber = [[wrapper getString:@"OrderStatus"] intValue];
        
        if (netNumber <= 199&&netNumber >= 100) {
            
            requestType = 1;
        }
        
        if (netNumber >= 200&&netNumber <= 299) {
            
            requestType = 2;
        }
        
        if (netNumber >= 300 && netNumber <= 399) {
            
            requestType = 3;
        }
        
        model = WEAK_OBJECT(MyMarketMyOrderListController, init);
        ((MyMarketMyOrderListController*)model).queryType = requestType;
        
        if ((netNumber >= 400 && netNumber <= 499)||netNumber == 501 || netNumber == 502 || netNumber == 921 || netNumber == 931 || netNumber == 941) {
            
            model = WEAK_OBJECT(MySaleReturnAndAfterSaleViewController, init);
        }
    //商家商品提醒
    }else if (_type & CRENUM_NCContentTypeProductMsg) {
    
        DictionaryWrapper *wrapper = [_data getDictionaryWrapper:@"RelatedDataInfo"];
        int productId = [wrapper getInt:@"ProductId"];
          //Commodity_Detail
          //CRSliverDetailViewController
        int advertId = [wrapper getInt:@"AdvertId"];
        
        switch ([wrapper getInt:@"ProductType"]) {
                
                //兑换商品
            case 1:{
                
                model = WEAK_OBJECT(CRSliverDetailViewController, init);
                ((CRSliverDetailViewController*)model).productId = productId;
                ((CRSliverDetailViewController*)model).advertId = advertId;
                break;
            }
                //易货商品
            case 2:{
                
                model = WEAK_OBJECT(Commodity_Detail, init);
                ((Commodity_Detail*)model).whereFrom = 999;
                ((Commodity_Detail*)model).productId = productId;
                break;
            }
                //直购商品
            case 3:
                [HUDUtil showErrorWithStatus:@"暂时没有直购商城"];
                break;
            default:
                break;
        }
    //系统消息
    }else if (_type & CRENUM_NCContentTypeSystemAdvert) {
    
        DictionaryWrapper *wrapper = [_data getDictionaryWrapper:@"RelatedDataInfo"];
        int systemMessageType = [wrapper getInt:@"MsgType"];
        switch (systemMessageType) {
            case 1:
                
                model = WEAK_OBJECT(VIPPrivilegeViewController, init);
                break;
            case 2:
            case 3:
                
                [UI_MANAGER.mainNavigationController popToRootViewControllerAnimated:NO];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"Message" object:nil];
                break;
            case 4:
                model = WEAK_OBJECT(YinYuanManageMainController, init);
                break;
            default:
                break;
        }
        //客服消息
    }
    else if (_type & CRENUM_NCContentTypeOfficial)
    {
    
        NSString *link = [_data getString:@"Link"];
        
        if ([link isKindOfClass:[NSNull class]]||!link.length) {
            
            return;
        }
        else
        {
        
            model = WEAK_OBJECT(TypicalURLViewController, init);
            ((TypicalURLViewController*)model).Url = link;
        }
    }
    else if (_type & CRENUM_NCContentTypeRemind)
    {
        
//        NSString *link = [_data getString:@"Link"];
//        
//        if ([link isKindOfClass:[NSNull class]]||!link.length) {
//            
//            return;
//        }
//        else
//        {
            model = WEAK_OBJECT(PhoneAuthenticationViewController, init);
//        }
    }
    else if (_type & CRENUM_NCContentTypeCurrency)
    {
        DictionaryWrapper *item = [_data getDictionaryWrapper:@"RelatedDataInfo"];
        switch ([item getInt:@"MsgType"]) {
            case 0:{
                
                [HUDUtil showErrorWithStatus:@"老数据无法完成跳转！"];
            return;}
            case 1:{
                //        1-银元求赠
                model = WEAK_OBJECT(CircurateViewController, init);
                WDictionaryWrapper *wrapper = WEAK_OBJECT(WDictionaryWrapper, init);
                [wrapper set:@"UserAccount" string:[item getString:@"EndUserName"]];
                [wrapper set:@"Number" string:[item getString:@"Number"]];
                [wrapper set:@"Type" string:@"2"];
                ((CircurateViewController*)model).userDic = [wrapper wrapper];
                break;}
            case 2:{
                //        2-收到银元赠送
                model = WEAK_OBJECT(SilverListViewController, init);
                ((SilverListViewController*)model).cellType = 4;
                break;}
            case 3:{
                //        3-金币求赠
                model = WEAK_OBJECT(MyGoldCircurateViewController, init);
                WDictionaryWrapper *wrapper = WEAK_OBJECT(WDictionaryWrapper, init);
                [wrapper set:@"UserAccount" string:[item getString:@"EndUserName"]];
                [wrapper set:@"Number" string:[item getString:@"Number"]];
                ((MyGoldCircurateViewController*)model).userDic = wrapper;
                break;}
            case 4:{
                //        4-收到金币赠送
                model = WEAK_OBJECT(MyGoldListController, init);
                ((MyGoldListController*)model).cellType = 5;
                break;}
            default:
                break;
        }
    }
    
    if (model && [model isKindOfClass:[UIViewController class]])
        [[DotCUIManager instance].mainNavigationController pushViewController:model animated:YES];
}

- (void)dealloc
{
    [_timeL release];
    [_statuL release];
    [_contentL release];
    [_titleL release];
    [_colorL release];
    [_priceL release];
    [_touchBt release];
    [_deleteBt release];
    [_line release];
    [_itemImg release];
    [_bottomView release];
    [_add_001 release];
    [_add_002 release];
    [_lineAdd release];
    [_lineADD1 release];
    [super dealloc];
}


@end
