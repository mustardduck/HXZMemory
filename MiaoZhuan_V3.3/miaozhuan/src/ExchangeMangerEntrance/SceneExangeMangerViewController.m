//
//  SceneExangeMangerViewController.m
//  miaozhuan
//
//  Created by apple on 14/12/5.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "SceneExangeMangerViewController.h"
#import "UIView+expanded.h"
#import "ExangeResultViewController.h"
#import "ZBarSDK.h"
#import <QuartzCore/QuartzCore.h>
#import "AllSiteExchangeViewController.h"

@interface SceneExangeMangerViewController ()<UITextFieldDelegate,ZBarReaderDelegate>
{
    NSInteger checkup;
}
@property (retain, nonatomic) ZBarReaderViewController *reade;

@property (retain, nonatomic) NSTimer *tiems;

@property (retain, nonatomic) IBOutlet UIButton *saomiaoBtn;

- (IBAction)touchUpInsideBtn:(id)sender;
@property (retain, nonatomic) IBOutlet UIButton *luruBtn;
@property (retain, nonatomic) IBOutlet UIButton *sceneBtn;
@property (retain, nonatomic) IBOutlet UIView *shoeView;


@property (retain, nonatomic) IBOutlet UIView *alertView;
@property (retain, nonatomic) IBOutlet UIView *alertTxtBgView;
@property (retain, nonatomic) IBOutlet UITextField *alertTxt;
@property (retain, nonatomic) IBOutlet UIButton *alertCancelBtn;
@property (retain, nonatomic) IBOutlet UIButton *alertOkBtn;
@property (retain, nonatomic) IBOutlet UIImageView *navBGImage;
@property (retain, nonatomic) IBOutlet UIView *lineImageOne;

@property (retain, nonatomic) IBOutlet UIView *navView;
- (IBAction)alertBtnTouch:(id)sender;
@end

@implementation SceneExangeMangerViewController


#define ORDERNUM @"0123456789-"

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad
{
    [super viewDidLoad];
   
    InitNav(@"现场兑换管理");
    
    _shoeView.hidden = YES;
 
//    [_alertView roundCorner];
    
    _alertView.layer.masksToBounds = YES;
    _alertView.layer.cornerRadius = 8.0;
    _alertView.layer.borderWidth = 0.5;
    _alertView.layer.borderColor = [[UIColor clearColor] CGColor];
    
    _sceneBtn.frame = CGRectMake(0, 0.5, 320, 49.5);
    
    _lineImageOne.frame = CGRectMake(145, 114, 0.5, 45);
    
    _alertCancelBtn.frame = CGRectMake(0, 114.5, 145, 45);
    
    _alertOkBtn.frame = CGRectMake(145.5, 114.5, 145, 45);
    
    [_alertTxtBgView roundCornerBorder];
    
    [self addDoneToKeyboard:_alertTxt];
}

-(void)hiddenKeyboard
{
    [_alertTxt resignFirstResponder];
}

#pragma mark Btn
- (IBAction)touchUpInsideBtn:(id)sender
{
    if (sender == _luruBtn)
    {
        [self.view addSubview:_alertView];
        
        if ([[UIScreen mainScreen] bounds].size.height < 568)
        {
            _alertView.frame = CGRectMake(15, 98, _alertView.width, _alertView.height);
        }
        else
        {
            _alertView.frame = CGRectMake(15, 148, _alertView.width, _alertView.height);
        }
        
        _shoeView.hidden = NO;
    }
    else if(sender == _saomiaoBtn)
    {
#if TARGET_IPHONE_SIMULATOR
        
        //模拟器
        
#elif TARGET_OS_IPHONE
        
        //真机
        _reade = [ZBarReaderViewController new];
        _reade.readerDelegate = self;
        _reade.wantsFullScreenLayout = NO;
        
        _reade.showsZBarControls = NO;
        
        [self setOverlayPickerView:_reade];
        ZBarImageScanner *scanner = _reade.scanner;
        [scanner setSymbology: ZBAR_I25
                       config: ZBAR_CFG_ENABLE
                           to: 0];
        
        [self presentViewController:_reade animated:YES completion:nil];
        
#endif
        


    }
    else if (sender == _sceneBtn)
    {
        PUSH_VIEWCONTROLLER(AllSiteExchangeViewController);
        model.EnterpriseId = _EnterpriseId;
    }
}

- (IBAction)alertBtnTouch:(id)sender
{
    if (sender == _alertCancelBtn)
    {
        [_alertView removeFromSuperview];
        
        _shoeView.hidden = YES;
        
        _alertTxt.text = @"";
    }
    else if (sender == _alertOkBtn)
    {
        if ([_alertTxt.text isEqualToString:@""])
        {
            [HUDUtil showErrorWithStatus:@"请录入订单号！"];
        }
        else
        {
            ADAPI_adv3_ExchangeManagement_GetExchangeRecordDetail([self genDelegatorID:@selector(HandleNotification:)], _alertTxt.text,_ExchangeAddressId);
        }
    }
}


- (void)HandleNotification:(DelegatorArguments *)arguments
{
    if ([arguments isEqualToOperation:ADOP_adv3_ExchangeManagement_GetExchangeRecordDetail])
    {
        [arguments logError];
        
        DictionaryWrapper *wrapper = arguments.ret;
        
        if (wrapper.operationSucceed)
        {
            [_alertView removeFromSuperview];
            
            _shoeView.hidden = YES;
            
            PUSH_VIEWCONTROLLER(ExangeResultViewController);
            
            model.OrderNumber = _alertTxt.text;
            
            model.ExchangeAddressId = _ExchangeAddressId;
            
            _alertTxt.text = @"";
        }
        else if (wrapper.operationPromptCode)
        {
            [HUDUtil showErrorWithStatus:wrapper.operationMessage];
        }
    }
}

#pragma mark UITextField

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField == _alertTxt)
    {
        [self animateTextField: textField up: YES];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == _alertTxt)
    {
        [self animateTextField: textField up: NO];
    }
}

- (void) animateTextField: (UITextField*) textField up: (BOOL) up
{
    int movementDistance = 0;
    
    float movementDuration = 0.3f;
    
    if (textField == _alertTxt)
    {
        if ([[UIScreen mainScreen] bounds].size.height < 568)
        {
            movementDistance = 100;
        }
        else
        {
            movementDistance = 100;
        }
    }
    
    int movement = (up ? -movementDistance : movementDistance);
    
    [UIView beginAnimations: @"anim" context: nil];
    
    [UIView setAnimationBeginsFromCurrentState: YES];
    
    [UIView setAnimationDuration: movementDuration];
    
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    
    [UIView commitAnimations];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (textField == _alertTxt)
    {
        NSCharacterSet*cs;
        
        cs = [[NSCharacterSet characterSetWithCharactersInString:ORDERNUM] invertedSet];
        
        NSString*filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        
        BOOL basicTest = [string isEqualToString:filtered];
        
        if(!basicTest) {
            
            [HUDUtil showErrorWithStatus:@"兑换编码请输入数字或-！"];
            
            return NO;
        }
    }
    
    return YES;
}


#pragma ZBarReaderDelegate
- (BOOL)isAllNum:(NSString *)string{
    unichar c;
    for (int i=0; i<string.length; i++) {
        c=[string characterAtIndex:i];
        if (!isdigit(c)) {
            return NO;
        }
    }
    return YES;
}


- (void) imagePickerController: (UIImagePickerController*) reader
 didFinishPickingMediaWithInfo: (NSDictionary*) info{

    
//    id<NSFastEnumeration> results = nil;
    
//    id<NSFastEnumeration> results = [info objectForKey: ZBarReaderControllerResults];

#if TARGET_IPHONE_SIMULATOR
    
    //模拟器
    id<NSFastEnumeration> results = nil;
    
#elif TARGET_OS_IPHONE
    
    //真机
    id<NSFastEnumeration> results = [info objectForKey: ZBarReaderControllerResults];
    
#endif
    
    
    ZBarSymbol *symbol = nil;
    
    for(symbol in results)
        break;
    
    
    NSString *te = symbol.data;
    
    
    if([te length] > 0){
        
        [_tiems invalidate];
        
        _tiems = nil;
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
        if (![self isAllNum:te]) {
            
            [HUDUtil showErrorWithStatus:@"记录不存在！"];
            return;
        }
       
        NSString *key = te;
        
        key = [key stringByReplacingOccurrencesOfString:@" " withString:@""];
        
        if ([key length] == 0)
        {
            
            [HUDUtil showErrorWithStatus:@"未找到该商品！"];
            
            return;
        }
        
        PUSH_VIEWCONTROLLER(ExangeResultViewController);
        
        model.OrderNumber = key;
        
        model.ExchangeAddressId = _ExchangeAddressId;
    }
}

- (void)setOverlayPickerView:(ZBarReaderViewController *)read{
    
    for (UIView *temp in [read.view subviews]) {
        
        for (UIButton *button in [temp subviews]) {
            
            if ([button isKindOfClass:[UIButton class]]) {
                
                [button removeFromSuperview];
            }
        }
        
        for (UIToolbar *toolbar in [temp subviews]) {
            
            if ([toolbar isKindOfClass:[UIToolbar class]]) {
                
                [toolbar setHidden:YES];
                
                [toolbar removeFromSuperview];
                
            }
        }
    }
    
    //最上部view
    
    UIView* upView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 64)];
    
    [read.view addSubview:upView];
    
    //导航View
        
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        self.navBGImage.image = [UIImage imageNamed:@"*_*_defaultNavigationBackground.png"];
        
    }
    else
    {
        self.navBGImage.image = [UIImage imageNamed:@"*_06_defaultNavigationBackground.png"];
    }
    
    [upView addSubview:self.navView];
    
    [upView release];
    
    
    UIView* labView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, 320, 75)];
    
    labView.backgroundColor = [UIColor blackColor];
    
    labView.alpha = 0.7;
    
    [read.view addSubview:labView];
    
    
    //用于说明的label
    
    UILabel * labIntroudction= [[UILabel alloc] init];
    
    labIntroudction.backgroundColor = [UIColor clearColor];
    
    labIntroudction.frame=CGRectMake(15, 9, 290, 50);
    
    labIntroudction.font = Font(15);
    
    labIntroudction.textColor=[UIColor whiteColor];
    
    labIntroudction.numberOfLines=2;
    
    labIntroudction.text=@"将二维码图像置于矩形方框内，离手机摄像头10CM左右，系统会自动识别。";
    
    //labIntroudction.text=@"将二维码放到框内，即可自动扫描";
    
    [labView addSubview:labIntroudction];
    
    [labIntroudction release];
    
    [labView release];
    
    //左侧的view
    
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 139, 35, 250)];
    
    leftView.alpha = 0.7;
    
    leftView.backgroundColor = [UIColor blackColor];
    
    [read.view addSubview:leftView];
    
    [leftView release];
    
    //右侧的view
    
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(285, 139, 35, 250)];
    
    rightView.alpha = 0.7;
    
    rightView.backgroundColor = [UIColor blackColor];
    
    [read.view addSubview:rightView];
    
    [rightView release];
    
    //底部view
    
    UIView * downView = [[UIView alloc] initWithFrame:CGRectMake(0, 389, 320, 184)];
    
    downView.alpha = 0.7;
    
    downView.backgroundColor = [UIColor blackColor];
    
    [read.view addSubview:downView];
    
    [downView release];
    
    //用于取消操作的button
    UIImageView *scannerbg=[[UIImageView alloc] initWithFrame:CGRectMake(35, 139, 250, 250)];
    [scannerbg setImage:[UIImage imageNamed:@"scanner_frame.png"]];
    [scannerbg setBackgroundColor:[UIColor clearColor]];
    [read.view addSubview:scannerbg];
    [scannerbg release];
    
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    //    cancelButton.alpha = 0.4;
    
    [cancelButton setFrame:CGRectMake(35, 430, 250, 38)];
    
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    cancelButton.layer.cornerRadius = 5.0f;
    
    if ([[[UIDevice currentDevice] systemVersion] intValue] >= 5.0)
    {
        [cancelButton setBackgroundColor:RGBCOLOR(240, 5, 0)];
    }
    
    [cancelButton.titleLabel setFont:[UIFont boldSystemFontOfSize:20]];
    
    [cancelButton addTarget:self action:@selector(dismissOverlayView:)forControlEvents:UIControlEventTouchUpInside];
    
    [read.view addSubview:cancelButton];
    
    //画中间的基准线
    
    UIView* line = [[UIView alloc] initWithFrame:CGRectMake(40, 215, 240, 10)];
    
    line.backgroundColor = [UIColor clearColor];
    UIImageView *imae=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"scanning_line.png"]];
    [line addSubview:imae];
    [imae release];
    line.tag=100;
    [read.view addSubview:line];
    [line release];
    _tiems=[NSTimer scheduledTimerWithTimeInterval:0.02 target:self selector:@selector(yidong:) userInfo:nil repeats:YES];
}


#pragma mark -- QR code scan

-(void)yidong:(UIImageView *)gun
{
    UIView *viewDemo = (UIView*)[_reade.view  viewWithTag:100];
    
    if(viewDemo.frame.origin.y==374)
    {
        checkup=1;
    }
    if(viewDemo.frame.origin.y==144)
    {
        checkup=0;
    }
    CGRect ge=viewDemo.frame;
    if(checkup==0)
    {
        ge.origin.y=ge.origin.y+1;
    }
    if(checkup==1)
    {
        ge.origin.y=ge.origin.y-1;
    }
    viewDemo.frame=ge;
}

- (void)dismissOverlayView:(id)sender{
    
    [_tiems invalidate];
    
    _tiems = nil;
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
    [_reade release];
    [_saomiaoBtn release];
    [_luruBtn release];
    [_sceneBtn release];
    [_alertView release];
    [_alertTxtBgView release];
    [_alertTxt release];

    [_alertCancelBtn release];
    [_alertOkBtn release];
    [_shoeView release];
    [_navView release];
    [_navBGImage release];
    [_lineImageOne release];
    [super dealloc];
}
- (void)viewDidUnload
{
    [self setSaomiaoBtn:nil];
    [self setLuruBtn:nil];
    [self setSceneBtn:nil];
    [self setAlertView:nil];
    [self setAlertTxtBgView:nil];
    [self setAlertTxt:nil];
    [self setAlertCancelBtn:nil];
    [self setAlertOkBtn:nil];
    [self setShoeView:nil];
    [super viewDidUnload];
}

@end
