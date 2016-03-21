//
//  MyMarketMyOrderCell.h
//  miaozhuan
//
//  Created by momo on 14/12/27.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetImageView.h"

@interface MyMarketMyOrderCell : UITableViewCell

@property (retain, nonatomic) IBOutlet UILabel *orderNumLbl;
@property (retain, nonatomic) IBOutlet UILabel *payMoneyLbl;
@property (retain, nonatomic) IBOutlet UIButton *payBtn;
@property (retain, nonatomic) IBOutlet UILabel *paySuccessLbl;
@property (retain, nonatomic) IBOutlet UILabel *nameLbl;
@property (retain, nonatomic) IBOutlet UILabel *compLbl;
@property (retain, nonatomic) IBOutlet UIView *statusView;
@property (retain, nonatomic) IBOutlet UILabel *statusOneLbl;
@property (retain, nonatomic) IBOutlet UILabel *statusTwoLbl;
@property (retain, nonatomic) IBOutlet UILabel *numLbl;

@property (retain, nonatomic) IBOutlet UIButton *BtnOne;
@property (retain, nonatomic) IBOutlet UIButton *BtnTwo;
@property (retain, nonatomic) IBOutlet UIView *imgView;
@property (retain, nonatomic) IBOutlet UILabel *prodLbl;
@property (retain, nonatomic) IBOutlet NetImageView *prodImgView;
@property (retain, nonatomic) IBOutlet UIButton *compBtn;

@property (retain, nonatomic) IBOutlet UIView *bottomBtnView;

@property (retain, nonatomic) IBOutlet UILabel *bottomLbl;

- (void) initWithDic:(NSDictionary *)dic;
- (void) setCellHandler:(id)obj withAction:(SEL)selector;


@end
