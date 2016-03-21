//
//  RCButton.m
//  miaozhuan
//
//  Created by abyss on 14/11/12.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "RCButton.h"
#import "Define+RCMethod.h"
#import "RRAttributedString.h"

@interface RCButton ()
{
    RCButton *_holderInstance;
}
@end
@implementation RCButton
- (void)setup:(RCButtonType)type
{
    switch (type) {
        case RCButtonTypeCountdown:
        {
            _holderInstance = [[CountdownButton alloc] initWithFrame:self.frame];
        }
            
        default:
            break;
    }
    [self release];
}
- (instancetype)initWithFrame:(CGRect)frame type:(RCButtonType)type
{
    INSTANCE_INIT_FRAME();
    INSTANCE_SETUP_WITHPARA(type);
    return _holderInstance;
}

@end

@interface CountdownButton ()
{
}
@end
@implementation INSTANCE_CLASS_SETUP(CountdownButton)
@synthesize delegate = _delegate;
@synthesize startTitle = _startTitle;
@synthesize midTitle = _midTitle;
@synthesize endTitle = _endTitle;
@synthesize secounds = _secounds;

- (void)dealloc
{
    [super dealloc];
}

- (void)setup
{
    [self defualtSetting];
    [self addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
    if ( _delegate && [_delegate respondsToSelector:@selector(buttonCountWillBegin:)])
    {
        [_delegate buttonCountWillBegin:self];
    }
    [self setTitle:_startTitle forState:UIControlStateNormal];
}

- (void)defualtSetting
{
    _startTitle = @"1";
    _midTitle   = @"2";
    _endTitle   = @"3";
    _secounds   = 60;
}

- (void)start
{
    __block int64_t timeout = (int64_t)_secounds; //倒计时时间
    __block NSString *title = nil;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0);
    BLOCK_GET_SEALF(CountdownButton);
    __block id<CDButtonDelegate> weakDelegate = _delegate;
    dispatch_source_set_event_handler(_timer, ^{
        if (timeout <= 0)
        {
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                if ( weakDelegate && [weakDelegate respondsToSelector:@selector(buttonCountEnd:)])
                {
                    [weakDelegate buttonCountEnd:blockself];
                }
                title = _endTitle;
                [blockself setTitle:title forState:UIControlStateNormal];
                [blockself setEnabled:YES];
            });
        }
        else
        {
#warning 根本停不下来！
            if (![self isTurnOffTimer]) return;
            int64_t seconds = timeout;
            NSString *strS = [NSString stringWithFormat:@"%.2lld", seconds];
            NSLog(@"%@",strS);
            dispatch_async(dispatch_get_main_queue(),^{
                [blockself setEnabled:NO];
                if ( weakDelegate && [weakDelegate respondsToSelector:@selector(buttonCountDidBegin:)])
                {
                    [weakDelegate buttonCountDidBegin:self];
                }
                title = [NSString stringWithFormat:@"%@%@",strS,_midTitle];
                NSAttributedString *colorTitle = [RRAttributedString setText:title color:AppColorRed range:NSMakeRange(0, strS.length)];
                [blockself setAttributedTitle:colorTitle forState:UIControlStateNormal];
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}

- (BOOL)isTurnOffTimer
{
    return [self isKindOfClass:[CountdownButton class]];
}


#pragma setter

- (void)setStartTitle:(NSString *)startTitle
{
    _startTitle = startTitle;
    [self setTitle:startTitle forState:UIControlStateNormal];
}

- (void)setMidTitle:(NSString *)midTitle {  _midTitle = midTitle;}
- (void)setEndTitle:(NSString *)endTitle {  _endTitle = endTitle;}
- (void)setSecounds:(NSInteger)secounds  {  _secounds = secounds;}

- (id)abstractInstance
{
    switch (self.type) {
        case RCButtonTypeCountdown:
        {
            return ((CountdownButton *)self);
        }
            
        default:
            return self;
            break;
    }
}
@end

@interface HightedButton ()
@end
@implementation INSTANCE_CLASS_SETUP(HightedButton)
@synthesize HightedImage = _HightedImage;
@synthesize NormalImage = _NormalImage;

- (void)setup
{
    _NormalImage = [UIImage imageNamed:@"white@2x.png"];
    _HightedImage = [UIImage imageNamed:@"color220@2x.png"];
    [self setBackgroundImage:_NormalImage forState:UIControlStateNormal];
    [self setBackgroundImage:_HightedImage forState:UIControlStateHighlighted];
}

- (void)setHightedImage:(UIImage *)HightedImage
{
    _HightedImage = HightedImage;
    [_HightedImage retain];
    [self setBackgroundImage:_HightedImage forState:UIControlStateHighlighted];
}

- (void)setNormalImage:(UIImage *)NormalImage
{
    _NormalImage = NormalImage;
    [_NormalImage retain];
    [self setBackgroundImage:_NormalImage forState:UIControlStateNormal];
}

@end

@interface NotifyButton ()
{
    BOOL turnOn;
    CGPoint _ori;
}
@end
@implementation INSTANCE_CLASS_SETUP(NotifyButton)
@synthesize delegate = _delegate;
@synthesize color = _color;
@synthesize num = _num;

- (void)dealloc
{
    [_color release];
    
    [super dealloc];
}

- (void)callUp
{
    self.hidden = NO;
    if (_delegate && [_delegate respondsToSelector:@selector(buttonShouldCallUp:)]) {
        [_delegate buttonShouldCallUp:self];
    }
}

- (void)setup
{
    [self setupPanGes];
    [self setRoundCornerAll];
    [self setTitleColor:AppColorWhite forState:UIControlStateNormal];
    self.color = AppColorRed;
    _num = INTMAX_MIN;
    
    _ori = CGPointMake(self.left, self.top);
    [self animationCompletion:NULL];
}

- (int64_t)num
{
    return _num;
}

- (void)setNum:(int64_t)num
{
    __block int64_t t = num;
    __block int64_t ori_t = _num;
    BLOCK_GET_SEALF(NotifyButton);
    [self animationCompletion:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            if (ori_t != t )
            {
                if (t < 0)
                {
                    [blockself setTitle:@"" forState:UIControlStateNormal];
                }
                else if (0 == t)
                {
                    blockself.hidden = YES;
                }
                else if (t > 99)
                {
                    [blockself setTitle:@"..." forState:UIControlStateNormal];
                }
                else
                {
                    [blockself setTitle:[NSString stringWithFormat:@"%lld",t] forState:UIControlStateNormal];
                }
            }
            _num = t;
        });
    }];
}

- (UIColor *)color
{
    return _color;
}

- (void)setColor:(UIColor *)color
{
    _color = color;
    [_color retain];
    self.backgroundColor = _color;
}

#pragma mark - private

- (void)animationCompletion:(void (^)())completion
{
    if (NO == turnOn)
    {
        BLOCK_GET_SEALF(NotifyButton);
        turnOn = YES;
        self.alpha = 0;
        [UIView animateWithDuration:0.33 animations:^{
            blockself.alpha = 1;
        } completion:^(BOOL finished){
            turnOn = NO;
            if (completion)
            {
                completion();
            }
        }];
    }
    else
    {
        if (completion)
        {
            completion();
        }
    }
}

- (void)setupPanGes
{
    UIPanGestureRecognizer *pan = WEAK_OBJECT(UIPanGestureRecognizer, initWithTarget:self action:@selector(pan:));
    [self addGestureRecognizer:pan];
}

- (void)pan:(UIGestureRecognizer *)sender
{
    CGPoint point = [sender locationInView:APP_DELEGATE.window];
    point.y -= 64;
    static CGPoint startPoint;
    float x;
    
    //滑动开始
    if (sender.state == UIGestureRecognizerStateBegan)
    {
        startPoint = point;
    }
    
    //滑动中
    else if (sender.state == UIGestureRecognizerStateChanged)
    {
        self.center = CGPointMake(point.x, point.y);
        x = hypotf((point.x - startPoint.x), (point.y - startPoint.y));
        self.alpha = 1 - (x - 20)*0.008;
        
    }
    
    //滑动结束
    else if  (sender.state == UIGestureRecognizerStateEnded || sender.state == UIGestureRecognizerStateCancelled)
    {
        x = hypotf((point.x - startPoint.x), (point.y - startPoint.y));
        if (x > 100)
        {
            self.hidden = YES;
            if(_delegate && [_delegate respondsToSelector:@selector(buttonShouldRemove:)])
            {
                [_delegate buttonShouldRemove:self];
            }
        }
        else
        {
            self.alpha = 1;
            self.center = CGPointMake(_ori.x, _ori.y);
        }
    }

}

@end





