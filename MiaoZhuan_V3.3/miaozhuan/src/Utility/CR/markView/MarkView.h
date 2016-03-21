//
//  MarkView.h
//  miaozhuan
//
//  Created by abyss on 14/11/20.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MarkViewDelegate;
@interface MarkView : UIView
@property (assign, nonatomic) id<MarkViewDelegate> delegate;

- (instancetype)initWithMark:(NSString *)str Frame:(CGRect)frame;
- (void)smallMark:(UIImage *)image content:(NSString *)content;
@end
@protocol MarkViewDelegate <NSObject>
- (void)markView:(MarkView *)markView didBeTouched:(NSString *)mark;
@end
