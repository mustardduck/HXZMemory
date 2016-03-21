//
//  AddShippingAddressViewController.m
//  miaozhuan
//
//  Created by apple on 14/12/20.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "AddShippingAddressViewController.h"
#import "PickerViewSelfDefined.h"
@interface AddShippingAddressViewController ()<PickerViewSelfDefineDelegate,UITextFieldDelegate>
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
@property (retain, nonatomic) IBOutlet UITextField *addressTxt;
@property (retain, nonatomic) IBOutlet UITextField *detailAddressTxt;
@property (retain, nonatomic) IBOutlet UITextField *nameTxt;
@property (retain, nonatomic) IBOutlet UITextField *phoneTxt;

@property (retain, nonatomic) IBOutlet UIButton *addressBtn;
- (IBAction)touchUpInsideBtn:(id)sender;

@property (strong, nonatomic) PickerViewSelfDefined *locatePicker;
@end

@implementation AddShippingAddressViewController

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupMoveFowardButtonWithTitle:@"保存"];
    
    [self addDoneToKeyboard:_detailAddressTxt];
    
    [self addDoneToKeyboard:_phoneTxt];
    
    [self addDoneToKeyboard:_nameTxt];
    
    if ([_type isEqualToString:@"2"])
    {
        InitNav(@"修改地址");
        
#define CTJ_ISNIL_DIC(_key) [_detailDic getString:_key]? [_detailDic getString:_key]:@""
        
        Province = CTJ_ISNIL_DIC(@"ProvinceName");
        City = CTJ_ISNIL_DIC(@"CityName");
        District = CTJ_ISNIL_DIC(@"DistrictName");
        
        _addressTxt.text = [NSString stringWithFormat:@"%@ %@ %@",Province,City,District];
        _detailAddressTxt.text = [_detailDic getString:@"Address"];
        
        _nameTxt.text = [_detailDic getString:@"Name"];
        _phoneTxt.text = [_detailDic getString:@"Phone"];
    }
    else
    {
        InitNav(@"新增地址");
    }
}

-(void)hiddenKeyboard
{
    [_detailAddressTxt resignFirstResponder];
    
    [_nameTxt resignFirstResponder];
    
    [_phoneTxt resignFirstResponder];
}

- (IBAction) onMoveFoward:(UIButton*) sender
{
    if ([_addressTxt.text isEqualToString:@""])
    {
        [HUDUtil showErrorWithStatus:@"请选择收货地区"];
        return;
    }
    else if ([_detailAddressTxt.text isEqualToString:@""])
    {
        [HUDUtil showErrorWithStatus:@"请填写详细街道地址"];
        return;
    }
    else if ([_nameTxt.text isEqualToString:@""])
    {
        [HUDUtil showErrorWithStatus:@"请填写收货人"];
        return;
    }
    else if ([_phoneTxt.text isEqualToString:@""])
    {
        [HUDUtil showErrorWithStatus:@"请填写手机号"];
        return;
    }
    else if (_phoneTxt.text.length<11)
    {
        [HUDUtil showErrorWithStatus:@"请填写正确手机号"];
        return;
    }
    else
    {
        if ([_type isEqualToString:@"1"])
        {
            ADAPI_adv3_ShippingAddress_SaveShippingAddress([self genDelegatorID:@selector(HandleNotification:)], @"0", _nameTxt.text, _detailAddressTxt.text, _phoneTxt.text, Province, City, District);
        }
        else
        {
            NSString * shippingId = [NSString stringWithFormat:@"%d",[_detailDic getInt:@"Id"]];
            
             ADAPI_adv3_ShippingAddress_SaveShippingAddress([self genDelegatorID:@selector(HandleNotification:)],shippingId , _nameTxt.text, _detailAddressTxt.text, _phoneTxt.text, Province, City, District);
        }
    }
}

- (void)HandleNotification:(DelegatorArguments *)arguments
{
    if ([arguments isEqualToOperation:ADOP_adv3_ShippingAddress_SaveShippingAddress])
    {
        [arguments logError];
        
        DictionaryWrapper *wrapper = arguments.ret;
        
        if (wrapper.operationSucceed)
        {
            [HUDUtil showSuccessWithStatus:wrapper.operationMessage];
            if (self.block) {
                NSString *fullName = [NSString stringWithFormat:@"%@%@%@%@", Province, City, District, _detailAddressTxt.text];
                NSDictionary *adsInfo = @{@"Id":[wrapper.data getString:@"Id"] ,@"Name":_nameTxt.text,@"FullAddress":fullName,@"Phone":_phoneTxt.text};
                self.block([adsInfo wrapper]);
            }
            [self.navigationController popViewControllerAnimated:YES];
        }
        else if (wrapper.operationPromptCode || wrapper.operationErrorCode)
        {
            [AlertUtil showAlert:@"" message:wrapper.operationMessage buttons:@[@"好的"]];
            return;
        }
    }
}


#pragma mark UITextField

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
{
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    //得到输入框的内容
    if (_phoneTxt == textField)  //判断是否时我们想要限定的那个输入框
    {
        if ([toBeString length] > 11)
        {
            return NO;
        }
    }
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField == _nameTxt || textField == _phoneTxt)
    {
        [self animateTextField: textField up: YES];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == _nameTxt || textField == _phoneTxt)
    {
        [self animateTextField: textField up: NO];
    }
}

- (void) animateTextField: (UITextField*) textField up: (BOOL) up
{
    int movementDistance = 0;
    
    float movementDuration = 0.3f;
    
    if (textField == _nameTxt)
    {
        if ([[UIScreen mainScreen] bounds].size.height < 568)
        {
            movementDistance = 80;
        }
        else
        {
            movementDistance = 80;
        }
    }
    else if (textField == _phoneTxt)
    {
        if ([[UIScreen mainScreen] bounds].size.height < 568)
        {
            movementDistance = 100;
        }
        else
        {
            movementDistance = 150;
        }
    }
    
    int movement = (up ? -movementDistance : movementDistance);
    
    [UIView beginAnimations: @"anim" context: nil];
    
    [UIView setAnimationBeginsFromCurrentState: YES];
    
    [UIView setAnimationDuration: movementDuration];
    
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    
    [UIView commitAnimations];
}



- (IBAction)touchUpInsideBtn:(id)sender
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
            _locatePicker = STRONG_OBJECT(PickerViewSelfDefined, initPickerWithDelegate:self name:THREELEVEL userData:_addressTxt.text array:_locationDataSource);
            [_locatePicker showInView:self.view];
            
            [_locatePicker release];
            _locatePicker = nil;
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
    _addressTxt.text = [NSString stringWithFormat:@"%@ %@ %@", picker.locate.state, picker.locate.city, picker.locate.district];
    
    _provinceRegion = [picker.locate.stateData getInt:@"RegionId"];
    _cityRegion = [picker.locate.cityData getInt:@"RegionId"];
    _areaRegion = [picker.locate.districtData getInt:@"RegionId"];
    
    Province = picker.locate.state;
    City = picker.locate.city;
    District = picker.locate.district;
}

- (void)pickerClearContent:(PickerViewSelfDefined *)picker
{
    _addressTxt.text = picker.userData;
    
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
    [_block release];
    [_locationDataSource release];
    
    _locationDataSource = nil;
    
    [_addressTxt release];
    [_detailAddressTxt release];
    [_nameTxt release];
    [_phoneTxt release];
    [_addressBtn release];
    [super dealloc];
}

- (void)viewDidUnload
{
    [self setAddressTxt:nil];
    [self setDetailAddressTxt:nil];
    [self setNameTxt:nil];
    [self setPhoneTxt:nil];
    [self setAddressBtn:nil];
    [super viewDidUnload];
}

@end
