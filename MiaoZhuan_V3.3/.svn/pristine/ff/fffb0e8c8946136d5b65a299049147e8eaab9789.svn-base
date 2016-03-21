//
//  TextInputViewController.h
//  MZV32
//
//  Created by admin on 15/4/20.
//  Copyright (c) 2015年 Junnpy.Pro.Test. All rights reserved.
//

#import <UIKit/UIKit.h>

//输入类型
typedef NS_ENUM(NSInteger, IWTextInputType) {
    IWTextInputTitle = 0, //输入标题
    IWTextInputContent,  //输入内容
    IWTextInputAttractBrand, //招商品牌
    IWTextInputAttractWebSite,//官网链接
};


typedef void(^IWTextInputFinishedBlock)(NSString *text);

@interface IWTextInputViewController : DotCViewController

@property (strong, nonatomic) NSDictionary *textInputAlert; //文本输入提示信息
@property (strong, nonatomic) NSString *value;
@property (assign, nonatomic) IWTextInputType inputType;     //输入类型
@property (strong, nonatomic) IWTextInputFinishedBlock inputFinished;//输入完成回调

@end
