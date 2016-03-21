//
//  ManagerListCell.h
//  miaozhuan
//
//  Created by 孙向前 on 15/5/18.
//  Copyright (c) 2015年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RRLineView.h"
#import "NetImageView.h"

@interface ManagerListCell : UITableViewCell

@property (retain, nonatomic) IBOutlet UILabel *lblName;
@property (retain, nonatomic) IBOutlet UILabel *lblPhone;
@property (retain, nonatomic) IBOutlet NetImageView *iconImgView;
@property (retain, nonatomic) IBOutlet RRLineView *line;

@property (nonatomic, retain) DictionaryWrapper *dataDic;

@end
