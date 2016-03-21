//
//  YinYuanADsDetailController.h
//  miaozhuan
//
//  Created by momo on 14-12-22.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YinYuanADsDetailController : UIViewController<UITableViewDataSource, UITableViewDelegate>

//状态：0. 草稿箱  1. 成功（播放中） 2.成功（即将播放） 3. 审核中 4.审核失败 5.已播完

@property (nonatomic, assign) int state;//状态
//广告id
@property (nonatomic, copy) NSString *advertId;
@property (retain, nonatomic) IBOutlet UITableView *mainTableView;
@property (retain, nonatomic) IBOutlet UIView *yinyuanView;

@end
