//
//  ProductOrderMsgTableViewCell.h
//  miaozhuan
//
//  Created by abyss on 14/12/5.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetImageView.h"
#import "CRHolderView.h"
#import "NotifyCenterDefine.h"

@protocol cr_NCCellDelegate;
@interface ProductOrderMsgTableViewCell : UITableViewCell
@property (retain, nonatomic) IBOutlet NetImageView *itemImg;
@property (retain, nonatomic) IBOutlet UILabel *timeL;
@property (retain, nonatomic) IBOutlet UILabel *statuL;
@property (retain, nonatomic) IBOutlet UILabel *contentL;
@property (retain, nonatomic) NSAttributedString *CRcontent;

@property (retain, nonatomic) IBOutlet UILabel *titleL;
@property (retain, nonatomic) IBOutlet UILabel *colorL;
@property (retain, nonatomic) IBOutlet UILabel *priceL;
@property (retain, nonatomic) IBOutlet UIImageView *line;

@property (retain, nonatomic) IBOutlet UIButton *touchBt;
@property (retain, nonatomic) IBOutlet UIButton *deleteBt;

//must
@property (assign, nonatomic) NSInteger deleteType;
@property (retain, nonatomic) NSString *MsgIds;
@property (retain, nonatomic) NSString *Link;
@property (retain, nonatomic) NSIndexPath *fatherIndex;
@property (retain, nonatomic) DictionaryWrapper* data;
@property (assign, nonatomic) CRENUM_NCContentType type;
@property (assign, nonatomic) id<cr_NCCellDelegate> delegate;

@property (retain, nonatomic) IBOutlet UILabel *add_001;
@property (retain, nonatomic) IBOutlet UILabel *add_002;
@property (assign, nonatomic, readonly) CGFloat exFloat;
@end

@protocol cr_NCCellDelegate <NSObject>
@required
- (void)cell:(ProductOrderMsgTableViewCell *)cell DidBeDelete:(NSIndexPath *)indexPath;
@end