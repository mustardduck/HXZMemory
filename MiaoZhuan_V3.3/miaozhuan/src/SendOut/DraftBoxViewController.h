//
//  DraftBoxViewController.h
//  miaozhuan
//
//  Created by 孙向前 on 14-11-19.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DraftBoxViewController : UIViewController
//状态：0、待审核。1、播放中，（1包含了2和3）2、正在播放，3、即将播放，
//4、审核中，5、审核失败，6、播放完毕。
@property (nonatomic, assign) int state;//状态

@end
