//
//  ConsultViewController.m
//  miaozhuan
//
//  Created by 孙向前 on 14-11-5.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "ConsultViewController.h"
#import "RRAttributedString.h"

@interface ConsultViewController ()<UITextFieldDelegate,UITextViewDelegate>


@property (retain, nonatomic) IBOutlet UILabel *lblTemp;
@property (retain, nonatomic) IBOutlet UITextView *txtView;
@property (retain, nonatomic) IBOutlet UILabel *lblTitle;

@property (retain, nonatomic) IBOutlet UIButton *btnPhoneTitle;
@property (retain, nonatomic) IBOutlet UIButton *btQQTitle;
@property (retain, nonatomic) IBOutlet UIButton *btnEmailTitle;
@property (retain, nonatomic) IBOutlet UITextField *txtPhone;
@property (retain, nonatomic) IBOutlet UITextField *txtQQ;
@property (retain, nonatomic) IBOutlet UITextField *txtEmail;
@property (retain, nonatomic) IBOutlet UIButton *btnPhone;
@property (retain, nonatomic) IBOutlet UIButton *btnQQ;
@property (retain, nonatomic) IBOutlet UIButton *btnEmail;

@property (retain, nonatomic) IBOutlet UIScrollView *scrollview;

@end

@implementation ConsultViewController

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setupMoveBackButton];
    
    [self setLblTitleRedColor];
    [self setPhoneQQEmailSettings];
    
    DictionaryWrapper *dic =[APP_DELEGATE.runtimeConfig getDictionary:RUNTIME_USER_LOGIN_INFO].wrapper;
    NSLog(@"%@",dic);
    _txtPhone.text = [dic getString:@"UserName"];
    _txtEmail.text = [dic getString:@"Email"];
    _txtQQ.text = [dic getString:@"QQ"];
    
    [_btnEmailTitle setTitleColor:RGBCOLOR(204, 204, 204) forState:UIControlStateNormal];
    [_btQQTitle setTitleColor:RGBCOLOR(204, 204, 204) forState:UIControlStateNormal];
    _txtQQ.textColor = RGBCOLOR(204, 204, 204);
    _txtEmail.textColor = RGBCOLOR(204, 204, 204);
    
    [self setNavigateTitle:@"咨询"];
}

#pragma mark - uitextview delegate
- (void)textViewDidChange:(UITextView *)textView
{
    _lblTemp.hidden = YES;
    NSInteger number = [textView.text length];
//    if (textView.text.length > 500) {
//        NSString *str = [NSString stringWithFormat:@"还可以输入%d字",0];
//        NSAttributedString *attributedString = [RRAttributedString setText:str
//                                                                     color:RGBCOLOR(240, 5, 0)
//                                                                     range:NSMakeRange(5, str.length - 6)];
//        _lblTitle.attributedText = attributedString;
//        textView.text = [textView.text substringToIndex:500];
//    } else {
        NSString *str = [NSString stringWithFormat:@"还可以输入%ld字",(long)500 - number];
        NSAttributedString *attributedString = [RRAttributedString setText:str
                                                                     color:RGBCOLOR(240, 5, 0)
                                                                     range:NSMakeRange(5, str.length - 6)];
        _lblTitle.attributedText = attributedString;
//    }
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    textView.text = [textView.text substringToIndex:MIN(textView.text.length, 500)];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if([text length] == 0)
    {
        return YES;
    }
    if([textView.text length] + range.length >= 500)
    {
        return NO;
    }
    else
    {
        return YES;
    }
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    _scrollview.contentSize = CGSizeMake(SCREENWIDTH, self.view.height + 216);//原始滑动距离加键盘高度
    CGPoint pt = [textField convertPoint:CGPointMake(0, 0) toView:_scrollview];//把当前的textField的坐标映射到scrollview上
    if(_scrollview.contentOffset.y - pt.y + 64 <= 0)//判断最上面不要去滚动
        [_scrollview setContentOffset:CGPointMake(0, pt.y - 64) animated:YES];//滑动
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self hiddenKeyboard];
    return YES;
}
//隐藏键盘
- (void)hiddenKeyboard{
    _scrollview.contentSize = CGSizeMake(SCREENWIDTH, self.view.height);
    [self.view endEditing:YES];
}

#pragma mark - 事件
- (IBAction)itemClicked:(UIButton *)sender {
    if ([sender isEqual:_btnPhone]) {
        sender.selected = _btnPhoneTitle.selected = _txtPhone.enabled = !sender.selected;
        [_btnPhoneTitle setTitleColor:sender.selected ? RGBCOLOR(34, 34, 34) : RGBCOLOR(204, 204, 204) forState:UIControlStateNormal];
        _txtPhone.textColor = sender.selected ? RGBCOLOR(34, 34, 34) : RGBCOLOR(204, 204, 204);
        
    } else if ([sender isEqual:_btnQQ]) {
        sender.selected = _btQQTitle.selected = _txtQQ.enabled = !sender.selected;
        [_btQQTitle setTitleColor:sender.selected ? RGBCOLOR(34, 34, 34) : RGBCOLOR(204, 204, 204) forState:UIControlStateNormal];
        _txtQQ.textColor = sender.selected ? RGBCOLOR(34, 34, 34) : RGBCOLOR(204, 204, 204);
    } else {
        sender.selected = _btnEmailTitle.selected = _txtEmail.enabled = !sender.selected;
        [_btnEmailTitle setTitleColor:sender.selected ? RGBCOLOR(34, 34, 34) : RGBCOLOR(204, 204, 204) forState:UIControlStateNormal];
        _txtEmail.textColor = sender.selected ? RGBCOLOR(34, 34, 34) : RGBCOLOR(204, 204, 204);
    }
}
//提交
- (IBAction)commitButtonClicked:(id)sender {
    if (!_txtView.text.length) {
        [HUDUtil showErrorWithStatus:@"请填写咨询内容!"];return;
    }
    
    if (![_txtPhone.text isEqualToString:@""]) {
        if (_txtPhone.text.length != 11) {
            [HUDUtil showErrorWithStatus:@"请填写正确电话号码!"];return;
        }
    }
    if (![_txtEmail.text isEqualToString:@""])
    {
        if (![self CheckInput:_txtEmail.text])
        {
            [HUDUtil showErrorWithStatus:@"请填写正确的邮箱地址"];
            return;
        }
    }
   

    [_commitDic setValue:_txtView.text forKey:@"Content"];

    [_commitDic setValue:(_txtPhone.text.length && _btnPhone.selected) ? _txtPhone.text : @"" forKey:@"Phone"];

    [_commitDic setValue:(_txtQQ.text.length && _btnQQ.selected) ? _txtQQ.text : @"" forKey:@"QQ"];

    [_commitDic setValue:(_txtEmail.text.length && _btnEmail.selected) ? _txtEmail.text : @"" forKey:@"Email"];
    
    ADAPI_adv2_AddAdvertCounsel([GLOBAL_DELEGATOR_MANAGER addDelegator:self selector:@selector(handleAddAdCounsel:)], _commitDic);
}

-(BOOL)CheckInput:(NSString *)_text
{
    NSString *Regex=@"[A-Z0-9a-z._%+-]+@[A-Z0-9a-z._]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest=[NSPredicate predicateWithFormat:@"SELF MATCHES %@",Regex];
    return [emailTest evaluateWithObject:_text];
}

//提交后的回调处理
- (void)handleAddAdCounsel:(DelegatorArguments *)arguments{
    DictionaryWrapper* dic = arguments.ret;
    if (dic.operationSucceed)
    {
        [HUDUtil showSuccessWithStatus:@"提交成功"];
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        [HUDUtil showErrorWithStatus:dic.operationMessage];
        return;
    }
    
}
//PhoneQQEmail 设置
- (void)setPhoneQQEmailSettings{
    
    [self addDoneToKeyboard:_txtPhone];
    [self addDoneToKeyboard:_txtQQ];
    [self addDoneToKeyboard:_txtEmail];
    [self addDoneToKeyboard:_txtView];
    
    _btnPhone.selected = _txtPhone.enabled = _btnPhoneTitle.selected = YES;
    _btnQQ.selected = _txtQQ.enabled = _btQQTitle.selected = NO;
    _btnEmail.selected = _txtEmail.enabled = _btnEmailTitle.selected = NO;
    
}
//设置提示lbl的初始状态
- (void)setLblTitleRedColor{
    NSString *str = @"还可以输入500字";
    NSAttributedString *attributedString = [RRAttributedString setText:str
                                                                 color:RGBCOLOR(240, 5, 0)
                                                                 range:NSMakeRange(5, str.length - 6)];
    _lblTitle.attributedText = attributedString;
}


#pragma mark - 内存管理
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_commitDic release];
    [_lblTitle release];
    [_btnPhoneTitle release];
    [_btQQTitle release];
    [_btnEmailTitle release];
    [_txtPhone release];
    [_txtQQ release];
    [_txtEmail release];
    [_btnPhone release];
    [_btnQQ release];
    [_btnEmail release];
    [_txtView release];
    [_lblTemp release];
    [_scrollview release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setLblTitle:nil];
    [self setBtnPhoneTitle:nil];
    [self setBtQQTitle:nil];
    [self setBtnEmailTitle:nil];
    [self setTxtPhone:nil];
    [self setTxtQQ:nil];
    [self setTxtEmail:nil];
    [self setBtnPhone:nil];
    [self setBtnQQ:nil];
    [self setBtnEmail:nil];
    [self setTxtView:nil];
    [self setLblTemp:nil];
    [self setScrollview:nil];
    [super viewDidUnload];
}
@end
