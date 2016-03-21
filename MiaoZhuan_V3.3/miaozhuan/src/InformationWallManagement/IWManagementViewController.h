//
//  InformationManagementViewController.h
//  miaozhuan
//
//  Created by admin on 15/4/21.
//  Copyright (c) 2015年 zdit. All rights reserved.
//

#import "DotCViewController.h"

//管理类型
typedef NS_ENUM(NSInteger, IWManagementType) {
    IWManagementType_ZhaoPin = 0, //招聘信息管理
    IWManagementType_ZhaoShang,  //招商信息管理
    IWManagementType_ShangJiaYouHui //商家优惠管理
};

//单元格对齐方式
typedef NS_ENUM(NSInteger, IWManagementCellAligningType) {
    IWManagementCellAligningType_OnlyOne = 0,//只有一个单元格
    IWManagementCellAligningType_Top,//多行首个
    IWManagementCellAligningType_Bottom,//多上最后一个
    IWManagementCellAligningType_Middle//多行中间
};

//单元格样式
typedef NS_ENUM(NSInteger, IWManagementCellType) {
    IWManagementCellType_OnlyTitle_DisclosureIndicator = 0, //只有标题 + 右箭头
    IWManagementCellType_Title_SubTitle_Vertical_DisclosureIndicator,  //标题 + 小标题 + 右箭头 （垂直对齐）
    IWManagementCellType_Title_SubTitleHighlight_Horizontal_DisclosureIndicator //标题 + 小标题（高亮） + 右箭头 （水平对齐）
};

@interface IWManagementViewController : DotCViewController

@property (assign, nonatomic) IWManagementType type;

-(void)loadData;

@end
