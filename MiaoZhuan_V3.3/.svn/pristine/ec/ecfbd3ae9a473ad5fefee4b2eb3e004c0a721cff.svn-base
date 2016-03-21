//
//  IndustryCategotiesViewController.h
//  miaozhuan
//
//  Created by Santiago on 14-11-11.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IndustryDetailViewController.h"
#import "YinYuanDelegate.h"

@protocol GetIndustryInformationForSpecialQualification <NSObject>
- (void)reloadFrameForSpeciaQualification:(NSArray*) wrapper;
@end


@interface IndustryCategotiesViewController : DotCViewController


@property(nonatomic, strong)IndustryDetailViewController *industryDetail;

@property(nonatomic, strong)NSString *detailChoosedStr;
@property(nonatomic, strong)NSString *parentStr;
@property(nonatomic, strong)NSArray *choosedIdArray;
@property(nonatomic, assign)int parentId;
@property(assign, nonatomic) BOOL isCateForYinYuan;

@property(assign) NSObject<YinYuanProductCategoreyDelegate> *delegate;

@property(assign) id<GetIndustryInformationForSpecialQualification> delegateForSpecialQualification;
@end



