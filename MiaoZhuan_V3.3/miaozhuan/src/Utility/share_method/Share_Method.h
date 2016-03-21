//
//  Share_Method.h
//  miaozhuan
//
//  Created by 孙向前 on 14-10-27.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Share_Method : NSObject
+ (instancetype)shareInstance;

//新注册自动分享                 4cff9a5e959e9540b8be7d8c7b2d0c8b
//看广告/发广告/我首页分享        24b85ba13b2d0e6245c257ffe27670a2
//VIP7用户银元捡满后分享          984a6ad4f3592993b0e944746b97b3fe
//非VIP7用户银元捡满后分享        39851c48465f6a30877319000ad91470
//兑换商城商品详情分享            18ea86162430fe32164c92e93e60843a
//易货商城商品详情分享            2a4c2657138247317d8979710e98f438
//商城交易成功分享               72e7c16a7b36074620cbea3fceb8d2be
//商城付款成功分享               709b55f6261448417f8d5055b7aff27a
//感恩果激活6层后邀请更多粉丝分享	  1336828a622ace94b24f482cf75a3776
//推荐用户获得金币分享            db2a2d27268cc6a73ae4b216dcb25bf7
//感恩分享                      b48f4584ef5fb324cf5c4a803ed8e575

/**
 * goodsInfo：
 *
 * 兑换商城商品详情分享/兑换商城交易成功分享：product_id(商品编号) advert_id(银元广告编号)  @{@"Key":@"", @"product_id":@"", @"advert_id":@""}
 *
 * 易货商城商品详情分享/易货商城付款成功分享：product_id(商品编号) @{@"Key":@"", @"product_id":@""}
 *
 * 其他的都是 @{@"Key":@""}
 */

- (void)getShareDataWithShareData:(NSDictionary *)shareInfo;

- (void)getShareDataWithShareData:(NSDictionary *)shareInfo withPlatforms:(NSArray *)platfroms;

/*
 *  分享方法
 */
- (void)shareToPlatform:(DictionaryWrapper *)shareDic;

/*
 *  分享方法 自定义方式
 */

- (void)shareToPlatforms:(NSArray *)platfroms withShareData:(DictionaryWrapper *)shareDic;

@end
