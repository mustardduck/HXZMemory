//
//  SetConvertCenterCell.m
//  miaozhuan
//
//  Created by Santiago on 14-11-17.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "SetConvertCenterCell.h"
#import "AppUtils.h"
@implementation SetConvertCenterCell
- (void)awakeFromNib {
    
    [self.backgoundView setOrigin:CGPointMake(0, 0)];
    
    UISwipeGestureRecognizer *recognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeToLeft:)];
    
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    [self.contentView addGestureRecognizer:recognizer];
    [recognizer release];
    
    UISwipeGestureRecognizer *recognizer2 = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeToRight:)];
    [recognizer2 setDirection:(UISwipeGestureRecognizerDirectionRight)];
    [self.contentView addGestureRecognizer:recognizer2];
    [recognizer2 release];
}

-(void)handleSwipeToLeft:(UISwipeGestureRecognizer *)recognizer {
    [UIView animateWithDuration:0.2 animations:^{
        
        [self.backgoundView setOrigin:CGPointMake(-70, 0)];
    }];
    
}

- (void)handleSwipeToRight:(UISwipeGestureRecognizer*)recognizer {

    [UIView animateWithDuration:0.2 animations:^{
        
        [self.backgoundView setOrigin:CGPointMake(0, 0)];
    }];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (void)dealloc {
    [_companyWholeName release];
    [_convertTime release];
    [_companyName release];
    [_phoneNumber release];
    [_convertManagers release];
    [_deleteView release];
    [_deleteBtn release];
    [_backgoundView release];
    [_jianTouIcon release];
    [_selectBtn release];
    [_selectImgView release];
    [_selectView release];
    [_buttomLineView release];
    [super dealloc];
}
@end
