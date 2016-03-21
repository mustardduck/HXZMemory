//
//  NSDictionaryCategory.h
//  cloud
//
//  Created by hetao on 11-4-19.
//  Copyright 2011年 oulin. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSDictionary (expanded)

/**
 *  返回一个oc对象，无数据则返回nil
 *
 *  @param aKey key值
 *
 *  @return oc对象
 */
- (id)objectForJSONKey:(id)aKey;
- (id)valueForJSONKey:(NSString *)key;

/**
 *  返回oc对象，无数据则返回nil，这个适用于字典里边存放字典，（比如NSDictionary *dic = @{@"key":@{@"key1":@[a,b,c]}}这种结构，NSArray *array = [dic valueForJsonKeys:@"key",@"key1",nil]）
 *
 *  @param key key值与key值之间，用“,”隔开，最后用nil结尾
 *
 *  @return oc对象
 */
- (id)valueForJSONKeys:(NSString *)key,...NS_REQUIRES_NIL_TERMINATION;

/**
 *  直接返回字符串，无数据或者为<null>则返回@""(空字符串)
 *
 *  @param key key值
 *
 *  @return 字符串
 */
- (NSString*)valueForJSONStrKey:(NSString *)key;

/**
 *  直接返回字符串，无数据或者为<null>则返回@""(空字符串),这个适用于字典里边存放字典，（比如NSDictionary *dic = @{@"key":@{@"key1":@"value1"}}这种结构，NSString *str = [dic valueForJsonKeys:@"key",@"key1",nil]）
 *
 *  @param key key值与key值之间，用“,”隔开，最后用nil结尾
 *
 *  @return 字符串
 */
- (id)valueForJSONStrKeys:(NSString *)key,...NS_REQUIRES_NIL_TERMINATION;

/**
 *  这个方法就是向同一个key，存入不同的数据，相当于存了一个可变数组，可以向这个key中不断添加
 *
 *  @param objects 要传入的数据
 *  @param aKey    key值
 */
- (void)setObjects:(id)objects forKey:(id)aKey;

- (id)valueShowByNil:(NSString *)key;  //空字符串显示暂无

@end
