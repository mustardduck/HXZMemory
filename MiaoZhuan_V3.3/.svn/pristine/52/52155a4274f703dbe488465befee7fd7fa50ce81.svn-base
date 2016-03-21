//
//  IndustryDetailViewController.h
//  miaozhuan
//
//  Created by Santiago on 14-11-13.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GetIndustryInformation <NSObject>

@optional
- (void)getInformation:(int)parentId choosedArray:(NSArray*)array choosedStr:(NSMutableString*)string;
@end

@protocol IndustryCategotiesViewControllerAddedDelgate <NSObject>
- (void)getChooseInfo:(DictionaryWrapper *)dic;
@end

@interface IndustryDetailViewController : DotCViewController
@property(assign) id<IndustryCategotiesViewControllerAddedDelgate> delegate_add;
@property (nonatomic, assign)int parentId;
@property (strong, nonatomic) NSString *parentString;
@property (nonatomic, strong)NSArray *choosedIdsArray;
@property (nonatomic, assign)id<GetIndustryInformation>delegate1;
@end
