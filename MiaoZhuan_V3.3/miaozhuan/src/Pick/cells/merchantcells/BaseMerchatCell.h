//
//  BaseMerchatCell.h
//  miaozhuan
//
//  Created by 孙向前 on 14-10-29.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseMerchatCell : UITableViewCell

@property (retain, nonatomic) IBOutlet UILabel *lblTest;

@property (nonatomic, assign) int queryType;

+ (instancetype)createCell:(NSInteger)type WithData:(NSDictionary *)dataDic;
+ (instancetype)createCell:(NSInteger)type WithData:(NSDictionary *)dataDic withQueryType:(int)queryType;

@end
