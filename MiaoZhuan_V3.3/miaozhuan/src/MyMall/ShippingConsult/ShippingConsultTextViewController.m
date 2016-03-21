//
//  ShippingConsultTextViewController.m
//  miaozhuan
//
//  Created by apple on 14/12/29.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "ShippingConsultTextViewController.h"
#import "RRAttributedString.h"

@interface ShippingConsultTextViewController ()<UITextViewDelegate>
{
    BOOL isEmpty;
    NSMutableDictionary * dic;
}
@property (retain, nonatomic) IBOutlet UITextView *consultText;
@property (retain, nonatomic) IBOutlet UILabel *numLable;

- (IBAction)touchUpInside:(id)sender;
@end

@implementation ShippingConsultTextViewController

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    InitNav(@"发起咨询");
    
    _consultText.returnKeyType = UIReturnKeyDefault;
    
    _consultText.keyboardType = UIKeyboardTypeDefault;
    
    [self addDoneToKeyboard:_consultText];

    _consultText.text = @"请输入您想咨询的内容";
    _consultText.textColor =  RGBCOLOR(153, 153, 153);
    
    isEmpty = YES;

    
    NSAttributedString * nowattributedString = [RRAttributedString setText:_numLable.text color:RGBCOLOR(240, 5, 0) range:NSMakeRange(5, _numLable.text.length - 6)];
    
    _numLable.attributedText = nowattributedString;
}

-(void)hiddenKeyboard
{
    [_consultText resignFirstResponder];
}


- (IBAction)touchUpInside:(id)sender
{
    if ([_consultText.text isEqualToString:@"请输入您想咨询的内容"])
    {
        [HUDUtil showErrorWithStatus:@"请输入您想咨询的内容"];
        return;
    }
    else
    {
        dic = [[NSMutableDictionary alloc] init];
        
        [dic setValue:_consultText.text forKey:@"Content"];
        
        [dic setValue:_proterId forKey:@"Id"];
        
        [dic setValue:_type forKey:@"Type"];
        
        [dic setValue:@"" forKey:@"Phone"];
        
        [dic setValue:@"" forKey:@"QQ"];
        
        [dic setValue:@"" forKey:@"Email"];
        
        ADAPI_adv2_AddAdvertCounsel([self genDelegatorID:@selector(HandleNotification:)], dic);
    }
}

- (void)HandleNotification:(DelegatorArguments *)arguments
{
    if ([arguments isEqualToOperation:ADOP_adv2_AddAdvertCounsel])
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

#pragma  mark UITextField

//- (void)textViewDidChange:(UITextView *)textView
//{
//    NSInteger number = [textView.text length];
//    
//    if (textView.text.length >= 500)
//    {
//        _numLable.text = [NSString stringWithFormat:@"还可以输入%d字",0];
//        
//        textView.text = [textView.text substringToIndex:500];
//    }
//    else
//    {
//        _numLable.text = [NSString stringWithFormat:@"还可以输入%d字",500 - number];
//    }
//    
//    NSAttributedString * nowattributedString = [RRAttributedString setText:_numLable.text color:RGBCOLOR(240, 5, 0) range:NSMakeRange(5, _numLable.text.length - 6)];
//    
//    _numLable.attributedText = nowattributedString;
//}
//
//- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
//{
//    NSString *new = [textView.text stringByReplacingCharactersInRange:range withString:text];
//    
//    NSInteger res = 500 - [new length];
//    
//    if(res >= 0)
//    {
//        return YES;
//    }
//    else
//    {
//        NSRange rg = {0,[text length]+res};
//        
//        if (rg.length>0)
//        {
//            NSString *s = [text substringWithRange:rg];
//            [textView setText:[textView.text stringByReplacingCharactersInRange:range withString:s]];
//        }
//        return NO;
//    }
//}


-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if([[textView text] length]> 500)
    {
        return NO;
    }
    
    //判断是否为删除字符，如果为删除则让执行
    
    char c=[text UTF8String][0];
    if (c=='\000') {
        _numLable.text=[NSString stringWithFormat:@"还可以输入%d字",500-[[textView text] length]+1];
        return YES;
    }
    
    if([[textView text] length]==500) {
        if(![text isEqualToString:@"\b"]) return NO;
    }
    
    _numLable.text=[NSString stringWithFormat:@"还可以输入%d字",500-[[textView text] length]-[text length]];
    
    NSAttributedString * nowattributedString = [RRAttributedString setText:_numLable.text color:RGBCOLOR(240, 5, 0) range:NSMakeRange(5, _numLable.text.length - 6)];
    
    _numLable.attributedText = nowattributedString;
    return YES;
    
}

//常常由于联想输入的缘故，会有很多字符一起输入
-(void)textViewDidChange:(UITextView *)textView{
    //该判断用于联想输入
    if (textView.text.length > 500)
    {
        textView.text = [textView.text substringToIndex:500];
        _numLable.text = [NSString stringWithFormat:@"还可以输入%d字",0];
    }
    else
    {
        _numLable.text = [NSString stringWithFormat:@"还可以输入%d字",500 - textView.text.length];
    }
    
    NSAttributedString * nowattributedString = [RRAttributedString setText:_numLable.text color:RGBCOLOR(240, 5, 0) range:NSMakeRange(5, _numLable.text.length - 6)];
    
    _numLable.attributedText = nowattributedString;
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self hiddenKeyboard];
}

-(void)textViewDidEndEditing:(UITextView *)textView
{
    if(_consultText.text.length == 0)
    {
        _consultText.textColor = RGBCOLOR(153, 153, 153);
        
        _consultText.text = @"请输入您想咨询的内容";
        
        isEmpty = YES;
        
    }
}

- (BOOL)textViewShouldBeginEditing:(UITextView*)textView
{
    if (isEmpty)
    {
        if ([_consultText.text isEqualToString:@"请输入您想咨询的内容"])
        {
            _consultText.text = @"";
            
            _consultText.textColor = RGBCOLOR(34, 34, 34);
            
            isEmpty = NO;
        }
        else
        {
            
        }
    }
    return YES;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
    [_consultText release];
    [_numLable release];
    [super dealloc];
}

- (void)viewDidUnload
{
    [self setConsultText:nil];
    [self setNumLable:nil];
    [super viewDidUnload];
}

@end
