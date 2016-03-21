//
//  VipPriviliegeViewController.m
//  miaozhuan
//
//  Created by abyss on 14/10/22.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "VipPriviliegeViewController.h"

#import "RRAttributedString.h"
#import "CROrderManagerViewController.h"
#import "WebhtmlViewController.h"
#import "CRHtmlManager.h"

#import "UserInfo.h"
#import "ConfirmOrderViewController.h"
#import "CRMallManagerViewContrillrtViewController.h"

@interface VipPriviliegeViewController ()
{
    NSInteger _markVipLevel;
    NSInteger _vipCost;
    
    UILabel *tempNum;
}
@property (retain, nonatomic) IBOutlet UILabel *vt1;
@property (retain, nonatomic) IBOutlet UILabel *vt2;
@property (retain, nonatomic) IBOutlet UILabel *vt3;
@property (retain, nonatomic) IBOutlet UILabel *vt4;
@property (retain, nonatomic) IBOutlet UILabel *vt5;
@property (retain, nonatomic) IBOutlet UILabel *vt6;
@property (retain, nonatomic) IBOutlet UILabel *vt7;
@end

//VIP1 40 : 40
@implementation VipPriviliegeViewController
@synthesize currentVipLevel = _currentVipLevel;
@synthesize bottom = _bottom;
@synthesize mark = _mark;
@synthesize vipBar = _vipBar;
@synthesize num1 = _num1;
@synthesize num2 = _num2;

- (void)viewWillAppear:(BOOL)animated
{
    ADAPI_adv3_GetVipLevel([self genDelegatorID:@selector(refreshVIP_local:)]);
}

- (void)refreshVIP_local:(DelegatorArguments *)arg
{
    if (arg.ret.operationSucceed)
    {
        int i = [arg.ret.data getInt:@"VipLevel"];
        [APP_DELEGATE.runtimeConfig set:RUNTIME_USER_LOGIN_INFO".VipLevel" value:@(i)];
        
        _currentVipLevel = i;
        [self layoutTheView];
        [self initMark];
    }
    else
    {
        [HUDUtil showErrorWithStatus:arg.ret.operationMessage];
    }
}

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    InitNav(@"用户VIP");
    [self setupMoveFowardButtonWithImage:@"goumai@2x.png" In:@"goumaihover@2x.png"];
    [self constData];
}


- (void)layoutTheView
{
    
    {
        if (_currentVipLevel > 5)
        {
            _vt6.textColor = AppColor(204);
        }
        
        if (_currentVipLevel > 4)
        {
            _vt5.textColor = AppColor(204);
        }
        
        if (_currentVipLevel > 3)
        {
            _vt4.textColor = AppColor(204);
        }
        
        if (_currentVipLevel > 2)
        {
            _vt3.textColor = AppColor(204);
        }
        
        if (_currentVipLevel > 1)
        {
            _vt2.textColor = AppColor(204);
        }
        
        if (_currentVipLevel > 0)
        {
            _vt1.textColor = AppColor(204);
        }
    }
    
    {
        UIView* v = WEAK_OBJECT(UIView, initWithFrame:CGRectMake(0, _bottom.height - 0.5, 320, 0.5));
        v.backgroundColor = AppColor(220);
        [_bottom addSubview:v];
        
        UIView* v1 = WEAK_OBJECT(UIView, initWithFrame:CGRectMake(0, _bottom_v.height - 0.5, 320, 0.5));
        v1.backgroundColor = AppColor(220);
        [_bottom_v addSubview:v1];
    }
    
    [_headImg requestIcon:USER_MANAGER.userPic];
    [_headImg setBorderWithColor:AppColor(220)];
    [_headImg setRoundCorner:11.0];
    
    {
        BOOL tooLong = USER_MANAGER.phone.length>14;
        _nameL.text = tooLong?[[USER_MANAGER.phone substringToIndex:13] stringByAppendingString:@"..."]:USER_MANAGER.phone;
        _vipIcon.left = [UICommon getHeightFromLabel:_nameL].width + _nameL.left + 6;
        if (tooLong)
        {
            //
        }
        else
        {
            _vipIcon.top  = _nameL.top + _nameL.height/2 - _vipIcon.height/2;
        }
    }
    
    _vipIcon.image = [USER_MANAGER getVipPic:_currentVipLevel];
    
    if (tempNum) [tempNum removeFromSuperview];
    tempNum = WEAK_OBJECT(UILabel, initWithFrame:CGRectMake(7, 3, 20, 20));
    tempNum.font = Font(14);
    tempNum.textColor  = AppColorWhite;
    tempNum.backgroundColor = [UIColor clearColor];
    [_mark addSubview:tempNum];
    
    ((UIScrollView *)self.view).contentSize = CGSizeMake(320, 568 - 64);
    ((UIScrollView *)self.view).showsHorizontalScrollIndicator = NO;
    ((UIScrollView *)self.view).showsVerticalScrollIndicator = NO;
    _img1.image = [UIImage imageNamed:@"026a"];
    _img2.image = [UIImage imageNamed:@"025a"];
    _img3.image = [UIImage imageNamed:@"024"];
    //两个图标
    _l1.textColor = AppColor(34);
    _l2.textColor = AppColor(34);
    _l3.textColor = AppColor(204);
    //VIP等级显示
    //用户名和头像
    if (_currentVipLevel == 0)
    {
        _l1.textColor = AppColor(204);
        _l2.textColor = AppColor(204);
        _l3.textColor = AppColor(204);
        _img1.image = [UIImage imageNamed:@"026"];
        _img2.image = [UIImage imageNamed:@"025"];
        _img3.image = [UIImage imageNamed:@"024"];
    }
    else if (_currentVipLevel == 7)
    {
        _bottom.hidden = YES;
        _l1.textColor = AppColor(34);
        _l2.textColor = AppColor(34);;
        _l3.textColor = AppColor(34);
        _img1.image = [UIImage imageNamed:@"026a"];
        _img2.image = [UIImage imageNamed:@"025a"];
        _img3.image = [UIImage imageNamed:@"024a"];
    }
}

- (void)constData
{
    _vipCost = 30;
}

- (void)initMark
{
    _markVipLevel = _currentVipLevel + 1;
    [self animation:_markVipLevel];
    
    UIGestureRecognizer *drag = [[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)] autorelease];
    _mark.userInteractionEnabled = YES;
    [_mark addGestureRecognizer:drag];
}

- (void)handlePanGesture:(UIGestureRecognizer *)sender
{
    CGPoint point = [sender locationInView:self.view];
    if (point.x < 50)       point.x = 50;
    if (point.x > 270)      point.x = 270;
    
    //滑动开始
    if (sender.state == UIGestureRecognizerStateBegan)
    {
    }
    
    //滑动中
    else if (sender.state == UIGestureRecognizerStateChanged)
    {
        _mark.center = CGPointMake(point.x + 0.5, _mark.center.y);
    }
    
    //滑动结束
    else if  (sender.state == UIGestureRecognizerStateEnded || sender.state == UIGestureRecognizerStateCancelled)
    {
//        float endX = 55;
        for (int i = 0 ; i < 7; i ++)
        {
            if ( 55/2 + 35*i + 10 < point.x && point.x < 55/2 + 35*(i+1) +10)
            {
//                endX = 60 + 35*i;
                _markVipLevel = i + 1;
            }
        }
        if (_markVipLevel <= _currentVipLevel)
        {
            _markVipLevel = _currentVipLevel + 1;
        }
        [self animation:_markVipLevel];
    }

}

- (void)animation:(NSInteger)level
{
    tempNum.text = [NSString stringWithFormat:@"%d",level];
    [_bt_de setEnabled:YES];
    [_bt_add setEnabled:YES];
    NSString *tempStr = @"";
    if (level - 1 == _currentVipLevel)
    {
        [_bt_de setEnabled:NO];
    }
    if (level == 7)
    {
        [_bt_add setEnabled:NO];
        tempStr = @"     激活金币账户";
    }

    
    // mark
    _mark.center = CGPointMake(55 + 35*(level-1),_mark.center.y);
    
    // vip title
    for (UIView *view in _vipBar.subviews)
    {
        if (view.tag != 0)
        {
            if (view.tag <= _markVipLevel)
            {
                view.backgroundColor = AppColorRed;
            }
            else
            {
                view.backgroundColor = AppColor(204);
            }
        }
    }
    
    //view
    _num1.text = [NSString stringWithFormat:@"￥%d.00",_vipCost * (_markVipLevel - _currentVipLevel)];
    _num2.text = [NSString stringWithFormat:@"成为VIP%d,附送%d银元%@",_markVipLevel,_vipCost * (_markVipLevel - _currentVipLevel) * 100,tempStr];
    if (level == 7) _num2.attributedText = [RRAttributedString setText:_num2.text color:AppColorRed range:NSMakeRange(_num2.text.length - 6, 6)];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)dealloc
{
    [_mark release];
    [_vipBar release];
    [_num1 release];
    [_num2 release];
    [_bottom release];
    [_img1 release];
    [_img2 release];
    [_img3 release];
    [_l1 release];
    [_l2 release];
    [_l3 release];
    [_bt_add release];
    [_bt_de release];
    [_bottom_v release];
    [_headImg release];
    [_nameL release];
    CRDEBUG_DEALLOC();
    [_vipIcon release];
    [_vt1 release];
    [_vt2 release];
    [_vt3 release];
    [_vt4 release];
    [_vt5 release];
    [_vt6 release];
    [_vt7 release];
    [super dealloc];
}
- (IBAction)lessVIP:(id)sender
{
    if (_markVipLevel - 1 <= _currentVipLevel)
    {
//        _bt_de.enabled = NO;
        return;
    }
//    _bt_de.enabled = YES;
    [self animation:--_markVipLevel];
}

- (IBAction)moreVIP:(id)sender
{
    if (_markVipLevel == 7)
    {
//        _bt_add.enabled = NO;
        return;
    }
//    _bt_add.enabled = YES;
    [self animation:++_markVipLevel];
}

- (IBAction)VIPRecord:(id)sender
{
#warning fix later
    PUSH_VIEWCONTROLLER(WebhtmlViewController);
    model.navTitle    = @"VIP特权详情";
    model.ContentCode = CRHtmlManager_Code_UserPrivilige_Json;
//    3135e04f7481761288cdc4b2cfa8ec64
//    3135e04f7481761288cdc4b2cfa8ec64
}

- (IBAction)but:(id)sender
{
    [APP_MTA MTA_touch_From:MTAEVENT_user_vip_to_pay];
    //购买数量
    NSString *count = [NSString stringWithFormat:@"%d",(int)_markVipLevel - (int)_currentVipLevel];
    //跳转去购买
    NSDictionary *dic = @{@"OrderType" : @"5", @"ItemCount" : count};
    ADAPI_Payment_GoCommonOrderShow([GLOBAL_DELEGATOR_MANAGER addDelegator:self selector:@selector(handleGoCommonOrderShow:)], dic);
}

- (void)handleGoCommonOrderShow:(DelegatorArguments *)arguments
{
    DictionaryWrapper *dic = arguments.ret;
    
    if (dic.operationSucceed)
    {
        PUSH_VIEWCONTROLLER(ConfirmOrderViewController);
        model.type = 3;
        model.payDic = @{@"OrderSerialNo" : @"", @"OrderType" : @"5", @"ItemCount" : [NSString stringWithFormat:@"%d",(int)_markVipLevel- (int)_currentVipLevel]};
        model.orderInfoDic = dic.data;
        model.goodsInfo = @[@{@"name" : @"用户VIP",@"num" : [NSString stringWithFormat:@"%d",(int)_markVipLevel - _currentVipLevel]}];
    }
    else
    {
        [HUDUtil showErrorWithStatus:dic.operationMessage];
        return;
    }
}

- (void)isDone:(DelegatorArguments *)arg
{
    [arg logError];
    NSLog(@"%@",arg.ret.operationMessage);
}

- (void)onMoveFoward:(UIButton *)sender
{
//    PUSH_VIEWCONTROLLER(CRMallManagerViewContrillrtViewController);
    PUSH_VIEWCONTROLLER(CROrderManagerViewController);
    model.type = CRENUM_OrderTypeUserVIP;
}
@end
