//
//  RCCommonTableViewCell
//  miaozhuan
//
//  Created by abyss on 14/11/1.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RRLineView.h"

@interface RCCommonTableViewCell : UITableViewCell

@property (retain, nonatomic) IBOutlet UIImageView *img;
@property (retain, nonatomic) IBOutlet UILabel *titleL;
@property (retain, nonatomic) IBOutlet RRLineView *topLine;
@property (retain, nonatomic) IBOutlet RRLineView *bottomLine;
@property (retain, nonatomic) IBOutlet RRLineView *sepLine;




@property (assign, nonatomic) BOOL hasTopLine;
@property (assign, nonatomic) BOOL hasBottomLine;
@property (assign, nonatomic) BOOL hasSepLine;
@end

@interface RCCommonTableViewCell (RCMethod)

- (void)layoutTheLineWithIndexPath:(NSIndexPath *)indexPath andEnd:(NSArray *)array;
@end

typedef NS_ENUM(NSInteger, BubbleCellType)
{
    BubbleCellTypeLeft = 0,
    BubbleCellTypeRight,
};


@interface UITableViewCell (RCMethod)
- (void)layoutTheViewBubbleWithImage:(UIImage *)image type:(BubbleCellType)type time:(NSString *)time;
- (CGFloat)getCellHeight:(NSString *)text;
@end