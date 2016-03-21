//
//  DataAdvertTableViewCell.m
//  miaozhuan
//
//  Created by abyss on 14/11/10.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "DataAdvertTableViewCell.h"

@implementation DataAdvertTableViewCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setName:(NSString *)name
{
    if (name && name.length > 0)
    {
        _advertName.text = name;
        
        if (_type) {//精准直投
            if ([_advertName.text sizeWithFont:_advertName.font].width > 200)
            {
                _advertName.top = 26;
                _text_1.top     = 68;
                _text_2.top     = 86;
                _text_3.top = 104;
                _advertName.height = 38;
                _playNum.top = _text_1.top;
                _costNum.top = _text_2.top;
                _lblWatched.top = _text_3.top;
                
            }
            else
            {
                _advertName.top = 35;
                _text_1.top     = 60;
                _text_2.top     = 78;
                _text_3.top = 96;
                _playNum.top = _text_1.top;
                _costNum.top = _text_2.top;
                _lblWatched.top = _text_3.top;
            }
        } else {
            self.lblWatched.hidden = _text_3.hidden = YES;
            if ([_advertName.text sizeWithFont:_advertName.font].width > 200)
            {
                _advertName.top = 36;
                _text_1.top     = 78;
                _text_2.top     = 96;
                _advertName.height = 38;
                _playNum.top = _text_1.top;
                _costNum.top = _text_2.top;
                
            }
            else
            {
                _advertName.top = 45;
                _text_1.top     = 70;
                _text_2.top     = 88;
                _playNum.top = _text_1.top;
                _costNum.top = _text_2.top;
            }

        }
        
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [_advertImg release];
    [_advertName release];
    [_playNum release];
    [_costNum release];
    [_flagImg release];
    [_flagL release];
    [_text_1 release];
    [_text_2 release];
    [super dealloc];
}
@end
