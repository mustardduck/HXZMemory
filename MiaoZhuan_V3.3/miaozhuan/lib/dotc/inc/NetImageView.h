//
//  ImageSizeUtil.h

//
//  Created by Yang G on 14-6-9.
//  Copyright (c) 2014年 BIN . All rights reserved.
//

#import <Foundation/Foundation.h>

DECL_DELEGATOR_FEATURE_CLASS(__DFCNetImageView, UIImageView)

@interface NetImageView : __DFCNetImageView
@property (assign, nonatomic) float zoom;           //default is 0.6
@property (retain, nonatomic) UIColor* holderColor;

- (NSString*) picture;
- (CGSize)    pictureSize;

-(void)requestPicture : (NSString *)picture;
-(void)requestPicture : (NSString *)picture placeHolder:(NSString*)placeHolder;
-(void)requestIcon:(NSString*)picture;
-(void)requestMiddle:(NSString*)picture;
-(void)requestLarge:(NSString*)picture;
-(void)requestCustom:(NSString*)picture width:(int)w height:(int)h;
-(void)requestCustom:(NSString*)picture width:(int)w height:(int)h placeHolder:(NSString*)placeHolder;
-(void)requestWithRecommandSize:(NSString*)picture;
-(void)requestWithRecommandSize:(NSString*)picture placeHolder:(NSString*)placeHolder;
-(void)requestWithScreenSize:(NSString*)picture;

+ (void) setDefaultPlaceHolder:(UIImage*)image name:(NSString*)name;

+ (instancetype) viewWithRecommandPicture:picture rect:(CGRect)rect;

/**  by Abyss 14.12.26 */
// 请求图片,默认当前imageView的2倍size,hasText设定默认图是否有文字
-(void)requestPic:(NSString*)picture placeHolder:(BOOL)hasText;
// 请求图片,自定义请求图片size
-(void)requestPic:(NSString*)picture size:(CGSize)size placeHolder:(BOOL)hasText;
// 请勿调用,设定默认无文字默认图
+(void)setNoTextDefaultPlaceHolder:(UIImage*)image name:(NSString*)name;


@end

// With the order in config.json/IMAGE_OPTION
typedef NS_ENUM(int64_t, EImageOption)
{
    IMG_OPTION_CULL = BIT(0),
    IMG_OPTION_SHORT_COMPATIBLE = BIT(1),
};

@interface NetImageViewEx : NetImageView

- (void)requestPicture:(NSString*)picture options:(EImageOption)options;

- (void)requestPicture:(NSString*)picture placeHolder:(NSString*)placeHolder options:(EImageOption)options;

- (void)requestPicture:(NSString*)picture width:(int)w height:(int)h options:(EImageOption)options;

- (void)requestPicture:(NSString*)picture width:(int)w height:(int)h placeHolder:(NSString*)placeHolder options:(EImageOption)options;

@end
