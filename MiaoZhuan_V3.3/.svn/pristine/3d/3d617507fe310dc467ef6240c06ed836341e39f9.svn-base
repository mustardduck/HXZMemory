//
//  CRString.m
//  CRCoreUnit
//
//  Created by abyss on 14/12/18.
//  Copyright (c) 2014年 Abyss Roger. All rights reserved.
//

#import "CRString.h"

//#import "Define+UIBox.h"

#define crs_getSubLenth()           NSRange range = NSMakeRange(from, length);
#define crs_getwholeLenth()         NSRange range = NSMakeRange(0, [_string length]);
#define crs_needParagraphStyle()    if (!_paragraph) [self addParagraph:range]

@interface CRString ()
@property (retain, nonatomic) NSMutableParagraphStyle *paragraph;
@end
@implementation CRString
@synthesize string = _string,attributedString = _attributedString;

- (void)dealloc
{
    [_string release];
    
    [super dealloc];
}

- (instancetype)initWithString:(NSString *)str
{
    self = [super init];
    if (self)
    {
        _string = str;
        [_string retain];
        
        _attributedString = OBJECT_NEW_WEAK(NSMutableAttributedString,
                                            initWithString:_string);
    }
    return self;
}
- (instancetype)initWithAttributedString:(NSAttributedString *)attrStr
{
    self = [super init];
    if (self)
    {
        _string = attrStr.string;
        [_string retain];
        

        _attributedString = OBJECT_NEW_WEAK(NSMutableAttributedString,
                                            initWithAttributedString:attrStr);
    }
    return self;
}

#pragma mark - setter

- (void) setFont:(UIFont *)font rangeStart:(NSInteger)from by:(NSInteger)length
{
    crs_getSubLenth();
    [_attributedString addAttribute:NSFontAttributeName value:font range:range];
}

- (void) setColor:(UIColor *)color rangeStart:(NSInteger)from by:(NSInteger)length
{
    crs_getSubLenth();
    [_attributedString addAttribute:NSForegroundColorAttributeName value:color range:range];
}

- (void) setLineSpacing:(CGFloat)space
{
    crs_getwholeLenth();
    crs_needParagraphStyle();
    
    _paragraph.lineSpacing = space;
}

- (void) setAlignment:(NSTextAlignment)alignment
{
    crs_getwholeLenth();
    crs_needParagraphStyle();
    
    _paragraph.alignment = alignment;
}

#pragma mark - Private

- (void)addParagraph:(NSRange)range
{
    _paragraph = OBJECT_NEW_WEAK(NSMutableParagraphStyle, init);
    
    [_attributedString addAttribute:NSParagraphStyleAttributeName
                              value:_paragraph
                              range:range];
    
}

@end
