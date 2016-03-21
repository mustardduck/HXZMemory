//
//  PlaceTableViewCell.m
//  miaozhuan
//
//  Created by abyss on 14/12/30.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "PlaceTableViewCell.h"
#import "GaoDeMapViewController.h"

@interface PlaceTableViewCell () <GetMapInformation>
@property (retain, nonatomic) IBOutlet UIView *c1;
@property (retain, nonatomic) IBOutlet UIView *c2;
@property (retain, nonatomic) IBOutlet UIView *addPlace;
@end
@implementation PlaceTableViewCell

- (void)awakeFromNib
{
}

//- (void)layoutSubviews
//{
//    CGSize size = [_t1.text sizeWithFont:_t1.font];
//    _add = size.height - 15;
//    
//    _t1.height += _add;
//    _t1.numberOfLines = 0;
//    _t1.lineBreakMode = NSLineBreakByCharWrapping;
//    _c1.top += _add;
//    _c2.top += _add;
//}

- (void)setPlace:(NSString *)place
{
    _t1.text = place;
    
    NSDictionary *attribute = @{NSFontAttributeName:_t1.font};
    
    CGSize retSize = CGSizeZero;
    
    if([UICommon getSystemVersion] >= 7.0)
    {
        retSize = [_t1.text boundingRectWithSize:CGSizeMake(_t1.width, MAXFLOAT)
                   
                                         options:\
                   
                   NSStringDrawingTruncatesLastVisibleLine |
                   
                   NSStringDrawingUsesLineFragmentOrigin |
                   
                   NSStringDrawingUsesFontLeading
                   
                                      attributes:attribute
                   
                                         context:nil].size;
    }
    else
        retSize = [_t1.text sizeWithFont:_t1.font constrainedToSize:CGSizeMake(_t1.width, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
    
    _add = retSize.height - 16.7;
    
    if (_add < 2)
    {
        _add = 0;
    }
    
    _t1.height += _add + 5;
    
    _c1.top = 61  + _add;
    _c2.top = 117 + _add;
    
        if([UICommon getSystemVersion] >= 7.0)
    {
        retSize = [_t3.text boundingRectWithSize:CGSizeMake(_t3.width, MAXFLOAT)
                   
                                         options:\
                   
                   NSStringDrawingTruncatesLastVisibleLine |
                   
                   NSStringDrawingUsesLineFragmentOrigin |
                   
                   NSStringDrawingUsesFontLeading
                   
                                      attributes:attribute
                   
                                         context:nil].size;
    }
    else
        retSize = [_t3.text sizeWithFont:_t3.font constrainedToSize:CGSizeMake(_t3.width, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
    
    float add_2 = retSize.height - 16.7;
    
    if (add_2 < 5)
    {
        add_2 = 0;
    }
    
    _add += add_2;
    _t3.height = retSize.height + 2;
    _addPlace.top += add_2;

    [self addSubview:_addL];
}

//- (void)layoutSubviews
//{
//    _addL.frame = CGRectMake(0 , 190 + _add - 0.5, 320, 0.5);
//}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)mapBt:(id)sender
{
    if(!_isDisable)
    {
        GaoDeMapViewController *map = WEAK_OBJECT(GaoDeMapViewController, init);
        map.latidiute = _l1;
        //    map.latidiute = 29.51;
        map.longitude = _l2;
        //    map.longitude = 106.45;
        map.hiddenRightItem = YES;
        map.delegate = self;
        map.markScrollWithMap = 1;
        [UI_MANAGER.mainNavigationController pushViewController:map animated:YES];
    }
}

- (IBAction)phoneBt:(id)sender
{
    if(!_isDisable)
    {
        [[UICommon shareInstance] makeCall:_phone?_phone:kServiceMobile];
    }
}

- (void)dealloc
{
    [_t1 release];
    [_t2 release];
    [_t3 release];
    [_c1 release];
    [_c2 release];
    [_addPlace release];
//    [_huo release];
    [_phoneBtns release];
    [super dealloc];
}
@end
