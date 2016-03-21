//
//  AddShippingAddressViewController.h
//  miaozhuan
//
//  Created by apple on 14/12/20.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

typedef void (^RRAddressBlock)(DictionaryWrapper *);

#import <UIKit/UIKit.h>

@interface AddShippingAddressViewController : DotCViewController

@property(retain, nonatomic) NSString * type;

@property(retain, nonatomic) DictionaryWrapper * detailDic;

@property (nonatomic, copy) RRAddressBlock block;



@end
