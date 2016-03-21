//
//  RequestFailed.h
//  miaozhuan
//
//  Created by xm01 on 15-1-27.
//  Copyright (c) 2015年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RequestFailedDelegate <NSObject>

-(void)didClickedRefresh;

@end

@interface RequestFailed : UIViewController
{

}
@property(nonatomic, assign)  BOOL   isShow;
@property (nonatomic, retain) IBOutlet UIView *viewNoNet;
@property (nonatomic, retain) IBOutlet UIView *viewIndex;
@property (nonatomic, retain) IBOutlet UIView *viewWeb;
@property(nonatomic, assign) id<RequestFailedDelegate> delegate;

+(instancetype)getInstance;
-(IBAction)dicClickedRefresh:(id)sender;

@end
