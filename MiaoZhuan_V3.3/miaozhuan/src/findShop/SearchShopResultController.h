//
//  SearchShopResultController.h
//  miaozhuan
//
//  Created by momo on 14-11-6.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchShopResultController : DotCViewController
{
    MJRefreshController *_MJRefreshCon;
    
}
@property (retain, nonatomic) IBOutlet UIView *searchCountView;
@property (retain, nonatomic) IBOutlet UIView *searchNothingView;
@property (retain, nonatomic) IBOutlet UILabel *keywordLbl;
@property (retain, nonatomic) IBOutlet UILabel *searchCountLbl;

@property (retain) NSString * keyword;

@end
