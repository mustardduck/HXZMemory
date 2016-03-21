//
//  SetUpLableViewController.m
//  miaozhuan
//
//  Created by apple on 14/11/19.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "SetUpLableViewController.h"
#import "MarkView.h"

@interface SetUpLableViewController ()<UITextFieldDelegate,MarkViewDelegate>
{
    NSMutableArray *_markArray;
    
    NSMutableArray * lableArray;
}

@property (retain, nonatomic) IBOutlet UITextField *lableTextField;
@end

CGFloat padding = 5;
CGFloat max_width = 300;

@implementation SetUpLableViewController

@synthesize lableTextField = _lableTextField;

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    InitNav(@"设置标签");
    
    NSLog(@"--array-%@",_CounselIds);
    
    _lableTextField.text = _LableName;
    
    _lableTextField.delegate = self;
    
    [self addDoneToKeyboard:_lableTextField];
    
    [self setupMoveFowardButtonWithTitle:@"完成"];
    
    ADAPI_adv3_GetLabelList([self genDelegatorID:@selector(HandleNotification:)]);
}

- (void)HandleNotification:(DelegatorArguments *)arguments
{
    if ([arguments isEqualToOperation:ADOP_adv3_GetLabelList])
    {
        [arguments logError];
        
        DictionaryWrapper *wrapper = arguments.ret;
        
        if (wrapper.operationSucceed)
        {
            for (int i = 0; i<[wrapper.data count]; i++)
            {
                DictionaryWrapper *dic = [[wrapper.data objectAtIndex:i] wrapper];
                NSString * lableName = [dic getString:@"LabelName"];
                if (!_markArray)
                {
                    _markArray = [NSMutableArray new];
                }
                [_markArray addObject:lableName];
            }
            
            [self configureView];
        }
        else if(wrapper.operationPromptCode || wrapper.operationErrorCode)
        {
            [AlertUtil showAlert:@"" message:wrapper.operationMessage buttons:@[@"好的"]];
        }
    }
    else if ([arguments isEqualToOperation:ADOP_adv3_SetLabel])
    {
        [arguments logError];
        
        DictionaryWrapper *wrapper = arguments.ret;
        
        if (wrapper.operationSucceed)
        {
            [HUDUtil showSuccessWithStatus:wrapper.operationMessage];
            
            [self.navigationController popViewControllerAnimated:YES];
        }
        else if(wrapper.operationPromptCode || wrapper.operationErrorCode)
        {
            [AlertUtil showAlert:@"" message:wrapper.operationMessage buttons:@[@"好的"]];
        }
    }
}


- (void)onMoveFoward:(UIButton *)sender
{
//    if ([_lableTextField.text isEqualToString:@""])
//    {
//        [HUDUtil showErrorWithStatus:@"请设置标签名称!"];
//    }
//    else
//    {
        ADAPI_adv3_SetLabel([self genDelegatorID:@selector(HandleNotification:)], _CounselIds, _lableTextField.text);
//    }
}

- (void)configureView
{
    NSUInteger row = 0;
    CGFloat x = 0;
    
    if (!_markArray || _markArray.count == 0) return;
    for (int i = 0; i < _markArray.count; i++)
    {
        MarkView *mark = [[[MarkView alloc] initWithMark:_markArray[i]  Frame:CGRectMake(x, row*35, 0, 25)] autorelease];
        mark.delegate = self;
        NSLog(@"%f ",mark.width);
        x += mark.width + padding;
        if (x > max_width)
        {
            x = 0;
            row++;
            mark.frame = CGRectMake(x, row*35, mark.width, mark.height);
            x += mark.width + padding;
        }
        [_scrollView addSubview:mark];
    }
    _scrollView.contentSize = CGSizeMake(300, row*30 > 300 ? row*30:300);
}

- (void)markView:(MarkView *)markView didBeTouched:(NSString *)mark
{
    if (![_lableTextField.text isEqualToString:@""])
    {
        _lableTextField.text = @"";
        _lableTextField.text = mark;
    }
    else
    {
        _lableTextField.text = mark;
    }
}

#pragma mark TextField

-(void)hiddenKeyboard
{
    [_lableTextField resignFirstResponder];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
{
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string]; //得到输入框的内容
    if (_lableTextField == textField)  //判断是否时我们想要限定的那个输入框
    {
        if ([toBeString length] > 10)
        {
            return NO;
        }
    }
    return YES;
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //隐藏键盘
    [_lableTextField resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
    [_markArray release];
    _markArray = nil;
    
    [_scrollView release];
    [_lableTextField release];
    [super dealloc];
}

- (void)viewDidUnload
{
    [self setScrollView:nil];
    [super viewDidUnload];
}
@end
