//
//  BaserHoverView.h
//  miaozhuan
//
//  Created by 孙向前 on 14-11-5.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaserHoverView : UIView

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message;

@property (retain, nonatomic) IBOutlet UIImageView *imgView;
@property (retain, nonatomic) IBOutlet UILabel *lblTitle;
@property (retain, nonatomic) IBOutlet UILabel *lblMessage;

@end
