//
//  InfoModelViewController.m
//  miaozhuan
//
//  Created by abyss on 14/11/8.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "InfoModelViewController.h"

#import "CommonTextView.h"
#import "CommonTextField.h"

@interface InfoModelViewController () <UIAlertViewDelegate>
{
    CommonTextView *_textView;
    CommonTextField *_textField;
    CGFloat _topBlank;
    NSString *_str;
    
    BOOL _isEdit;
}


@end

@implementation InfoModelViewController
@synthesize type = _type;

- (void)dealloc
{
    [_textField release];
    [_textView release];
    [_str release];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    CRDEBUG_DEALLOC();
    [_gongHaoView release];
    [super dealloc];
}
MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initNav];
    _topBlank = 10.f;
    self.view.backgroundColor = AppColorBackground;
    [self layoutView];
}

- (void)initNav
{
    [self setNavigateTitle:_type.title];
    [self setupMoveBackButtonWithTitle:@"取消"];
    [self setupMoveFowardButtonWithTitle:@"保存"];
}

- (void)layoutView
{
    switch (_type.inputType) {
        case InfoModelTypeField:
        {
            
            _textField = STRONG_OBJECT(CommonTextField, initWithFrame:CGRectMake(0, _topBlank, 320, 50));
            _textField.backgroundColor = AppColorWhite;
            _textField.layer.cornerRadius = 0;
            _textField.textColor = AppColorBlack43;
            if (_object.text && _object.text.length > 0 && ![_object.text isEqualToString:@"未填写"]) {
                 _textField.text = _object.text;
                
                _gongHaoView.hidden = YES;
            }
            else
            {
                _textField.text = @"";
                _textField.placeholder = @"请输入线下为您服务人员的工号";
                
                _gongHaoView.hidden = NO;

            }
            _textField.font = Font(16);
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(flag) name:@"UITextFieldTextDidChangeNotification" object:nil];
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(end) name:UITextFieldTextDidEndEditingNotification object:nil];
            [_textField setShouldChangeCharactersInRangeBlock:CommonTextFieldBlockChange
            {
                _isEdit = YES;
                return [_type.title isEqual:@"联系电话"]?[_textField limitTextFieldContentToNum:string]:YES;
            }];
            [self addDoneToKeyboard:_textField];
            [self.view addSubview:_textField];
            if ([_type.title isEqual:@"联系电话"]) [_textField setKeyboardType:UIKeyboardTypeNumberPad];
            break;
        }
        case InfoModelTypeView:
        {
            _textView = STRONG_OBJECT(CommonTextView, initWithFrame:CGRectMake(0, _topBlank, 320, self.height == 0? 70:self.height-30) parent:self.view);
            _textView.limitNum = self.num == 0? 100:self.num;
            _textView.font = Font(15);
            _textView.text = _object.text;
            [_textView TextDidChange:(id)_textView.text];
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(flag) name:@"UITextViewTextDidChangeNotification" object:nil];
            [self addDoneToKeyboard:_textView];
            [self.view addSubview:_textView];
            break;
        }
        default:
            break;
    }
}

- (void)flag
{
//    NSLog(@"%@",_textField.text);
    _isEdit = YES;
//    if (_textField.text.length > 12) _textField.text = [_textField.text substringToIndex:12];
}
- (void)end
{
    if (_textField.text.length > 12) _textField.text = [_textField.text substringToIndex:12];
}

- (void)onMoveFoward:(UIButton *)sender
{
    
    if (_type.inputType == InfoModelTypeField)
    {
        //不能为空
        if (_textField.text.length < 1)
        {
           [HUDUtil showErrorWithStatus:@"不能为空"];
            return;
        }
        
        if([_type.title isEqualToString:@"服务工号"])
        {
            UIAlertView* view = [[UIAlertView alloc] initWithTitle:_textField.text message:@"确认以上工号,提交后不可修改" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [view show];
            [view autorelease];
            
            return;
        }
        
        if ([_type.title isEqual:@"联系电话"])
        {
            int judgeNum = (int)_textField.text.length;
            if (judgeNum != 7 && judgeNum != 8 && judgeNum != 10 && judgeNum != 11 && judgeNum != 12)
            {
                [HUDUtil showErrorWithStatus:@"请输入正确的电话号码"];
                return;
            }
        }
        _str = _textField.text;
    }
    else if (_type.inputType == InfoModelTypeView)
    {
        //不能为空
        if (_textView.text.length < 1)
        {
            [HUDUtil showErrorWithStatus:@"不能为空"];
            return;
        }
        
        _str = _textView.text;
    }
    
    [_str retain];
    _object.text = _str;
    
    if (_isEdit == YES)
        if (_delegate && [_delegate respondsToSelector:@selector(InfoDidSet:withType:)])
        {
            [_delegate InfoDidSet:_str withType:_type];
        }
    
    [self onMoveBack:nil];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        _str = _textField.text;
        _object.text = _str;
        
        if (_isEdit == YES)
        {
            if (_delegate && [_delegate respondsToSelector:@selector(InfoDidSet:withType:)])
            {
                [_delegate InfoDidSet:_str withType:_type];
            }
        }
        
        [self onMoveBack:nil];
    }
}


- (void)onMoveBack:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)hiddenKeyboard
{
    [self.view endEditing:YES];
}


@end
