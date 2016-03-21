//
//  ModelSliverDetail.m
//  miaozhuan
//
//  Created by abyss on 14/12/30.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "ModelSliverDetail.h"

@implementation ModelSliverDetail

- (instancetype)initWith:(DictionaryWrapper *)wrapper
{
    self = [super init];
    if (self)
    {
        if (wrapper.dictionary == nil) wrapper = @{}.wrapper;
        
        _sdProductId = [wrapper getInt:@"ProductId"];
        _sdAdvertId = [wrapper getInt:@"AdvertId"];
        _sdEnterpriseId = [wrapper getInt:@"EnterpriseId"];
        _sdName = [wrapper getString:@"Name"];
        _sdDescribe = [wrapper getString:@"Describe"];
        _sdUnitPrice = [wrapper getDouble:@"UnitPrice"];
        _sdUnitIntegral = [wrapper getDouble:@"UnitIntegral"];
        _sdExchangeType = [wrapper getInt:@"ExchangeType"];
        _sdExchangedCount = [wrapper getInt:@"ExchangedCount"];
        _sdRemainExchangeCount = [wrapper getInt:@"RemainExchangeCount"];
        _sdExchangeableCount = [wrapper getInt:@"ExchangeableCount"];
        _sdExchangeTotal = [wrapper getInt:@"ExchangeTotal"];
        _sdPerPersonNumber = [wrapper getInt:@"PerPersonNumber"];
        _sdPerPersonPerDayNumber = [wrapper getInt:@"PerPersonPerDayNumber"];
        _sdCustomerSilverBalance = [wrapper getInt:@"CustomerSilverBalance"];
        _sdIsCollect = [wrapper getBool:@"IsCollect"];
        _sdPictures = [wrapper getArray:@"Pictures"];
        _sdEnterpriseInfo = [wrapper getDictionary:@"EnterpriseInfo"];
        _sdProductExchangeAddress = [wrapper getArray:@"ProductExchangeAddress"];
    }
    return self;
}
@end
