//
//  ShippingViewController.m
//  miaozhuan
//
//  Created by apple on 14/12/10.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "ShippingViewController.h"
#import "Redbutton.h"
#import "RRAttributedString.h"
#import "IndustryPicker.h"
#import "WatingShippingViewController.h"

@interface ShippingViewController ()<IndustryPickerDelegate,UIAlertViewDelegate>
{
    NSMutableArray * _wuliuArray;
    
    IndustryPicker *industryPicker;
    
    CGFloat offsetY;
    
    int tag;
    
    int choiceTag;
    
    DictionaryWrapper * result ;
    
    NSArray * _arrwithWuLiu;
}
@property (retain, nonatomic) IBOutlet Redbutton *shippingBtn;
- (IBAction)touchUpInsideBtn:(id)sender;
@property (retain, nonatomic) IBOutlet UIScrollView *mainScroller;

@property (retain, nonatomic) IBOutlet UIView *wuliuView;
@property (retain, nonatomic) IBOutlet UITextField *wuliuTxt;
@property (retain, nonatomic) IBOutlet UITextField *yundanhaoTxt;
@property (retain, nonatomic) IBOutlet UIButton *wuliuBtn;
@property (retain, nonatomic) IBOutlet UIImageView *daosanjiaoImage;

@property (retain, nonatomic) IBOutlet UIView *shippingView;
@property (retain, nonatomic) IBOutlet UILabel *shippingName;
@property (retain, nonatomic) IBOutlet UILabel *shippingPhone;
@property (retain, nonatomic) IBOutlet UILabel *shippingAddress;
@property (retain, nonatomic) IBOutlet UILabel *shippingaddressLable;

@property (retain, nonatomic) IBOutlet UIView *viewOne;
@property (retain, nonatomic) IBOutlet UIView *viewTwo;

- (IBAction)choiceBtn:(id)sender;
@property (retain, nonatomic) IBOutlet UIButton *choicebtnOne;
@property (retain, nonatomic) IBOutlet UIButton *choicebtnTwo;
@property (retain, nonatomic) IBOutlet UIImageView *imageOne;
@property (retain, nonatomic) IBOutlet UIImageView *imageTwo;

@property (retain, nonatomic) IBOutlet UITextField *wuliuTxtshuru;
@end

@implementation ShippingViewController

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    InitNav(@"发货");
    [_mainScroller addSubview:_shippingView];
    
    [_mainScroller addSubview:_wuliuView];
    
    _shippingView.frame = CGRectMake(0, 10, _shippingView.width, _shippingView.height);
    
    _wuliuView.frame = CGRectMake(0, 20 + _shippingView.height, _wuliuView.width, _wuliuView.height);
    
    _shippingBtn.frame = CGRectMake(15, 30 + _wuliuView.height + _shippingView.height, 290, 40);
    
    [_mainScroller setContentSize:CGSizeMake(320, _wuliuView.height + _shippingView.height + _shippingBtn.height + 40)];
    
    offsetY = [UICommon getIos4OffsetY];
    
    tag = 1;
    
    choiceTag = 1;
    
    [self addDoneToKeyboard:_yundanhaoTxt];

    [self addDoneToKeyboard:_wuliuTxtshuru];
    
    if ([_orderType isEqualToString:@"1"])
    {
        ADAPI_adv3_ExchangeManagement_GetDeliveryAddress([self genDelegatorID:@selector(HandleNotification:)], _OrderNumber);
    }
    else
    {
        ADAPI_adv3_GoldOrder_GetOrderDeliveryAddress([self genDelegatorID:@selector(HandleNotification:)], _OrderNumber);
    }
    
    //获取物流
    ADAPI_adv3_MyGoldMall_GetCompanys([self genDelegatorID:@selector(HandleNotification:)]);
}

-(void)hiddenKeyboard
{
    [_yundanhaoTxt resignFirstResponder];
    [_wuliuTxtshuru resignFirstResponder];
}

-(void) setResult:(DictionaryWrapper *) dic
{
    _shippingName.text = [NSString stringWithFormat:@"收货人：%@",[dic getString:@"ContactName"]];
    
    _shippingPhone.text = [NSString stringWithFormat:@"电话：%@",[dic getString:@"ContactPhone"]];
    
    
#define CTJ_ISNIL_DIC(_key) [dic getString:_key]? [dic getString:_key]:@""
    
    NSString * Province = CTJ_ISNIL_DIC(@"Province");
    NSString * City = CTJ_ISNIL_DIC(@"City");
    NSString * District = CTJ_ISNIL_DIC(@"District");
    NSString * Address = CTJ_ISNIL_DIC(@"Address");
    
    _shippingAddress.text = [NSString stringWithFormat:@"%@%@%@%@",Province,City,District,Address];
    
    if (_shippingAddress.text.length <= 19)
    {
        _shippingaddressLable.frame = CGRectMake(15, 151, 60, 20);
    }
    
    NSAttributedString * attributedStringname= [RRAttributedString setText:_shippingName.text color:RGBCOLOR(153, 153, 153) range:NSMakeRange(0, 4)];
    
    _shippingName.attributedText = attributedStringname;
    
    NSAttributedString * attributedStringphone= [RRAttributedString setText:_shippingPhone.text color:RGBCOLOR(153, 153, 153) range:NSMakeRange(0, 3)];
    
    _shippingPhone.attributedText = attributedStringphone;
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
    else if ([arguments isEqualToOperation:ADOP_adv3_ExchangeManagement_ConfirmExchange])
    {
        [arguments logError];
        
        DictionaryWrapper *wrapper = arguments.ret;
        
        if (wrapper.operationSucceed)
        {
            [HUDUtil showSuccessWithStatus:wrapper.operationMessage];
            
            if (_delegate && [_delegate respondsToSelector:@selector(stateShouldBeChange:)])
            {
                [_delegate stateShouldBeChange:@"3"];
            }
            [self.navigationController popViewControllerAnimated:YES];
        }
        else if(wrapper.operationPromptCode || wrapper.operationErrorCode)
        {
            [AlertUtil showAlert:@"" message:wrapper.operationMessage buttons:@[@"好的"]];
        }
    }
    else if ([arguments isEqualToOperation:ADOP_adv3_MyGoldMall_GetCompanys])
    {
        [arguments logError];
        
        DictionaryWrapper *wrapper = arguments.ret;
        
        if (wrapper.operationSucceed)
        {
            if (!_wuliuArray)
            {
                _wuliuArray = [NSMutableArray new];
            }
            
            NSArray * arr = wrapper.data;
            
            NSString * wuliu = nil;
            
            for (int i = 0; i< [arr count]; i++)
            {
                wuliu = [[[arr objectAtIndex:i]wrapper]getString:@"CompanyName"];
                
                [_wuliuArray addObject:wuliu];
            }
            
        }
        else if(wrapper.operationPromptCode || wrapper.operationErrorCode)
        {
            [AlertUtil showAlert:@"" message:wrapper.operationMessage buttons:@[@"好的"]];
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
    else if ([arguments isEqualToOperation:ADOP_adv3_GoldOrder_EnterpriseDeliver])
    {
        [arguments logError];
        
        DictionaryWrapper *wrapper = arguments.ret;
        
        if (wrapper.operationSucceed)
        {
            [HUDUtil showSuccessWithStatus:wrapper.operationMessage];
            
            if (_delegate && [_delegate respondsToSelector:@selector(stateShouldBeChange:)])
            {
                [_delegate stateShouldBeChange:@"301"];
            }
            
            if ([_type isEqualToString:@"1"])
            {
                NSLog(@"------%@",self.navigationController.viewControllers);
                
                for (UIViewController *vc in self.navigationController.viewControllers)
                {
                    if ([vc isKindOfClass:[WatingShippingViewController class]])
                    {
                        [self.navigationController popToViewController:vc animated:YES];
                        break;
                    }
                }
            }
            else
            {
                [self.navigationController popViewControllerAnimated:YES];
            }
        }
        else if(wrapper.operationPromptCode || wrapper.operationErrorCode)
        {
            [AlertUtil showAlert:@"" message:wrapper.operationMessage buttons:@[@"好的"]];
        }
    }
}

-(void) setPickerViewWith :(NSString *) title
{
    industryPicker = [[IndustryPicker alloc]initWithStyle:self pickerData:_wuliuArray];
    
    [industryPicker initwithtitles:0];
    
    industryPicker.frame = CGRectMake(0, 0, 320, 460 + offsetY);
    
    industryPicker.delegate = self;
    
    [self.view addSubview:industryPicker];
}

- (void)pickerIndustryOk:(IndustryPicker *)picker
{
    _wuliuTxt.text = picker.curText;
    
    [picker removeFromSuperview];
    
    [industryPicker release];
    
    industryPicker = nil;
}

- (void)pickerIndustryCancel:(IndustryPicker *)picker{
    
    [picker removeFromSuperview];
    
    [industryPicker release];
    
    industryPicker = nil;
}


- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField == _yundanhaoTxt)
    {
        [self animateTextField: textField up: YES];
    }
    else if (textField == _wuliuTxtshuru)
    {
        [self animateTextField: textField up: YES];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == _yundanhaoTxt)
    {
        [self animateTextField: textField up: NO];
    }
    else if (textField == _wuliuTxtshuru)
    {
        [self animateTextField: textField up: NO];
    }
}

- (void) animateTextField: (UITextField*) textField up: (BOOL) up
{
    int movementDistance = 0;
    
    float movementDuration = 0.3f;
    
    if (textField == _yundanhaoTxt)
    {
        if ([[UIScreen mainScreen] bounds].size.height < 568)
        {
            movementDistance = 275;
        }
        else
        {
            movementDistance = 155;
        }
    }
    else if (textField == _wuliuTxtshuru)
    {
        if ([[UIScreen mainScreen] bounds].size.height < 568)
        {
            movementDistance = 275;
        }
        else
        {
            movementDistance = 155;
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
    if (sender == _wuliuBtn)
    {
        if (tag == 1)
        {
            
            tag = 2;
        }
        else
        {
        
            tag = 1;
        }
        
        [self setPickerViewWith:@""];
        
    }
    else if(sender == _shippingBtn)
    {
        if (choiceTag == 1)
        {
            if ([_wuliuTxt.text isEqualToString:@""])
            {
                [HUDUtil showErrorWithStatus:@"请选择物流公司"];
                return;
            }
            else if ([_yundanhaoTxt.text isEqualToString:@""])
            {
                [HUDUtil showErrorWithStatus:@"请录入运单号"];
                return;
            }
            else
            {
                UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"" message:@"您确定向用户发货了吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                [alert show];
                [alert release];
            }
        }
        else
        {
            if ([_wuliuTxtshuru.text isEqualToString:@""])
            {
                [HUDUtil showErrorWithStatus:@"请输入物流公司名称"];
                return;
            }
            else if ([_yundanhaoTxt.text isEqualToString:@""])
            {
                [HUDUtil showErrorWithStatus:@"请录入运单号"];
                return;
            }
            else
            {
                UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"" message:@"您确定向用户发货了吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                [alert show];
                [alert release];
            }
        }
    }
}

- (IBAction)choiceBtn:(id)sender
{
    if (sender == _choicebtnOne)
    {
        _viewOne.hidden = YES;
        _viewTwo.hidden = NO;
        _imageOne.image = [UIImage imageNamed:@"rank-03.png"];
        _imageTwo.image = [UIImage imageNamed:@"rank-02.png"];
        
        choiceTag = 1;
    }
    else if (sender == _choicebtnTwo)
    {
        _viewTwo.hidden = YES;
        _viewOne.hidden = NO;
        _imageOne.image = [UIImage imageNamed:@"rank-02.png"];
        _imageTwo.image = [UIImage imageNamed:@"rank-03.png"];
        
        choiceTag = 2;
    }
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        if ([_orderType isEqualToString:@"1"])
        {
            if (choiceTag == 1)
            {
                ADAPI_adv3_ExchangeManagement_ConfirmExchange([self genDelegatorID:@selector(HandleNotification:)], _EnterpriseId, _OrderNumber, @"0", _wuliuTxt.text, _yundanhaoTxt.text);
            }
            else
            {
                ADAPI_adv3_ExchangeManagement_ConfirmExchange([self genDelegatorID:@selector(HandleNotification:)], _EnterpriseId, _OrderNumber, @"0", _wuliuTxtshuru.text, _yundanhaoTxt.text);
            }
        }
        else
        {
            if (choiceTag == 1)
            {
                ADAPI_adv3_GoldOrder_EnterpriseDeliver([self genDelegatorID:@selector(HandleNotification:)], _OrderNumber, _wuliuTxt.text, _yundanhaoTxt.text);
            }
            else
            {
                ADAPI_adv3_GoldOrder_EnterpriseDeliver([self genDelegatorID:@selector(HandleNotification:)], _OrderNumber, _wuliuTxtshuru.text, _yundanhaoTxt.text);
            }
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
    [result release];
    result = nil;
    [_wuliuArray release];
    
    _wuliuArray = nil;
    
    [_shippingBtn release];
    [_wuliuView release];
    [_mainScroller release];
    [_wuliuTxt release];
    [_yundanhaoTxt release];
    [_shippingView release];
    [_shippingName release];
    [_shippingPhone release];
    [_shippingAddress release];
    [_shippingaddressLable release];
    [_wuliuBtn release];
    [_daosanjiaoImage release];
    [_viewOne release];
    [_viewTwo release];
    [_choicebtnOne release];
    [_choicebtnTwo release];
    [_wuliuTxtshuru release];
    [_imageOne release];
    [_imageTwo release];
    [super dealloc];
}

- (void)viewDidUnload
{
    [self setShippingBtn:nil];
    [self setWuliuView:nil];
    [self setMainScroller:nil];
    [self setWuliuTxt:nil];
    [self setYundanhaoTxt:nil];
    [self setShippingView:nil];
    [self setShippingName:nil];
    [self setShippingPhone:nil];
    [self setShippingAddress:nil];
    [super viewDidUnload];
}


@end
