//
//  PublicBenifitAccountViewController.m
//  miaozhuan
//
//  Created by Santiago on 14-11-18.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "PublicBenifitAccountViewController.h"
#import "StatementOfPublicBenifit.h"
#import "WebhtmlViewController.h"

@interface PublicBenifitAccountViewController () {

    DictionaryWrapper *dataSource ;
}
@property (retain, nonatomic) IBOutlet UILabel *loveNumPerson;
@property (retain, nonatomic) IBOutlet UILabel *loveNumAll;
@property (retain, nonatomic) IBOutlet UIScrollView *scroller;
@end

@implementation PublicBenifitAccountViewController

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    InitNav(@"爱心账户");
    
    if ([[UIScreen mainScreen] bounds].size.height < 568)
    {
        [_scroller setContentSize:CGSizeMake(320, 635)];
    }
    
    [self setupMoveFowardButtonWithTitle:@"说明"];
    
    ADAPI_PublicBenifitAccount([self genDelegatorID:@selector(getdata:)]);
}

- (void)getdata:(DelegatorArguments*)arguments
{
    DictionaryWrapper *wrapper = arguments.ret;
    
    if (wrapper.operationSucceed)
    {
        dataSource = wrapper.data;
        
        [dataSource retain];
        
        double personalCount = [dataSource getDouble:@"Personal"];
        personalCount = floor(personalCount*100)/100;
        _loveNumPerson.text = [NSString stringWithFormat:@"¥%.2f",personalCount];
        
        double poolCount = [dataSource getDouble:@"Pool"];
        poolCount = floor(poolCount*100)/100;
        _loveNumAll.text = [NSString stringWithFormat:@"¥%.2f",poolCount];
    }
    else if(wrapper.operationPromptCode || wrapper.operationErrorCode)
    {
        [HUDUtil showErrorWithStatus:wrapper.operationMessage];
    }
}

- (IBAction) onMoveFoward:(UIButton*) sender
{
    PUSH_VIEWCONTROLLER(WebhtmlViewController);
    model.navTitle = @"说明";
    model.ContentCode = @"e0327e674e30712b5bbd5434b05df0b5";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
    [dataSource release];
    [_loveNumPerson release];
    [_loveNumAll release];
    [_scroller release];
    [super dealloc];
}
@end
