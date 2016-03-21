//
//  Management_Index.h
//  miaozhuan
//
//  Created by xm01 on 14-12-29.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Management_Index : DotCViewController
{
    MJRefreshController     *_mjCon;
    WDictionaryWrapper      *_postDataWrapper;
}

@property(nonatomic, assign) NSInteger                      statusTag;                      //状态标识, 4:出售中, 3:等待上架, 5:已下架, 1:审核中, 2:审核失败

@end
