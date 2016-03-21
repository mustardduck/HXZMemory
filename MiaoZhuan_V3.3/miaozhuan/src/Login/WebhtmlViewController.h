//
//  WebhtmlViewController.h
//  miaozhuan
//
//  Created by apple on 14/12/16.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebhtmlViewController : DotCViewController

@property (retain, nonatomic) NSString * navTitle;//标题

@property (retain, nonatomic) NSString * ContentCode;//内容号

-(void)showContent:(NSString *)code;

@end
