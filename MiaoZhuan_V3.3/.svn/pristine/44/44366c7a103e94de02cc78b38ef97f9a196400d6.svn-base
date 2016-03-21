//
//  YinYuanDelegate.h
//  miaozhuan
//
//  Created by momo on 14-11-20.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol YinYuanProdDelegate <NSObject>

@optional
-(void)passProdDes:(NSString *)prodDes;

-(void)passADsDes:(NSString *)ADsDes;

-(void)passDuihuanLimit:(int)dayCount andTotalCount:(int)totalCount;

-(void)passReturnProduct:(NSString *)reasonDes;

@end


@protocol YinYuanAdvertDelegate <NSObject>

@optional

- (void) passAdvertUser:(NSMutableDictionary *)body;

@end

@protocol YinYuanProductBindingDelegate <NSObject>

@optional

- (void) productBindingFinish:(NSMutableArray*)selArr;

- (void) saveAdvert;

@end

@protocol YinYuanProductCategoreyDelegate <NSObject>

- (void) selectProductCategorey:(NSString*)cateName withId:(NSString *)cateId;

@end

@protocol YinYuanSelectExPointDelegate <NSObject>

@optional

- (void) yinYuanSelectExPointFinish:(NSMutableArray*)selExPointArr;

@end
