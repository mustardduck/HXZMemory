//
//  PayMethod.h
//  miaozhuan
//
//  Created by 孙向前 on 14-11-12.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    wxPay = 4,
    upompPay = 1,
    aliPay = 2,
} payType;

typedef void (^ResultBlock)(id result, payType type);

@interface PayMethod : NSObject

+ (void)payWithPayType:(payType)payType
               payInfo:(id)info
            resultback:(ResultBlock)block;

@end
