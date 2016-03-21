//
//  Management_Index.h
//  miaozhuan
//
//  Created by xm01 on 14-12-29.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Management_Index : DotCViewController<UITableViewDelegate, UITableViewDataSource>
{
    UITableView             *_tabView;
    UIView                  *_slipBar;
    MJRefreshController     *_mjCon;
    WDictionaryWrapper      *_postDataWrapper;
    UITextField             *_searchTF;
    
    
    NSInteger               _statusTag;            //状态标识, 4:出售中, 3:等待上架, 5:已下架, 1:审核中, 2:审核失败
    NSMutableArray          *_searchStrs;           //5个状态下 搜索框的输入内容
    
    UILabel                 *_onOfferCount;
    UILabel                 *_onlineCount;
    UILabel                 *_offlineCount;
    UILabel                 *_inTheReviewCount;
    UILabel                 *_auditFailureCount;
}

@property(nonatomic, retain) IBOutlet UITableView           *tabView;

@property(nonatomic, retain) IBOutlet UIView                *slipBar;                       //选项卡底部横向红色滑动条

@property(nonatomic, retain) IBOutlet UIView                *labView;

@property(nonatomic, retain) MJRefreshController            *mjCon;

@property(nonatomic, retain) WDictionaryWrapper             *postDataWrapper;

@property(nonatomic, retain) IBOutlet UITextField           *searchTF;

@property(nonatomic, retain) NSMutableArray                 *searchStrs;

@property(nonatomic, retain) IBOutlet UILabel               *onOfferCount;                  //出售中总数
@property(nonatomic, retain) IBOutlet UILabel               *onlineCount;                   //等待上架总数
@property(nonatomic, retain) IBOutlet UILabel               *offlineCount;                  //已下架总数
@property(nonatomic, retain) IBOutlet UILabel               *inTheReviewCount;              //审核中总数
@property(nonatomic, retain) IBOutlet UILabel               *auditFailureCount;             //审核失败总数

@end
