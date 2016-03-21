//
//  FansLayerCell.m
//  miaozhuan
//
//  Created by Santiago on 15-3-17.
//  Copyright (c) 2015年 zdit. All rights reserved.
//

#import "FansLayerCell.h"
#import "UICommon.h"
@interface FansLayerCell()

@property (retain, nonatomic) IBOutlet UILabel *label1;
@property (retain, nonatomic) IBOutlet UILabel *label2;
@property (retain, nonatomic) IBOutlet UILabel *label3;
@property (retain, nonatomic) IBOutlet UIImageView *lockIcon;
@end

@implementation FansLayerCell
@synthesize label1 = _label1;
@synthesize label2 = _label2;
@synthesize label3 = _label3;
@synthesize lockIcon = _lockIcon;

- (void)awakeFromNib {
    // Initialization code
    _label_line.height = 0.5f;
}

- (void)setupCellWith:(int)number1 qualifiedNumber:(int)number2 cashNumber:(double)number3 isLocked:(BOOL)lockded {

    if (lockded) {
        
        _label3.hidden = YES;
        _lockIcon.hidden = NO;
        _label1.textColor = AppColor(204);
        _label2.textColor = AppColor(204);
        [self.contentView setBackgroundColor:RGBCOLOR(239, 239, 244)];
    }else {
    
        _label3.hidden = NO;
        _lockIcon.hidden = YES;
        _label1.textColor = [UIColor blackColor];
        _label2.textColor = RGBCOLOR(204, 5, 0);
        [self.contentView setBackgroundColor:[UIColor whiteColor]];
    }
    
    [_label2 setText:[NSString stringWithFormat:@"%d",number1]];
    [_label1 setText:[NSString stringWithFormat:@"%d",number2]];
    [_label3 setText:[UICommon getStringToTwoDigitsAfterDecimalPointPlaces:number3 withAppendStr:nil]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (void)dealloc {
    [_label1 release];
    [_label2 release];
    [_label3 release];
    [_lockIcon release];
    [_label_line release];
    [super dealloc];
}
@end
