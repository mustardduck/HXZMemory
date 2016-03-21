//
//  CommonTextView.m
//  miaozhuan
//
//  Created by abyss on 14/11/8.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "CommonTextView.h"
#import "RRAttributedString.h"

@interface CommonTextView ()<UITextViewDelegate>
{
    UIView* _bottom;
//    UIView* _cover;
    UILabel *_label;
    
    UIImageView *_topLine;
    UIImageView *_endLine;
    
    NSInteger _num;
    BOOL isFirst;
    
    CGPoint _p;
}
@end
@implementation CommonTextView
@synthesize limitNum = _limitNum;
@synthesize beforeStr = _beforeStr;
@synthesize endStr = _endStr;

- (void)dealloc
{
    [_beforeStr release];
    [_endStr release];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [super dealloc];
}

- (void)setup
{
    [self setupObserver];
    
    isFirst = YES;
    
    self.delegate = self;
    self.backgroundColor = AppColorWhite;
    if ([SystemUtil aboveIOS7_0])
    {
        self.textContainerInset = UIEdgeInsetsMake(12, 15, 30, 15);//** momo ios6 **//
    }
    self.textColor = AppColorBlack43;
    self.layer.masksToBounds = YES;
    
    [self setBottomView];
}

- (void)setBottomView
{
//    _cover = WEAK_OBJECT(UIView, initWithFrame:CGRectMake(0, - 10, self.width, 10));
//    _cover.backgroundColor = AppColorBackground;
//    _cover.opaque = NO;
//    _cover.layer.masksToBounds = YES;
//    [self addSubview: _cover];
    
    _bottom = WEAK_OBJECT(UIView, initWithFrame:CGRectMake(0, self.height, self.width, 30));
    _bottom.backgroundColor = AppColorWhite;
    
    _label = WEAK_OBJECT(UILabel, initWithFrame:CGRectMake(0, 0, _bottom.width - 15, _bottom.height));
    _label.backgroundColor = AppColorWhite;
    _label.font = Font(12);
    _label.textColor = AppColorLightGray204;
    _label.textAlignment = NSTextAlignmentRight;
//    self.height += 30;
    
    _beforeStr = @"还可以输入";
    [_beforeStr retain];
    _endStr = @"字";
    [_endStr retain];
    _limitNum = 100;
    
    _label.text = [NSString stringWithFormat:@"%@%d%@",_beforeStr,_limitNum,_endStr];
    _label.attributedText  = [RRAttributedString setText:_label.text color:AppColorRed range:NSMakeRange(_beforeStr.length, _label.text.length - _beforeStr.length - _endStr.length)];
    [_bottom addSubview:_label];
    
    _topLine = WEAK_OBJECT(UIImageView, initWithFrame:CGRectMake(0, self.top - 0.5, self.width, 0.5));
    _endLine = WEAK_OBJECT(UIImageView, initWithFrame:CGRectMake(0, self.height - 0.5 + 30, self.width, 0.5));
    _topLine.backgroundColor = AppColor(204);
    _endLine.backgroundColor = AppColor(204);
    
    [_parent insertSubview:_bottom aboveSubview:self];
    [_parent insertSubview:_endLine aboveSubview:self];
    [_parent insertSubview:_topLine aboveSubview:self];
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame parent:(UIView *)view
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.parent = view;
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self setup];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    if (self.text.length != 0 && self.text.length > _limitNum)
    {
        NSUInteger num = MIN(_limitNum, self.text.length);
        self.text = [self.text substringToIndex:num];
        [self change:@(_limitNum - num)];
        return;
    }
}


#pragma mark - setter

- (void)setLimitNum:(NSInteger)limitNum
{
    _limitNum = limitNum;
    [self performSelector:@selector(change:) withObject:@(_limitNum)];
}

- (void)setRealHeight:(CGFloat)realHeight
{
    _realHeight = realHeight - 30;
    self.height = _realHeight;
}
#pragma mark -

- (void)setupObserver
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(TextDidChange:)
                                                 name:UITextViewTextDidChangeNotification
                                               object:nil];
    
}

- (void)TextDidChange:(id)notity
{
    NSInteger num;
    CommonTextView *object = nil;
    
    if ([notity isKindOfClass:[NSNotification class]])
    {
        object = ((NSNotification *)notity).object;
        num = object.text.length;
    }
    else if ([notity isKindOfClass:[NSString class]])
    {
        num = ((NSString *)notity).length;
    }
    
//    if (num >= _limitNum)
//    {
//        object.text = [object.text substringToIndex:_limitNum];
//        num = _limitNum;
//    }
    _num = _limitNum - num;
    [self performSelector:@selector(change:) withObject:@(_num)];
}

- (void)change:(NSNumber *)num
{
    _label.text = [NSString stringWithFormat:@"%@%d%@",_beforeStr,num.intValue,_endStr];
    _label.attributedText  = [RRAttributedString setText:_label.text color:AppColorRed range:NSMakeRange(_beforeStr.length, _label.text.length - _beforeStr.length - _endStr.length)];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    int num = (int)textView.text.length;
    if (num >= _limitNum)
    {
        textView.text = [textView.text substringToIndex:_limitNum];
        num = _limitNum;
    }
    _num = _limitNum - num;
    [self performSelector:@selector(change:) withObject:@(_num)];
}


@end
