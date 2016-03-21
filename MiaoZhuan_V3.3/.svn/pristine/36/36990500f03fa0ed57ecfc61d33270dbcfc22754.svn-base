//
//  CRThankgivingEncryptUnit.m
//  CRCoreUnit
//
//  Created by abyss on 14/12/15.
//  Copyright (c) 2014年 Abyss Roger. All rights reserved.
//

#import "CRThankgivingEncryptUnit.h"
#import <CommonCrypto/CommonHMAC.h>
#import <CommonCrypto/CommonCryptor.h>

//1. token: 本身是16进制数，转字节
//2. 感恩号码用utf-8获取字节
//3. 密码：9FF3D76611BA436E98E357EDE4BF6145，本身是16进制数，转字节

//token+感恩号码+密码，然后做sha1
//结果再转16进制数的字符串，放到sign

NSString *CRToken           = @"0CAC5947E5B0604D0CD466FEFD8B59F5";
NSString* CRTestPhoneNumber = @"18680713541";

NSString* CRSecretID        = @"9FF3D76611BA436E98E357EDE4BF6145";
NSString* CRCookieKey       = @"__CRCookieKey";
NSInteger CRMXFormatVersion1= 46;

@implementation CRThankgivingEncryptUnit

+ (NSData *)getThanksgivingCode:(NSString *)token forPhone:(NSString *)Numbers
{
    NSMutableData* unEncryptCode = [NSMutableData data];
    
    NSData *tokenByte = [self stringToByte:token];
    [unEncryptCode appendData:tokenByte];
    
    NSData *phoneNumberByte = [Numbers dataUsingEncoding:NSUTF8StringEncoding];
    [unEncryptCode appendData:phoneNumberByte];
    
    NSData *secretIDByte = [self stringToByte:CRSecretID];
    [unEncryptCode appendData:secretIDByte];
    
    unsigned char *digest;
    digest = malloc(CC_SHA1_DIGEST_LENGTH);
    
    CC_SHA1([unEncryptCode bytes], (CC_LONG)[unEncryptCode length], digest);
    NSData *EncryptCode = [[[NSData alloc] initWithBytes:digest length:CC_SHA1_DIGEST_LENGTH] autorelease];
    free(digest);
    
    return EncryptCode;
}

+ (NSData *)stringToByte:(NSString *)string
{
    NSMutableData* data = [NSMutableData data];
    int idx;
    for (idx = 0; idx+2 <= string.length; idx+=2)
    {
        NSRange range = NSMakeRange(idx, 2);
        NSString* hexStr = [string substringWithRange:range];
        NSScanner* scanner = [NSScanner scannerWithString:hexStr];
        unsigned int intValue;
        [scanner scanHexInt:&intValue];
        [data appendBytes:&intValue length:1];
    }
    return data;
}


+ (NSString *)stringFromHexData:(NSData *)hexData
{
    return [self stringFromHexData:hexData length:CRMXFormatVersion1];
}

+ (NSString *)stringFromHexData:(NSData *)hexData length:(NSInteger)length
{
    NSString *tempString = [NSString stringWithFormat:@"%@",hexData];
    tempString = [[tempString substringWithRange:NSMakeRange(0, length-1)] substringWithRange:NSMakeRange(1, length-2)];
    
    return [tempString stringByReplacingOccurrencesOfString:@" " withString:@""];
}

@end
