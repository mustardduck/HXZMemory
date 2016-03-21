//
//  TextInputViewController.m
//  MZV32
//
//  Created by admin on 15/4/20.
//  Copyright (c) 2015年 Junnpy.Pro.Test. All rights reserved.
//

#import "IWTextInputViewController.h"
#import "RTLabel.h"

@interface IWTextInputViewController ()<UITextViewDelegate,UIScrollViewDelegate>

@property (strong, nonatomic) RTLabel *alert_TextLengthLabel;//最大输入长度标签
@property (strong, nonatomic) RTLabel *placeholderLabel;//占位标签
@property (strong, nonatomic) RTLabel *alert_DemoTextLabel; //示例标签
@property (strong, nonatomic) UITextView *textView;//输入框
@property (strong, nonatomic) UIScrollView *contentView;

@end

@implementation IWTextInputViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = RGBACOLOR(239, 239, 244, 1);
    self.contentView.backgroundColor = [UIColor clearColor];
    
    self.contentView = ({
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        scrollView.delegate = self;
        scrollView;
    });
    [self.view addSubview:self.contentView];
    
    UITapGestureRecognizer *resignFirstResponderTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(textViewResignFirstResponder)];
    resignFirstResponderTap.numberOfTapsRequired = 1;
    resignFirstResponderTap.numberOfTouchesRequired = 1;
    [self.view addGestureRecognizer:resignFirstResponderTap];
    
    InitNav(self.textInputAlert[@"alert_title"]);
    
    [self setupMoveFowardButtonWithTitle:@"保存"];
    
#pragma mark -- 预传字典： alert_placeholder 占位符，alert_textLength 最大输入字数，alert_demo 输入示例 alert_textMinLength最小输入字数
    NSString *alert_placeholder = self.textInputAlert[@"alert_placeholder"];
    int textLength = [self.textInputAlert[@"alert_textLength"] intValue];
    NSString *alert_demo = self.textInputAlert[@"alert_demo"];
    
    UIView *backgourndView = [[UIView alloc] initWithFrame:CGRectMake(0, 10.f, self.contentView.width, 150.f)];
    backgourndView.backgroundColor = RGBACOLOR(255, 255, 255, 1);
    [self.contentView addSubview:backgourndView];
    
    self.textView = ({
        UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(8.f, 17, self.contentView.width - 16.f, 110.f)];
        textView.font = [UIFont systemFontOfSize:16];
        textView.backgroundColor = RGBACOLOR(255, 255, 255, 1);
        textView.delegate = self;
        textView.text = self.value;
        textView;
    });
    [self.contentView addSubview:self.textView];
    [self.textView becomeFirstResponder];
    
    self.placeholderLabel = ({
        NSString *alert = @"";
        RTLabel *label = [[RTLabel alloc] initWithFrame:CGRectMake(14.f, 27.f, self.contentView.width - 24.f, 20.f)];
        label.userInteractionEnabled = YES;
        if(alert_placeholder.length > 0 && nil != alert_placeholder){
            alert = [NSString stringWithFormat:@"<font size=16 color=#CCCCCC>%@</font>",alert_placeholder];
            label.text = alert;
            label.height = label.optimumSize.height;
        }
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(textViewBecomeFirstResponder)];
        tap.numberOfTapsRequired = 1;
        tap.numberOfTouchesRequired = 1;
        [label addGestureRecognizer:tap];
        
        label;
    });
    if(self.textView.text.length > 0){
        self.placeholderLabel.hidden = YES;
    }
    [self.contentView addSubview:self.placeholderLabel];
    
    if(nil != self.value && self.value.length > 0){
        self.textView.text = self.value;
    }
    
    self.alert_TextLengthLabel = ({
        
        NSString *alert = @"";
        if(textLength > 0){
            if(self.textView.text.length > 0){
                textLength = textLength - self.textView.text.length;
            }
            alert = [NSString stringWithFormat:@"<font size=14 color=#D0CFD0>还可以输入</font><font size=14 color=#FB0000> %d </font><font size=14 color=#D0CFD0>个字</font>",textLength];
        }
        RTLabel *label = [[RTLabel alloc] initWithFrame:CGRectMake(15.f, self.textView.bottom, self.contentView.width - 30.f, 20.f)];
        label.textAlignment = RTTextAlignmentRight;
        label.text = alert;
        label.height = label.optimumSize.height;
        label.bottom = backgourndView.bottom - 15.f;
        label;
    });
    [self.contentView addSubview:self.alert_TextLengthLabel];
    
    self.alert_DemoTextLabel = ({
        
        RTLabel *label = [[RTLabel alloc] initWithFrame:CGRectMake(15.f, backgourndView.bottom + 20.f, self.textView.width, 20.f)];
        if(nil != alert_demo && alert_demo.length > 0){
             NSString *alert = [NSString stringWithFormat:@"<font size=14 color=#9B9B9A>描述示例</font>\n<font size=14 color=39393A>%@</font>",alert_demo];
            label.text = alert;
            label.height = label.optimumSize.height;
        }
        label;
    });
    [self.contentView addSubview:self.alert_DemoTextLabel];
    
    
    self.contentView.contentSize = CGSizeMake(0, self.alert_DemoTextLabel.bottom + 84.f);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- 输入框成为第一响应者
-(void)textViewBecomeFirstResponder{
    [self.textView becomeFirstResponder];
}

#pragma mark -- 输入框取消第一响应
-(void)textViewResignFirstResponder{
    [self.textView resignFirstResponder];
}

#pragma mark -- 保存输入
- (IBAction) onMoveFoward:(UIButton*) sender
{
    int textLength = [self.textInputAlert[@"alert_textMinLength"] intValue];
    
    if(self.inputType == IWTextInputTitle){
        if (self.textView.text.length < textLength) {
            [HUDUtil showErrorWithStatus:[NSString stringWithFormat:@"标题不足%d个字",textLength]]; return;
        }
    }else if (self.inputType == IWTextInputContent){
        if (self.textView.text.length < textLength) {
            [HUDUtil showErrorWithStatus:[NSString stringWithFormat:@"内容不足%d个字",textLength]]; return;
        }
    }else if(self.inputType == IWTextInputAttractBrand){
        if (self.textView.text.length < textLength) {
            [HUDUtil showErrorWithStatus:[NSString stringWithFormat:@"品牌不足%d个字",textLength]]; return;
        }
    }else if (self.inputType == IWTextInputAttractWebSite){
        if (self.textView.text.length < textLength) {
            [HUDUtil showErrorWithStatus:[NSString stringWithFormat:@"链接不足%d个字符",textLength]]; return;
        }
    }
    
    
    [_textView resignFirstResponder];
    if(nil != self.inputFinished){
        NSString *text = self.textView.text;
        
        self.inputFinished(text);
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark -- uiscrollview delegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if([scrollView isEqual:self.contentView]){
        //释放键盘
        [self.textView resignFirstResponder];
    }
}

#pragma mark -- uitextview delegate

-(void)textViewDidChange:(UITextView *)textView{
    
    
    if(textView.text.length > 0){
        
        self.placeholderLabel.hidden = YES;
    }else{
        
        self.placeholderLabel.hidden = NO;
    }
    
    int textLength = [self.textInputAlert[@"alert_textLength"] intValue];
    if(textLength > 0){
        
        int currentTextLength = (int)textView.text.length;
        int canInputTextLength = textLength - currentTextLength;
        
        
        
        NSString *alert = [NSString stringWithFormat:@"<font size=14 color=#D0CFD0>还可以输入</font><font size=14 color=#FB0000> %d </font><font size=14 color=#D0CFD0>个字</font>",canInputTextLength];
        if(canInputTextLength < 0){
            alert = [NSString stringWithFormat:@"<font size=14 color=#D0CFD0>你已超出</font><font size=14 color=#FB0000> %d </font><font size=14 color=#D0CFD0>个字</font>",abs(canInputTextLength)];
        }
        self.alert_TextLengthLabel.text = alert;
        
    }
}

-(BOOL)textViewShouldEndEditing:(UITextView *)textView{
    int textLength = [self.textInputAlert[@"alert_textLength"] intValue];
    
    if(textLength > 0){
        if(_textView.text.length > textLength){
            _textView.text = [_textView.text substringToIndex:textLength];
            NSString *alert = [NSString stringWithFormat:@"<font size=14 color=#D0CFD0>还可以输入</font><font size=14 color=#FB0000> 0 </font><font size=14 color=#D0CFD0>个字</font>"];
            self.alert_TextLengthLabel.text = alert;
        }
    }
    
    return YES;
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if([text isEqualToString:@""]){
        return YES;
    }
    int textLength = [self.textInputAlert[@"alert_textLength"] intValue];
    if(textLength > 0){
        
        int currentTextLength = (int)textView.text.length;
        int canInputTextLength = textLength - currentTextLength;
        
        if(canInputTextLength < 1){
            return NO;
        }
    }
    return YES;
}

@end
