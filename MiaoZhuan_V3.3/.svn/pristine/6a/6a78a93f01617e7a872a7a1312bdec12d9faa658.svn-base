//
//  IWSellerDiscountHeaderTableViewCell.h
//  miaozhuan
//
//  Created by luo on 15/5/14.
//  Copyright (c) 2015年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^IWSellerDiscountHeaderTapGes)(int pageIndex);

@interface IWSellerDiscountHeaderTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView_TopBanner;
@property (strong, nonatomic) IBOutlet UILabel *lableName;
@property (strong, nonatomic) IBOutlet UILabel *lableRefreshTime;
@property (strong, nonatomic) IBOutlet UILabel *lablePublichTime;
@property (strong, nonatomic) IBOutlet UIImageView *imageDefaultNoPic;
@property (strong, nonatomic) IWSellerDiscountHeaderTapGes tapSellerDiscountHeaderTapGes;

- (void)createBannerViewWithImages:(NSArray *)images;


@end
