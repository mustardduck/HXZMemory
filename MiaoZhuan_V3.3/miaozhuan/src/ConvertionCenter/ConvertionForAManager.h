//
//  ConvertionForAManager.h
//  miaozhuan
//
//  Created by Santiago on 14-11-18.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UpdateAfterCancleManagerPermission <NSObject>

@optional
- (void)refreshList;

@end

@interface ConvertionForAManager : DotCViewController
@property (nonatomic, assign)id <UpdateAfterCancleManagerPermission> delegate;
@property (nonatomic, assign)int managerId;
@end
