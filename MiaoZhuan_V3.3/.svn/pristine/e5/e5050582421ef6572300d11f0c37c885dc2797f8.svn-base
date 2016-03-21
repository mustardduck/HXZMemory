//
//  MallHistory.m
//  miaozhuan
//
//  Created by abyss on 14/12/31.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "MallHistory.h"
#import "Define+RCMethod.h"
#import "ModelSliverDetail.h"
#import "CRDateCounter.h"
#import "UserInfo.h"

NSString* MallHistoryData = @"MallHistoryDatakey";

@interface MallHistory ()
@property (retain, nonatomic) NSMutableArray* historyData;
@end
static MallHistory *cr_MallHistoryManager = nil;
@implementation MallHistory
//#if !__has_feature(objc_arc)
//INSTANCE_SETUP_ONCE_SAFE_UNARC();
//#endif
+ (instancetype)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!cr_MallHistoryManager)
        {
            cr_MallHistoryManager = [[MallHistory alloc] init];
            cr_MallHistoryManager.historyData = [NSMutableArray new];
        }
    });
    return cr_MallHistoryManager;
}

- (void)reSet
{
    if (cr_MallHistoryManager.historyData.count > 0) [cr_MallHistoryManager.historyData removeAllObjects];
    
    //get
    NSArray* array = [[NSUserDefaults standardUserDefaults] objectForKey:[MallHistoryData stringByAppendingString:USER_MANAGER.phone]];
    if (array)
    {
        cr_MallHistoryManager.historyData = [NSMutableArray arrayWithArray:array];
    }
}

- (NSInteger)count
{
    return _historyData.count;
}

#pragma mark - private

- (NSMutableDictionary *)cr_getSafeDic:(NSDictionary *)dic
{
    NSMutableDictionary *dataDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    
    for (id object in dataDic.allKeys)
    {
        id ret = [dataDic objectForKey:object];
        
        if ([ret isKindOfClass:[NSNull class]])
        {
            [dataDic setValue:@"" forKey:object];
        }
        
        if ([ret isKindOfClass:[NSDictionary class]])
        {
            ret =  [self cr_getSafeDic:ret];
            [dataDic setObject:ret forKey:object];
        }
    }

    return dataDic;
}

- (void)newRecord:(DictionaryWrapper *)data isYin:(BOOL)Yin;
{
    BOOL new = NO;
    NSString* time = [NSDate stringFromDate:[NSDate date]];
    NSMutableDictionary *dataDic = [self cr_getSafeDic:data.dictionary];
    
    NSDictionary *result = nil;
    
    NSString* type      = Yin?@"1":@"2";
    NSString* productid = [dataDic.wrapper getString:@"ProductId"];
    
    //time,name,img
    NSString* name = nil;
    NSString* img  = nil;
    {
        name = [dataDic objectForKey:Yin?@"Name":@"ProductName"];
        
        img  = @"";
        NSArray* array = [dataDic objectForKey:@"Pictures"];
        if(array && [array isKindOfClass:[NSArray class]])
        {
            if (array.count > 0)
                img  = [array[0] objectForKey:@"PictureUrl"];
        }
        else img = @"";
    }
    
    result = @{@"type":type,
               @"page":dataDic,
               @"id":productid,
               @"name":name,
               @"time":time,
               @"img":img};
    
    if (!_historyData) APP_ASSERT(@"_historyData");
    
    
    if (_historyData.count > 0)
    {
        int i = 0;
        for (NSDictionary* objct in _historyData)
        {
            NSString* o_type = [objct objectForKey:@"type"];
            NSString* o_productid = [objct objectForKey:@"id"];
            
            if ([type isEqualToString:o_type] && [productid isEqualToString:o_productid])
            {
                //替换
//                [_historyData replaceObjectAtIndex:i withObject:result];
                [_historyData removeObjectAtIndex:i];
                [_historyData addObject:result];
                new = YES;
                break;
            }

            i ++;
        }
    }
    
    if (!new || _historyData.count == 0)
    {
        //添加
        [_historyData addObject:result];
    }
    
    if (_historyData.count == 20)
    {
        [_historyData removeObjectAtIndex:0];
    }
    
    APP_ASSERT(_historyData.count <= 20);
    //save
    {
        [[NSUserDefaults standardUserDefaults] setObject:_historyData forKey:[MallHistoryData stringByAppendingString:USER_MANAGER.phone]];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (DictionaryWrapper *)getAdvertInfoForIndex:(NSInteger)index
{
    if (index < 0 || index > _historyData.count - 1) return nil;
    
    //倒序
    NSDictionary *dic = _historyData[_historyData.count - index - 1];
    MallHistoryWrapper *wrapper = [[MallHistoryWrapper alloc] initWith:dic];
    
    return wrapper;
}

- (void)removeHistoryData
{
    [_historyData removeAllObjects];
    _historyData = [NSMutableArray new];
    
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:[MallHistoryData stringByAppendingString:USER_MANAGER.phone]];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end


@implementation MallHistoryWrapper

- (ModelSliverDetail *)data
{
    DictionaryWrapper* wrapper = [self getDictionaryWrapper:@"page"];
    ModelSliverDetail* ret = [[ModelSliverDetail alloc] initWith:wrapper];
    
    return ret;
}

- (NSInteger)type
{
    return [self getInt:@"type"];
}

- (NSString *)name
{
    return [self getString:@"name"];
}

- (NSString *)img
{
    return [self getString:@"img"];
}

- (NSString *)time
{
    return [self getString:@"time"];
}




@end
