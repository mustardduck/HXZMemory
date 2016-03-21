//
//  PayMethod.m
//  miaozhuan
//
//  Created by 孙向前 on 14-11-12.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "PayMethod.h"
#import "WXApi.h"
#import <AlipaySDK/AlipaySDK.h>
//#import "UPOMP.h"
#import "UPPayPlugin.h"
#import "UPPayPluginDelegate.h"

#import "NSDictionary+expanded.h"
#import "XMLReader.h"
//#import "UPPayPlugin.h"
/**
 *  微信公众平台商户模块生成的ID
 */


#define kMode_Development             @"01"
#define kURL_TN_Normal                @"http://202.101.25.178:8080/sim/gettn"
#define kURL_TN_Configure             @"http://202.101.25.178:8080/sim/app.jsp?user=123456789"



NSString * const WXPartnerId = @"1220742901";

@interface PayMethod()<UPPayPluginDelegate>/*<UPPayPluginDelegate>*/{
//    UPOMP *cpView;
}

@property (nonatomic, copy) ResultBlock resultBlock;

@end

static PayMethod *payMethod = nil;
@implementation PayMethod

+ (instancetype)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!payMethod) {
            payMethod = STRONG_OBJECT(PayMethod, init);
        }
    });
    return payMethod;
}

+ (void)payWithPayType:(payType)payType
               payInfo:(id)info
            resultback:(ResultBlock)block{
    
    ((PayMethod *)[self shareInstance]).resultBlock = nil;
    ((PayMethod *)[self shareInstance]).resultBlock = block;
    
    switch (payType) {
        case aliPay:
            [[self shareInstance] alipayWithInfo:info callback:block];
            break;
        case wxPay:
            [[self shareInstance] wxPayWithInfo:[info wrapper] callback:block];
            break;
        case upompPay:
            [[self shareInstance] upompPayWithInfo:[info wrapper] callback:block];
            break;
            
        default:
            break;
    }
}
#pragma mark - 微信支付
//微信支付
- (void)wxPayWithInfo:(DictionaryWrapper *)dic callback:(ResultBlock)block{
    
    //wx客户端返回 （appdelegate）
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleAlipayNotification:) name:@"wxpay" object:nil];
    
//    self.resultBlock = block;
    
    if (![[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]]) {
        [AlertUtil showAlert:@"抱歉，不能支付" message:@"请检查是否安装微信，或是否是5.0或以上版本" buttons:@[@"取消",@"立即检查"]];
        return;
    }
    
    PayReq *request   = [[PayReq alloc] init];
    request.partnerId = WXPartnerId;
    request.prepayId  = [dic getString:@"PrePayId"];
    request.package   = [dic getString:@"PackageForIos"];//@"Sign=WXPay";     // 文档为 `Request.package = _package;` , 但如果填写上面生成的 `package` 将不能支付成功
    request.nonceStr  = [dic getString:@"NonceStr"];
    request.timeStamp = (UInt32)[[dic getString:@"TimeStamp"] longLongValue];
    request.sign = [dic getString:@"SignForIos"];
    
    // 在支付之前，如果应用没有注册到微信，应该先调用 [WXApi registerApp:appId] 将应用注册到微信
    [WXApi safeSendReq:request];
}

#pragma  mark - 银联支付，回调
//银联支付
- (void)upompPayWithInfo:(id)info callback:(ResultBlock)block{
    
//    最新sdk支付方式
    [UPPayPlugin startPay:[info getString:@"payData"]//@"201506151724510005272"//
                     mode:@"00"
           viewController:[info get:@"viewController"]
                 delegate:self];
//    cpView=[UPOMP new];
//    cpView.viewDelegate=self;
//    cpView.view.hidden = NO;
//    [[[UIApplication sharedApplication] keyWindow] addSubview:cpView.view];
//    [cpView setXmlData:[[[info wrapper] getString:@"payData"] dataUsingEncoding:NSUTF8StringEncoding]];
    
}

#pragma mark
//UPOMP delegate
- (void)viewClose:(NSData*)data{
    
    NSDictionary *dic = [XMLReader dictionaryForXMLData:data error:nil];
    NSString *respCode = [dic valueForJSONStrKeys:@"upomp",@"respCode",@"text", nil];
    if ([respCode isEqualToString:@"0000"]) {
        
       self.resultBlock(respCode, upompPay);
    }
//    cpView.viewDelegate=nil;
//    [cpView release];
}

//最新sdk支付回调
////回调
- (void)UPPayPluginResult:(NSString *)result {
    self.resultBlock(result, upompPay);
}

#pragma mark - 支付宝支付
//支付宝支付
- (void)alipayWithInfo:(NSString *)xmlstr callback:(ResultBlock)block{
    
    //支付宝客户端返回（appdelegate）
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleAlipayNotification:) name:@"alipay" object:nil];
    
    __block typeof(self)weakself = self;
    [[AlipaySDK defaultService] payOrder:xmlstr fromScheme:@"miaozhuan" callback:^(NSDictionary *resultDic) {
        if ([[resultDic wrapper] getInt:@"resultStatus"] == 9000) {
            weakself.resultBlock(resultDic, aliPay);
        }
    }];
}
//支付宝/微信客户端回调
- (void)handleAlipayNotification:(NSNotification *)noti{
    if ([noti.name isEqualToString:@"wxpay"])
        self.resultBlock(noti.object, wxPay);
    else
        self.resultBlock(noti.object, aliPay);
}

#pragma mark - 内存管理
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self.resultBlock release];
    [super dealloc];
}

@end
