//
//  MerchantLocation.h
//  miaozhuan
//
//  Created by Santiago on 14-11-5.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MerchantLocation : NSObject

@property (copy, nonatomic) NSString *country;
@property (copy, nonatomic) NSString *state;
@property (copy, nonatomic) NSString *city;
@property (copy, nonatomic) NSString *district;
@property (copy, nonatomic) NSString *locationType;
@property (copy, nonatomic) NSDictionary *normalData;
@property (strong, nonatomic) DictionaryWrapper* stateData;
@property (strong, nonatomic) DictionaryWrapper* cityData;
@property (strong, nonatomic) DictionaryWrapper* districtData;
@property (nonatomic) double latitude;
@property (nonatomic) double longitude;
@end
