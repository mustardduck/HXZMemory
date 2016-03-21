//
//  IWCompanyIntroTableViewCell.h
//  miaozhuan
//
//  Created by luo on 15/5/15.
//  Copyright (c) 2015年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^CellButtonClick)(void);

@interface IWCompanyIntroTableViewCell : UITableViewCell


@property (retain, nonatomic) IBOutlet UILabel *lableTelePhone;

@property (copy,nonatomic) CellButtonClick cellButtonClick;

@end
