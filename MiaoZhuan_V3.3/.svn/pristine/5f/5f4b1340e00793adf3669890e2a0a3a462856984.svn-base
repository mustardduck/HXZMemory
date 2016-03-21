//
//  AddManagerViewController.h
//  miaozhuan
//
//  Created by Santiago on 14-11-15.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GetManagerIds <NSObject>

- (void)getManagerIds:(NSArray*)array;
@end

@interface AddManagerViewController : DotCViewController
@property (nonatomic, assign)id<GetManagerIds>delegate;
@property (strong, nonatomic) NSArray *managersAlreadyAdd;
@end
