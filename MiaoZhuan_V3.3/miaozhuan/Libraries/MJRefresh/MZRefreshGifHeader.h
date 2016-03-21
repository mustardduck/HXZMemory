//  代码地址: https://github.com/CoderMZLee/MZRefresh
//  代码地址: http://code4app.com/ios/%E5%BF%AB%E9%80%9F%E9%9B%86%E6%88%90%E4%B8%8B%E6%8B%89%E4%B8%8A%E6%8B%89%E5%88%B7%E6%96%B0/52326ce26803fabc46000000
//  MZRefreshGifHeader.h
//  MZRefreshExample
//
//  Created by MZ Lee on 15/3/4.
//  Copyright (c) 2015年 itcast. All rights reserved.
//  带有gif图片功能的下拉刷新控件

#import "MZRefreshHeader.h"

@interface MZRefreshGifHeader : MZRefreshHeader
/** 设置state状态下的动画图片images */
- (void)setImages:(NSArray *)images forState:(MZRefreshHeaderState)state;
@end
