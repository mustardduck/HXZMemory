//
//  AreaListCell.h
//  miaozhuan
//
//  Created by 孙向前 on 14-11-22.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RRLineView.h"

@interface AreaListCell : UITableViewCell

@property (retain, nonatomic) IBOutlet UILabel *lblArea;
@property (retain, nonatomic) IBOutlet UIButton *btnSelected;
@property (retain, nonatomic) IBOutlet UIImageView *imgArrow;
@property (retain, nonatomic) IBOutlet RRLineView *line;

@property (nonatomic, retain) NSDictionary *dataDic;
@end
