//
//  EditContentViewController.m
//  miaozhuan
//
//  Created by 孙向前 on 14-11-18.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "EditContentViewController.h"
#import "RRAttributedString.h"

@interface EditContentViewController ()

@property (retain, nonatomic) IBOutlet UILabel *lblTemp;
@property (retain, nonatomic) IBOutlet UITextView *txtView;
@property (retain, nonatomic) IBOutlet UILabel *lblTitle;

@end

@implementation EditContentViewController

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigateTitle:@"内容简介"];
    [self setupMoveBackButtonWithTitle:@"取消"];
    [self setupMoveFowardButtonWithTitle:@"保存"];
    
    if (_content.length) {
        _lblTemp.hidden = YES;
        _txtView.text = _content;
        int number = (int)_content.length;
        NSString *str = [NSString stringWithFormat:@"还可以输入%ld字",(long)500 - number];
        NSAttributedString *attributedString = [RRAttributedString setText:str
                                                                     color:RGBCOLOR(240, 5, 0)
                                                                     range:NSMakeRange(5, str.length - 6)];
        _lblTitle.attributedText = attributedString;
    } else {
        NSString *str = @"还可以输入500字";
        NSAttributedString *attributedString = [RRAttributedString setText:str
                                                                     color:RGBCOLOR(240, 5, 0)
                                                                     range:NSMakeRange(5, 3)];
        _lblTitle.attributedText = attributedString;
    }
    
}

#pragma mark - uitextview delegate
- (void)textViewDidChange:(UITextView *)textView
{
    _lblTemp.hidden = YES;
    NSInteger number = [textView.text length];
    NSString *str = [NSString stringWithFormat:@"还可以输入%ld字",(long)500 - number];
    NSAttributedString *attributedString = [RRAttributedString setText:str
                                                                 color:RGBCOLOR(240, 5, 0)
                                                                 range:NSMakeRange(5, str.length - 6)];
    _lblTitle.attributedText = attributedString;
//    NSInteger number = [textView.text length];
//    if (textView.text.length > 500) {
//        NSString *str = [NSString stringWithFormat:@"还可以输入%d字",0];
//        NSAttributedString *attributedString = [RRAttributedString setText:str
//                                                                     color:RGBCOLOR(240, 5, 0)
//                                                                     range:NSMakeRange(5, 1)];
//        _lblTitle.attributedText = attributedString;
//        textView.text = [textView.text substringToIndex:500];
//    } else {
//        NSString *str = [NSString stringWithFormat:@"还可以输入%ld字",(long)500 - number];
//        NSAttributedString *attributedString = [RRAttributedString setText:str
//                                                                     color:RGBCOLOR(240, 5, 0)
//                                                                     range:NSMakeRange(5, str.length - 6)];
//        _lblTitle.attributedText = attributedString;
//    }
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

#pragma mark - 事件
- (void)onMoveFoward:(UIButton *)sender{
    if (!_txtView.text.length) {
        [HUDUtil showErrorWithStatus:@"请填写内容简介"];return;
    }
    [UI_MANAGER.mainNavigationController popViewControllerAnimated:YES];
    if (self.value) {
        self.value(_txtView.text);
    }
}

#pragma mark - 内存管理
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    [_value release];
    [_lblTemp release];
    [_lblTitle release];
    [_txtView release];
    [super dealloc];
}

@end
