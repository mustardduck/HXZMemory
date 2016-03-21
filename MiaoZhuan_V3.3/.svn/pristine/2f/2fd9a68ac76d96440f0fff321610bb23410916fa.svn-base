//
//  NotifyClassTableViewCell.m
//  miaozhuan
//
//  Created by abyss on 14/11/13.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "NotifyClassTableViewCell.h"
#import "NotifyCenterDefine.h"
#import "CRPoint.h"

//--跳转
#import "ProductOrderMsgViewController.h"
#import "ProductMsgViewController.h"
#import "AdvertMsgViewController.h"
#import "CustomerServiceMsgViewController.h"
#import "CurrencyCirculationMsgViewController.h"
#import "SystemMsgViewController.h"
#import "ConsultAndAnswerViewController.h"
#import "RemindMsgViewController.h"

@interface NotifyClassTableViewCell ()
@property (retain, nonatomic) IBOutlet CRPoint *red;
@property (retain, nonatomic) IBOutlet UIImageView *img;
@end
@implementation NotifyClassTableViewCell
NSDictionary *data_dic;
- (void)awakeFromNib
{
    if (!data_dic && data_dic.allKeys.count == 0)
    {
        data_dic = @{@"11":@{@"title":@"咨询回复",@"image":@"no_040.png"},
                     @"12":@{@"title":@"交易消息",@"image":@"no_041.png"},
                     @"13":@{@"title":@"商品上架提醒",@"image":@"no_042.png"},
                     @"21":@{@"title":@"邮寄订单",@"image":@"no_046.png"},
                     @"22":@{@"title":@"现场订单",@"image":@"no_047.png"},
                     @"23":@{@"title":@"商品管理消息",@"image":@"no_045.png"},
                     @"24":@{@"title":@"广告播放消息",@"image":@"no_044.png"},
                     @"25":@{@"title":@"系统消息",@"image":@"no_043.png"},
                     @"31":@{@"title":@"货币流通消息",@"image":@"no_049.png"},
                     @"32":@{@"title":@"客服消息",@"image":@"no_048.png"},
                     @"33":@{@"title":@"手机认证提醒",@"image":@"messageforPhone.png"}
                     };
        [data_dic retain];
//        [data_dic autorelease];
    }
    NSString *str = [NSString stringWithFormat:@"%ld",(long)_cellStyle];
    if (_cellStyle != 0)
    {
        _classL.text = [[ [data_dic wrapper]getDictionaryWrapper:str] getString:@"title"];
        _img.image = [UIImage imageNamed:[[ [data_dic wrapper]getDictionaryWrapper:str] getString:@"image"]];
    }

    _red.num = _newCount;
    
    _line = WEAK_OBJECT(UIView, initWithFrame:CGRectMake(45, 49.5, 320, 0.5));
    _line.backgroundColor = AppColor(204);
    [self.contentView addSubview:_line];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

//- (void)setNewCount:(NSInteger)newCount
//{
//    _newCount = newCount;
//    [self awakeFromNib];
//}
#define CRNC_jump(_viewcontroller) \
_viewcontroller *model = WEAK_OBJECT(_viewcontroller, init); \
[CRHttpAddedManager mz_pushViewController:model]; \
model.type = _type;

- (void)jump
{
    NSLog(@"%ld",(long)_type);
    //0
    if (_type & CRENUM_NCContentType10)
    {
        
        CRNC_jump(ConsultAndAnswerViewController);
    }
    else if (_type & CRENUM_NCContentType11)
    {
        CRNC_jump(ProductOrderMsgViewController);
    }
    else if (_type & CRENUM_NCContentType12)
    {
        CRNC_jump(ProductMsgViewController);
    }
    //1
    else if (_type & (CRENUM_NCContentType21|CRENUM_NCContentType20))
    {
        CRNC_jump(ProductOrderMsgViewController);
    }
    else if (_type & CRENUM_NCContentType22)
    {
        CRNC_jump(ProductMsgViewController);
    }
    else if (_type & CRENUM_NCContentType23)
    {
        CRNC_jump(AdvertMsgViewController);
    }
    else if (_type & CRENUM_NCContentType24)
    {
        CRNC_jump(SystemMsgViewController);
    }
    //2
    else if (_type & CRENUM_NCContentType30)
    {
        CRNC_jump(CurrencyCirculationMsgViewController);
    }
    else if (_type & CRENUM_NCContentType31)
    {
        CRNC_jump(CustomerServiceMsgViewController);
    }
    else if (_type & CRENUM_NCContentType32)
    {
        CRNC_jump(RemindMsgViewController);
    }
    else
    {
        NSLog(@"not found");
    }
}

- (void)setData:(DictionaryWrapper *)data
{
    _data = data;
    [_data retain];
    if (_data)
    {
        _type = [_data getInt:@"type"];
        _newCount = [_data getInt:@"count"];
        _cellStyle = [_data getInt:@"cell"];
        [self awakeFromNib];
    }
}

- (void)dealloc
{
    [_data release];
    [_classL release];
    [_red release];
    [_img release];
    [super dealloc];
}
@end
