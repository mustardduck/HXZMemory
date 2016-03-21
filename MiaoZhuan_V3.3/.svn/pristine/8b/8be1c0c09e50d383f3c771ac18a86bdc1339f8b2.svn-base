//
//  CRFlatButton.m
//  test
//
//  Created by abyss on 14/11/22.
//  Copyright (c) 2014年 Abyss Roger. All rights reserved.
//

#import "CRFlatButton.h"
#import "Define+RCMethod.h"

@interface CRFlatButton ()
{
    CGRect _rect;
}
@property (retain, nonatomic) UIColor *flatColor;
@end
@implementation INSTANCE_CLASS_SETUP(CRFlatButton)
@synthesize flatColor = _flatColor;

- (void)setup
{
    _flatColor = __cr_FlatButtonColor;
    UIImage *normalBackgroundImage = [UIImage imageWithFlatColor:_flatColor size:CGSizeMake(10.0f, 40.0f) andRoundSize:5.0f];
    UIImage *selectedBackgroundImage = [UIImage imageWithFlatColor:[UIColor clearColor] size:CGSizeMake(10.0f, 40.0f) andRoundSize:5.0f];
    
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:14],
                                 NSForegroundColorAttributeName: _flatColor};
    [self setTitleTextAttributes:attributes forState:UIControlStateNormal];
    
    NSDictionary *highlightedAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    [self setTitleTextAttributes:highlightedAttributes forState:UIControlStateHighlighted];
    
    [self setBackgroundImage:selectedBackgroundImage
                    forState:UIControlStateNormal
                  barMetrics:UIBarMetricsDefault];
    
    [self setBackgroundImage:normalBackgroundImage
                    forState:UIControlStateSelected
                  barMetrics:UIBarMetricsDefault];
    
    
    [self setDividerImage:[UIImage imageWithFlatColor:[UIColor clearColor]] forLeftSegmentState:UIControlStateNormal rightSegmentState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self flatSetting];
}

- (id)initWithItems:(NSArray *)items
{
    self = [super initWithItems:items];
    if (self) {
        [self setup];
        [self flatSetting];
    }
    return self;
}

- (void)flatSetting
{
    self.layer.cornerRadius = 5.0f;
    self.layer.borderWidth = 1.0f;
    self.layer.borderColor = _flatColor.CGColor;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _rect = self.bounds;
}
@end

@implementation UIImage (CRFlatButton_Addtion)

+ (UIImage *)imageWithFlatColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIImage *)imageWithFlatColor:(UIColor *)color size:(CGSize)size andRoundSize:(CGFloat)roundSize {
    
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if (roundSize > 0) {
        UIBezierPath* roundedRectanglePath = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius: roundSize];
        [color setFill];
        [roundedRectanglePath fill];
    } else {
        CGContextSetFillColorWithColor(context, [color CGColor]);
        CGContextFillRect(context, rect);
        
    }
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end

