//  代码地址: https://github.com/CoderMZLee/MZRefresh
//  代码地址: http://code4app.com/ios/%E5%BF%AB%E9%80%9F%E9%9B%86%E6%88%90%E4%B8%8B%E6%8B%89%E4%B8%8A%E6%8B%89%E5%88%B7%E6%96%B0/52326ce26803fabc46000000
//  UIScrollView+Extension.m
//  MZRefreshExample
//
//  Created by MZ Lee on 14-5-28.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "UIScrollView+MZExtension.h"

@implementation UIScrollView (MZExtension)
- (void)setMZ_insetT:(CGFloat)MZ_insetT
{
    UIEdgeInsets inset = self.contentInset;
    inset.top = MZ_insetT;
    self.contentInset = inset;
}

- (CGFloat)MZ_insetT
{
    return self.contentInset.top;
}

- (void)setMZ_insetB:(CGFloat)MZ_insetB
{
    UIEdgeInsets inset = self.contentInset;
    inset.bottom = MZ_insetB;
    self.contentInset = inset;
}

- (CGFloat)MZ_insetB
{
    return self.contentInset.bottom;
}

- (void)setMZ_insetL:(CGFloat)MZ_insetL
{
    UIEdgeInsets inset = self.contentInset;
    inset.left = MZ_insetL;
    self.contentInset = inset;
}

- (CGFloat)MZ_insetL
{
    return self.contentInset.left;
}

- (void)setMZ_insetR:(CGFloat)MZ_insetR
{
    UIEdgeInsets inset = self.contentInset;
    inset.right = MZ_insetR;
    self.contentInset = inset;
}

- (CGFloat)MZ_insetR
{
    return self.contentInset.right;
}

- (void)setMZ_offsetX:(CGFloat)MZ_offsetX
{
    CGPoint offset = self.contentOffset;
    offset.x = MZ_offsetX;
    self.contentOffset = offset;
}

- (CGFloat)MZ_offsetX
{
    return self.contentOffset.x;
}

- (void)setMZ_offsetY:(CGFloat)MZ_offsetY
{
    CGPoint offset = self.contentOffset;
    offset.y = MZ_offsetY;
    self.contentOffset = offset;
}

- (CGFloat)MZ_offsetY
{
    return self.contentOffset.y;
}

- (void)setMZ_contentSizeW:(CGFloat)MZ_contentSizeW
{
    CGSize size = self.contentSize;
    size.width = MZ_contentSizeW;
    self.contentSize = size;
}

- (CGFloat)MZ_contentSizeW
{
    return self.contentSize.width;
}

- (void)setMZ_contentSizeH:(CGFloat)MZ_contentSizeH
{
    CGSize size = self.contentSize;
    size.height = MZ_contentSizeH;
    self.contentSize = size;
}

- (CGFloat)MZ_contentSizeH
{
    return self.contentSize.height;
}
@end
