//
//  IWCollectTableviewCell.m
//  miaozhuan
//
//  Created by luo on 15/4/23.
//  Copyright (c) 2015年 zdit. All rights reserved.
//

#import "IWCollectTableviewCell.h"

@implementation IWCollectTableviewCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void) updateContent:(CollectionInfo *)obj{

    [_imageViewCover requestWithRecommandSize:obj.collectionLogoUrl];
    
    
    _imageViewCover.clipsToBounds = YES;
    _imageViewCover.layer.cornerRadius = 10.0;
    _imageViewCover.layer.borderWidth = 0.5;
    _imageViewCover.layer.borderColor = RGBCOLOR(197, 197, 197).CGColor;
    
    _lableCollectTile.text = obj.collectionTitle;
    _lableCollectTime.text = [NSString stringWithFormat:@"收藏于%@",[[obj.collectionFavoriteTime stringByReplacingOccurrencesOfString:@"T" withString:@" "] substringToIndex:19]];
}

- (void)dealloc {
    [_imageViewCover release];
    [_lableCollectTile release];
    [_lableCollectTime release];
    [super dealloc];
}
@end
