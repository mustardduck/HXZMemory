//
//  YinYuanAdvertMainController.m
//  miaozhuan
//
//  Created by momo on 14-11-19.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "YinYuanAdvertMainController.h"
#import "YinYuanAdvertEditController.h"
#import "YinYuanAdvertListController.h"
#import "YinYuanProductEditController.h"

@interface YinYuanAdvertMainController ()<UIAlertViewDelegate>
{
    BOOL _isBinding;
}
@end

@implementation YinYuanAdvertMainController

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setNavigateTitle:@"银元广告管理"];
    [self setupMoveBackButton];
}

- (void)viewWillAppear:(BOOL)animated
{
    ADAPI_SilverAdvertCountUnreadAds([self genDelegatorID:@selector(CountUnreadAds:)]);
}

- (void)CountUnreadAds:(DelegatorArguments*)arguments
{
    [arguments logError];
    
    DictionaryWrapper *wrapper = arguments.ret;
    
    if (wrapper.operationSucceed)
    {
        _successRedPoint.num = [wrapper.data getInt:@"AuditSucceedCount"];
        
        if(_successRedPoint.num)
        {
            _successRedPoint.hidden = NO;
        }
        
        _failRedPoint.num = [wrapper.data getInt:@"AuditFailedCount"];
        
        if(_failRedPoint.num)
        {
            _failRedPoint.hidden = NO;
        }
        
        BOOL isShowTop = [wrapper.data getBool:@"IsShowTips"];
        
        NSString * msg = [wrapper.data getString:@"Message"];
        
        _isBinding = [wrapper.data getBool:@"HasBindingProduct"];
        
        if(!isShowTop)
        {
            _topView.hidden = YES;
            
            CGRect rect = _mainview.frame;
            
            rect.origin.y = 0;
            
            _mainview.frame = rect;
            
        }
        else
        {
            _topTextField.text = msg;
        }
    }
    else
    {
        [HUDUtil showErrorWithStatus:wrapper.operationMessage];
        
    }
}

- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 0)//仍然进入
    {
        PUSH_VIEWCONTROLLER(YinYuanAdvertEditController);
    }
    else if (buttonIndex == 1)//去绑定
    {
        PUSH_VIEWCONTROLLER(YinYuanProductEditController);
    }
}

- (IBAction)touchUpInsideOnBtn:(id)sender
{
    if(sender == _createAdvertBtn)
    {
        if(_isBinding)
        {
            PUSH_VIEWCONTROLLER(YinYuanAdvertEditController);
        }
        else
        {
            UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"抱歉"
                                                             message:@"发广告需要有审核成功或审核中的兑换商品"
                                                            delegate:self
                                                   cancelButtonTitle:nil
                                                   otherButtonTitles:@"仍然进入", @"去创建商品", nil] autorelease];
            [alert show];
        }
    }
    else if (sender == _draftBtn)
    {
        YinYuanAdvertListController * view = WEAK_OBJECT(YinYuanAdvertListController, init);
        
        view.queryType = DraftADType;
        
        [self.navigationController pushViewController:view animated:YES];
    }
    else if (sender == _successBtn)
    {
        YinYuanAdvertListController * view = WEAK_OBJECT(YinYuanAdvertListController, init);
        
        view.queryType = PlayingADType;
        
        [self.navigationController pushViewController:view animated:YES];
    }
    else if (sender == _proccedingBtn)
    {
        YinYuanAdvertListController * view = WEAK_OBJECT(YinYuanAdvertListController, init);
        
        view.queryType = ProceedingADType;
        
        [self.navigationController pushViewController:view animated:YES];
    }
    else if (sender == _failBtn)
    {
        YinYuanAdvertListController * view = WEAK_OBJECT(YinYuanAdvertListController, init);
        
        view.queryType = AuditFailedADType;
        
        [self.navigationController pushViewController:view animated:YES];
    }
    else if (sender == _playedBtn)
    {
        YinYuanAdvertListController * view = WEAK_OBJECT(YinYuanAdvertListController, init);
        
        view.queryType = PlayedADType;
        
        [self.navigationController pushViewController:view animated:YES];
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

- (void)dealloc {
    [_topView release];
    [_createAdvertBtn release];
    [_draftBtn release];
    [_draftRedPoint release];
    [_successBtn release];
    [_successRedPoint release];
    [_proccedingBtn release];
    [_failBtn release];
    [_failRedPoint release];
    [_playedBtn release];
    [_mainview release];
    [_topTextField release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setTopView:nil];
    [self setCreateAdvertBtn:nil];
    [self setDraftBtn:nil];
    [self setDraftRedPoint:nil];
    [self setSuccessBtn:nil];
    [self setSuccessRedPoint:nil];
    [self setProccedingBtn:nil];
    [self setFailBtn:nil];
    [self setFailRedPoint:nil];
    [self setPlayedBtn:nil];
    [super viewDidUnload];
}
@end
