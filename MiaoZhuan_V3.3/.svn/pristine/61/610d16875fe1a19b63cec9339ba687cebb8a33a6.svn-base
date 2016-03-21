//
//  FindShopController.h
//  miaozhuan
//
//  Created by momo on 14-10-22.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetImageView.h"
#import "RRLineView.h"

typedef enum {
    
    nearbyType = 0,
    
    mostProdType
    
}sortType;


@interface FindShopController : DotCViewController
{
    NSMutableArray * _categoryArr;
    
    NSMutableArray * _provinceArr;
    
    NSMutableArray * _cityArr;
    
    NSMutableDictionary * _provinceDic;
    
    NSMutableDictionary * _cityDic;

    NSMutableDictionary * _provinceNameDic;
    
    NSMutableDictionary * _cityIdDic;
    
    NSMutableDictionary * _provinceIdDic;

    NSString * _selectCityName;
    

}

@property (assign) int categoryId;
@property (assign) int sortTypeNum;

@property (assign) int provinceId;
@property (assign) int cityId;
@property (assign) int districtId;


@property (retain, nonatomic) IBOutlet UIButton *categoryBtn;
@property (retain, nonatomic) IBOutlet UIButton *cityBtn;
@property (retain, nonatomic) IBOutlet UIButton *SortTypeBtn;
@property (retain, nonatomic) IBOutlet UILabel *categoryLbl;
@property (retain, nonatomic) IBOutlet UILabel *cityLbl;
@property (retain, nonatomic) IBOutlet UILabel *sortTypeLbl;
@property (retain, nonatomic) IBOutlet UIImageView *arrowIcon1;
@property (retain, nonatomic) IBOutlet UIImageView *arrowIcon2;
@property (retain, nonatomic) IBOutlet UIImageView *arrowIcon3;
@property (retain, nonatomic) IBOutlet UILabel *locationLbl;
@property (retain, nonatomic) IBOutlet UIButton *locationRefreshBtn;
@property (retain, nonatomic) IBOutlet UITableView *mainTableView;
@property (retain, nonatomic) IBOutlet UIView *categoryView;
@property (retain, nonatomic) IBOutlet UITableView *cateTableView;
@property (retain, nonatomic) IBOutlet UIView *cityView;
@property (retain, nonatomic) IBOutlet UIButton *countryBtn;
@property (retain, nonatomic) IBOutlet UITableView *provinceTableView;
@property (retain, nonatomic) IBOutlet UITableView *cityTableView;
@property (retain, nonatomic) IBOutlet UIButton *filterBtn;
@property (retain, nonatomic) IBOutlet UIView *sortView;
@property (retain, nonatomic) IBOutlet UIButton *nearbyBtn;
@property (retain, nonatomic) IBOutlet UIButton *mostProductBtn;
@property (retain, nonatomic) IBOutlet UIView *filterView;
@property (retain, nonatomic) IBOutlet UIButton *CancelBtn;
@property (retain, nonatomic) IBOutlet UIButton *okBtn;
@property (retain, nonatomic) IBOutlet UIButton *selectVipBtn;
@property (retain, nonatomic) IBOutlet UIButton *selectDuihuanBtn;
@property (retain, nonatomic) IBOutlet UIButton *selectJinbiBtn;
@property (retain, nonatomic) IBOutlet UIButton *selectZhigouBtn;
@property (retain, nonatomic) IBOutlet UIImageView *VipIcon;
@property (retain, nonatomic) IBOutlet UIImageView *DuihuanIcon;
@property (retain, nonatomic) IBOutlet UIImageView *JinBiIcon;
@property (retain, nonatomic) IBOutlet UIImageView *ZhigouIcon;
@property (retain, nonatomic) IBOutlet UIButton *filterFullscreenBtn;
@property (retain, nonatomic) IBOutlet UIButton *sortTypeFullscreenBtn;
@property (retain, nonatomic) IBOutlet RRLineView *lineView;

- (IBAction) touchUpInsideOnBtn:(id)sender;

@end
