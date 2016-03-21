//
//  MainSupportor.h
//  miaozhuan
//
//  Created by abyss on 14/12/22.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, CRPageType)
{
    CRPageTypeShoppingPage = 1,
    CRPageTypeMallSearch,
    CRPageTypeMyMall,
};

@interface MainSupportor : NSObject
@property (assign, readonly) CRPageType type;
@property (copy, nonatomic) NSString* searchKey;

@property (retain, nonatomic) UIView*    bar;
@property (retain) UIImageView*          search;
@property (retain, nonatomic) UILabel*   navTitle;
@property (retain, nonatomic) NSArray*   viewConArray;

- (instancetype)initWith:(UIViewController *)con;
@end
