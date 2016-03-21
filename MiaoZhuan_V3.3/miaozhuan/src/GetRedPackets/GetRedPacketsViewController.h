//
//  GetRedPacketsViewController.h
//  miaozhuan
//
//  Created by Santiago on 14-10-23.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GetRedPacketDelegate <NSObject>

//调用未拆红包数量接口
-(void)calculateRedCount;

@end

@interface GetRedPacketsViewController : DotCViewController

@property(nonatomic, assign) id<GetRedPacketDelegate>   delegate;

@end
