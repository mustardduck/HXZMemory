//
//  MallHistory.h
//  miaozhuan
//
//  Created by abyss on 14/12/31.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <Foundation/Foundation.h>

#define MallHistory_Manager [MallHistory shareInstance]
extern NSString* MallHistoryData;

@class MallHistoryWrapper;
@interface MallHistory : NSObject
@property (assign, readonly) NSInteger count;

+ (instancetype)shareInstance;

- (void)reSet;
- (void)removeHistoryData;
- (MallHistoryWrapper *)getAdvertInfoForIndex:(NSInteger)index;         //获得广告信息
- (void)newRecord:(DictionaryWrapper *)data isYin:(BOOL)Yin;            //添加新浏览记录 银元yes 金币no
@end

@class ModelSliverDetail;
@interface MallHistoryWrapper : DictionaryWrapper
//now need
@property (retain, readonly) NSString* time;
@property (retain, readonly) NSString* name;
@property (retain, readonly) NSString* img;
//if need
@property (assign, readonly) NSInteger type;                          //1:银元 2:金币
@property (retain, readonly) ModelSliverDetail* data;
@end