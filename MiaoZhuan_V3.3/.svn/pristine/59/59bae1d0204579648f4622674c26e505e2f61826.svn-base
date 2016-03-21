//
//  CRSelectTable.h
//  miaozhuan
//
//  Created by abyss on 14/12/23.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <Foundation/Foundation.h>

extern CGFloat CRSeletctTable_CellHeight;
@protocol CRSeletctTableDelegate;
@interface CRSelectTable : UIView
@property (retain, nonatomic) UIView* cover;
@property (assign, nonatomic) NSInteger selectCell;
@property (retain, nonatomic) NSArray*  buttonArray;
@property (assign) id<CRSeletctTableDelegate> cr_delegate;

- (instancetype)initWithFrame:(CGRect)frame delegate:(id<CRSeletctTableDelegate>)delegate;
@end

@protocol CRSeletctTableDelegate <NSObject>
@optional
- (void)selectTable:(CRSelectTable *)table didSelectedAt:(NSInteger)index with:(NSString *)data;
@end