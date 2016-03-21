//
//  IViewController.h
//  guanggaoban
//
//  Created by Santiago on 14-10-20.
//  Copyright (c) 2014年 Arvin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IViewController : UIViewController
@property (retain, nonatomic) IBOutlet UITableView *myTable;
@property (strong, nonatomic) UIView *footer;
@property (retain, nonatomic) IBOutlet UIImageView *watchAdImage;
@property (retain, nonatomic) IBOutlet UIImageView *sendAdImage;
@property (retain, nonatomic) IBOutlet UIImageView *IPageImage;
@property (retain, nonatomic) IBOutlet UILabel *watchAdLabel;
@property (retain, nonatomic) IBOutlet UILabel *sendAdLabel;
@property (retain, nonatomic) IBOutlet UILabel *IPageLabel;
@end
