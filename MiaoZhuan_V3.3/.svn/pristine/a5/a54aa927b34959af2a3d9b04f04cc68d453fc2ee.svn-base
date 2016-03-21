//
//  AreaListViewController.h
//  miaozhuan
//
//  Created by 孙向前 on 14-11-17.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AreaListDelegate;
@interface AreaListViewController : UIViewController

@property (nonatomic, copy) NSString *titleName;//title
@property (nonatomic, assign) NSInteger level;//1:省 2:市 3:区
@property (assign) id <AreaListDelegate> delegate;

@end

@protocol AreaListDelegate <NSObject>
@optional
- (void)AreaList:(UIViewController *)viewCon selected:(NSDictionary *)str forKey:(NSInteger)level;
@end