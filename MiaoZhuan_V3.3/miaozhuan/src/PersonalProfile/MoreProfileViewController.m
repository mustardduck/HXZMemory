//
//  MoreProfileViewController.m
//  miaozhuan
//
//  Created by apple on 14/11/28.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "MoreProfileViewController.h"
#import "PickerViewSelfDefined.h"
#import "RRLineView.h"

@interface MoreProfileViewController ()<UITextFieldDelegate,PickerViewSelfDefineDelegate>
{
    DictionaryWrapper* dic;
    
    NSArray* _locationDataSource;
    
    int _provinceRegion;
    
    int _cityRegion;
    
    int _areaRegion;
    
    NSString * Province;
    NSString * City;
    NSString * District;
}
@property (retain, nonatomic) IBOutlet UITextField *otherPhoneTxtField;
@property (retain, nonatomic) IBOutlet UITextField *emailTxtField;
@property (retain, nonatomic) IBOutlet UITextField *qqTxtField;
@property (retain, nonatomic) IBOutlet UITextField *weiboTxtField;
@property (retain, nonatomic) IBOutlet UITextField *weixinTxtField;
@property (retain, nonatomic) IBOutlet UIView *bgView;
@property (retain, nonatomic) IBOutlet RRLineView *lineImage;

- (IBAction)addressBtnTouch:(id)sender;

@property (strong, nonatomic) PickerViewSelfDefined *locatePicker;

@property (retain, nonatomic) IBOutlet UILabel *addressLable;

@end

@implementation MoreProfileViewController
@synthesize otherPhoneTxtField = _otherPhoneTxtField;
@synthesize emailTxtField = _emailTxtField;
@synthesize qqTxtField = _qqTxtField;
@synthesize weiboTxtField= _weiboTxtField;
@synthesize weixinTxtField = _weixinTxtField;
@synthesize bgView = _bgView;
@synthesize addressLable = _addressLable;
@synthesize locatePicker = _locatePicker;


MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    InitNav(@"更多资料");
    
    [self addDoneToKeyboard:_otherPhoneTxtField];
    [self addDoneToKeyboard:_emailTxtField];
    [self addDoneToKeyboard:_qqTxtField];
    [self addDoneToKeyboard:_weiboTxtField];
    [self addDoneToKeyboard:_weixinTxtField];
    
    _lineImage.top = 299.5;
    
    dic =[APP_DELEGATE.runtimeConfig getDictionary:RUNTIME_USER_LOGIN_INFO].wrapper;
    
    [dic retain];
    
    _otherPhoneTxtField.text = [dic getString:@"OtherPhone"];
    _emailTxtField.text = [dic getString:@"Email"];
    _qqTxtField.text = [dic getString:@"QQ"];
    _weiboTxtField.text = [dic getString:@"Weibo"];
    _weixinTxtField.text = [dic getString:@"Weixin"];
    
#define CTJ_ISNIL_DIC(_key) [dic getString:_key]? [dic getString:_key]:@""
    
    Province = CTJ_ISNIL_DIC(@"Province");
    City = CTJ_ISNIL_DIC(@"City");
    District = CTJ_ISNIL_DIC(@"District");
    
    _addressLable.text = [NSString stringWithFormat:@"%@ %@ %@",Province,City,District];
}

-(void)hiddenKeyboard
{
    [_otherPhoneTxtField resignFirstResponder];
    [_emailTxtField resignFirstResponder];
    [_qqTxtField resignFirstResponder];
    [_weiboTxtField resignFirstResponder];
    [_weixinTxtField resignFirstResponder];
}

- (IBAction) onMoveBack:(UIButton *)sender
{
    if (_otherPhoneTxtField.text.length != 0)
    {
        if (_otherPhoneTxtField.text.length !=7 && _otherPhoneTxtField.text.length !=8 &&_otherPhoneTxtField.text.length !=10 &&_otherPhoneTxtField.text.length !=11 &&_otherPhoneTxtField.text.length !=12)
        {
            [HUDUtil showErrorWithStatus:@"请填写正确的电话号码"];
            return;
        }
    }
    if (![_emailTxtField.text isEqualToString:@""])
    {
        if (![self CheckInput:_emailTxtField.text])
        {
            [HUDUtil showErrorWithStatus:@"请输入正确的邮箱地址"];
            return;
        }
    }
    
    
#define CTJ_ISNIL_DIC(_key) [dic getString:_key]? [dic getString:_key]:@""
    
    NSString * str = [NSString stringWithFormat:@"%@ %@ %@",CTJ_ISNIL_DIC(@"Province"),CTJ_ISNIL_DIC(@"City"),CTJ_ISNIL_DIC(@"District")];
    
    if (![_otherPhoneTxtField.text isEqualToString:[dic getString:@"OtherPhone"]] || ![_emailTxtField.text isEqualToString:[dic getString:@"Email"]] || ![_qqTxtField.text isEqualToString:[dic getString:@"QQ"]] || ![_weiboTxtField.text isEqualToString:[dic getString:@"Weibo"]] || ![_weixinTxtField.text isEqualToString:[dic getString:@"Weixin"]] || ![_addressLable.text isEqualToString:str])
    {
        //有一项改动
        [[NSUserDefaults standardUserDefaults] setObject:@"1"  forKey:@"ChangeUsers"];
        
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    else
    {
        [[NSUserDefaults standardUserDefaults] setObject:@"0"  forKey:@"ChangeUsers"];
        
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    if (![_otherPhoneTxtField.text isEqualToString:[dic getString:@"OtherPhone"]])
    {
        [APP_DELEGATE.runtimeConfig set:RUNTIME_USER_LOGIN_INFO".OtherPhone" string:_otherPhoneTxtField.text];
    }
    if (![_emailTxtField.text isEqualToString:[dic getString:@"Email"]])
    {
        [APP_DELEGATE.runtimeConfig set:RUNTIME_USER_LOGIN_INFO".Email" string:_emailTxtField.text];
    }
    if (![_qqTxtField.text isEqualToString:[dic getString:@"QQ"]])
    {
        [APP_DELEGATE.runtimeConfig set:RUNTIME_USER_LOGIN_INFO".QQ" string:_qqTxtField.text];
    }
    if (![_weiboTxtField.text isEqualToString:[dic getString:@"Weibo"]])
    {
        [APP_DELEGATE.runtimeConfig set:RUNTIME_USER_LOGIN_INFO".Weibo" string:_weiboTxtField.text];
    }
    if (![_weixinTxtField.text isEqualToString:[dic getString:@"Weixin"]])
    {
        [APP_DELEGATE.runtimeConfig set:RUNTIME_USER_LOGIN_INFO".Weixin" string:_weixinTxtField.text];
    }
    if (![_addressLable.text isEqualToString:@""])
    {
        
        NSLog(@"---province-%@---%@---%@",Province,City,District);
        
        //省市区编号
        [APP_DELEGATE.runtimeConfig set:RUNTIME_USER_LOGIN_INFO".ProvinceId" string:[NSString stringWithFormat:@"%d",_provinceRegion]];
        [APP_DELEGATE.runtimeConfig set:RUNTIME_USER_LOGIN_INFO".CityId" string:[NSString stringWithFormat:@"%d",_cityRegion]];
        [APP_DELEGATE.runtimeConfig set:RUNTIME_USER_LOGIN_INFO".DistrictId" string:[NSString stringWithFormat:@"%d",_areaRegion]];
        
        //省市区名字
        [APP_DELEGATE.runtimeConfig set:RUNTIME_USER_LOGIN_INFO".Province" string:Province];
        [APP_DELEGATE.runtimeConfig set:RUNTIME_USER_LOGIN_INFO".City" string:City];
        [APP_DELEGATE.runtimeConfig set:RUNTIME_USER_LOGIN_INFO".District" string:District];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
{
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string]; //得到输入框的内容
    if (_otherPhoneTxtField == textField)  //判断是否时我们想要限定的那个输入框
    {
        if ([toBeString length] > 12)
        {
            return NO;
        }
    }
    return YES;
}


-(BOOL)CheckInput:(NSString *)_text
{
    NSString *Regex=@"[A-Z0-9a-z._%+-]+@[A-Z0-9a-z._]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest=[NSPredicate predicateWithFormat:@"SELF MATCHES %@",Regex];
    return [emailTest evaluateWithObject:_text];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField == _weixinTxtField || textField == _weiboTxtField || textField == _emailTxtField || textField == _qqTxtField)
    {
        [self animateTextField: textField up: YES];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == _weixinTxtField || textField == _weiboTxtField || textField == _emailTxtField || textField == _qqTxtField)
    {
        [self animateTextField: textField up: NO];
    }
}

- (void) animateTextField: (UITextField*) textField up: (BOOL) up
{
    int movementDistance = 0;
    
    float movementDuration = 0.3f;
    
    if (textField == _weiboTxtField)
    {
        if ([[UIScreen mainScreen] bounds].size.height < 568)
        {
            movementDistance = 140;
        }
        else
        {
            movementDistance = 80;
        }
    }
    else if (textField == _weixinTxtField)
    {
        if ([[UIScreen mainScreen] bounds].size.height < 568)
        {
            movementDistance = 190;
        }
        else
        {
            movementDistance = 150;
        }
    }
    else if (textField == _emailTxtField)
    {
        if ([[UIScreen mainScreen] bounds].size.height < 568)
        {
            movementDistance = 80;
        }
        else
        {
            movementDistance = 0;
        }
    }
    else if (textField == _qqTxtField)
    {
        if ([[UIScreen mainScreen] bounds].size.height < 568)
        {
            movementDistance = 100;
        }
        else
        {
            movementDistance = 0;
        }
    }
    
    int movement = (up ? -movementDistance : movementDistance);
    
    [UIView beginAnimations: @"anim" context: nil];
    
    [UIView setAnimationBeginsFromCurrentState: YES];
    
    [UIView setAnimationDuration: movementDuration];
    
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    
    [UIView commitAnimations];
}

- (IBAction)addressBtnTouch:(id)sender
{
    ADAPI_RegionGetAllBaiduRegionList([self genDelegatorID:@selector(handleRegionList:)]);
}

- (void)handleRegionList:(DelegatorArguments*)arguments {
    
    DictionaryWrapper *wrapper = arguments.ret;
    if (wrapper.operationSucceed)
    {
        [_locationDataSource release];
        _locationDataSource = [wrapper.data retain];
        
        if (!_locatePicker)
        {
            _locatePicker = STRONG_OBJECT(PickerViewSelfDefined, initPickerWithDelegate:self name:THREELEVEL userData:_addressLable.text array:_locationDataSource);
            [_locatePicker showInView:self.view];
            
            [_locatePicker release];
            _locatePicker = nil;
            
            [self hiddenKeyboard];
        }
    }
    else if(wrapper.operationPromptCode || wrapper.operationErrorCode)
    {
        
        [HUDUtil showErrorWithStatus:wrapper.operationMessage];
    }
}

#pragma mark - pickerdelegate
- (void)pickerDidChangeContent:(PickerViewSelfDefined *)picker
{
    _addressLable.text = [NSString stringWithFormat:@"%@ %@ %@", picker.locate.state, picker.locate.city, picker.locate.district];
    
    _provinceRegion = [picker.locate.stateData getInt:@"RegionId"];
    _cityRegion = [picker.locate.cityData getInt:@"RegionId"];
    _areaRegion = [picker.locate.districtData getInt:@"RegionId"];
    
    Province = picker.locate.state;
    City = picker.locate.city;
    District = picker.locate.district;
    
}

- (void)pickerClearContent:(PickerViewSelfDefined *)picker
{
    _addressLable.text = picker.userData;
    
    Province = picker.locate.state;
    City = picker.locate.city;
    District = picker.locate.district;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
    [dic release];
    
    dic = nil;
    
    [_locationDataSource release];
    
    _locationDataSource = nil;
    
    [_otherPhoneTxtField release];
    [_emailTxtField release];
    [_qqTxtField release];
    [_weiboTxtField release];
    [_weixinTxtField release];
    [_bgView release];
    [_addressLable release];
    [_lineImage release];
    [super dealloc];
}

- (void)viewDidUnload
{
    
    
    [self setOtherPhoneTxtField:nil];
    [self setEmailTxtField:nil];
    [self setQqTxtField:nil];
    [self setWeiboTxtField:nil];
    [self setWeixinTxtField:nil];
    [self setBgView:nil];
    [self setAddressLable:nil];
    [super viewDidUnload];
}


@end
