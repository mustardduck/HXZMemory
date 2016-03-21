//
//  PersonalPreferenceSet.h
//  miaozhuan
//
//  Created by Santiago on 14-10-27.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RefreshDelegate <NSObject>
- (void)refresh2;
@end
@interface PersonalPreferenceSet : DotCViewController
@property(nonatomic,assign) id<RefreshDelegate>delegate;
@end
