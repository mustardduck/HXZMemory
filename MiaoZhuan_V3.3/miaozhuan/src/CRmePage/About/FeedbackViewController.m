//
//  FeedbackViewController.m
//  miaozhuan
//
//  Created by apple on 14/12/3.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "FeedbackViewController.h"
#import "RRAttributedString.h"
#import "WebhtmlViewController.h"
#import "JSONKit.h"
#import "RRLineView.h"

@interface FeedbackViewController ()<UITextFieldDelegate,UIScrollViewDelegate>
{
    BOOL isEmpty;
}
@property (retain, nonatomic) IBOutlet UITextView *feedbackTxtField;
@property (retain, nonatomic) IBOutlet UILabel *numberLabler;
@property (retain, nonatomic) IBOutlet UIButton *okBtn;
@property (retain, nonatomic) IBOutlet UIScrollView *scroller;

- (IBAction)touchUpInside:(id)sender;
@end

@implementation FeedbackViewController
@synthesize feedbackTxtField = _feedbackTxtField;
@synthesize numberLabler = _numberLabler;
@synthesize okBtn = _okBtn;

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    InitNav(@"帮助/反馈");
    
    _feedbackTxtField.returnKeyType = UIReturnKeyDefault;
    
    _feedbackTxtField.keyboardType = UIKeyboardTypeDefault;
    
    [self addDoneToKeyboard:_feedbackTxtField];
    
    _feedbackTxtField.text = @"请输入您的意见或建议";
    
    _feedbackTxtField.textColor = [UIColor lightGrayColor];
    
    isEmpty = YES;
    
    NSAttributedString * nowattributedString = [RRAttributedString setText:_numberLabler.text color:RGBCOLOR(240, 5, 0) range:NSMakeRange(5, _numberLabler.text.length - 6)];
    
    _numberLabler.attributedText = nowattributedString;
    
    [self setupMoveFowardButtonWithTitle:@"常见问题"];

    _scroller.frame = CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT);
    
    ADAPI_GetContentByCode([self genDelegatorID:@selector(HandleNotification:)], @"8971dea9df80b308ca34606f9e9bfa23");

}


-(void)hiddenKeyboard
{
    [_feedbackTxtField resignFirstResponder];
}

-(void)onMoveFoward:(UIButton *)sender
{
    PUSH_VIEWCONTROLLER(WebhtmlViewController);
    model.navTitle = @"常见问题";
    model.ContentCode = @"3656f4c5f028484b0cf47540f25e4b9d";
}

- (IBAction)touchUpInside:(id)sender
{
    if ([_feedbackTxtField.text isEqualToString:@"请输入您的意见或建议"])
    {
        [HUDUtil showErrorWithStatus:@"请输入您的意见或建议"];
        return;
    }
    else
    {
        ADAPI_adv3_CommonAbout_Suggest([self genDelegatorID:@selector(HandleNotification:)], _feedbackTxtField.text);
    }
}

-(void)HandleNotification: (DelegatorArguments *)arguments
{
    if ([arguments isEqualToOperation:ADOP_adv3_CommonAbout_Suggest])
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
    else if ([arguments isEqualToOperation:ADOP_GetContentByCode])
    {
        [arguments logError];
        
        DictionaryWrapper *wrapper = arguments.ret;
        
        if (wrapper.operationSucceed)
        {
            NSString *json = [[wrapper  getDictionary:@"Data"] objectForKey:@"ContentText"];
            NSDictionary *dic = [[json dataUsingEncoding:NSUTF8StringEncoding] objectFromJSONData];
            
            NSArray * arr = [dic objectForKey:@"Qq"];
            
            [arr retain];
            
            int num = (int)[arr count]/2;
            
            [_scroller setContentSize:CGSizeMake(320, 295 + 89 * num)];
            
            for (int i = 0; i < [arr count]; i ++)
            {
                [self drawItem:arr[i] at:i];
            }
            //奇数
            if ([arr count] %2 == 1)
            {
                [_scroller setContentSize:CGSizeMake(320, 362 + 89 * num + 89)];
                
                int add = (int)[arr count];
                UIView *view = WEAK_OBJECT(UIView, initWithFrame:CGRectMake(add%2 == 0?0:161, 296 + MAX(0, (add/2)*90), 160, 89));
                view.backgroundColor = AppColorWhite;
                [_scroller addSubview:view];
                
                UIView * vw = [[[UIView alloc] initWithFrame:CGRectMake(160, 0, 0.5, 89)]autorelease];
                vw.backgroundColor = RGBCOLOR(239, 239, 240);
                [view addSubview:vw];
                
                UIView *line_b = WEAK_OBJECT(UIView, initWithFrame:CGRectMake(0, 89, 161, 0.5));
                line_b.backgroundColor = RGBCOLOR(239, 239, 240);
                [view addSubview:line_b];
            }
            
            UIView *line_c = WEAK_OBJECT(UIView, initWithFrame:CGRectMake(0, _scroller.contentSize.height + 2, 320, 0.5));
            line_c.backgroundColor = RGBCOLOR(204, 204, 204);
            [_scroller addSubview:line_c];
        }
        else if(wrapper.operationPromptCode || wrapper.operationErrorCode)
        {
            [AlertUtil showAlert:@"" message:wrapper.operationMessage buttons:@[@"好的"]];
            return;
        }
    }
}

#pragma  mark UITextField
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if([[textView text] length]> 400)
    {
        return NO;
    }
    
    //判断是否为删除字符，如果为删除则让执行
    
    char c=[text UTF8String][0];
    if (c=='\000') {
        _numberLabler.text=[NSString stringWithFormat:@"还可以输入%d字",400-[[textView text] length]+1];
        return YES;
    }
    
    if([[textView text] length]==400) {
        if(![text isEqualToString:@"\b"]) return NO;
    }
    
    _numberLabler.text=[NSString stringWithFormat:@"还可以输入%d字",400-[[textView text] length]-[text length]];
    
    NSAttributedString * nowattributedString = [RRAttributedString setText:_numberLabler.text color:RGBCOLOR(240, 5, 0) range:NSMakeRange(5, _numberLabler.text.length - 6)];
    
    _numberLabler.attributedText = nowattributedString;
    return YES;
    
}

//常常由于联想输入的缘故，会有很多字符一起输入
-(void)textViewDidChange:(UITextView *)textView{
    //该判断用于联想输入
    if (textView.text.length > 400)
    {
        _numberLabler.text = [NSString stringWithFormat:@"还可以输入%d字",0];
    }
    else
    {
        _numberLabler.text = [NSString stringWithFormat:@"还可以输入%d字",400 - textView.text.length];
    }
    
    NSAttributedString * nowattributedString = [RRAttributedString setText:_numberLabler.text color:RGBCOLOR(240, 5, 0) range:NSMakeRange(5, _numberLabler.text.length - 6)];

    _numberLabler.attributedText = nowattributedString;
    
    [_feedbackTxtField scrollRangeToVisible:NSMakeRange(_feedbackTxtField.text.length - 1, 1)];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self hiddenKeyboard];
}

-(void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([[UIScreen mainScreen] bounds].size.height < 568)
    {
        [self animateTextField: textView up: YES];
    }
}


-(void)textViewDidEndEditing:(UITextView *)textView
{
    textView.text = [textView.text substringToIndex:MIN(400, textView.text.length)];
    
    if ([[UIScreen mainScreen] bounds].size.height < 568)
    {
        [self animateTextField: textView up: NO];
    }
    
    if(_feedbackTxtField.text.length == 0)
    {
        _feedbackTxtField.textColor = RGBCOLOR(153, 153, 153);
        
        _feedbackTxtField.text = @"请输入您的意见或建议";
        
        isEmpty = YES;
        
    }
}

- (BOOL)textViewShouldBeginEditing:(UITextView*)textView
{
    if (isEmpty)
    {
        _feedbackTxtField.text = @"";
        
        _feedbackTxtField.textColor = RGBCOLOR(34, 34, 34);
        
        isEmpty = NO;
    }
    return YES;
}

- (void)drawItem:(NSString *)qq at:(NSInteger)index
{
    UIView *view = WEAK_OBJECT(UIView, initWithFrame:CGRectMake(index%2 == 0?0:161, 296 + MAX(0, (index/2)*90), 160, 89));
    view.backgroundColor = AppColorWhite;
    [_scroller addSubview:view];
    
    HightedButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 160, 89);
    [view addSubview:button];
    
    UIImageView *img = WEAK_OBJECT(UIImageView, initWithFrame:CGRectMake(15, 25, 40, 40));
    img.image = [UIImage imageNamed:@"feedbackTouxiang"];
    [view addSubview:img];
    
    UILabel *label = WEAK_OBJECT(UILabel, initWithFrame:CGRectMake(65, 25, 90, 20));
    label.textColor = AppColor(153);
    label.font = Font(11);
    label.text = [NSString stringWithFormat:@"意见反馈群%d",(int)index+1];

    [view addSubview:label];
    
    UILabel *qqL = WEAK_OBJECT(UILabel, initWithFrame:CGRectMake(65, 40, 90, 30));
    qqL.font = Font(16);
    qqL.textColor = AppColor(85);
    qqL.text = qq;
    [view addSubview:qqL];
    
    UIView * vw = [[[UIView alloc] initWithFrame:CGRectMake(160, 0, 0.5, 89)]autorelease];
    vw.backgroundColor = RGBCOLOR(239, 239, 240);
    [view addSubview:vw];
    
    UIView *line_b = WEAK_OBJECT(UIView, initWithFrame:CGRectMake(0, 89, 161, 0.5));
    line_b.backgroundColor = RGBCOLOR(239, 239, 240);
    [view addSubview:line_b];
}

//上移view
-(void) animateTextField:(UITextView *)textField up:(BOOL)up
{
    const int movementDistance = 40;
    const float movementDuration = 0.3f;
    int movement = (up ? -movementDistance : movementDistance);
    [UIView beginAnimations: @"anim" context: nil];
    
    [UIView setAnimationBeginsFromCurrentState: YES];
    
    [UIView setAnimationDuration: movementDuration];
    
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    
    [UIView commitAnimations];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
    [_feedbackTxtField release];
    [_numberLabler release];
    [_okBtn release];
    [_scroller release];
    [super dealloc];
}

- (void)viewDidUnload
{
    [self setFeedbackTxtField:nil];
    [self setNumberLabler:nil];
    [self setOkBtn:nil];
    [super viewDidUnload];
}

@end
