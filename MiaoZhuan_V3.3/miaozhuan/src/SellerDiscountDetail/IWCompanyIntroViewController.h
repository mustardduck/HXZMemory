//
//  SellerDiscountEnterPrice.h
//  sss
//
//  Created by luocena on 4/27/15.
//  Copyright (c) 2015 luocena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DotCViewController.h"
#import "Definition.h"


/**
 *      企业简介
 */
@interface IWCompanyIntroViewController : DotCViewController

/**
 *  草稿或者预览
 */
@property (nonatomic,assign) BOOL  isDraft;


@property (nonatomic,assign) PostBoardType postBoardType;

-(void) loadData;

@end
