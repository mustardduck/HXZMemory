//
//  CRShoppingContentView.m
//  miaozhuan
//
//  Created by abyss on 14/12/26.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "CRShoppingContentView.h"
#import "CRButtonContainer.h"
#import "CRArrow.h"

@interface CRShoppingContentView () <CRButtonContainerDelegate,CRArrowDelegate>
{
    Class           _buttonClass;
    BOOL            _open;
    BOOL            _layoutDone;
    UIView*         _add;
    CRArrow*        _arrow;
    NSInteger       _waitExchange;
    NSMutableArray* _retArray;
    
    //settring
    CGFloat         _defalut_Height;
    CGFloat         _defalut_margin;
    NSInteger       _defalut_itemCount;
}
@property (retain, nonatomic) CRButtonContainer *buttonContainer;
@end
@implementation CRShoppingContentView

- (void)dealloc
{
    [_buttonContainer release];
    [_arrow release];
    [_add release];
    
    CRDEBUG_DEALLOC();
    [super dealloc];
}

- (instancetype)initWithFrame:(CGRect)headFrame with:(NSArray *)buttonArray delegate:(id<CRShoppingContentViewDelegate>)delegate
{
    self = [super initWithFrame:headFrame];
    if (self)
    {
        {
            [self setDelegate:delegate];
            
            _defalut_Height     = 30.f;
            _defalut_margin     = 5.f;
            _defalut_itemCount  = 4;
        }
        
        buttonArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"CRShoppingContent"];
        if (!buttonArray || buttonArray.count <= 1)
        {
            ADAPI_adv3_GetProductCatagorys([GLOBAL_DELEGATOR_MANAGER addDelegator:self selector:@selector(isDone:)]);
        }
        else
        {
            _buttonContainer = OBJECT_NEW_STRONG(CRButtonContainer,
                                                 initWith:[buttonArray copy]
                                                 delegate:self
                                                 height:_defalut_Height);
            _retArray = [buttonArray copy];
        }
        _add   = [[UIView alloc] init];
        _arrow  = [[CRArrow alloc] initWithType:CRArrowLayerTypeBottom delegate:self];
        
        _buttonClass     = _buttonContainer.buttonClass;
        
        self.backgroundColor = AppColorWhite;
    }
    return self;
}

- (void)isDone:(DelegatorArguments *)arg
{
    if (arg.ret.operationSucceed)
    {
        NSArray *array  = arg.ret.data;
        _retArray       = [NSMutableArray array];
        if (array)
        {
            [_retArray addObject:@{@"title":@"全部",@"data":@0}];
            for (NSDictionary *dic in array)
            {
                [_retArray addObject:@{@"title":[dic objectForKey:@"CatagoryName"],@"data":[dic objectForKey:@"CatagoryId"]}];
            }
            
            if(_retArray.count > 3)
            {
                [[NSUserDefaults standardUserDefaults] setObject:_retArray forKey:@"CRShoppingContent"];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }
            
            _buttonContainer = OBJECT_NEW_STRONG(CRButtonContainer,
                                                 initWith:[_retArray copy]
                                                 delegate:self
                                                 height:_defalut_Height);
            
            [_retArray retain];
            [self layoutSubviews];
        }
    }
}

#pragma mark - Layout

- (void)layoutSubviews
{
    if (_layoutDone || !cr_buttonObjectArray || [cr_buttonObjectArray count] == 0)
    {
        [self setHeight:_open?35 + _add.height : 35];
        return;
    }
    [self.superview bringSubviewToFront:self];
    
    _visiableButtons    = nil;
    _unVisiableButtons  = nil;
    
    CGFloat offset      = 0;
    NSInteger count     = 0;
    //get headButtons
    {
        _visiableButtons    = [NSMutableArray new];
        _unVisiableButtons  = [NSMutableArray new];
        
        CGFloat headLength  = 0;
        BOOL    headUnit    = YES;
        for (Class object in cr_buttonObjectArray)
        {
            NSString* str = nil;
            
            str = ((UIButton *)object).titleLabel.text;
            
            CGSize size = CGSizeZero;
            
            if([UICommon getSystemVersion] >= 7.0)
                size = [str sizeWithAttributes:@{NSFontAttributeName:Font(12)}];
            else
                size = [str sizeWithFont:Font(12)];
            
            ((UIButton *)object).frame = (CGRect){headLength,0,size.width + _defalut_margin*2, 35};
            
            headLength += size.width + _defalut_margin*2;
            
            if(headLength < SCREENWIDTH - _defalut_Height && headUnit)
            {
                [_visiableButtons addObject:object];
                count ++;
            }
            else
            {
                if (headUnit)
                {
                    headLength -= size.width + _defalut_margin*2;
                    offset      = SCREENWIDTH - _defalut_Height - headLength;
                    
                    APP_ASSERT(offset > 0);
                    headUnit = NO;
                    [_unVisiableButtons addObject:object];
                }
                else
                {
                    [_unVisiableButtons addObject:object];
                }
            }
        }
        
    }
    
    CGFloat ref = (float)(offset / count);
    int n = 0;
    for (Class object in _visiableButtons)
    {
        ((UIButton *)object).frame = CGRectMake(((UIButton *)object).left + (n++)*ref, 0.5, ((UIButton *)object).width + ref, 35 - 0.5);
        ((UIButton *)object).titleLabel.font = Font(12);
        ((UIButton *)object).backgroundColor = AppColorWhite;
        [((UIButton *)object) setTitleColor:AppColor(43) forState:UIControlStateNormal];
        [((UIButton *)object) setTitleColor:AppColorRed forState:UIControlStateSelected];
        [self addSubview:(UIView *)object];
    }
    
    {
        UIView* v = WEAK_OBJECT(UIView, initWithFrame:CGRectMake(0, 0, 320, 0.5));
        v.backgroundColor = AppColor(204);
        [self addSubview:v];
    }
    [self addSubview:_add];
    [self addSubview:_arrow];
    
    CGFloat buttonWidth     = self.width/_defalut_itemCount;
    if (0 == buttonWidth) LOG_DBUG(@"button width is nil");
    if (0 == [_unVisiableButtons count] || _unVisiableButtons == nil)
        LOG_DBUG(@"unVisiableButtons is nil");

    
    int i           = 0;
    int j           = 0;
    int k           = 0;
    CGFloat left    = 0;
    UIView *line    = nil;
    for (Class object in _unVisiableButtons)
    {
        
        {
            ((UIButton *)object).frame = CGRectMake(left, 5 + j*30, buttonWidth, _defalut_Height);
            ((UIButton *)object).backgroundColor = AppColor(247);
            ((UIButton *)object).titleLabel.font = Font(11);
            ((UIButton *)object).titleLabel.textColor = AppColor(34);
            i++;
            k++;
            left += buttonWidth;
        }
        
        if (i == 4 || k == [_unVisiableButtons count])
        {
            left = 0;
            i    = 0;
            j++;
        }
        else
        {
            line = WEAK_OBJECT(UIView, initWithFrame:CGRectMake(left - 0.5, 10 + j*30, 0.5, 15));
            line.backgroundColor = AppColor(204);
            [_add addSubview:line];
        }
        
        [_add addSubview:(UIView *)object];
        [_add addSubview:line];
    }
    
    _add.hidden             = YES;
    _add.backgroundColor    = AppColor(247);
    _add.frame              = CGRectMake(0, 35, 320, j*30 + 10);

    {
        UIView* v = WEAK_OBJECT(UIView, initWithFrame:CGRectMake(0, _add.height - 0.5, 320, 0.5));
        v.backgroundColor = AppColor(204);
        [_add addSubview:v];
        
        UIView* v1 = WEAK_OBJECT(UIView, initWithFrame:CGRectMake(0, 0.5, 320, 0.5));
        v1.backgroundColor = AppColor(204);
        [_add addSubview:v1];
    }
    [self setHeight:35];
    _arrow.frame = CGRectMake(SCREENWIDTH - _defalut_Height, 2.5 , _defalut_Height, _defalut_Height);
    _arrow.backgroundColor = AppColorWhite;
    
    [_buttonContainer needAutoawakNow];
    _layoutDone = YES;
}

- (void)buttonContainer:(CRButtonContainer *)view willRefreshData:(BOOL)shouldRemoveAllButtonsBefore
{
    [self removeAllSubviews];
}

- (void)buttonContainer:(CRButtonContainer *)view button:(id)button shouldResponseButtonTouchAt:(NSInteger)buttonIndex
{
    if (_open)
    {
        int tag     = 0;
        int change  = 0;
        for (Class object in cr_buttonObjectArray)
        {
            if (((UIButton *)object).tag == ((UIButton *)button).tag)
            {
                
                change = tag;
                continue;
            }
            tag ++;
        }
        
        [self arrow:_arrow click:NO];
        _arrow.arrowOpen = NO;
        
        if (_waitExchange <= 1) _waitExchange = 2;
        if (change == 0) change = 1;
        [_buttonContainer exchangeButton:change to:_waitExchange - 1];
        NSLog(@"swap ===\n %d to %d",change,_waitExchange - 1);
        _layoutDone = NO;
        [self layoutSubviews];
    }
    else
    {
        int tag     = 0;
        int change  = 0;
        for (Class object in cr_buttonObjectArray)
        {
            if (((UIButton *)object).tag == ((UIButton *)button).tag)
            {
                
                change = tag;
                continue;
            }
            tag ++;
            ((UIButton *)object).selected = NO;
        }
        ((UIButton *)button).selected = YES;

        _waitExchange = change;
        NSLog(@"~~~~~\n %d",_waitExchange - 1);
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(shoppingContentView:button:didTouchAt:data:)])
    {
        NSString *data = nil;
        for (NSDictionary *DIC in _retArray)
        {
            if([[DIC.wrapper getString:@"title"] isEqualToString:((UIButton *)button).titleLabel.text])
            {
                data = [DIC.wrapper getString:@"data"];
            }
        }
        [_delegate shoppingContentView:self button:button didTouchAt:_waitExchange data:data];
    }
    
    {
        [[NSUserDefaults standardUserDefaults] setObject:_buttonContainer.buttonArray forKey:@"CRShoppingContent"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (void)arrow:(CRArrow *)arrow click:(BOOL)open
{
    if (open)
    {
        [arrow setUp];
        _open       = YES;
        _add.hidden = NO;
        
        [self layoutSubviews];
    }
    else
    {
        [arrow setDown];
        _open       = NO;
        _add.hidden = YES;
        
        [self layoutSubviews];
    }
}


@end
