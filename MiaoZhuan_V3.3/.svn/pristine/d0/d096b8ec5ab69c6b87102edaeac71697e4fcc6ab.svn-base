//
//  CRString.h
//  CRCoreUnit
//
//  Created by abyss on 14/12/18.
//  Copyright (c) 2014年 Abyss Roger. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CRString : NSObject
@property (retain, readonly) NSString* string;
@property (retain, readonly) NSMutableAttributedString* attributedString;

@property (assign, nonatomic) CGFloat lineSpacing;
@property (assign, nonatomic) NSTextAlignment alignment;

- (instancetype)initWithString:(NSString *)str;
- (instancetype)initWithAttributedString:(NSAttributedString *)attrStr;


- (void) setFont:(UIFont *)font rangeStart:(NSInteger)from by:(NSInteger)length;
- (void) setColor:(UIColor *)color rangeStart:(NSInteger)from by:(NSInteger)length;

#warning fix later 边线，删除线，空心线，
@end
