//
//  ChangeShippingAddressViewController.m
//  miaozhuan
//
//  Created by apple on 14/12/10.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "ChangeShippingAddressViewController.h"

@interface ChangeShippingAddressViewController ()<UITextFieldDelegate>
{
    DictionaryWrapper * result;
}
@property (retain, nonatomic) IBOutlet UITextField *shippingName;
@property (retain, nonatomic) IBOutlet UITextField *shippingPhoneLable;
@property (retain, nonatomic) IBOutlet UITextField *shippingAddressLable;
@property (retain, nonatomic) IBOutlet UITextField *shippingDetailAddressLable;
@property (retain, nonatomic) IBOutlet UITextField *shippingCity;
@property (retain, nonatomic) IBOutlet UITextField *shippingDistrict;

@end

@implementation ChangeShippingAddressViewController

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    InitNav(@"更改收货地址");
    
    [self setupMoveFowardButtonWithTitle:@"保存"];
    
    [self addDoneToKeyboard:_shippingName];
    
    [self addDoneToKeyboard:_shippingPhoneLable];
    
    [self addDoneToKeyboard:_shippingAddressLable];
    
    [self addDoneToKeyboard:_shippingDistrict];
    
    [self addDoneToKeyboard:_shippingCity];
    
    [self addDoneToKeyboard:_shippingDetailAddressLable];
  
    if ([_orderType isEqualToString:@"1"])
    {
        ADAPI_adv3_ExchangeManagement_GetDeliveryAddress([self genDelegatorID:@selector(HandleNotification:)], _OrderNumber);
    }
    else
    {
        ADAPI_adv3_GoldOrder_GetOrderDeliveryAddress([self genDelegatorID:@selector(HandleNotification:)], _OrderNumber);
    }
}

-(void)hiddenKeyboard
{
    [_shippingName resignFirstResponder];
    [_shippingPhoneLable resignFirstResponder];
    [_shippingAddressLable resignFirstResponder];
    [_shippingCity resignFirstResponder];
    [_shippingDistrict resignFirstResponder];
    [_shippingDetailAddressLable resignFirstResponder];
}

- (void)onMoveFoward:(UIButton *)sender
{
    if ([_shippingName.text isEqualToString:@""])
    {
        [HUDUtil showErrorWithStatus:@"请先输入收货人"];
        return;
    }
    else if ([_shippingPhoneLable.text isEqualToString:@""])
    {
        [HUDUtil showErrorWithStatus:@"请先输入电话"];
        return;
    }
    else if ([_shippingAddressLable.text isEqualToString:@""])
    {
        [HUDUtil showErrorWithStatus:@"请先输入省份"];
        return;
    }
    else if ([_shippingCity.text isEqualToString:@""])
    {
        [HUDUtil showErrorWithStatus:@"请先输入城市"];
        return;
    }
    else if ([_shippingDistrict.text isEqualToString:@""])
    {
        [HUDUtil showErrorWithStatus:@"请先输入区县"];
        return;
    }
    else if ([_shippingDetailAddressLable.text isEqualToString:@""])
    {
        [HUDUtil showErrorWithStatus:@"请先输入详细街道"];
        return;
    }
    else
    {
        if ([_orderType isEqualToString:@"1"])
        {
            ADAPI_adv3_ExchangeManagement_ChangeDeliveryAddress([self genDelegatorID:@selector(HandleNotification:)], _OrderNumber, _shippingName.text, _shippingPhoneLable.text, _shippingAddressLable.text, _shippingCity.text, _shippingDistrict.text, _shippingDetailAddressLable.text);
        }
        else
        {
            ADAPI_adv3_GoldOrder_EnterpriseUpdateOrderAddress([self genDelegatorID:@selector(HandleNotification:)], _OrderNumber, _shippingName.text, _shippingPhoneLable.text, _shippingAddressLable.text, _shippingCity.text, _shippingDistrict.text, _shippingDetailAddressLable.text);
        }
    }
}

- (void)HandleNotification:(DelegatorArguments *)arguments
{
    if ([arguments isEqualToOperation:ADOP_adv3_ExchangeManagement_GetDeliveryAddress])
    {
        [arguments logError];
        
        DictionaryWrapper *wrapper = arguments.ret;
        
        if (wrapper.operationSucceed)
        {
            result = wrapper.data;
            [result retain];
            
            [self setResult:result];
        }
        else if (wrapper.operationPromptCode)
        {
            [HUDUtil showErrorWithStatus:wrapper.operationMessage];
        }
    }
    else if ([arguments isEqualToOperation:ADOP_adv3_ExchangeManagement_ChangeDeliveryAddress])
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
    else if ([arguments isEqualToOperation:ADOP_adv3_GoldOrder_GetOrderDeliveryAddress])
    {
        [arguments logError];
        
        DictionaryWrapper *wrapper = arguments.ret;
        
        if (wrapper.operationSucceed)
        {
            result = wrapper.data;
            [result retain];
            
            [self setResult:result];
        }
        else if (wrapper.operationPromptCode)
        {
            [HUDUtil showErrorWithStatus:wrapper.operationMessage];
        }
    }
    else if ([arguments isEqualToOperation:ADOP_adv3_GoldOrder_EnterpriseUpdateOrderAddress])
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


-(void) setResult:(DictionaryWrapper *) changeAddressDic
{
    _shippingName.text = [changeAddressDic getString:@"ContactName"];
    
    _shippingPhoneLable.text = [changeAddressDic getString:@"ContactPhone"];
    
    if ([_orderType isEqualToString:@"1"])
    {
         _shippingAddressLable.text = [changeAddressDic getString:@"Province"];
    }
    else
    {
         _shippingAddressLable.text = [changeAddressDic getString:@"Province"];
    }
    
    _shippingCity.text = [changeAddressDic getString:@"City"];
    
    _shippingDistrict.text = [changeAddressDic getString:@"District"];
    
    _shippingDetailAddressLable.text = [changeAddressDic getString:@"Address"];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField == _shippingCity || textField == _shippingDetailAddressLable || textField == _shippingDistrict || textField == _shippingAddressLable)
    {
        [self animateTextField: textField up: YES];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == _shippingCity || textField == _shippingDetailAddressLable || textField == _shippingDistrict || textField == _shippingAddressLable)
    {
        [self animateTextField: textField up: NO];
    }
}

- (void) animateTextField: (UITextField*) textField up: (BOOL) up
{
    int movementDistance = 0;
    
    float movementDuration = 0.3f;
    
    if (textField == _shippingAddressLable)
    {
        if ([[UIScreen mainScreen] bounds].size.height < 568)
        {
            movementDistance = 130;
        }
        else
        {
            movementDistance = 80;
        }
    }
    else if (textField == _shippingCity)
    {
        if ([[UIScreen mainScreen] bounds].size.height < 568)
        {
            movementDistance = 160;
        }
        else
        {
            movementDistance = 80;
        }
    }
    else if (textField == _shippingDistrict)
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
    else if (textField == _shippingDetailAddressLable)
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

    int movement = (up ? -movementDistance : movementDistance);
    
    [UIView beginAnimations: @"anim" context: nil];
    
    [UIView setAnimationBeginsFromCurrentState: YES];
    
    [UIView setAnimationDuration: movementDuration];
    
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    
    [UIView commitAnimations];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
    [result release];
    
    result = nil;
    
    [_shippingName release];
    [_shippingPhoneLable release];
    [_shippingAddressLable release];
    [_shippingDetailAddressLable release];
    [_shippingCity release];
    [_shippingDistrict release];
    [super dealloc];
}

- (void)viewDidUnload
{
    [self setShippingName:nil];
    [self setShippingPhoneLable:nil];
    [self setShippingAddressLable:nil];
    [self setShippingDetailAddressLable:nil];
    [self setShippingCity:nil];
    [self setShippingDistrict:nil];
    [super viewDidUnload];
}
@end
