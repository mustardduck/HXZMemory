//
//  ItemViewController.m
//  miaozhuan
//
//  Created by apple on 14/12/11.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "ItemViewController.h"
#import "RRAttributedString.h"

@interface ItemViewController ()<UITextViewDelegate>
{
    BOOL isEmpty;
}
@property (retain, nonatomic) IBOutlet UITextView *itemTxt;
@property (retain, nonatomic) IBOutlet UILabel *numLable;

@end

@implementation ItemViewController

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    InitNav(@"备忘信息");

    _itemTxt.returnKeyType = UIReturnKeyDefault;
    
    _itemTxt.keyboardType = UIKeyboardTypeDefault;

    if (_nots == nil)
    {
        _itemTxt.text = @"请输入备忘信息";
        _itemTxt.textColor =  RGBCOLOR(153, 153, 153);
    }
    else
    {
        _itemTxt.text = _nots;
        _itemTxt.textColor =  RGBCOLOR(34, 34, 34);
        
        NSInteger length = _itemTxt.text.length;
        
        _numLable.text = [NSString stringWithFormat:@"还可以输入%d字",200 - length];
    }
    
    isEmpty = YES;
    
    [self addDoneToKeyboard:_itemTxt];
    
    NSAttributedString * nowattributedString = [RRAttributedString setText:_numLable.text color:RGBCOLOR(240, 5, 0) range:NSMakeRange(5, _numLable.text.length - 6)];
    
    _numLable.attributedText = nowattributedString;
}

-(void)hiddenKeyboard
{
    [_itemTxt resignFirstResponder];
}

- (void)onMoveBack:(UIButton *)sender
{
    if (![_itemTxt.text isEqualToString:@"请输入备忘信息"])
    {
        if ([_itemTxt.text isEqualToString:_nots])
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
        else
        {
            if ([_orderType isEqualToString:@"1"])
            {
                ADAPI_adv3_ExchangeManagement_AddNotes([self genDelegatorID:@selector(HandleNotification:)], _OrderNumber,_itemTxt.text);
            }
            else
            {
               ADAPI_adv3_GoldOrder_EnterpriseCloseComent([self genDelegatorID:@selector(HandleNotification:)], _OrderNumber,_itemTxt.text);
            }
        }
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)HandleNotification: (DelegatorArguments *)arguments
{
    if ([arguments isEqualToOperation:ADOP_adv3_ExchangeManagement_AddNotes])
    {
        [arguments logError];
        
        DictionaryWrapper* wrapper = arguments.ret;
        
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
    else if ([arguments isEqualToOperation:ADOP_adv3_GoldOrder_EnterpriseCloseComent])
    {
        [arguments logError];
        
        DictionaryWrapper* wrapper = arguments.ret;
        
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

- (void)textViewDidChange:(UITextView *)textView
{
    NSInteger number = [textView.text length];
    
    if (textView.text.length >= 200)
    {
        _numLable.text = [NSString stringWithFormat:@"还可以输入%d字",0];
    }
    else
    {
        _numLable.text = [NSString stringWithFormat:@"还可以输入%d字",200 - number];
    }
    
    NSAttributedString * nowattributedString = [RRAttributedString setText:_numLable.text color:RGBCOLOR(240, 5, 0) range:NSMakeRange(5, _numLable.text.length - 6)];
    
    _numLable.attributedText = nowattributedString;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    NSString *new = [textView.text stringByReplacingCharactersInRange:range withString:text];
    
    NSInteger res = 200 - [new length];
    
    if(res >= 0)
    {
        return YES;
    }
    else
    {
        NSRange rg = {0,[text length]+res};
        
        if (rg.length>0)
        {
            NSString *s = [text substringWithRange:rg];
            [textView setText:[textView.text stringByReplacingCharactersInRange:range withString:s]];
        }
        return NO;
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self hiddenKeyboard];
}

-(void)textViewDidEndEditing:(UITextView *)textView
{
    textView.text = [textView.text substringToIndex:MIN(200, textView.text.length)];
    
    if(_itemTxt.text.length == 0)
    {
        _itemTxt.textColor = RGBCOLOR(153, 153, 153);
        
        _itemTxt.text = @"请输入备忘信息";
        
        isEmpty = YES;
        
    }
}

- (BOOL)textViewShouldBeginEditing:(UITextView*)textView
{
    if (isEmpty)
    {
        if ([_itemTxt.text isEqualToString:@"请输入备忘信息"])
        {
            _itemTxt.text = @"";
            
            _itemTxt.textColor = RGBCOLOR(34, 34, 34);
            
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
    [_itemTxt release];
    [_numLable release];
    [super dealloc];
}

- (void)viewDidUnload
{
    [self setItemTxt:nil];
    [self setNumLable:nil];
    [super viewDidUnload];
}
@end
