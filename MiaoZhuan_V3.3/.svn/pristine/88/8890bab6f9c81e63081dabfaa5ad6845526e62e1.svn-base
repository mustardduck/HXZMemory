//
//  StatementOfRedPacketController.m
//  miaozhuan
//
//  Created by Santiago on 14-10-27.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "StatementOfRedPacketController.h"

@interface StatementOfRedPacketController ()
@property (retain, nonatomic) IBOutlet DotCWebView *webView;

@end

@implementation StatementOfRedPacketController
@synthesize webView = _webView;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupMoveBackButton];
//    ADAPI_GetRedPacketStatement([self genDelegatorID:@selector(getStatementUrl:)]);
    
    ADAPI_GetContentByCode([self genDelegatorID:@selector(getContentByCode:)], @"ca3dca791c18983a470f49b6f2da488d");
}

- (void)getContentByCode:(DelegatorArguments*)arguments {

    DictionaryWrapper *wrapper = arguments.ret;
    
    if (wrapper.operationSucceed) {
        
        DictionaryWrapper *dataSource = wrapper.data;
        NSLog(@"!~~~~~~~~~~~~~~~~~~~~~~~~~~~%@",wrapper.dictionary);
        
        
    }else {
    
        [HUDUtil showWithStatus:wrapper.operationMessage];
    }
}


- (void)getStatementUrl:(DelegatorArguments*)arguments {

    DictionaryWrapper *wrapper = arguments.ret;
    if (wrapper.operationSucceed) {
        DictionaryWrapper *dataSource = wrapper.data;
        
        [_webView loadURL:[dataSource getString:@"Url"]];
    }else {
    
        [HUDUtil showErrorWithStatus:@"请求数据失败！"];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    [_webView release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setWebView:nil];
    [super viewDidUnload];
}
@end
