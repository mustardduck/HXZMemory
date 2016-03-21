//
//  BusinessInfoManagerViewController.h
//  miaozhuan
//
//  Created by abyss on 14/11/10.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetImageView.h"

@class InfoModelViewController;
@interface BusinessInfoManagerViewController : DotCViewController
//header
@property (retain, nonatomic) IBOutlet NetImageView *img;
@property (retain, nonatomic) IBOutlet UIImageView *vipIcon;
@property (retain, nonatomic) IBOutlet UIImageView *icon_1;
@property (retain, nonatomic) IBOutlet UIImageView *icon_2;
@property (retain, nonatomic) IBOutlet UIImageView *icon_3;
@property (retain, nonatomic) IBOutlet UILabel *nameL;

//mid
@property (retain, nonatomic) IBOutlet UILabel *phoneL;
@property (retain, nonatomic) IBOutlet UILabel *categroyL;
@property (retain, nonatomic) IBOutlet UILabel *infoL;
@property (retain, nonatomic) IBOutlet UILabel *advantegeL;
@property (retain, nonatomic) IBOutlet UILabel *addressL;
@property (retain, nonatomic) IBOutlet UILabel *addressL_c;

- (IBAction)eventManager:(id)sender;
@end
