//
//  SetUpLableViewController.h
//  miaozhuan
//
//  Created by apple on 14/11/19.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SetUpLableViewController : DotCViewController
@property (retain, nonatomic) IBOutlet UIScrollView *scrollView;
@property (copy, nonatomic) NSMutableArray * CounselIds;

@property (copy, nonatomic) NSString * LableName;

@end
