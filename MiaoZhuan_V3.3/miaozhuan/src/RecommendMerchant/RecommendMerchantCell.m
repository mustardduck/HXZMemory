//
//  RecommendMerchantCell.m
//  guanggaoban
//
//  Created by Santiago on 14-10-21.
//  Copyright (c) 2014年 Arvin. All rights reserved.
//

#import "RecommendMerchantCell.h"
#import "NetImageView.h"
#import "UIView+expanded.h"

@implementation ProductView

- (void) setImage:(NSString *)string andPrice:(NSString*)price andName:(NSString *)name {
    
    ((NetImageView*) [self viewWithTag:1]).layer.borderWidth = 0.5;
    ((NetImageView*) [self viewWithTag:1]).layer.borderColor = [RGBCOLOR(204, 204, 204)CGColor];
    [((NetImageView*) [self viewWithTag:1]) requestWithRecommandSize:string];
    ((UILabel*)[self viewWithTag:2]).text = [NSString stringWithFormat:@"%@",price];
    ((UILabel *)[self viewWithTag:3]).text = [NSString stringWithFormat:@"%@",name];
}

@end

@implementation RecommendMerchantCell

- (void)awakeFromNib {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)dealloc {
    [_merchantLogo release];
    [_merchantLabel release];
    [_merchantAdvantageLabel release];
    [_grayCutOffLine release];
    [_shelfGoods release];
    [_product1View release];
    [_product2View release];
    [_product3View release];
    [_buttomGrayCutLine release];
    [_vipImage release];
    [_goldImage release];
    [_silverImage release];
    [_havaProductsView release];
    [_noProductsView release];
    [_UILineView1 release];
    [_UILineView2 release];
    [_UILineView3 release];
    [_UILineView4 release];
    [_grayCutOffLine2 release];
    [_UILineView31 release];
    [_buttomGrayCutLine2 release];
    [super dealloc];
}

@end












