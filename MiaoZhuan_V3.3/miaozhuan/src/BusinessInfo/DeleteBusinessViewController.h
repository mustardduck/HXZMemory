//
//  DeleteBusinessViewController.h
//  miaozhuan
//
//  Created by abyss on 14/11/12.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "otherButton.h"

@interface DeleteBusinessViewController : DotCViewController
@property (retain, nonatomic) IBOutlet otherButton *bt;
@property (retain, nonatomic) IBOutlet CommonTextField *textF;
- (IBAction)getYanzhengma:(id)sender;
- (IBAction)delete:(id)sender;

@end
