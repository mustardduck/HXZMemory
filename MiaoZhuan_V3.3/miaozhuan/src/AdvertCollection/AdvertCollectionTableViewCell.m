//
//  AdvertCollectionTableViewCell.m
//  miaozhuan
//
//  Created by abyss on 14/10/21.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "AdvertCollectionTableViewCell.h"

@interface AdvertCollectionTableViewCell () <UIScrollViewDelegate>
{
    CGPoint _startPoint;
    CGPoint _point;
    CGFloat _offset;
}
@end

@implementation AdvertCollectionTableViewCell

- (void)awakeFromNib
{
    {
        UIView* v = WEAK_OBJECT(UIView, initWithFrame:CGRectMake(15, 145 - 0.5, 320, 0.5));
        v.backgroundColor = AppColor(197);
        [self.contentView addSubview:v];
    }
    // Initialization code
//    UIPanGestureRecognizer *pan = [[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(deleteCell:)] autorelease];
//    [self.contentView addGestureRecognizer:pan];
}

//- (void)deleteCell:(UISwipeGestureRecognizer *)sender
//{
//    _point = [sender locationInView:self.contentView];
////    NSLog(@"%f",_point.x);
//    
//    //滑动中
//    if (sender.state == UIGestureRecognizerStateChanged)
//    {
//        _offset = _point.x - _startPoint.x;
//        CGFloat end = self.contentView.center.x + _offset;
//        NSLog(@"%f",end);
//        if (end < 100) end = 100;
//        if (end > 160) end = 160;
//        self.contentView.center = CGPointMake(end, self.contentView.center.y);
//    }
//    
//    //滑动结束
//    else if  (sender.state == UIGestureRecognizerStateEnded || sender.state == UIGestureRecognizerStateCancelled)
//    {
//    }
//}
//
//
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
//{
//    //记录滑动初始点
//    _startPoint = [touch locationInView:self.contentView];
////    NSLog(@"%f",_startPoint.x);
//    
//    return TRUE;
//}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc
{
    [_img release];
    [_icon release];
    [_titleL release];
    [_textL release];
    [super dealloc];
}
@end
