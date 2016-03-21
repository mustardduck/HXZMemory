//
//  YinYuanManageMainController.m
//  miaozhuan
//
//  Created by momo on 14-11-15.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "YinYuanManageMainController.h"
#import "YinYuanProductController.h"
#import "YinYuanAdvertMainController.h"
#import "WebhtmlViewController.h"

@interface YinYuanManageMainController ()

@end

@implementation YinYuanManageMainController

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setNavigateTitle:@"银元广告发布与管理"];
    
    [self setupMoveBackButton];
    
}

- (void) viewWillAppear:(BOOL)animated
{
    ADAPI_SilverAdvertCountUnread([self genDelegatorID:@selector(CountUnread:)]);
}

- (void)CountUnread:(DelegatorArguments*)arguments
{
    [arguments logError];
    
    DictionaryWrapper *wrapper = arguments.ret;
    
    if (wrapper.operationSucceed)
    {
        _productPoint.num = [wrapper.data getInt:@"ProductCount"];
        
        if(_productPoint.num)
        {
            _productPoint.hidden = NO;
        }
        
        _advertPoint.num = [wrapper.data getInt:@"AdvertCount"];
        
        if(_advertPoint.num)
        {
            _advertPoint.hidden = NO;
        }
    }
    else
    {
        [HUDUtil showErrorWithStatus:wrapper.operationMessage];
        
    }
}

- (void) onMoveBack:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)touchUpInsideOnBtn:(id)sender
{
    if(sender == _howToBtn)
    {
        WebhtmlViewController * view = WEAK_OBJECT(WebhtmlViewController, init);
        view.navTitle = @"如何发布银元广告";
        view.ContentCode = @"60ce1c3293083650c7353b562587c966";
        [self.navigationController pushViewController:view animated:YES];
    }
    else if (sender == _advertBtn)
    {
        PUSH_VIEWCONTROLLER(YinYuanAdvertMainController);
    }
    else if (sender == _productBtn)
    {
        PUSH_VIEWCONTROLLER(YinYuanProductController);
    }
}

- (void)dealloc {
    [_howToBtn release];
    [_productBtn release];
    [_advertBtn release];
    [_productPoint release];
    [_advertPoint release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setHowToBtn:nil];
    [self setProductBtn:nil];
    [self setAdvertBtn:nil];
    [self setProductPoint:nil];
    [self setAdvertPoint:nil];
    [super viewDidUnload];
}
@end
