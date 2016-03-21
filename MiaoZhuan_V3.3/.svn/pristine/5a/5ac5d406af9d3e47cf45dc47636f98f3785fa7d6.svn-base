//
//  YinYuanProductController.m
//  miaozhuan
//
//  Created by momo on 14-11-15.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "YinYuanProductController.h"
#import "YinYuanProductEditController.h"
#import "YinYuanProdListController.h"
#import "SetConvertCenterViewController.h"

@interface YinYuanProductController ()

@end

@implementation YinYuanProductController

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
   
    [self setNavigateTitle:@"兑换商品管理"];
    [self setupMoveBackButton];
}

- (void)viewWillAppear:(BOOL)animated
{
    ADAPI_SilverAdvertCountUnreadProducts([self genDelegatorID:@selector(CountUnreadProducts:)]);
}

- (void)CountUnreadProducts:(DelegatorArguments*)arguments
{
    [arguments logError];
    
    DictionaryWrapper *wrapper = arguments.ret;
    
    if (wrapper.operationSucceed)
    {
        _bindingPoint.num = [wrapper.data getInt:@"AuditSucceedCount"];
        
        if(_bindingPoint.num)
        {
            _bindingPoint.hidden = NO;
        }
        
        _auditFailedPoint.num = [wrapper.data getInt:@"AuditFailedCount"];
        
        if(_auditFailedPoint.num)
        {
            _auditFailedPoint.hidden = NO;
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
    if(sender == _createBtn)
    {
        PUSH_VIEWCONTROLLER(YinYuanProductEditController);
        
    }
    else if (sender == _draftBtn)
    {
        YinYuanProdListController * view = WEAK_OBJECT(YinYuanProdListController, init);
        
        view.queryType = DraftType;
        
        [self.navigationController pushViewController:view animated:YES];
    }
    else if (sender == _bindingBtn)
    {
        YinYuanProdListController * view = WEAK_OBJECT(YinYuanProdListController, init);
        
        view.queryType = SuccessType;
        
        [self.navigationController pushViewController:view animated:YES];
    }
    else if (sender == _proceedingBtn)
    {
        YinYuanProdListController * view = WEAK_OBJECT(YinYuanProdListController, init);
        
        view.queryType = ProceedingType;
        
        [self.navigationController pushViewController:view animated:YES];
    }
    else if (sender == _AuditFailedBtn)
    {
        YinYuanProdListController * view = WEAK_OBJECT(YinYuanProdListController, init);
        
        view.queryType = AuditFailedType;
        
        [self.navigationController pushViewController:view animated:YES];
    }
    else if (sender == _exchangeBtn)
    {
        PUSH_VIEWCONTROLLER(SetConvertCenterViewController);
    }
}

- (void)dealloc {
    [_createBtn release];
    [_draftBtn release];
    [_bindingBtn release];
    [_proceedingBtn release];
    [_AuditFailedBtn release];
    [_exchangeBtn release];
    [_draftPoint release];
    [_bindingPoint release];
    [_auditFailedPoint release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setCreateBtn:nil];
    [self setDraftBtn:nil];
    [self setBindingBtn:nil];
    [self setProceedingBtn:nil];
    [self setAuditFailedBtn:nil];
    [self setExchangeBtn:nil];
    [self setDraftPoint:nil];
    [self setBindingPoint:nil];
    [self setAuditFailedPoint:nil];
    [super viewDidUnload];
}
@end
