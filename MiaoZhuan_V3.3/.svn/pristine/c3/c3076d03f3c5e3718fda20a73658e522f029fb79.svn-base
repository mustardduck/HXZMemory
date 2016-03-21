//
//  OrderTableViewCell.h
//  miaozhuan
//
//  Created by abyss on 14/12/4.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CROrder.h"
#import "RRLineView.h"
@protocol OrderTableViewCellDelegate;
@interface OrderTableViewCell : UITableViewCell
@property (retain, nonatomic) CROrder *data;
@property (retain, nonatomic) NSIndexPath *fatherIndex;

@property (retain, nonatomic) IBOutlet RRLineView *cellLine;
@property (assign) id<OrderTableViewCellDelegate> delegate;
@end

@protocol OrderTableViewCellDelegate <NSObject>
@optional
- (void)orderDelete:(NSIndexPath *)deleteIndexPath;
- (void)orderRefresh:(NSIndexPath *)refreshIndexPath;
@end