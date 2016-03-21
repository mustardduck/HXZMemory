//
//  CollectConsultTableViewCell.m
//  miaozhuan
//
//  Created by apple on 14/11/20.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "CollectConsultTableViewCell.h"


@implementation CollectConsultTableViewCell

- (void)awakeFromNib
{
    _mark = [[[MarkView alloc] initWithMark:@"lalala" Frame:CGRectMake(60, 75, 0, 16)] autorelease];

    [self.contentView addSubview:_mark];

}

- (void)setImageFlag:(BOOL)imageFlag
{
    _imageFlag = imageFlag;
    if (_imageFlag)
    {
        __block CollectConsultTableViewCell *weak = self;
        dispatch_async(dispatch_get_main_queue(), ^{
            weak.contentView.left = 35;
            
        });
    }
    else
    {
        self.contentView.left = 0;
    }
}

- (void)setCheckFlag:(BOOL)checkFlag
{
    _checkFlag = checkFlag;
    
    if (_checkFlag) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            _kuangCell.image = [UIImage imageNamed:@"findShopfilterSelectBtn"];
        });
    }
    else
    {
        _kuangCell.image = [UIImage imageNamed:@"findShopfilterBtn"];
    }

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [_titleCell release];
    [_logoImageCell release];
    [_contentCell release];
    [_dataCell release];

    [_kuangCell release];
    [_cellLInes release];
    [super dealloc];
}
@end
