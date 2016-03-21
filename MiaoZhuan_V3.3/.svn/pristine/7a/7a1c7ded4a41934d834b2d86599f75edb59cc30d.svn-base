//
//  IWComplainReasonListTableViewCellStyle2.m
//  miaozhuan
//
//  Created by admin on 15/5/4.
//  Copyright (c) 2015年 zdit. All rights reserved.
//

#import "IWComplainReasonListTableViewCellStyle2.h"

@implementation IWComplainReasonListTableViewCellStyle2

- (void)awakeFromNib {
    // Initialization code
    
    self.view_BottomView.layer.borderColor = [RGBACOLOR(220, 220, 220, 1) CGColor];
    self.view_BottomView.layer.borderWidth = .5f;
    self.view_BottomView.layer.cornerRadius = 5.f;
    self.view_BottomView.backgroundColor = RGBACOLOR(239, 239, 244, 1);
    
    self.textView.backgroundColor = [UIColor clearColor];
    self.textView.delegate = self;
    
    self.view_Alert.font = [UIFont systemFontOfSize:14.f];
    self.view_Alert.textColor = RGBACOLOR(204, 204, 204, 1);
    self.view_Alert.text = @"你还可以输入50字";
    self.view_Alert.textAlignment = RTTextAlignmentRight;
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark -- uitextview delegate
-(void)textViewDidChange:(UITextView *)textView{
    if(_textViewShouldBeginInput){
        self.textViewShouldBeginInput();
    }
    int currentTextLength = (int)textView.text.length;
    int canInputTextLength = 50 - currentTextLength;
    
    if(canInputTextLength <= 0){
        canInputTextLength = 0;
    }
    
    NSString *alert = [NSString stringWithFormat:@"<font size=14 color=#D0CFD0>还可以输入</font><font size=14 color=#FB0000>%d</font><font size=14 color=#D0CFD0>个字</font>",canInputTextLength];
    self.view_Alert.text = alert;
    
    if(canInputTextLength <= 0){
        [textView setContentOffset:CGPointMake(0, 0)];
        textView.text = [textView.text substringToIndex:50];
        return;
    }
}

-(void)textViewDidBeginEditing:(UITextView *)textView{
    if(_textViewShouldBeginInput){
        self.textViewShouldBeginInput();
    }
    
}

-(BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    NSString *alert = [NSString stringWithFormat:@"<font size=14 color=#D0CFD0>还可以输入</font><font size=14 color=#FB0000>50</font><font size=14 color=#D0CFD0>个字</font>"];
    self.view_Alert.text = alert;
    
    if(_textViewShouldBeginInput){
        self.textViewShouldBeginInput();
    }
    
    return YES;
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if(_textViewShouldBeginInput){
        self.textViewShouldBeginInput();
    }
    int currentTextLength = (int)textView.text.length;
    int canInputTextLength = 50 - currentTextLength;
    
    if(canInputTextLength < 1){
        if([text isEqualToString:@""]){
            return YES;
        }
        return NO;
    }
    return YES;
}

-(void)textViewDidEndEditing:(UITextView *)textView{
    textView.text = @"";
    NSString *alert = [NSString stringWithFormat:@"<font size=14 color=#D0CFD0>还可以输入50个字</font>"];
    self.view_Alert.text = alert;
    if(_textViewShouldEndInput){
        self.textViewShouldEndInput();
    }
}

@end
