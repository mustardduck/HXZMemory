//
//  CustomAgeCell.h
//  miaozhuan
//
//  Created by 孙向前 on 14-11-18.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomBaseCell.h"

@interface CustomAgeCell : CustomBaseCell

@property (retain, nonatomic) IBOutlet CommonTextField *txtMinAge;
@property (retain, nonatomic) IBOutlet CommonTextField *txtMaxAge;
@property (nonatomic, retain) DictionaryWrapper *dataDic;

+ (instancetype)newInstance;

@end
