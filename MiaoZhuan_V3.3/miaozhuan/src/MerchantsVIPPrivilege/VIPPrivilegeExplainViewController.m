//
//  VIPPrivilegeExplainViewController.m
//  miaozhuan
//
//  Created by apple on 14/12/15.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "VIPPrivilegeExplainViewController.h"

@interface VIPPrivilegeExplainViewController ()
@property (retain, nonatomic) IBOutlet UIWebView *web;

@end

@implementation VIPPrivilegeExplainViewController

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    InitNav(@"商家VIP介绍");
    
    ADAPI_GetContentByCode([self genDelegatorID:@selector(HandleNotification:)], @"e1461c1686cd3fb7859be503b26b8d6c");
}

- (void)HandleNotification:(DelegatorArguments *)arguments
{
    if ([arguments isEqualToOperation:ADOP_GetContentByCode])
    {
        [arguments logError];
        
        DictionaryWrapper *wrapper = arguments.ret;
        
        if (wrapper.operationSucceed)
        {
            DictionaryWrapper * dic = wrapper.data;
            
            NSString *htmlTemplatePath = [dic getString:@"ContentText"];
            
            [_web loadHTMLString:htmlTemplatePath baseURL:nil];
            
        }
        else if (wrapper.operationPromptCode || wrapper.operationErrorCode)
        {
            [AlertUtil showAlert:@"" message:wrapper.operationMessage buttons:@[@"好的"]];
        }
        else
        {
            [HUDUtil showErrorWithStatus:wrapper.operationMessage];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
    [_web release];
    [super dealloc];
}

- (void)viewDidUnload
{
    [self setWeb:nil];
    [super viewDidUnload];
}
@end
