//
//  AccurateService.m
//  miaozhuan
//
//  Created by 孙向前 on 14-11-25.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "AccurateService.h"
#import "NSDictionary+expanded.h"

@implementation AccurateService

+ (NSMutableDictionary *)uploadData{
    NSMutableDictionary *upDic = [NSMutableDictionary dictionary];
    
    //第一个页面数据
    NSDictionary *fdic = [[NSUserDefaults standardUserDefaults] valueForKey:@"FirstPage"];
    for (NSString *key in fdic.allKeys) {
        [upDic setValue:[fdic valueForKey:key] forKey:key];
    }
    //第二个页面数据
    NSDictionary *sdic = [[NSUserDefaults standardUserDefaults] valueForKey:@"SecondPage"];
    for (NSString *key in sdic.allKeys) {
        [upDic setValue:[sdic valueForKey:key] forKey:key];
    }
    //性别
    NSString *sex = [[NSUserDefaults standardUserDefaults] valueForKey:@"CustomQuestionSex"];
    if (sex.length) {
        [upDic setValue:sex forKey:@"PostGander"];
    }
    //年龄
    NSArray *array = [[NSUserDefaults standardUserDefaults] valueForKey:@"CustomQuestionAge"];
    if (array.count == 2) {
        [upDic setValue:array[0] forKey:@"PostMinAge"];
        [upDic setValue:array[1] forKey:@"PostMaxAge"];
    }
    //投放区域数据
    NSArray *tdic = [[NSUserDefaults standardUserDefaults] valueForKey:@"UploadData"];
//    NSArray *lo = [[NSUserDefaults standardUserDefaults] valueForKey:@"CurrentLocations"];
//    NSMutableArray *ps = [NSMutableArray arrayWithArray:tdic];
//    for (NSDictionary *dic in lo) {
//        if (![tdic containsObject:dic]) {
//            [ps addObject:dic];
//        }
//    }

    [upDic setValue:tdic forKey:@"PostLocations"];
    //接受广告人群数据
    [upDic setValue:[[NSUserDefaults standardUserDefaults] valueForKey:@"PostOptions"] forKey:@"PostOptions"];
    return upDic;
}

//保存草稿箱
+ (void)saveDraftBoxWithDelegator:(id)delegator selector:(SEL)selector{
    
    NSMutableDictionary *updic = [self uploadData];
    
    ADAPI_DirectAdvert_Save([GLOBAL_DELEGATOR_MANAGER addDelegator:delegator selector:selector], updic);
}

+ (void)commitWithDelegator:(id)delegator selector:(SEL)selector{
    NSMutableDictionary *updic = [self uploadData];
    [updic setValue:@"1" forKey:@"Action"];
    ADAPI_DirectAdvert_Save([GLOBAL_DELEGATOR_MANAGER addDelegator:delegator selector:selector], updic);
}

//保存数据（分类网络数据）
+ (void)saveData:(DictionaryWrapper *)dic isYinyuan:(BOOL)flag{
    NSDictionary *temp = dic.dictionary;
    //1.年龄
    [[NSUserDefaults standardUserDefaults] setValue:[temp valueForJSONStrKey:flag ? @"PutSex" : @"PostGander"] forKey:@"CustomQuestionSex"];
    //2.性别
    NSString *min = [temp valueForJSONStrKey:flag ? @"PutMinAge" : @"PostMinAge"];
    NSString *max = [temp valueForJSONStrKey:flag ? @"PutMaxAge" : @"PostMaxAge"];
    [[NSUserDefaults standardUserDefaults] setValue:@[min, max] forKey:@"CustomQuestionAge"];
    //3.投放区域
    NSArray *areas = [dic getArray:flag ? @"PushRegionals" : @"PostLocations"];
    [self areaSetting:areas];
    //4.问题
    NSArray *options = [temp valueForJSONKey:@"PostOptions"];
    [[NSUserDefaults standardUserDefaults] setValue:options forKey:@"pts"];
    [[NSUserDefaults standardUserDefaults] setValue:[self getPostOptions:options] forKey:@"PostOptions"];
    //第一页数据
    NSMutableArray *picIds = [NSMutableArray arrayWithCapacity:0];
    for (DictionaryWrapper *picdic in [dic getArray:@"Pictures"]) {
        [picIds addObject:[[picdic wrapper] getString:@"PictureId"]];
    }
    NSDictionary *tempFirstPage = @{
                          @"Action":[temp valueForJSONStrKey:@"Action"],
                          @"DirectAdvertId":[temp valueForJSONStrKey:flag ? @"Id" : @"DirectAdvertId"],
                          @"Name":[temp valueForJSONStrKey:flag ? @"Title" : @"Name"],
                          @"Description":[temp valueForJSONStrKey:flag ? @"Content" : @"Description"],
                          @"PictureIds":picIds,
                          @"LinkUrl":[temp valueForJSONStrKey:@"LinkUrl"],
                          @"Phone":[temp valueForJSONStrKey:flag ? @"Tel" : @"Phone"],
                          @"Address":[temp valueForJSONStrKey:@"Address"],
                          @"Slogan":[temp valueForJSONStrKey:@"Slogan"]
                          };
    [[NSUserDefaults standardUserDefaults] setValue:tempFirstPage forKey:@"FirstPage"];
    
    //第二页数据
    NSDictionary *tempSecondPage = @{
                                     @"Count":[temp valueForJSONStrKey:@"Count"],
                                     @"StartTime":[temp valueForJSONStrKey:@"StartTime"],
                                     @"EndTime":[temp valueForJSONStrKey:@"EndTime"]
                                     };
    [[NSUserDefaults standardUserDefaults] setValue:tempSecondPage forKey:@"SecondPage"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSMutableArray *)getMsgs:(NSArray *)msgs{
    NSMutableArray *pinfos = [NSMutableArray arrayWithCapacity:0];
    for (id dic in msgs) {
        if (![msgs isKindOfClass:[NSNull class]]) {
            dic = @"";
        }
        [pinfos addObject:dic];
    }
    return pinfos;
}

+(NSMutableArray *)getPostOptions:(NSArray *)options{
    
    NSMutableArray *pinfos = [NSMutableArray arrayWithCapacity:0];
    NSMutableArray *optName = [NSMutableArray arrayWithCapacity:0];
    for (NSDictionary *dic in options) {
        NSArray *ops = [dic valueForJSONKey:@"Options"];
        if (ops.count) {
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:[dic.wrapper getString:@"FieldName"]];
        }
        [optName addObject:[dic.wrapper getString:@"FieldName"]];
        [pinfos addObjectsFromArray:ops];
    }
    
    NSMutableArray *temp = [NSMutableArray array];
    for (int i = 0; i < pinfos.count; i++) {
        NSString *str = [NSString stringWithFormat:@"%d",[pinfos[i] intValue]];
        [temp addObject:str];
    }
    
    [[NSUserDefaults standardUserDefaults] setValue:optName forKey:@"QuestionFields"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    return temp;
}

+ (void)areaSetting:(NSArray *)areas{
    NSMutableArray *location = [NSMutableArray array];
    NSMutableArray *country = [NSMutableArray array];
    NSMutableArray *province = [NSMutableArray array];
    NSMutableArray *city = [NSMutableArray array];
    NSMutableArray *district = [NSMutableArray array];
    for (NSDictionary *dic in areas) {
        int type = [dic.wrapper getInt:@"PutRegionalType"];
        switch (type) {
            case 1:
                [location addObject:dic];
                break;
            case 2:
                [country addObject:dic];
                break;
            case 3:
                [province addObject:dic];
                break;
            case 4:
                [city addObject:dic];
                break;
            case 5:
                [district addObject:dic];
                break;
            default:
                break;
        }
    }
    
    [[NSUserDefaults standardUserDefaults] setValue:[self checkData:country] forKey:@"Country"];
    [[NSUserDefaults standardUserDefaults] setValue:[self checkData:location] forKey:@"CurrentLocations"];
    [[NSUserDefaults standardUserDefaults] setValue:[self checkData:province] forKey:@"Province"];
    [[NSUserDefaults standardUserDefaults] setValue:[self checkData:city] forKey:@"City"];
    [[NSUserDefaults standardUserDefaults] setValue:[self checkData:district] forKey:@"District"];
    
    NSDictionary *temp = @{
                           @"ProvinceId" : @"",
                           @"CityId" : @"",
                           @"DistrictId" : @"",
                           @"PutRegionalType" : @"",
                           @"LocationType" : @"",
                           @"Lng" : @"",
                           @"Lat" : @"",
                           };
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *dic in areas) {
        NSMutableDictionary *data = [NSMutableDictionary dictionaryWithDictionary:temp];
        for (NSString *key in dic) {
            if ([[dic.wrapper get:key] isKindOfClass:[NSNull class]]) {
                [data setValue:@"" forKey:key];
                continue;
            }
            [data setValue:[dic.wrapper getString:key] forKey:key];
            
        }
        [array addObject:data];
    }
    [[NSUserDefaults standardUserDefaults] setValue:array forKey:@"UploadData"];
}

+ (id)checkData:(NSMutableArray *)array{
    NSArray *names = @[@"Province", @"City", @"District"];
    NSMutableArray *temp = [NSMutableArray array];
    for (NSDictionary *dic in array) {
        int type = [dic.wrapper getInt:@"PutRegionalType"];
        if (type == 3 || type == 4 || type == 5) {
            if (![[dic.wrapper get:names[type - 3]] isKindOfClass:[NSNull class]]) {
                [temp addObject:[dic.wrapper get:names[type - 3]]];
            }
            continue;
        }
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        for (NSString *key in dic.allKeys) {
            if ([[dic.wrapper get:key] isKindOfClass:[NSNull class]]) {
                [dict setValue:@"" forKey:key];
                continue;
            }
            [dict setValue:[dic.wrapper get:key] forKey:key];
        }
        [temp addObject:dict];
    }
    return temp;
}

+ (void)clearData{
     NSArray *array = @[@"CurText" ,@"PostOptions", @"CurrentLocations", @"Province", @"City", @"District", @"Country", @"UploadData", @"FirstPage", @"SecondPage", @"CustomQuestionSex", @"CustomQuestionAge"];
    for (NSString *key in array) {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
    }
    
    for (NSString *key in @[@"目标用户的基本信息", @"目标用户的经济能力", @"目标用户的生活习惯", @"目标用户的兴趣偏好"]) {
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

@end
