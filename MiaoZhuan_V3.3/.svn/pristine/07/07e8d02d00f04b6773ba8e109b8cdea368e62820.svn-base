//
//  HeaderCollectionCell.h
//  guanggaoban
//
//  Created by abyss on 14-8-22.
//  Copyright (c) 2014年 Arvin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PSTCollectionView.h"

@interface HeaderCollectionCell : PSTCollectionViewCell

//ID , Test
@property (retain, nonatomic) NSDictionary*  data;
//@property (retain, nonatomic) UIView*        coverView;
@property (nonatomic ,retain) UIButton *btnItem;
@property (retain, nonatomic) UIImageView*   coverView;
@property (assign, nonatomic) BOOL           showHolder;
@property (assign, nonatomic) BOOL           dragable;
@property (assign, nonatomic) BOOL           curTag;

- (void)getData:(NSDictionary *)data;

@end

@interface  FloatCell : HeaderCollectionCell

@property (retain, nonatomic) NSDictionary*     floatData;

- (void)floatWithCell:(HeaderCollectionCell *)Cell data:(NSDictionary *)floatData;
- (void)stopFloat;
- (BOOL)isFloating;

@end