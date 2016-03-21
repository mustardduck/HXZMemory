//
//  IWComplaintViewController.h
//  miaozhuan
//
//  Created by admin on 15/5/4.
//  Copyright (c) 2015年 zdit. All rights reserved.
//

#import "DotCViewController.h"

typedef void(^IWComplaintBlock)(NSString *code,NSString *reason);

@interface IWComplaintViewController : DotCViewController

@property (nonatomic,copy) IWComplaintBlock complaint;

@end
