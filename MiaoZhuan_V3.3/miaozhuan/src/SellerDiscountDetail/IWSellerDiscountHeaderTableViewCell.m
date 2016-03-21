//
//  IWSellerDiscountHeaderTableViewCell.m
//  miaozhuan
//
//  Created by luo on 15/5/14.
//  Copyright (c) 2015年 zdit. All rights reserved.
//

#import "IWSellerDiscountHeaderTableViewCell.h"
//#import "ScrollerViewWithTime.h"
//#import "PreviewViewController.h"
#import "UI_CycleScrollView.h"
@interface IWSellerDiscountHeaderTableViewCell()<UI_CycleScrollViewDelegate>{
//    ScrollerViewWithTime *_recommandBanner;
    UI_CycleScrollView *_cycleView;
}

@end

@implementation IWSellerDiscountHeaderTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - banner
- (void)createBannerViewWithImages:(NSArray *)images{
    
    if (!images.count) {
        return;
    }
    
//    CGSize tempsize = {150,217};
//    if (!_recommandBanner) {
//        _recommandBanner = [ScrollerViewWithTime controllerFromView:self.scrollView_TopBanner pictureSize:tempsize];
//        [_recommandBanner setWidthSelf:160];
//        [_recommandBanner addImageItems:images];
//    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.001 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (_cycleView == nil) {
            _cycleView = [[UI_CycleScrollView alloc] initWithFrame:self.scrollView_TopBanner.frame];
            _cycleView.backgroundColor = [UIColor clearColor];
            _cycleView.delegate = self;
            [self.scrollView_TopBanner addSubview:_cycleView];
            
            [_cycleView setPictureUrls:[NSMutableArray arrayWithArray:images]];
        }
    });
  
    
    
//    _recommandBanner.TapActionBlock = ^(NSInteger pageIndex){
//        if(self.tap){
//            self.tap(pageIndex);
//        }
//    };
}

-(void)CycleImageTap:(int)page {
    if (self.tapSellerDiscountHeaderTapGes) {
        self.tapSellerDiscountHeaderTapGes(page);
    }
}

@end
