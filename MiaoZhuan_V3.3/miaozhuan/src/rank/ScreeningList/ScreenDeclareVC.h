//
//  ScreenDeclareVC.h
//  guanggaoban
//
//  Created by CQXianMai on 14-8-10.
//  Copyright (c) 2014年 Arvin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScreeningListType.h"

@interface ScreenDeclareVC : UIViewController<NSURLConnectionDataDelegate>

@property (retain, nonatomic) IBOutlet UIWebView *webUI;
@property WebShowType webViewType;
@end
