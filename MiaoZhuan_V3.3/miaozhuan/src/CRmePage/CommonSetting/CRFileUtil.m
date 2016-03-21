//
//  FileUtil.m
//  miaozhuan
//
//  Created by abyss on 14/11/27.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "CRFileUtil.h"
#import <objc/runtime.h>

NSString *cr_CACHE_AUTOCLEAR = @"autoCleanState";
NSString *cr_SOUND_TURN = @"sound";

@implementation CRFileUtil

+ (NSArray *)getCachePaths
{
    NSArray* paths = @
    [
     [PathUtil cacheRoot],
     [PathUtil netCacheRoot],
     [PathUtil databaseCacheRoot],
     ];
    
    return paths;
}

+ (CGFloat)folderSizeAtPath:(NSString *)folderPath
{
    NSFileManager* manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath]) return 0;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    NSString* fileName;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil)
    {
        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
    }
    return folderSize/(1024.f);
}

//单个文件的大小
+ (long long)fileSizeAtPath:(NSString *)filePath
{
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath])
    {
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}

//获取文件路径
+ (NSString *)attchmentFolder:(NSString *)path
{
    NSFileManager * manager = [NSFileManager defaultManager];
    
    if(![manager contentsOfDirectoryAtPath:path error:nil])
    {
        [manager createDirectoryAtPath:path withIntermediateDirectories:NO attributes:nil error:nil];
    }
    return path;
}

//删除目录下所有文件
+ (BOOL)deleteDirectory:(NSString *)path
{
    BOOL result = [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
    return result;
}

////自动清除某天以前的缓存
//+ (void)cleanCacheByPath:(NSString *)path  day:(NSInteger)aday
//{
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
//        NSFileManager* manager = [NSFileManager defaultManager];
//        
//        NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:path] objectEnumerator];
//        NSString* fileName;
//        while ((fileName = [childFilesEnumerator nextObject]) != nil)
//        {
//            NSString* fileAbsolutePath = [path stringByAppendingPathComponent:fileName];
//            NSDate *fileCreatDate = [[manager attributesOfItemAtPath:fileAbsolutePath
//                                                               error:nil]
//                                     objectForKey:NSFileCreationDate];
//            NSTimeInterval secondsBetweenDates= [fileCreatDate timeIntervalSinceNow];
//            if (!(int)(secondsBetweenDates/60*60*24)<aday)
//            {
//                [manager removeItemAtPath:fileAbsolutePath error:nil];
//            }
//        }
//        NSLog(@"%@\n<auto clear sucess!>\n",path);
//    });
//}
//
+ (void)cleanSevenDaysAgoCache
{
    if ([[NSUserDefaults standardUserDefaults]boolForKey:@"autoCleanState"])
    {
        float day = 7.0f;
        [APP_DELEGATE clearCache:day];
    }
}
@end
