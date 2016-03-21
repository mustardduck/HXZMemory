//
//  MsgCollectionReusableView.m
//  miaozhuan
//
//  Created by momo on 15/4/28.
//  Copyright (c) 2015年 zdit. All rights reserved.
//

#import "MsgCollectionReusableView.h"

@implementation MsgCollectionReusableView

- (void)awakeFromNib {
    // Initialization code
}

- (void)dealloc {
    [_titleLbl release];
    [_msgLbl release];
    [_downloadBtn release];
    [super dealloc];
}

@end
