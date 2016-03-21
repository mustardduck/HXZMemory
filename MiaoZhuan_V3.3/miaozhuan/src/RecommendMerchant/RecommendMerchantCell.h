//
//  RecommendMerchantCell.h
//  guanggaoban
//
//  Created by Santiago on 14-10-21.
//  Copyright (c) 2014年 Arvin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetImageView.h"
@class ProductView;

@interface RecommendMerchantCell : UITableViewCell


@property (retain, nonatomic) IBOutlet NetImageView *merchantLogo;
@property (retain, nonatomic) IBOutlet UILabel *merchantLabel;
@property (retain, nonatomic) IBOutlet UIImageView *vipImage;
@property (retain, nonatomic) IBOutlet UIImageView *goldImage;
@property (retain, nonatomic) IBOutlet UIImageView *silverImage;

@property (retain, nonatomic) IBOutlet UIView *havaProductsView;
@property (retain, nonatomic) IBOutlet UIView *noProductsView;



@property (strong, nonatomic) NSString *merchantAdvantage;
@property (retain, nonatomic) IBOutlet ProductView *product1View;
@property (retain, nonatomic) IBOutlet ProductView *product2View;
@property (retain, nonatomic) IBOutlet ProductView *product3View;
@property (retain, nonatomic) IBOutlet UILabel *merchantAdvantageLabel;

@property (retain, nonatomic) IBOutlet UIView *grayCutOffLine;
@property (retain, nonatomic) IBOutlet UIView *grayCutOffLine2;

@property (retain, nonatomic) IBOutlet UILabel *shelfGoods;

@property (strong, nonatomic) NSString *companyUrl;
@property (strong, nonatomic) NSString *silverProductsUrl;
@property (strong, nonatomic) NSString *goldProductsUrl;
@property (strong, nonatomic) NSString *directProductUrl;

//底部灰条
@property (retain, nonatomic) IBOutlet UIView *buttomGrayCutLine;
@property (retain, nonatomic) IBOutlet UIView *buttomGrayCutLine2;


@property (retain, nonatomic) IBOutlet UIButton *productBtn1;//银元
@property (retain, nonatomic) IBOutlet UIButton *productBtn2;//银元
@property (retain, nonatomic) IBOutlet UIButton *productBtn3;//金币

@property (retain, nonatomic) IBOutlet UIView *UILineView1;
@property (retain, nonatomic) IBOutlet UIView *UILineView2;
@property (retain, nonatomic) IBOutlet UIView *UILineView3;
@property (retain, nonatomic) IBOutlet UIView *UILineView31;





@property (retain, nonatomic) IBOutlet UIView *UILineView4;






@end

@interface ProductView : UIView

- (void) setImage:(NSString *)string andPrice:(NSString*)price andName:(NSString*)name;

@end