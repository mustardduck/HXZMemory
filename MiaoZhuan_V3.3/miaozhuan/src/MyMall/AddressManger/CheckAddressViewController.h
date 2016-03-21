//
//  CheckAddressViewController.h
//  miaozhuan
//
//  Created by apple on 14/12/31.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^AddressBlock) (DictionaryWrapper *addressInfo);

@interface CheckAddressViewController : DotCViewController

@property (nonatomic, copy) NSString *addressId;

@property (nonatomic, copy) AddressBlock block;

@end
