//
//  CreatMerchantStatementViewController.m
//  miaozhuan
//
//  Created by Santiago on 14-12-25.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "CreatMerchantStatementViewController.h"
#import "ApplyToBeMerchantStep1.h"
@interface CreatMerchantStatementViewController ()
@property (retain, nonatomic) IBOutlet DotCWebView *mainWebView;
@property (retain, nonatomic) IBOutlet UIView *btnVIew;
@end

@implementation CreatMerchantStatementViewController
@synthesize mainWebView = _mainWebView;

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"申请成为商家"];
    [self setupMoveBackButton];
    
    _mainWebView.frame = CGRectMake(0, 0, 320, [[UIScreen mainScreen] bounds].size.height - 64 - 60);
    
    _btnVIew.frame = CGRectMake(0, [[UIScreen mainScreen] bounds].size.height - 64 - 60, 320, 60);

    ADAPI_GetContentByCode([self genDelegatorID:@selector(handleNotification:)], @"46a9a26f97592fbe66d4b3f2b1057a9f");
}

- (void)handleNotification:(DelegatorArguments*)argument {

    DictionaryWrapper *wrapper = argument.ret;
    
    if (wrapper.operationSucceed)
    {
        DictionaryWrapper * dic = wrapper.data;
        
        int type = [dic getInt:@"ContentType"];
        NSString * htmlTemplatePath = [dic getString:@"ContentText"];
        if (type == 1) {
            
            if (!htmlTemplatePath.length) {
                
                return;
            }
            NSURL *url = [NSURL URLWithString:htmlTemplatePath];
            NSURLRequest *request = [NSURLRequest requestWithURL:url];
            [_mainWebView loadRequest:request];
            
        } else if(type == 3) {
            //html
            [_mainWebView loadHTMLString:htmlTemplatePath baseURL:nil];
        }
    }
    else if(wrapper.operationPromptCode || wrapper.operationErrorCode)
    {
        [AlertUtil showAlert:@"" message:wrapper.operationMessage buttons:@[@"好的"]];
        return;
    }
}

- (IBAction)toApplyToBeMerchant:(id)sender {
    
    PUSH_VIEWCONTROLLER(ApplyToBeMerchantStep1);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)dealloc {
    [_mainWebView release];
    [_btnVIew release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setMainWebView:nil];
    [super viewDidUnload];
}
@end
