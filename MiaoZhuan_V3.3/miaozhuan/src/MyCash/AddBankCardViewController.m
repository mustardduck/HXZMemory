//
//  AddBankCardViewController.m
//  miaozhuan
//
//  Created by Santiago on 14-11-19.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "AddBankCardViewController.h"
#import "PickerViewSelfDefined.h"
#import "Redbutton.h"
#import "ApplyToGetCashViewController.h"
@interface AddBankCardViewController () <UITextFieldDelegate, PickerViewSelfDefineDelegate> {

    BOOL _bottomTextFieldBeginEditing;
}
@property (strong, nonatomic)NSArray *locationDataSource;
@property (strong, nonatomic)NSString *province;
@property (strong, nonatomic)NSString *city;
@property (strong, nonatomic)NSString *area;

@property (strong, nonatomic) PickerViewSelfDefined *locatePicker;
@property (strong, nonatomic) WDictionaryWrapper *postData;
@property (retain, nonatomic) IBOutlet UITextField *nameTextField;
@property (retain, nonatomic) IBOutlet UITextField *locationTextField;
@property (retain, nonatomic) IBOutlet UITextField *cardIdTextField;
@property (retain, nonatomic) IBOutlet UITextField *bankDetailTextField;
@property (retain, nonatomic) IBOutlet UIScrollView *mainScrollerView;

@property (retain, nonatomic) IBOutlet UIView *UILineView1;
@property (retain, nonatomic) IBOutlet UIView *UILineView2;
@property (retain, nonatomic) IBOutlet UIView *UILineView3;
@property (retain, nonatomic) IBOutlet UIView *UILineView4;
@property (retain, nonatomic) IBOutlet UIView *UILineView5;
@property (retain, nonatomic) IBOutlet UIView *UILineView6;

@end

@implementation AddBankCardViewController
@synthesize locatePicker = _locatePicker;
@synthesize locationTextField = _locationTextField;
@synthesize nameTextField = _nameTextField;
@synthesize cardIdTextField = _cardIdTextField;
@synthesize bankDetailTextField = _bankDetailTextField;
@synthesize postData = _postData;
@synthesize locationDataSource = _locationDataSource;
@synthesize province = _province;
@synthesize city = _city;
@synthesize area = _area;
@synthesize mainScrollerView = _mainScrollerView;
@synthesize dataSource = _dataSource;
@synthesize dicDataSource = _dicDataSource;
@synthesize UILineView1 = _UILineView1;
@synthesize UILineView2 = _UILineView2;
@synthesize UILineView3 = _UILineView3;
@synthesize UILineView4 = _UILineView4;
@synthesize UILineView5 = _UILineView5;
@synthesize UILineView6 = _UILineView6;

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupMoveBackButton];
    [self setTitle:@"添加银行卡"];
    
    [self addDoneToKeyboard:_nameTextField];
    [self addDoneToKeyboard:_cardIdTextField];
    [self addDoneToKeyboard:_bankDetailTextField];
    
    self.postData = WEAK_OBJECT(WDictionaryWrapper, init);
    
    [self.UILineView1 setSize:CGSizeMake(320, 0.5)];
    [self.UILineView2 setSize:CGSizeMake(250, 0.5)];
    [self.UILineView3 setSize:CGSizeMake(250, 0.5)];
    [self.UILineView4 setSize:CGSizeMake(250, 0.5)];
    [self.UILineView5 setSize:CGSizeMake(250, 0.5)];
    [self.UILineView6 setFrame:CGRectMake(0, 254.5, 320, 0.5)];
    
    //增加监听，当键盘出现或改变时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    //增加监听，当键退出时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
}

- (void)keyboardWillShow:(NSNotification *)aNotification {

    //获取键盘的高度
    if (_bottomTextFieldBeginEditing) {
        
        NSDictionary *userInfo = [aNotification userInfo];
        NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
        CGRect keyboardRect = [aValue CGRectValue];
        int height = keyboardRect.size.height;
        
        int moreHeight;
        if ([[UIScreen mainScreen] bounds].size.height <= 480) {
            
            moreHeight = 70;
        }else {
            
            moreHeight = 0;
        }
        
        [UIView animateWithDuration:0.25 animations:^{
            [self.mainScrollerView setContentOffset:CGPointMake(0,height-200+moreHeight)];
        }];
    }
}

- (void)keyboardWillHide:(NSNotification *)aNotification {

    //获取键盘的高度
    if (_bottomTextFieldBeginEditing) {
        
        [UIView animateWithDuration:0.25 animations:^{
            [self.mainScrollerView setContentOffset:CGPointMake(0, 0)];
        }];
    }
}
//保存
- (IBAction)saveAndPostData:(id)sender {

    [self.postData set:@"BankType" string:@"0"];

    ADAPI_AddNewBankCard([self genDelegatorID:@selector(postData:)],_postData.dictionary);
}
//提交
- (void)postData:(DelegatorArguments*)arguments {

    DictionaryWrapper *wrapper = arguments.ret;
    
    if (wrapper.operationSucceed) {
        
        if ([_dataSource count] > 0) {
            
            [self.delegate refreshBankList];
            [self.navigationController popViewControllerAnimated:YES];
        }else {
        
            int identifyStatus = [APP_DELEGATE.runtimeConfig getInt:RUNTIME_USER_LOGIN_INFO".IdentityStatus"];
            
            if (identifyStatus == 1 && [APP_DELEGATE.runtimeConfig getInt:RUNTIME_USER_LOGIN_INFO".haveGetCashPermission"] == 1) {
                
                ApplyToGetCashViewController *temp = WEAK_OBJECT(ApplyToGetCashViewController, init);
                temp.dataSource = _dataSource;
                temp.dicDataSource = _dicDataSource;
                [APP_DELEGATE.runtimeConfig set:RUNTIME_USER_LOGIN_INFO".IFHAVEONLYONEBANKCARD" int:1];
                [self.navigationController pushViewController:temp animated:YES];
            }else {
            
                [self.delegate refreshBankList];
                [self.navigationController popViewControllerAnimated:YES];
            }
        }
    }else {
    
        [HUDUtil showErrorWithStatus:wrapper.operationMessage];
    }
}

- (void)hiddenKeyboard {

    [_nameTextField resignFirstResponder];
    [_cardIdTextField resignFirstResponder];
    [_bankDetailTextField resignFirstResponder];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {

    switch (textField.tag) {
            
            //姓名
        case 1:
            
            break;
            
            //卡号
        case 2:
            
            break;
            
            //地区
        case 3:{
            [_cardIdTextField resignFirstResponder];
            [_nameTextField resignFirstResponder];
            [_bankDetailTextField resignFirstResponder];
            if ([[APP_DELEGATE.runtimeConfig getArray:RUNTIME_USER_LOGIN_INFO".LocationArray"] count] > 0) {
                
                self.locationDataSource = [APP_DELEGATE.runtimeConfig getArray:RUNTIME_USER_LOGIN_INFO".LocationArray"];
                if (!_locatePicker) {
                    
                    self.locatePicker = STRONG_OBJECT(PickerViewSelfDefined, initPickerWithDelegate:self name:THREELEVEL userData:_locationTextField.text array:_locationDataSource);
                    [_locatePicker showInView:self.view];
                    
                    [_locatePicker release];
                    self.locatePicker = nil;
                }
            }else {
            
                ADAPI_RegionGetAllBaiduRegionList([self genDelegatorID:@selector(handleRegionList:)]);
            }
            return NO;
        }
            //开户行
        case 4:
            _bottomTextFieldBeginEditing = YES;
            
            break;
        default:
            break;
    }
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {

    switch (textField.tag) {
            
        case 1:
            
            [self.postData set:@"AccountName" string:textField.text];
            break;
            
        case 2:
            
            [self.postData set:@"AccountNumber" string:textField.text];
            break;
            
        case 3:
            break;
            
        case 4:
            
            _bottomTextFieldBeginEditing = NO;
            [self.postData set:@"BankName" string:textField.text];
            break;
        default:
            break;
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [_nameTextField resignFirstResponder];
    [_locationTextField resignFirstResponder];
    [_cardIdTextField resignFirstResponder];
    [_bankDetailTextField resignFirstResponder];
    [super touchesBegan:touches withEvent:event];
}


- (void)handleRegionList:(DelegatorArguments*)arguments {
    
    DictionaryWrapper *wrapper = arguments.ret;
    if (wrapper.operationSucceed) {

        self.locationDataSource = wrapper.data;
        
        [APP_DELEGATE.runtimeConfig set:RUNTIME_USER_LOGIN_INFO".LocationArray" value:_locationDataSource];
        
        if (!_locatePicker) {
            
            self.locatePicker = STRONG_OBJECT(PickerViewSelfDefined, initPickerWithDelegate:self name:THREELEVEL userData:_locationTextField.text array:_locationDataSource);
            [_locatePicker showInView:self.view];
            
            [_locatePicker release];
            self.locatePicker = nil;
        }
    }else{
        
        [HUDUtil showErrorWithStatus:wrapper.operationMessage];
    }
}
#pragma mark - pickerdelegate
- (void)pickerDidChangeContent:(PickerViewSelfDefined *)picker {
    
    self.locationTextField.text = [NSString stringWithFormat:@"%@ %@ %@", picker.locate.state, picker.locate.city, picker.locate.district];
    self.province = picker.locate.state;
    self.city = picker.locate.city;
    self.area = picker.locate.district;
    [self.postData set:@"Province" string:_province];
    [self.postData set:@"City" string:_city];
    [self.postData set:@"BankAddress" string:_area];
}

- (void)pickerClearContent:(PickerViewSelfDefined *)picker {
    
    self.locationTextField.text = picker.userData;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)dealloc {
    self.delegate = nil;
    [_area release];
    [_city release];
    [_province release];
    [_locationDataSource release];
    [_postData release];
    [_locationTextField release];
    [_nameTextField release];
    [_cardIdTextField release];
    [_bankDetailTextField release];
    [_mainScrollerView release];
    [_UILineView1 release];
    [_UILineView2 release];
    [_UILineView3 release];
    [_UILineView4 release];
    [_UILineView5 release];
    [_UILineView6 release];
    [super dealloc];
}
@end
