//
//  MarkView.m
//  miaozhuan
//
//  Created by abyss on 14/11/20.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "MarkView.h"
#import "Define+RCMethod.h"

@interface MarkView ()
{
    float _length;
}
@property (retain, nonatomic) UIButton *button;
@property (retain, nonatomic) UIView *back;
@property (retain, nonatomic) UIImageView *img;
@property (retain, nonatomic) UILabel *label;
@property (retain, nonatomic) NSString *mark;
@end
@implementation INSTANCE_CLASS_SETUP(MarkView)

- (instancetype)initWithMark:(NSString *)str Frame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self configureLabel:str];
        [self setup];
    }
    return self;
}

- (void)setup
{
    [self setRoundCorner];
    [self configureBack];
    [self configureImg];
    [self configureButton];
    [self addSubview:_label];
}

- (void)configureButton
{
    _button = [UIButton buttonWithType:UIButtonTypeSystem];
    _button.frame = self.bounds;
    [_button addTarget:self action:@selector(buttonTouch) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_button];
}

- (void)configureBack
{
    _back = [[UIView alloc] initWithFrame:self.bounds];
    _back.layer.cornerRadius = 5.f;
    _back.layer.masksToBounds = YES;
    _back.width -= 15;
    _back.layer.borderWidth = 0.5f;
    _back.layer.borderColor = [RGBACOLOR(204, 204, 204, 1) CGColor];
    _back.backgroundColor = AppColorWhite;
    [self addSubview:_back];
}

- (void)configureImg
{
    _img = [[UIImageView alloc] initWithFrame:CGRectMake(self.width - 20, 0, 15, self.height)];
    _img.image = [UIImage imageNamed:@"IW_lableImage"];
    [self addSubview:_img];
}

- (void)configureLabel:(NSString *)str
{
    _mark = str;
    [_mark retain];
    _label = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 280, self.height)];
    _label.text = _mark;
    _label.font = [UIFont systemFontOfSize:14];
    _label.textColor = RGBCOLORFLOAT(34);
    
    _length = AppGetTextWidth(_label);
    _label.width = _length;
    self.width = _length + 20;
    
}


- (void)dealloc
{
    [_back release];
    [_img release];
    [_label release];
    [_mark release];
    
    [super dealloc];
}

- (void)buttonTouch
{
    if (_delegate && [_delegate respondsToSelector:@selector(markView:didBeTouched:)])
    {
        [_delegate markView:self didBeTouched:_mark];
    }
}

#define WAIT_FILL NULL
- (void)smallMark:(UIImage *)image content:(NSString *)content
{
    //img to 10
    _label.text = content;
    _label.font = [UIFont systemFontOfSize:10];
    _label.textColor = RGBACOLOR(85, 85, 85, 1);
    _length = AppGetTextWidth(_label);
    _label.width = _length;
    self.width = _length + 15;
    _img.frame = CGRectMake(self.width - 15, 0, 10, self.height);
    _img.image = image;
    _back.backgroundColor = AppColorBackground;
    _back.width = _length;
}
@end
