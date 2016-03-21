//
//  YinYuanProdEditSubController.m
//  miaozhuan
//
//  Created by momo on 14-11-18.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "YinYuanProdEditSubController.h"
#import "RRLineView.h"
#import "RRAttributedString.h"

@interface YinYuanProdEditSubController ()<UITextFieldDelegate, UITextViewDelegate, UIActionSheetDelegate>
{
    BOOL _isAlert;
}

@property (retain, nonatomic) IBOutlet RRLineView *line;

@property (retain, nonatomic) IBOutlet UIView *txtMainView;
@property (retain, nonatomic) IBOutlet UITextView *txtView;
@property (retain, nonatomic) IBOutlet UILabel *lblTitle;

@end

@implementation YinYuanProdEditSubController

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setNavigateTitle: _naviTitle];
    
    [self setupMoveBackButton];
    
    [self setupMoveFowardButtonWithTitle:@"保存"];
    
    if([_naviTitle isEqualToString:@"兑换限制"])
    {
        _duihuanXianzhiView.hidden = NO;
        
        _prodDesView.hidden = YES;
        
        _DayField.text = [NSString stringWithFormat:@"%d", _dayCount];
        
        _TotalField.text = [NSString stringWithFormat:@"%d", _totalCount];

        [self addDoneToKeyboard:_DayField];
        
        [self addDoneToKeyboard:_TotalField];
    }
    else
    {
        _prodDesView.hidden = NO;
        
        _duihuanXianzhiView.hidden = YES;
        
        if(_isADs)
        {
            _bottomSampleView.hidden = YES;
            
            _txtView.text = _ADsDes;

        }
        else if (_isReturnProduct)
        {
            _bottomSampleView.hidden = YES;
            
            _txtView.text = _prodDes;
        }
        else
        {
            _txtView.text = _prodDes;
        }
        
        [self layoutView:_limitNum];

    }
    
    [self fixView];
}

- (void) fixView
{
    _line.top = 94.5;
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    _isAlert = YES;
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [_txtView resignFirstResponder];
    
    if(buttonIndex == 0)
    {
        if(!_prodDesView.hidden && _isADs)//广告描述
        {
            if(![self validTextView])
            {
                return;
            }
            
            [_delegate passADsDes:_txtView.text];
        }
        else if(!_prodDesView.hidden && !_isADs && !_isReturnProduct)//商品描述
        {
            if(![self validTextView])
            {
                return;
            }
            
            [_delegate passProdDes:_txtView.text];
        }
        else if(_isReturnProduct)//退款（货）
        {
            if(![self validTextView])
            {
                return;
            }
            [_delegate passReturnProduct:_txtView.text];
        }
        
        [self.navigationController popViewControllerAnimated:YES];

    }
    else if (buttonIndex == 1)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void) onMoveBack:(UIButton *)sender
{
    if(!_isADs && _prodDesView.hidden)
    {
        [_delegate passDuihuanLimit:[_DayField.text intValue] andTotalCount:[_TotalField.text intValue]];
    }
    else
    {
        if(_isAlert && _txtView.text.length)
        {
            UIActionSheet *actionSheet = [[[UIActionSheet alloc]
                                           initWithTitle:nil
                                           delegate:self
                                           cancelButtonTitle:@"取消"
                                           destructiveButtonTitle:nil
                                           otherButtonTitles:@"保存草稿", @"不保存",nil]autorelease];
            
            actionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
            
            [actionSheet showInView:self.view];
            
            return;
        }
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL) validTextView
{
    NSString * text = _txtView.text;
    
    text = [text stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    if(text.length == 0)
    {
        [HUDUtil showErrorWithStatus:@"暂无可保存的内容"];
        
        return NO;
    }
    return YES;
}

- (void) onMoveFoward:(UIButton *)sender
{
    if(!_prodDesView.hidden && !_isADs && !_isReturnProduct)//商品描述
    {
        if(![self validTextView])
        {
            return;
        }
        
        [_delegate passProdDes:_txtView.text];
    }
    else if(_isReturnProduct)//退货
    {
        if(![self validTextView])
        {
            return;
        }
        
        [_delegate passReturnProduct:_txtView.text];
    }
    else if (!_prodDesView.hidden && _isADs)
    {
        if(![self validTextView])
        {
            return;
        }
        
        [_delegate passADsDes:_txtView.text];
    }
    else
    {
        if([_DayField.text intValue] > [_TotalField.text intValue])
        {
            [HUDUtil showErrorWithStatus:@"每天最多可兑换数不能大于总兑换数"];
            
            return ;
        }
        
        [_delegate passDuihuanLimit:[_DayField.text intValue] andTotalCount:[_TotalField.text intValue]];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) textFieldDidEndEditing:(UITextField *)textField
{
    if([textField.text intValue] == 0)
    {
        textField.text = @"1";
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)layoutView:(int)num
{
    [self setLblTitleRedColor:num];

    [self addDoneToKeyboard:_txtView];
}

//设置提示lbl的初始状态
- (void)setLblTitleRedColor:(int)num
{
    NSInteger number = [_txtView.text length];
    
    NSString *str = [NSString stringWithFormat:@"还可以输入%ld字",(long)_limitNum - number];
    NSAttributedString *attributedString = [RRAttributedString setText:str
                                                                 color:RGBCOLOR(240, 5, 0)
                                                                 range:NSMakeRange(5, str.length - 6)];
    _lblTitle.attributedText = attributedString;
}

- (void) hiddenKeyboard
{
    [self.view endEditing:YES];
}

- (void)changeCount:(UITextField *) textField andJian:(BOOL) isJian
{
    int count = [textField.text intValue];
    
    if(count > 1)
    {
        count += isJian ? -1 : 1 ;
    }
    else if (count == 1)
    {
        count += isJian ? 0 : 1;
    }
    
    textField.text = [NSString stringWithFormat:@"%d", count];
}

- (IBAction)touchUpInsideOnBtn:(id)sender
{
    if(sender == _jianDayBtn)
    {
        [self changeCount:_DayField andJian:YES];
    }
    else if (sender == _jiaDayBtn)
    {
        [self changeCount:_DayField andJian:NO];
    }
    else if (sender == _jianTotalBtn)
    {
        [self changeCount:_TotalField andJian:YES];
    }
    else if (sender == _jiaTotalBtn)
    {
        [self changeCount:_TotalField andJian:NO];
    }
}

#pragma mark - uitextview delegate
- (void)textViewDidChange:(UITextView *)textView
{
    NSInteger number = [textView.text length];

    NSString *str = [NSString stringWithFormat:@"还可以输入%ld字",(long)_limitNum - number];
    NSAttributedString *attributedString = [RRAttributedString setText:str
                                                                 color:RGBCOLOR(240, 5, 0)
                                                                 range:NSMakeRange(5, str.length - 6)];
    _lblTitle.attributedText = attributedString;

}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    textView.text = [textView.text substringToIndex:MIN(textView.text.length, _limitNum)];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if([text length] == 0)
    {
        return YES;
    }
    if([textView.text length] + range.length >= _limitNum)
    {
        return NO;
    }
    else
    {
        return YES;
    }
}

- (void)dealloc {
    [_duihuanXianzhiView release];
    [_prodDesView release];
    [_lblTitle release];
    [_txtMainView release];
    [_txtView release];
    [_jianDayBtn release];
    [_jiaDayBtn release];
    [_jianTotalBtn release];
    [_jiaTotalBtn release];
    [_TotalField release];
    [_DayField release];
    [_bottomSampleView release];
    
    self.prodDes = nil;
    
    [_line release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setLblTitle:nil];
    [self setTxtView:nil];
    [self setTxtMainView:nil];
    [self setDuihuanXianzhiView:nil];
    [self setProdDesView:nil];
    [self setJianDayBtn:nil];
    [self setJiaDayBtn:nil];
    [self setJianTotalBtn:nil];
    [self setJiaTotalBtn:nil];
    [self setTotalField:nil];
    [self setDayField:nil];
    [self setBottomSampleView:nil];
    [self setLine:nil];
    [super viewDidUnload];
}
@end
