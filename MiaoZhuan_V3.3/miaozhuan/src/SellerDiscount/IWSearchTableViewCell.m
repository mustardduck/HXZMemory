//
//  IWSearchTableViewCell.m
//  miaozhuan
//
//  Created by luo on 15/4/24.
//  Copyright (c) 2015年 zdit. All rights reserved.
//

#import "IWSearchTableViewCell.h"

@implementation IWSearchTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)buttonClick:(UIButton *)sender {
    
    if (self.deleteItem != nil) {
        self.deleteItem(self.tag);
    }
    
}

-(void) setupContent:(BOOL) isShowDelete title:(NSString *) title
{
    self.lableTitle.text = title;
    if (isShowDelete) {
        self.buttonDelete.hidden = NO;
    }else{
        self.buttonDelete.hidden = YES;
    }
}

- (void)dealloc {
    [_buttonDelete release];
    [_lableTitle release];
    [super dealloc];
}
@end
