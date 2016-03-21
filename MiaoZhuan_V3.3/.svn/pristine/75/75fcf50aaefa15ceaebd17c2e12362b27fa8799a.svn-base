//
//  BuyRecordsCell.h
//  miaozhuan
//
//  Created by 孙向前 on 14-11-20.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RRLineView.h"
#import "RRNormalButton.h"

@interface BuyRecordsCell : UITableViewCell

+ (instancetype)newInstance;
- (void)createNewInstanceWithRow:(NSInteger)row dataDic:(NSDictionary *)dataDic;
- (void)addAction:(id)obj withAction:(SEL)selector;

@property (retain, nonatomic) IBOutlet UILabel *lblSingleStatus;
@property (retain, nonatomic) IBOutlet UILabel *lblDoubleStatus;
@property (retain, nonatomic) IBOutlet UILabel *lblDoubleDetail;
@property (retain, nonatomic) IBOutlet UIView *doubleView;

@property (retain, nonatomic) IBOutlet UILabel *lblCompany;
@property (retain, nonatomic) IBOutlet UILabel *lblDetail;
@property (retain, nonatomic) IBOutlet UILabel *lblOrderNum;

@property (retain, nonatomic) IBOutlet RRNormalButton *btnFront;
@property (retain, nonatomic) IBOutlet RRNormalButton *btnFollow;
@property (retain, nonatomic) IBOutlet UILabel *lblPrice;
@property (retain, nonatomic) IBOutlet RRLineView *line;

@end
