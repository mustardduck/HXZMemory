//
//  ThankFulMechanismViewController.m
//  miaozhuan
//
//  Created by apple on 14/11/24.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "ThankFulMechanismViewController.h"
#import "ThankFulMechanismTableViewCell.h"
#import "ThankFulFansStatisticalViewController.h"
#import "ThanksGivingViewController.h"
#import "WebhtmlViewController.h"
#import "Share_Method.h"
#import "NetImageView.h"
#import "QRCodeGenerator.h"
#import "UserInfo.h"
#import "PhoneAuthenticationViewController.h"
@interface ThankFulMechanismViewController ()<UIAlertViewDelegate>
{
   
}
- (IBAction)touchupBtn:(id)sender;
@property (retain, nonatomic) IBOutlet UIButton *myfansBtn;
@property (retain, nonatomic) IBOutlet UIButton *faceforthanksBtn;
@property (retain, nonatomic) IBOutlet UIButton *shareBtn;
@property (retain, nonatomic) IBOutlet UIButton *skillBtn;
@property (retain, nonatomic) IBOutlet UIButton *forthanksBtn;
@property (retain, nonatomic) IBOutlet UILabel *thanksLable;
@property (retain, nonatomic) IBOutlet UIView *blackView;
@property (retain, nonatomic) IBOutlet NetImageView *erweimaimage;
@property (retain, nonatomic) IBOutlet UIView *blackviewTwo;
@property (retain, nonatomic) IBOutlet UILabel *versionL;

- (IBAction)blackBtn:(id)sender;
@end

@implementation ThankFulMechanismViewController

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    InitNav(@"感恩机制");
    
    [self setupMoveFowardButtonWithTitle:@"活动介绍"];
    
    
    
    UIView* ret = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    ret.opaque = NO;
    ret.backgroundColor = [UIColor blackColor];
    
    
}

- (IBAction) onMoveFoward:(UIButton*) sender
{
    PUSH_VIEWCONTROLLER(WebhtmlViewController);
    model.navTitle = @"感恩活动介绍";
    model.ContentCode = @"fe7fee3453cf38988c1ac040e277c73c";
}

-(void)viewWillAppear:(BOOL)animated
{
    DictionaryWrapper* dic =[APP_DELEGATE.runtimeConfig getDictionary:RUNTIME_USER_LOGIN_INFO].wrapper;
    
    //是否感恩
    if ([dic getBool:@"HasParent"])
    {
        _thanksLable.text = @"已完成";
    }
    else
    {
        _thanksLable.text = @"未感恩";
    }
    
    //判断手机是否认证
    if ([dic getBool:@"IsPhoneVerified"])
    {
        
    }

}

- (IBAction)touchupBtn:(id)sender
{
    if (sender == _myfansBtn)
    {
        PUSH_VIEWCONTROLLER(ThankFulFansStatisticalViewController);
    }
    else if (sender == _faceforthanksBtn)
    {
        
        DictionaryWrapper* dic =[APP_DELEGATE.runtimeConfig getDictionary:RUNTIME_USER_LOGIN_INFO].wrapper;
        //判断手机是否认证
        if ([dic getBool:@"IsPhoneVerified"])
        {
            [APP_DELEGATE.window addSubview:_blackView];
            _blackView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.95];
            [[UIApplication sharedApplication] setStatusBarHidden:YES];
            
            if ([[UIScreen mainScreen] bounds].size.height < 568)
            {
                _blackviewTwo.frame = CGRectMake(0, 135, 320, 320);
            }
            
            _versionL.text = [NSString stringWithFormat:@"秒赚  V%@",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
            
            //生成二维码
            NSString * HexPhone = [self TenToSixteen:USER_MANAGER.phone];
            NSString * erWeiUrl = [NSString stringWithFormat:@"http://down.inkey.com/Download/Down/%@" , HexPhone];
            _erweimaimage.image = [QRCodeGenerator qrImageForString:erWeiUrl imageSize:_erweimaimage.bounds.size.width];
        }
        else
        {
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"" message:@"发展粉丝前，请先进行手机认证" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"去认证", nil];
            [alert show];
            [alert release];
        }
    }
    else if (sender == _shareBtn)
    {
        DictionaryWrapper* dic =[APP_DELEGATE.runtimeConfig getDictionary:RUNTIME_USER_LOGIN_INFO].wrapper;
        //判断手机是否认证
        if ([dic getBool:@"IsPhoneVerified"])
        {
            [[Share_Method shareInstance] getShareDataWithShareData:@{@"Key":@"b48f4584ef5fb324cf5c4a803ed8e575"}];
        }
        else
        {
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"" message:@"发展粉丝前，请先进行手机认证" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"去认证", nil];
            [alert show];
            [alert release];
        }
    }
    else if (sender == _skillBtn)
    {
        PUSH_VIEWCONTROLLER(WebhtmlViewController);
        model.navTitle = @"发展粉丝小技巧";
        model.ContentCode = @"4cd9847fcc96ea9961e42fb9123bcd26";
    }
    else if (sender == _forthanksBtn)
    {
        PUSH_VIEWCONTROLLER(ThanksGivingViewController);
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        PUSH_VIEWCONTROLLER(PhoneAuthenticationViewController);
    }
}

- (IBAction)blackBtn:(id)sender
{
    [_blackView removeFromSuperview];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
}

-(NSString *)TenToSixteen : (NSString *)tenStr  //10进制字符串转换成16进制字符串
{
    long long tenInt = [tenStr longLongValue];
    NSMutableString * HexStr = [[[NSMutableString alloc] init] autorelease];
    do {
        [HexStr appendString:[NSString stringWithFormat:@"%llx" , tenInt % 16 ]];
        tenInt = tenInt / 16;
    }while (tenInt);
    NSString * hexStr = [self reverseString:HexStr];
    return hexStr;
}

-(NSMutableString *)reverseString : (NSString *)str  //倒序字符串
{
    NSMutableString * reverseStr = [[[NSMutableString alloc] init] autorelease];
    int count = [str length];
    for(int i = count - 1 ; i >= 0 ; i --)
    {
        char c = [str characterAtIndex:i];
        [reverseStr appendString:[NSString stringWithFormat:@"%c" , c]];
    }
    return  reverseStr;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
    [_myfansBtn release];
    [_faceforthanksBtn release];
    [_shareBtn release];
    [_skillBtn release];
    [_forthanksBtn release];
    [_thanksLable release];
    [_blackView release];
    [_erweimaimage release];
    [_blackviewTwo release];
    [_versionL release];
    [super dealloc];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}



@end
