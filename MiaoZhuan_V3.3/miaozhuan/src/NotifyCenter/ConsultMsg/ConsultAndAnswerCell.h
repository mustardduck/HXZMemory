//
//  ConsultAndAnswerCell.h
//  miaozhuan
//
//  Created by Santiago on 14-12-6.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol DelMessageCell;
@interface ConsultAndAnswerCell : UITableViewCell

@property (retain, nonatomic) IBOutlet UIButton *delBtn;
@property (strong, nonatomic) NSString *messageID;
@property (assign, nonatomic) int cellType;
@property (strong, nonatomic) NSIndexPath *thisIndexPath;
@property (assign, nonatomic) id<DelMessageCell>delegate;

@property (retain, nonatomic) IBOutlet UILabel *messageDate;
@property (retain, nonatomic) IBOutlet UILabel *consultText;
@property (retain, nonatomic) IBOutlet UILabel *answerText;
@property (retain, nonatomic) IBOutlet UIView *littleGrayLine;

@property (retain, nonatomic) IBOutlet UIImageView *consultMessage;
@property (retain, nonatomic) IBOutlet UIImageView *answerImage;
@property (retain, nonatomic) IBOutlet UILabel *fromCompanyName;
@property (retain, nonatomic) IBOutlet UIView *UIButtomLineView;

@property (retain, nonatomic) IBOutlet UIImageView *delMessageImage;
@property (retain, nonatomic) IBOutlet UILabel *fromMerchantTitle;

@property (retain, nonatomic) IBOutlet UIView *topGrayView;

@property (retain, nonatomic) IBOutlet UIView *earlierReplyView;
@property (retain, nonatomic) IBOutlet UILabel *earlierReplyText;
@end

@protocol DelMessageCell <NSObject>
-(void) deleteMessage:(ConsultAndAnswerCell*)cell atIndexPath:(NSIndexPath*)indexPath;
@end