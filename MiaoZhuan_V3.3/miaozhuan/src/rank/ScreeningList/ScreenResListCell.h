//
//  ScreenResListCell.h
//  guanggaoban
//
//  Created by CQXianMai on 14-8-11.
//  Copyright (c) 2014年 Arvin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetImageView.h"

@interface ScreenResListCell : UITableViewCell

@property (retain, nonatomic) IBOutlet UILabel *rankLbl;
@property (retain, nonatomic) IBOutlet NetImageView *comLogoImg;
@property (retain, nonatomic) IBOutlet UILabel *comNameLbl;
@property (retain, nonatomic) IBOutlet UILabel *tipCatogryLbl;
@property (retain, nonatomic) IBOutlet UIView *tipCatogryView;
- (void)initCellWithDic:(NSDictionary *)dic;
@end
