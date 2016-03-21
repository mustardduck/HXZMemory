//
//  ChooseLoticticsViewController.m
//  miaozhuan
//
//  Created by Santiago on 15-1-4.
//  Copyright (c) 2015年 zdit. All rights reserved.
//

#import "ChooseLoticticsViewController.h"
#import "PickerViewSelfDefined.h"
@interface ChooseLoticticsViewController ()<PickerViewSelfDefineDelegate, UITextFieldDelegate>{

    BOOL _ifUseListInput;
}
@property (strong, nonatomic) NSArray *logicticsDataSource;
@property (retain, nonatomic) IBOutlet UIImageView *arrowImage;
@property (retain, nonatomic) IBOutlet UITextField *orderNumberTextField;
@property (strong, nonatomic) PickerViewSelfDefined *logicticsPicker;
@property (strong, nonatomic) WDictionaryWrapper *postData;

@property (retain, nonatomic) IBOutlet UITextField *chooseLogicticsTextField;

@property (retain, nonatomic) IBOutlet UIView *UILineView1;
@property (retain, nonatomic) IBOutlet UIView *UILineView2;


@property (retain, nonatomic) IBOutlet UIImageView *chooseLogicticsByListImage;
@property (retain, nonatomic) IBOutlet UIImageView *chooseLogicticsByTextFieldImage;

@end

@implementation ChooseLoticticsViewController
@synthesize logicticsDataSource = _logicticsDataSource;
@synthesize chooseLogicticsTextField = _chooseLogicticsTextField;
@synthesize arrowImage = _arrowImage;
@synthesize orderNumberTextField = _orderNumberTextField;
@synthesize logicticsPicker = _logicticsPicker;
@synthesize postData = _postData;
@synthesize orderId = _orderId;
@synthesize chooseLogicticsByListImage = _chooseLogicticsByListImage;
@synthesize chooseLogicticsByTextFieldImage = _chooseLogicticsByTextFieldImage;
@synthesize UILineView2 = _UILineView2;
MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self getLogicticsList];
    [self addDoneToKeyboard:_orderNumberTextField];
    [self addDoneToKeyboard:_chooseLogicticsTextField];
    [self setupMoveBackButton];
    [self setTitle:@"请录入物流信息"];
    self.postData = WEAK_OBJECT(WDictionaryWrapper, init);
    [_UILineView1 setFrame:CGRectMake(0, [_UILineView1 superview].size.height - 0.5, 320, 0.5)];
    _ifUseListInput = YES;
    [_UILineView2 setHeight:0.5];
}

- (void)hiddenKeyboard {

    [_orderNumberTextField resignFirstResponder];
    [_chooseLogicticsTextField resignFirstResponder];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {

    [_orderNumberTextField resignFirstResponder];
    [_chooseLogicticsTextField resignFirstResponder];
}

//选择输入物流公司方式
- (IBAction)chooseLogicticsByList:(id)sender {
    
    [self.chooseLogicticsByListImage setImage:[UIImage imageNamed:@"rank-03.png"]];
    [self.chooseLogicticsByTextFieldImage setImage:[UIImage imageNamed:@"rank-02.png"]];
    self.arrowImage.hidden = NO;
    _ifUseListInput = YES;
    self.chooseLogicticsTextField.placeholder = @"选择你发货的物流公司";
    self.chooseLogicticsTextField.text = @"";
    [self.postData set:@"CompanyName" string:nil];
}

- (IBAction)chooseLogicticsByTextField:(id)sender {
    
    [self.chooseLogicticsByListImage setImage:[UIImage imageNamed:@"rank-02.png"]];
    [self.chooseLogicticsByTextFieldImage setImage:[UIImage imageNamed:@"rank-03.png"]];
    self.arrowImage.hidden = YES;
    _ifUseListInput = NO;
    self.chooseLogicticsTextField.placeholder = @"输入物流公司名称";
    self.chooseLogicticsTextField.text = @"";
    [self.postData set:@"CompanyName" string:nil];
}

//获取物流公司列表
- (void)getLogicticsList {
    
    ADAPI_LogisticsCompanyData([self genDelegatorID:@selector(getData:)]);
}

- (void)getData:(DelegatorArguments*)arguments {
    
    DictionaryWrapper *wrapper = arguments.ret;
    
    if (wrapper.operationSucceed) {
        
        self.logicticsDataSource = wrapper.data;
    }else {
        
        [HUDUtil showErrorWithStatus:@"获取邮递公司数据失败！"];
    }
}

//确认退货
- (IBAction)confirmToReturn:(id)sender {
    
    [self.postData set:@"OrderId" string:[NSString stringWithFormat:@"%d",_orderId]];
    
    if ([[_postData getString:@"CompanyName"] isEqualToString:@""]||![_postData getString:@"CompanyName"]) {
        
        [HUDUtil showErrorWithStatus:@"请选择物流公司"];
        return;
    }
    
    if ([[_postData getString:@"BillNo"]isEqualToString:@""]||![_postData getString:@"BillNo"]) {
        
        [HUDUtil showErrorWithStatus:@"请手动输入订单号"];
        return;
    }
    
    ADAPI_ConfirmReturn([self genDelegatorID:@selector(postDataRequest:)],_postData.dictionary);
}

- (void)postDataRequest:(DelegatorArguments*)arguments {

    DictionaryWrapper *wrapper = arguments.ret;
    
    if (wrapper.operationSucceed) {
        
        [HUDUtil showSuccessWithStatus:@"操作成功"];
        [self.delagate refresh];
        [self.navigationController popViewControllerAnimated:YES];
    }else {
    
        [HUDUtil showErrorWithStatus:@"操作失败"];
    }
}

#pragma mark - PickerViewSelfDefinedDelagate
- (void)pickerDidChangeContent:(PickerViewSelfDefined *)picker {
    
    NSString *text = [[picker.locate.normalData wrapper] getString:@"CompanyName"];
    
    if (!text.length) {
        NSInteger index = [picker.locatePicker selectedRowInComponent:0];
        text = _logicticsDataSource[index][@"CompanyName"];
    }
    
    self.chooseLogicticsTextField.text = text;
    
    [self.postData set:@"CompanyName" string:text];
}
- (void)endOperating {

    self.arrowImage.image = [UIImage imageNamed:@"littleDown.png"];
}

- (void)pickerClearContent:(PickerViewSelfDefined *)picker {

    self.chooseLogicticsTextField.text = [[_logicticsDataSource[0] wrapper] getString:@"CompanyName"];
    [self.postData set:@"CompanyName" string:[[_logicticsDataSource[0] wrapper] getString:@"CompanyName"]];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {

     NSString * aString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if (textField.tag == 1) {
     
        [self.postData set:@"CompanyName" string:aString];
    }
    if (textField.tag == 2) {
        
        [self.postData set:@"BillNo" string:aString];
    }
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {

    if (textField.tag == 1) {
        
        if (_ifUseListInput) {
            
            if (!_logicticsPicker) {
                
                self.logicticsPicker = STRONG_OBJECT(PickerViewSelfDefined, initPickerWithDelegate:self name:NORMALPICKERVIEWSTYLE userData:nil array:_logicticsDataSource);
                [_logicticsPicker showInView:self.view];
                [_logicticsPicker release];
                self.logicticsPicker = nil;
            }
            self.arrowImage.image = [UIImage imageNamed:@"littleUp.png"];
            return NO;
        }
    }
    return YES;
}

#pragma mark -TextViewDelegate
- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    self.delagate = nil;
    [_logicticsDataSource release];
    [_chooseLogicticsTextField release];
    [_arrowImage release];
    [_orderNumberTextField release];
    [_UILineView1 release];
    [_chooseLogicticsByListImage release];
    [_chooseLogicticsByTextFieldImage release];
    [_postData release];
    [_UILineView2 release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setLogicticsDataSource:nil];
    [super viewDidUnload];
}
@end
