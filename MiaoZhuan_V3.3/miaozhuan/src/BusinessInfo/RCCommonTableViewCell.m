//
//  RCCommonTableViewCell
//  miaozhuan
//
//  Created by abyss on 14/11/1.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "RCCommonTableViewCell.h"
#import "UIView+expanded.h"

@implementation RCCommonTableViewCell
@synthesize hasTopLine = _hasTopLine;
@synthesize hasBottomLine = _hasBottomLine;
@synthesize hasSepLine = _hasSepLine;
@synthesize topLine = _topLine;
@synthesize bottomLine = _bottomLine;
@synthesize sepLine = _sepLine;

- (void)awakeFromNib
{
    // Initialization code
    _bottomLine.top += 0.5;
    _sepLine.top += 0.5;
}

- (void)setHasTopLine:(BOOL)hasTopLine
{
    _hasSepLine = hasTopLine;
    if (_hasSepLine)
    {
        _topLine.hidden = NO;
        _sepLine.hidden = NO;
    }
}

- (void)setHasBottomLine:(BOOL)hasBottomLine
{
    _hasBottomLine = hasBottomLine;
    if (_hasBottomLine)
    {
        _bottomLine.hidden = NO;
        _sepLine.hidden = YES;
    }
}

- (void)setHasSepLine:(BOOL)hasSepLine
{
    _hasSepLine = hasSepLine;
    if (_hasSepLine)
    {
        _sepLine.hidden = NO;
    }
    else
    {
        _sepLine.hidden = YES;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc
{
    [_img release];
    [_titleL release];
    [_topLine release];
    [_bottomLine release];
    [_sepLine release];
    
    [super dealloc];
}
@end

@implementation RCCommonTableViewCell (RCMethod)

- (void)layoutTheLineWithIndexPath:(NSIndexPath *)indexPath andEnd:(NSArray *)array
{
    self.hasSepLine = YES;
    if (indexPath.row == 0)
    {
        self.hasTopLine = YES;
    }
    
    NSArray * arr = array[indexPath.section];
    if(indexPath.row == arr.count - 1)
    {
        self.hasBottomLine = YES;
    }

//    NSInteger count;
//    if (!array) count = 1;
//    else count = array.count;
//    for (int i = 0; i < count; i ++)
//    {
//        NSLog(@"%d %@",i,((NSNumber *)array[i]));
//        if (indexPath.section == i && indexPath.row == ((NSNumber *)array[indexPath.section]).integerValue)
//        {
//            self.hasBottomLine = YES;
//        }
//    }
}

@end

@implementation UITableViewCell (RCMethod)

- (void)layoutTheViewBubbleWithImage:(UIImage *)image type:(BubbleCellType)type time:(NSString *)time;
{
    UILabel *timeL = [[[UILabel alloc] init]autorelease];
    timeL.text = time;
    //timelL initframe
    timeL.textColor = RGBCOLOR(153, 153, 153);
    timeL.font = [UIFont systemFontOfSize:10];
    timeL.backgroundColor = [UIColor clearColor];
    timeL.frame = CGRectMake(0, 10, 320, 15);
    timeL.textAlignment = UITextAlignmentCenter;
    [self.contentView addSubview:timeL];
    
    
    UIView *retView = WEAK_OBJECT(UIView, initWithFrame:CGRectZero);
    retView.backgroundColor = [UIColor clearColor];
    
    UIImageView *backgroundView = nil;
    
    if (image)
    {
        backgroundView = WEAK_OBJECT(UIImageView , initWithImage:[image stretchableImageWithLeftCapWidth:25 topCapHeight:14]);
    }
    else
    {
        backgroundView = WEAK_OBJECT(UIImageView, init);
    }
    
    CGSize size = [self getSize:nil];
    
    UILabel *bubbleText = [[UILabel alloc] initWithFrame:CGRectMake(type == BubbleCellTypeLeft?20.0f : 10.f, 5.0f, type == BubbleCellTypeLeft?size.width + 10 : size.width +10, size.height + 5)];
    bubbleText.backgroundColor = [UIColor clearColor];
    
    bubbleText.font = Font(15);
    
    bubbleText.textColor = self.textLabel.textColor;
    bubbleText.numberOfLines = 0;
    bubbleText.lineBreakMode = NSLineBreakByWordWrapping;
    bubbleText.text = self.textLabel.text;
    
    if (type == BubbleCellTypeLeft)
    {
        backgroundView.frame = CGRectMake(10, 5 + timeL.height + 10, bubbleText.width + 20, bubbleText.height + 10);
    }
    else
    {
        backgroundView.frame = CGRectMake(SCREENWIDTH - bubbleText.width - 30, 5 +  timeL.height + 10, bubbleText.width + 20, bubbleText.height + 10);
        
        bubbleText.textColor = [UIColor whiteColor];
    }
    
    [backgroundView addSubview:bubbleText];
    [self.contentView addSubview:backgroundView];
}

- (CGSize)getSize:(NSString *)text
{
    if (text)
    {
        self.textLabel.text = text;
    }
    return [self.textLabel.text sizeWithFont:Font(15) constrainedToSize:CGSizeMake(230.f, 1000.0f) lineBreakMode: NSLineBreakByWordWrapping];
}

- (CGFloat)getCellHeight:(NSString *)text
{
    return [self getSize:text].height + 20 + 40;
}

@end
