//
//  CRShoppingTableViewCell.m
//  miaozhuan
//
//  Created by abyss on 14/12/20.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "CRShoppingTableViewCell.h"
#import "NetImageView.h"
#import "CRString.h"

@interface CRShoppingTableViewCell ()
@property (retain, nonatomic) IBOutlet NetImageView *img;
@property (retain, nonatomic) IBOutlet UILabel *title;
@property (retain, nonatomic) IBOutlet UILabel *price;
//yin
@property (retain, nonatomic) IBOutlet UIImageView *you;
@property (retain, nonatomic) IBOutlet UIImageView *map;
@property (retain, nonatomic) IBOutlet UILabel *distance;
@property (retain, nonatomic) IBOutlet UIView *yinView;
@property (retain, nonatomic) IBOutlet UIImageView *distanceHead;
@property (retain, nonatomic) IBOutlet UIImageView *tuijianImage;

@end
@implementation CRShoppingTableViewCell

- (void)awakeFromNib
{
    _yinView.hidden = YES;
    [_img setBorderWithColor:AppColor(220)];
    
    UIView* view = WEAK_OBJECT(UIView, initWithFrame:CGRectMake(15, 109.5, 320, 0.5));
    view.backgroundColor = AppColor(197);
    [self.contentView addSubview:view];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setData:(DictionaryWrapper *)data
{
    if (data)
    {
        _data = data;
        [data retain];
        
        if (_isYinCell)
        {
            [_img requestPic:[_data getString:@"PictureUrl"] placeHolder:YES];
            _title.text = [_data getString:@"Name"];
            
            if ([_data getBool:@"IsRecommend"] == YES)
            {
                _tuijianImage.hidden = NO;
            }
            
            NSString *tempStr1 = @"所需银元 ";
            NSString *tempStr2 = [_data getString:@"UnitIntegral"];
            NSString *tempStr = [tempStr1 stringByAppendingString:tempStr2?tempStr2:@""];
            CRString *str = [[[CRString alloc] initWithString:tempStr] autorelease];
            
            [str setFont:Font(15) rangeStart:5 by:[tempStr length] - 5];
            [str setColor:AppColorRed rangeStart:5 by:[tempStr length] - 5];
            _price.attributedText = str.attributedString;
            
            BOOL hasDistance = YES;
            NSString * distance = [_data getString:@"Distance"];
            if (!distance || distance.length < 1)
            {
                hasDistance = NO;
            }
            
            int type = [_data getInt:@"ExchangeType"];
            if (type == 1)
            {
                _map.left   = _you.left;
                _you.hidden = YES;
                 _yinView.hidden = NO;
            }
            else if (type == 2)
            {
                _yinView.hidden = YES;
                _map.hidden = YES;
            }
            else
            {
                _yinView.hidden = NO;
            }
            if (!hasDistance)  _yinView.hidden = YES;
            _distance.text = distance;
        }
        else
        {
            [_img requestPic:[_data getString:@"PictureUrl"] placeHolder:YES];
            _title.text = [_data getString:@"ProductName"];
            
            NSString *tempStr1 = @"所需易货码 ";//momo_v3.3
            NSString *tempStr = [tempStr1 stringByAppendingString:[NSString stringWithFormat:@"%.2f",[_data getDouble:@"Price"]]];
            CRString *str = [[[CRString alloc] initWithString:tempStr] autorelease];
            _price.top -= 15.f;
            
            [str setFont:BoldFont(15) rangeStart:5 by:[tempStr length] - 5];
            [str setColor:AppColorRed rangeStart:5 by:[tempStr length] - 5];
            _price.attributedText = str.attributedString;
            
            _map.hidden = YES;
            _you.hidden = YES;
        }
        
        _distanceHead.left = 300 - [_distance.text sizeWithFont:Font(11)].width - 196 - 5;
        
        
        
        if (_isYinCell)
        {
            if ([_title.text sizeWithFont:_title.font].width > 200)
            {
                _title.top = 15;
                _map.top   = 56;
                _you.top = _map.top;
                _price.top = 80;
                _title.height = 40;
                
                _yinView.bottom = _price.bottom;
            }
            else
            {
                _title.top = 25;
                _map.top   = 50;
                _you.top = _map.top;
                _price.top = 72;
                
                _yinView.bottom = _price.bottom;
                
            }
        }
        else
        {
            if ([_title.text sizeWithFont:_title.font].width > 200)
            {
                _title.top = 24;
                _price.top = 70;
                _title.height = 40;
                
                _yinView.bottom = _price.bottom;
            }
            else
            {
                _title.top = 32;
                _price.top = 62;
                
                _yinView.bottom = _price.bottom;
            }
        }

//        if ([_title.text sizeWithFont:_title.font].width > 200 && !_isYinCell)
//        {
//            _title.top += 10;
//            _price.top += 4;
//            
//        }
//        else if ([_title.text sizeWithFont:_title.font].width < 200  && !_isYinCell)
//        {
//            _title.top += 6;
//            _price.top -= 3;
//        }
    }
}

- (void)dealloc
{
    [_img release];
    [_title release];
    [_price release];
    [_you release];
    [_map release];
    [_distance release];
    [_yinView release];
    [_distanceHead release];
    [_tuijianImage release];
    [super dealloc];
}
@end
