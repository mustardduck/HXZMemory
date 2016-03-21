//
//  FileUtil.h
//  miaozhuan
//
//  Created by abyss on 14/11/27.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <Foundation/Foundation.h>

//自动清除
extern NSString *cr_CACHE_AUTOCLEAR;
//声音开关
extern NSString *cr_SOUND_TURN;


@interface CRFileUtil : NSObject

+ (NSArray *)getCachePaths;

//遍历文件夹获得文件夹大小，返回多少M
+ (CGFloat)folderSizeAtPath:(NSString *)folderPath;
//删除目录下所有文件
+ (BOOL) deleteDirectory:(NSString *)path;
//根据用户设置自动清除7天以前的缓存
+ (void)cleanSevenDaysAgoCache;
@end
