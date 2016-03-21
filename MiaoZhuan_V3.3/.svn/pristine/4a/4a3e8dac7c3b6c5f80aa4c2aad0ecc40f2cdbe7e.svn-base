//
//  ApplyToGetCashViewController.m
//  miaozhuan
//
//  Created by Santiago on 14-11-18.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "ApplyToGetCashViewController.h"
#import "ApplyToGetCash2ViewController.h"
#import "ChooseBankCardViewController.h"
#import "UIView+expanded.h"
#import "Redbutton.h"


#define NUMBERS @"0123456789.\n"
@interface ApplyToGetCashViewController () <GetChoosedBankCard, UITextFieldDelegate>
@property (retain, nonatomic) IBOutlet UILabel *labelLeft;
@property (retain, nonatomic) IBOutlet UILabel *labelMiddle;
@property (retain, nonatomic) IBOutlet UILabel *choosedBankLabel;
@property (retain, nonatomic) IBOutlet UITextField *getCashTextField;
@property (strong, nonatomic) DictionaryWrapper *choosedBankCard;

@property (retain, nonatomic) IBOutlet UIView *UILineView1;
@property (retain, nonatomic) IBOutlet UIView *UILineView2;
@property (retain, nonatomic) IBOutlet UIView *UILineView3;
@property (retain, nonatomic) IBOutlet UIView *UILineView4;

@property (retain, nonatomic) IBOutlet Redbutton *buttonNext;

@property (assign,nonatomic) int inputNumber;
@property (retain, nonatomic) IBOutlet UIButton *button0;
@property (retain, nonatomic) IBOutlet UIButton *button1;



@end

@implementation ApplyToGetCashViewController
@synthesize labelLeft = _labelLeft;
@synthesize labelMiddle = _labelMiddle;
@synthesize dataSource = _dataSource;
@synthesize choosedBankLabel = _choosedBankLabel;
@synthesize getCashTextField = _getCashTextField;
@synthesize choosedBankCard = _choosedBankCard;
@synthesize dicDataSource = _dicDataSource;
MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setupMoveBackButton];
    [self setTitle:@"申请提现"];
    [self setUpLabel:[NSString stringWithFormat:@"￥%.2f",[[_dicDataSource wrapper] getFloat:@"Balance"]]];
    [self addDoneToKeyboard:_getCashTextField];
    [self.UILineView1 setFrame:CGRectMake(0, 0, 320, 0.5)];
    [self.UILineView2 setFrame:CGRectMake(0, 49.5, 320, 0.5)];
    [self.UILineView3 setFrame:CGRectMake(0, 0, 320, 0.5)];
    [self.UILineView4 setFrame:CGRectMake(0, 104.5, 320, 0.5)];
    
    [self.getCashTextField roundCorner];
    
    self.inputNumber = 10;
    
    self.getCashTextField.layer.borderColor = [RGBCOLOR(204, 204, 204) CGColor];
}

- (void)viewWillAppear:(BOOL)animated {
    
    ADAPI_GetBankCardList([self genDelegatorID:@selector(getBankList:)]);
}

- (IBAction)buttonClick:(UIButton *)sender {
    
    if (sender.tag == 0) {
        
        if(_inputNumber - 10 > 0){
            _inputNumber = _inputNumber / 10 * 10  - 10;
            _getCashTextField.text = [NSString stringWithFormat:@"%d",_inputNumber];
        }else{
           
        }
       
    }else if(sender.tag == 1){
        _inputNumber = _inputNumber / 10 * 10 + 10;
        _getCashTextField.text = [NSString stringWithFormat:@"%d",_inputNumber];
    }else{
    
    }
}

- (void)getBankList:(DelegatorArguments*)arguments {
    
    DictionaryWrapper *wrapper = arguments.ret;
    NSArray *bankCardListX = wrapper.data;
    if (wrapper.operationSucceed) {
        
        if ([APP_DELEGATE.userConfig get:@"ChoosedGetCashBankCardData"]) {
            
            self.choosedBankLabel.text = [NSString stringWithFormat:@"农业银行 尾号%@",[[[APP_DELEGATE.userConfig get:@"ChoosedGetCashBankCardData"] wrapper] getString:@"AccountNumberEnd"]];
            self.choosedBankCard = [[APP_DELEGATE.userConfig get:@"ChoosedGetCashBankCardData"] wrapper];
        }else if([bankCardListX count] >= 1){
            
            [APP_DELEGATE.userConfig set:@"ChoosedGetCashBankCardData" value:bankCardListX[0]];
            self.choosedBankLabel.text = [NSString stringWithFormat:@"农业银行 尾号%@",[[[APP_DELEGATE.userConfig get:@"ChoosedGetCashBankCardData"] wrapper] getString:@"AccountNumberEnd"]];
            self.choosedBankCard = [[APP_DELEGATE.userConfig get:@"ChoosedGetCashBankCardData"] wrapper];
        }else {
        
            self.choosedBankLabel.text = @"未设置";
        }
    }else {
        [HUDUtil showWithStatus:wrapper.operationMessage];
    }
}


- (void)hiddenKeyboard {
    
    [_getCashTextField resignFirstResponder];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [_getCashTextField resignFirstResponder];
    [super touchesBegan:touches withEvent:event];
}
#pragma mark - GetChoosedBankCardDelegate
- (void)choosedBankCardData:(NSDictionary*)dic {

    self.choosedBankCard = dic.wrapper;
    self.choosedBankLabel.text = [NSString stringWithFormat:@"农业银行 尾号%@",[dic.wrapper getString:@"AccountNumberEnd"]];
    
    [APP_DELEGATE.userConfig set:@"ChoosedGetCashBankCardData" value:dic];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    _inputNumber = [textField.text integerValue];
    
    NSCharacterSet *cs;
    
    cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS] invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    BOOL basicTest = [string isEqualToString:filtered];
    
    if(!basicTest) {
        [HUDUtil showErrorWithStatus:@"请输入正确的金额!"];
        return NO;
    }
    
    if ([string isEqual:@"0"]&&[_getCashTextField.text isEqualToString:@""]) {
        [HUDUtil showErrorWithStatus:@"请输入正确的金额"];
        return NO;
    }
    
    NSMutableString * futureString = [NSMutableString stringWithString:textField.text];
    [futureString  insertString:string atIndex:range.location];
    
    NSInteger flag=0;
    const NSInteger limited = 2;
    for (int i = (int)futureString.length-1; i>=0; i--) {
        
        if ([futureString characterAtIndex:i] == '.') {
            
            if (flag > limited) {
                return NO;
            }
            
            break;
        }
        flag++;
    }
    
    NSString * aString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if ([aString length] > 15) {
        
        [HUDUtil showErrorWithStatus:@"最多输入15位数字，且小数点后保留两位"];
        return NO;
    }
    return YES;
}

- (IBAction)chooseBankCard:(id)sender {
    
    ChooseBankCardViewController *temp = STRONG_OBJECT(ChooseBankCardViewController, init);
    temp.dataSource = _dataSource;
    temp.delegate = self;
    [self.navigationController pushViewController:temp animated:YES];
    [temp release];
}

- (void)setUpLabel:(NSString*)middleString{

    _labelMiddle.text = middleString;
    CGSize temp = [middleString sizeWithFont:_labelMiddle.font constrainedToSize:CGSizeMake(MAXFLOAT, _labelMiddle.frame.size.height) lineBreakMode:NSLineBreakByWordWrapping];
    [_labelMiddle setFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width-temp.width-15, _labelMiddle.frame.origin.y, temp.width + 15, temp.height)];
    [_labelLeft setOrigin:CGPointMake([[UIScreen mainScreen] bounds].size.width-90-temp.width, 190)];
}

- (IBAction)nextStep:(id)sender {
    
    if([[_dicDataSource wrapper] getFloat:@"Balance"] < [self.getCashTextField.text floatValue]){
        [HUDUtil showErrorWithStatus:@"余额不足"]; return;
    }
    
    
    ADAPI_CashStatement([self genDelegatorID:@selector(getUrl:)]);
}

- (void)getUrl:(DelegatorArguments*)arguments
{
    DictionaryWrapper *wrapper = arguments.ret;
    DictionaryWrapper *item = wrapper.data;
    if (wrapper.operationSucceed)
    {
        float moneyLeft = [item getFloat:@"Balance"];
        moneyLeft = floor(moneyLeft*100)/100;
        
        if ([_getCashTextField.text intValue]<10) {
            
            [HUDUtil showErrorWithStatus:@"最低提现金额为十元"];
            return;
        }else if(moneyLeft < [_getCashTextField.text floatValue]){
            
            [HUDUtil showErrorWithStatus:@"余额不足！"];
            return;
        }else{
            
            if (_choosedBankCard) {
                
                ApplyToGetCash2ViewController *temp = WEAK_OBJECT(ApplyToGetCash2ViewController, init);
                temp.bankCardData = _choosedBankCard;
                temp.cashCount = [_getCashTextField.text floatValue];
                [self.navigationController pushViewController:temp animated:YES];
            }else {
                
                [HUDUtil showErrorWithStatus:@"请选择银行卡"];
            }
        }
    }
    else if(wrapper.operationErrorCode || wrapper.operationPromptCode)
    {
        [HUDUtil showErrorWithStatus:wrapper.operationMessage];
    }
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}
- (void)dealloc {
    [_dicDataSource release];
    [_choosedBankCard release];
    [_labelLeft release];
    [_labelMiddle release];
    [_dataSource release];
    [_choosedBankLabel release];
    [_getCashTextField release];
    [_UILineView1 release];
    [_UILineView2 release];
    [_UILineView3 release];
    [_UILineView4 release];
    [_buttonNext release];
    [_button0 release];
    [_button1 release];
    [super dealloc];
}
@end
