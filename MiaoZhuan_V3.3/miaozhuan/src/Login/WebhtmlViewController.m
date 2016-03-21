//
//  WebhtmlViewController.m
//  miaozhuan
//
//  Created by apple on 14/12/16.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "WebhtmlViewController.h"
#import "VIPPrivilegeViewController.h"

#import "CRWebSupporter.h"
#import "NetImageView.h"


@interface WebhtmlViewController ()<UIWebViewDelegate,RequestFailedDelegate>
{
    int _start;
}
@property (retain, nonatomic) IBOutlet DotCWebView *webHtmlView;
@property (retain, nonatomic) CRWebSupporter* supporter;
@property (retain, nonatomic) RequestFailed *requestFailed;
@end

@implementation WebhtmlViewController

MTA_viewDidAppear()
MTA_viewDidDisappear()

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _webHtmlView.scalesPageToFit = YES;
    InitNav(_navTitle);
    _supporter = [CRWebSupporter supportFromViewController:_webHtmlView];
    
    if ([_navTitle isEqualToString:@"注册协议"])
    {
        ADAPI_adv3_registerGetContentByContentCode([self genDelegatorID:@selector(HandleNotification:)], _ContentCode);
    }
    else
    {
        ADAPI_GetContentByCode([self genDelegatorID:@selector(HandleNotification:)], _ContentCode);
    }
    
    //判断 是否秒赚广告商品兑换协议
    if([_ContentCode isEqualToString:@"d1d23f03edbc383f6c6873822f305584"])
    {
        [self setupMoveFowardButtonWithTitle:@"下载"];
    }
}

//点击下载协议图片
- (void)onMoveFoward:(UIButton *)sender
{
    _ContentCode = @"9c0a26d1e61aa98bf7c3a4e65c8604ad";
    //秒赚广告商品兑换协议的图片H5
    ADAPI_GetContentByCode([self genDelegatorID:@selector(HandleNotification:)], _ContentCode);
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [HUDUtil incNetLoading:YES];
    _start ++;
    
    [self performSelector:@selector(stopHUD) withObject:nil afterDelay:10];
}

//- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
//{
//    [HUDUtil decNetLoading];
//    [_supporter webBack];
//}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self stopHUD];
    [_webHtmlView cancelWebCopy];
    [_supporter supportFor:webView];
}

- (void)stopHUD
{
    if (_start > 0)
    {
        [HUDUtil decNetLoading];
        _start--;
    }
}


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSLog(@"URL :%@", [request URL]);
    NSString *requestURl = [[request URL] absoluteString];
    
//    NSRange range = [requestURl rangeOfString:@"token"];
//    if (range.location == NSNotFound) {
//        
//        ServerRequestOption* option = [ServerRequestOption optionFromService:@""];
//        NSString *cookie = [[NET_SERVICE httpCookiesForURL:option.url] objectForKey:@"token"];
//        requestURl = [NSString stringWithFormat:@"%@?token=%@",requestURl, cookie];
//    }
    [CRWebSupporter responeseEventFor:requestURl];
    
    return YES;
}



-(void)showContent:(NSString *)code
{

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
    [_supporter release];
    [_webHtmlView release];
    [_requestFailed release];
    [super dealloc];
}

- (void)viewDidUnload
{
    [self setWebHtmlView:nil];
    [super viewDidUnload];
}

#pragma mark - 处理回调

- (void)HandleNotification:(DelegatorArguments *)arguments
{
    if ([arguments isEqualToOperation:ADOP_GetContentByCode])
    {
        [arguments logError];
        
        DictionaryWrapper *wrapper = arguments.ret;
        
        if (wrapper.operationSucceed)
        {
            if(_requestFailed){
                [_requestFailed.view removeAllSubviews];
                [_requestFailed.view removeFromSuperview];
            }
            
            DictionaryWrapper * dic = wrapper.data;
            
            if (dic == nil || [dic isKindOfClass:[NSNull class]])
            {
                return;
            }
            
            //判断 是否秒赚广告商品兑换协议的图片H5
            if([_ContentCode isEqualToString:@"9c0a26d1e61aa98bf7c3a4e65c8604ad"])
            {
                
                NSString *imageUrl = [dic getString:@"ContentText"];
                
                //下载图片代码
                
                NSData* data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]];
                UIImage* image = [UIImage imageWithData:data];
                
                //UIImageWriteToSavedPhotosAlbum(image, nil, nil,nil);
                NSLog(@"UIImageWriteToSavedPhotosAlbum = %@", imageUrl);
                UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
                
               
                return;
            }
            
            int type = [dic getInt:@"ContentType"];
            
            NSString * htmlTemplatePath = [dic getString:@"ContentText"];
            
            
            NSRange range = [htmlTemplatePath rangeOfString:@"<head>"];
            if(range.location !=NSNotFound )
            {
                ServerRequestOption* option = [ServerRequestOption optionFromService:@""];
                
                NSString *cookie = [[NET_SERVICE httpCookiesForURL:option.url] objectForKey:@"token"];
                
                NSString *last = [htmlTemplatePath substringToIndex:range.location + 6];
                
                NSString *center = [NSString stringWithFormat:@"\n \t \t<meta name=\"token\" content=\"%@\">", cookie];
                
                NSString *next = [htmlTemplatePath substringFromIndex:range.location + 6];
                
                htmlTemplatePath = [NSString stringWithFormat:@"%@%@%@",last, center, next];
            }
            
            if (type == 1)
            {
                //url
                if (!htmlTemplatePath.length)
                {
                    return;
                }
                
                ServerRequestOption* option = [ServerRequestOption optionFromService:@""];
                NSString *cookie = [[NET_SERVICE httpCookiesForURL:option.url] objectForKey:@"token"];
                htmlTemplatePath = [NSString stringWithFormat:@"%@?token=%@",htmlTemplatePath,cookie];
                
                [_webHtmlView loadURL:htmlTemplatePath];
                
            }
            else if(type == 3)
            {
                //html
                [_supporter getContent:htmlTemplatePath];
                [_webHtmlView loadHTMLString:htmlTemplatePath baseURL:nil];
            }
        }
        else if(wrapper.operationPromptCode || wrapper.operationErrorCode)
        {
            if(nil == _requestFailed){
                _requestFailed = [[RequestFailed alloc] init];
                _requestFailed.delegate = self;
                if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
                {
                    self.edgesForExtendedLayout = UIRectEdgeNone;
                }
                [self addChildViewController:_requestFailed];
            }
            [_requestFailed.view addSubview:_requestFailed.viewWeb];
            [self.view addSubview:_requestFailed.view];
//            [AlertUtil showAlert:@"" message:wrapper.operationMessage buttons:@[@"好的"]];
            return;
        }
    }
    if ([arguments isEqualToOperation:ADOP_adv3_registerGetContentByContentCode])
    {
        [arguments logError];
        
        DictionaryWrapper *wrapper = arguments.ret;
        
        if (wrapper.operationSucceed)
        {
            DictionaryWrapper * dic = wrapper.data;
            
            int type = [dic getInt:@"ContentType"];
            
            NSString * htmlTemplatePath = [dic getString:@"ContentText"];
            
            if (type == 1)
            {
                //url
                if (!htmlTemplatePath.length)
                {
                    return;
                }
                
                ServerRequestOption* option = [ServerRequestOption optionFromService:@""];
                NSString *cookie = [[NET_SERVICE httpCookiesForURL:option.url] objectForKey:@"token"];
                htmlTemplatePath = [NSString stringWithFormat:@"%@?token=%@",htmlTemplatePath,cookie];
                
                [_webHtmlView loadURL:htmlTemplatePath];
                
            }
            else if(type == 3)
            {
                //html
                [_supporter getContent:htmlTemplatePath];
                [_webHtmlView loadHTMLString:htmlTemplatePath baseURL:nil];
            }
        }
        else if(wrapper.operationPromptCode || wrapper.operationErrorCode)
        {
            [AlertUtil showAlert:@"" message:wrapper.operationMessage buttons:@[@"好的"]];
            return;
        }
    }
}

// 功能：显示图片保存结果
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError*)error contextInfo:(void*)contextInfo
{
    if (error){
        NSLog(@"Error");
        [HUDUtil showSuccessWithStatus:@"保存失败，请检查网络"];

    }else {
        NSLog(@"OK");
        
        [HUDUtil showSuccessWithStatus:@"已下载到手机相册"];
    }
}

#pragma mark -- RequestFailedDelegate

-(void)didClickedRefresh{
    if ([_navTitle isEqualToString:@"注册协议"])
    {
        ADAPI_adv3_registerGetContentByContentCode([self genDelegatorID:@selector(HandleNotification:)], _ContentCode);
    }
    else
    {
        ADAPI_GetContentByCode([self genDelegatorID:@selector(HandleNotification:)], _ContentCode);
    }
}

@end
