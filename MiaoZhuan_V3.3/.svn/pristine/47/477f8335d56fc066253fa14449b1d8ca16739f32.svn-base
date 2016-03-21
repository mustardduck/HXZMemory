//
//  CommonSettingViewController.m
//  miaozhuan
//
//  Created by abyss on 14/11/24.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "CommonSettingViewController.h"
#import "AlertPasswordViewController.h"
#import "CRLabel.h"
#import "CRFileUtil.h"
#import "LoginViewController.h"
#import "SetUpNewPwdViewController.h"
#import "VoiceControl.h"
#import "PlaySound.h"
#import "SharedData.h"
#import "ZhiFuPwdMainController.h"
#import "UserInfo.h"
#import "ZhiFuPwdEditController.h"
#import "ZhiFuPwdYanZhengViewController.h"
#import "PhoneAuthenticationViewController.h"

@interface CommonSettingViewController ()<cr_LabelDelegate,UIAlertViewDelegate>
@property (retain, nonatomic) IBOutlet CRLabel *chacheLabel;
@property (retain, nonatomic) IBOutlet UISwitch *swith_autoClean;
@property (retain, nonatomic) IBOutlet UISwitch *swith_sound;

@end

@implementation CommonSettingViewController

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _swith_autoClean.on = [[NSUserDefaults standardUserDefaults] boolForKey:cr_CACHE_AUTOCLEAR];
    _swith_sound.on = [VoiceControl isOpen];

    [self configureChacheLabel];
    InitNav(@"通用设置");
}

- (void)configureChacheLabel
{
    _chacheLabel.delegate = self;
    _chacheLabel.isAnimatingNumbers = NO;
    _chacheLabel.hasUnit = NO;
    _chacheLabel.randAnmation = NO;
    _chacheLabel.numbers = [self getCacheSize];
}

- (IBAction)goToZhiFuPW:(id)sender
{
    int status = USER_MANAGER.setPayPwdStatus;
    
    //是否进行手机认证
    if (USER_MANAGER.IsPhoneVerified == YES)
    {
        if(status == 0)//未设置支付密码
        {
            PUSH_VIEWCONTROLLER(ZhiFuPwdYanZhengViewController);
        }
        else
        {
            PUSH_VIEWCONTROLLER(ZhiFuPwdMainController);
        }
    }
    else
    {
//        PUSH_VIEWCONTROLLER(PhoneAuthenticationViewController);
        [AlertUtil showAlert:@"" message:@"您尚未通过手机认证，无法设置支付密码" buttons:@[
                                                                       @{
                                                                           @"title":@"去认证",
                                                                           @"delegator":ALERT_VIEW_DELEGATOR_BLOCK
                                                                           ({
            PUSH_VIEWCONTROLLER(PhoneAuthenticationViewController);
        })
                                                                           },@"取消"
                                                                       
                                                                       ]];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)alertPassword:(id)sender
{
    
    PUSH_VIEWCONTROLLER(SetUpNewPwdViewController);
    model.type = @"2";
}

- (float) getCacheSize
{
    float size = 0.0f;
    NSArray * paths= [CRFileUtil getCachePaths];
    for(NSString * path in paths)
    {
        size += [CRFileUtil folderSizeAtPath:path];
    }
    
    if (size < 50) {
        
        return 0;
    }else {
    
        return size;
    }
}

- (IBAction)clear:(id)sender
{
    [PlaySound playSound:@"ClearCacheV" type:@"mp3"];
    
    NSArray * paths= [CRFileUtil getCachePaths];
    for(NSString * path in paths)
    {
        [CRFileUtil deleteDirectory:path];
    }
    CGFloat size = [self getCacheSize];
    [_chacheLabel jumpNumberWithDuration:2 from:_chacheLabel.numbers to:size];
    
    [PathUtil rebuildDatabase];
}

- (void)label:(CRLabel *)label shouldPrintfResultSelf:(CGFloat)numbers
{
    if (numbers < 1024)
    {
        label.text = [NSString stringWithFormat:@"%.1f KB",numbers];
    }
    else
    {
        label.text = [NSString stringWithFormat:@"%.2f MB",numbers/1024.f];
    }
}

- (IBAction)quit:(id)sender {
    
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"" message:@"确定退出当前登录" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
    [alert release];
}

- (void)HandleNotification:(DelegatorArguments *)arguments{
    
    if ([arguments isEqualToOperation:ADOP_adv3_Logout]) {
        
        [arguments logError];
        DictionaryWrapper *wrapper = arguments.ret;
        if (wrapper.operationSucceed){
            
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"" message:@"确定退出当前登录" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [alert show];
            [alert release];
        }
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        [SharedData getInstance].isUserLogoutManual = YES;
        [APP_DELEGATE setUserState:USER_STATE_LOGOUT];
        
        PUSH_VIEWCONTROLLER(LoginViewController);
        
        [APP_DELEGATE.persistConfig set:USER_INFO_NAME value: @""];
        [APP_DELEGATE.persistConfig set:USER_INFO_PASSWORD value: @""];
    }
}

- (void)dealloc
{
    _chacheLabel.delegate = nil;
    [_chacheLabel release];
    [_swith_autoClean release];
    [_swith_sound release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setChacheLabel:nil];
    [super viewDidUnload];
}

- (IBAction)swithSound:(id)sender
{
    [VoiceControl openTheSound:_swith_sound.isOn];
//    [[NSUserDefaults standardUserDefaults] removeObjectForKey:cr_SOUND_TURN];
//    [[NSUserDefaults standardUserDefaults] setBool:_swith_sound.on  forKey:cr_SOUND_TURN];
//    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (IBAction)swithClean:(id)sender
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:cr_CACHE_AUTOCLEAR];
    [[NSUserDefaults standardUserDefaults] setBool:_swith_autoClean.isOn  forKey:cr_CACHE_AUTOCLEAR];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
