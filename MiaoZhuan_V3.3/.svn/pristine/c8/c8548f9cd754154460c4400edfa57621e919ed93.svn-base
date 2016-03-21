//
//  DetailShippingViewController.m
//  miaozhuan
//
//  Created by apple on 14/12/22.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "DetailShippingViewController.h"
#import "Redbutton.h"
#import "AddShippingAddressViewController.h"

@interface DetailShippingViewController ()<UIAlertViewDelegate>
{
    DictionaryWrapper * result;
}
@property (retain, nonatomic) IBOutlet UILabel *addressLable;
@property (retain, nonatomic) IBOutlet UILabel *detailAddresslable;
@property (retain, nonatomic) IBOutlet UILabel *nameLable;
@property (retain, nonatomic) IBOutlet UILabel *phoneLable;
@property (retain, nonatomic) IBOutlet UIButton *deleteBtn;
- (IBAction)touchUpinside:(id)sender;
@property (retain, nonatomic) IBOutlet Redbutton *morenBtn;

@end

@implementation DetailShippingViewController

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    InitNav(@"收货地址");
    
    _deleteBtn.frame = CGRectMake(0, 0.5, 320, 49.5);
    
    [self setupMoveFowardButtonWithTitle:@"编辑"];
}

-(void)viewWillAppear:(BOOL)animated
{
    ADAPI_adv3_ShippingAddress_GetShippingAddress([self genDelegatorID:@selector(HandleNotification:)], _shippingId);
}

- (IBAction) onMoveFoward:(UIButton*) sender
{
    PUSH_VIEWCONTROLLER(AddShippingAddressViewController);
    model.type = @"2";
    model.detailDic = result;
}

- (IBAction)touchUpinside:(id)sender
{
    if (sender == _deleteBtn)
    {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"" message:@"确认删除本收货地址吗" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
        [alert show];
        [alert release];
    }
    else if (sender == _morenBtn)
    {
        ADAPI_adv3_ShippingAddress_SetPrimary([self genDelegatorID:@selector(HandleNotification:)], _shippingId);
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        ADAPI_adv3_ShippingAddress_DeleteShippingAddress([self genDelegatorID:@selector(HandleNotification:)], _shippingId);
    }
}

- (void)HandleNotification:(DelegatorArguments *)arguments
{
    if ([arguments isEqualToOperation:ADOP_adv3_ShippingAddress_GetShippingAddress])
    {
        [arguments logError];
        
        DictionaryWrapper *wrapper = arguments.ret;
        
        if (wrapper.operationSucceed)
        {
            result = wrapper.data;
            [result retain];
            [self getResult:result];
        }
        else if (wrapper.operationPromptCode || wrapper.operationErrorCode)
        {
            [AlertUtil showAlert:@"" message:wrapper.operationMessage buttons:@[@"好的"]];
            return;
        }
    }
    else if ([arguments isEqualToOperation:ADOP_adv3_ShippingAddress_SetPrimary])
    {
        [arguments logError];
        
        DictionaryWrapper *wrapper = arguments.ret;
        
        if (wrapper.operationSucceed)
        {
            [HUDUtil showSuccessWithStatus:wrapper.operationMessage];
            
            [self.navigationController popViewControllerAnimated:YES];
        }
        else if (wrapper.operationPromptCode || wrapper.operationErrorCode)
        {
            [AlertUtil showAlert:@"" message:wrapper.operationMessage buttons:@[@"好的"]];
            return;
        }
    }
    else if ([arguments isEqualToOperation:ADOP_adv3_ShippingAddress_DeleteShippingAddress])
    {
        [arguments logError];
        
        DictionaryWrapper *wrapper = arguments.ret;
        
        if (wrapper.operationSucceed)
        {
            [HUDUtil showSuccessWithStatus:wrapper.operationMessage];
            
            [self.navigationController popViewControllerAnimated:YES];
        }
        else if (wrapper.operationPromptCode || wrapper.operationErrorCode)
        {
            [AlertUtil showAlert:@"" message:wrapper.operationMessage buttons:@[@"好的"]];
            return;
        }
    }
}

-(void) getResult:(DictionaryWrapper *) dic
{
#define CTJ_ISNIL_DIC(_key) [dic getString:_key]? [dic getString:_key]:@""
    
    NSString * Province = CTJ_ISNIL_DIC(@"ProvinceName");
    NSString * City = CTJ_ISNIL_DIC(@"CityName");
    NSString * District = CTJ_ISNIL_DIC(@"DistrictName");

    _addressLable.text = [NSString stringWithFormat:@"%@ %@ %@",Province,City,District];
    _detailAddresslable.text = [dic getString:@"Address"];
    _nameLable.text = [dic getString:@"Name"];
    _phoneLable.text = [dic getString:@"Phone"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
    [result release];
    [_addressLable release];
    [_detailAddresslable release];
    [_nameLable release];
    [_phoneLable release];
    [_deleteBtn release];
    [_morenBtn release];
    [super dealloc];
}

- (void)viewDidUnload
{
    [self setAddressLable:nil];
    [self setDetailAddresslable:nil];
    [self setNameLable:nil];
    [self setPhoneLable:nil];
    [self setDeleteBtn:nil];
    [self setMorenBtn:nil];
    [super viewDidUnload];
}

@end
