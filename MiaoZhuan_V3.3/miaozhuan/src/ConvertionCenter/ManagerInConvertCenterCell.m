//
//  ManagerInConvertCenterCell.m
//  miaozhuan
//
//  Created by Santiago on 14-11-18.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "ManagerInConvertCenterCell.h"

@interface ManagerInConvertCenterCell()
@property (retain, nonatomic) IBOutlet UILabel *leftLabel;
@property (retain, nonatomic) IBOutlet UILabel *rightLabel;

@end

@implementation ManagerInConvertCenterCell
@synthesize leftLabel = _leftLabel;
@synthesize middleLabel = _middleLabel;
@synthesize rightLabel = _rightLabel;

- (void)awakeFromNib {
}

- (void)setUpLayouts:(NSString*)string{

    CGSize temp = [string sizeWithFont:_middleLabel.font constrainedToSize:CGSizeMake(MAXFLOAT, _middleLabel.frame.size.height) lineBreakMode:NSLineBreakByWordWrapping];
    [_middleLabel setFrame:CGRectMake(320 - temp.width - _rightLabel.frame.size.width-15, _middleLabel.frame.origin.y,temp.width, _middleLabel.frame.size.height)];
    [_leftLabel setFrame:CGRectMake(320 - temp.width - _rightLabel.frame.size.width-_leftLabel.frame.size.width-17, _leftLabel.frame.origin.y, _leftLabel.frame.size.width, _leftLabel.frame.size.height)];
    [_middleLabel setText:string];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [_leftLabel release];
    [_middleLabel release];
    [_rightLabel release];
    [_name release];
    [_phoneNumber release];
    [_headImage release];
    [_buttomLineView release];
    [super dealloc];
}
@end
