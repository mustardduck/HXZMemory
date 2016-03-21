//
//  CRThankgivingEncryptUnit.h
//  CRCoreUnit
//
//  Created by abyss on 14/12/15.
//  Copyright (c) 2014年 Abyss Roger. All rights reserved.
//

#import <Foundation/Foundation.h>

//===== Test Unit =====
extern NSString* CRToken;
extern NSString* CRTestPhoneNumber;
//=====================

extern NSString* CRCookieKey;
extern NSInteger CRMXFormatVersion1;

@interface CRThankgivingEncryptUnit : NSObject

+ (NSData *)getThanksgivingCode:(NSString *)token forPhone:(NSString *)Numbers;
+ (NSString *)stringFromHexData:(NSData *)hexData;
@end
