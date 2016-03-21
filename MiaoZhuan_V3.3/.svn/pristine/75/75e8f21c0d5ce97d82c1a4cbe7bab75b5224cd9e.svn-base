//
//  CRTableSectionBar.h
//  miaozhuan
//
//  Created by abyss on 15/1/23.
//  Copyright (c) 2015年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CRTableSectionBarItem;
@class CRTableSectionBarController;
extern CGFloat CRTS_Callout_Padding;

typedef NS_ENUM(NSInteger, CRTablePosition)
{
    CRTablePositionRight    = 0,
    CRTablePositionLeft     = 1,
};

@protocol CRTableSectionBarDelegate <NSObject>
@required
- (CRTableSectionBarItem *) sectionSelectionView:(CRTableSectionBarController *)sectionSelectionView sectionSelectionItemViewForSection:(NSInteger)section;
- (NSInteger) numberOfSectionsInSectionSelectionView:(CRTableSectionBarController *)sectionSelectionView;
- (UIView *) sectionSelectionView:(CRTableSectionBarController *)sectionSelectionView callOutViewForSelectedSection:(NSInteger)section;
@optional
- (void) sectionSelectionView:(CRTableSectionBarController *)sectionSelectionView didSelectSection:(NSInteger)section;
@end
@interface CRTableSectionBarController : UIView
@property (assign, nonatomic) id<CRTableSectionBarDelegate> delegate;

@property (assign, nonatomic) CRTablePosition position;
@property (assign, nonatomic) BOOL showCallout;

@property (assign, nonatomic, readonly) NSInteger numOfItems;

+ (CRTableSectionBarController *)controllerFrom:(UITableView *)tableView;
+ (CRTableSectionBarController *)controllerFrom:(UITableView *)tableView
                                             on:(CRTablePosition)diretion
                                           with:(CGFloat)width;

- (void)reloadData;
@end

@interface CRTableSectionBarItem : UIView
@property (retain, nonatomic) UIView* contentView;
@property (retain, nonatomic) UIImageView* bgImgView;
@property (retain, nonatomic) UILabel* titleLabel;
@property (assign, nonatomic) NSInteger section;

- (void)setSelected:(BOOL)selected animated:(BOOL)animated;
- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated;
@end