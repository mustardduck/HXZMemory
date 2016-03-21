//
//  ChooseManagerFromList.h
//  miaozhuan
//
//  Created by Santiago on 14-11-18.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GetManagerIdsList <NSObject>

- (void)getManagersIdsList:(NSArray*)array;
@end




@interface ChooseManagerFromList : DotCViewController
@property (nonatomic, assign)id<GetManagerIdsList>delegate;
@property (nonatomic, strong)NSArray *chooedArray;
@end
