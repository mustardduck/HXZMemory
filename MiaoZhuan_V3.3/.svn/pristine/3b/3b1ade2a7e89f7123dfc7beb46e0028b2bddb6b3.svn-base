//
//  InfoModelViewController.h
//  miaozhuan
//
//  Created by abyss on 14/11/8.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, BusinessBtType)
{
    BusinessBtTypeLogoChange = 0,
    BusinessBtTypeLogoLook,
    BusinessBtTypePhone,
    BusinessBtTypeCateGroy,
    BusinessBtTypeInfo,
    BusinessBtTypeAdvantege,
    BusinessBtTypeAddress,
    BusinessBtTypeDelete,
    BusinessBtTypeGongHao,
};

typedef NS_ENUM(NSInteger, InfoModelType)
{
    InfoModelTypeField = 0,
    InfoModelTypeView,
};

typedef struct businessInfoType
{
    BusinessBtType classType;
    InfoModelType inputType;
    NSString *key;
    NSString *title;
}InfoType;

@protocol InfoHandleDelegate;
@interface InfoModelViewController : DotCViewController
@property (assign, nonatomic) id<InfoHandleDelegate> delegate;

@property (assign, nonatomic) InfoType type;
@property (retain, nonatomic) IBOutlet UIView *gongHaoView;


//@property (retain, nonatomic) NSString *navTitle;
//@property (assign, nonatomic) InfoModelType type;
//@property (assign, nonatomic) BusinessBtType key;

@property (assign, nonatomic) NSInteger num;
@property (assign, nonatomic) CGFloat height;

@property (retain, nonatomic) UILabel *object;
@end

@protocol InfoHandleDelegate <NSObject>
@optional

- (void)InfoDidSet:(NSString *)info withType:(InfoType)type;

@end