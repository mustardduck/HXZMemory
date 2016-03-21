
//
//  ConsumerPriviliegeViewController.m
//  miaozhuan
//
//  Created by abyss on 14/10/22.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "ConsumerPriviliegeViewController.h"
#import "VipPriviliegeViewController.h"
#import "ThankfulFruitViewController.h"
#import "UserInfo.h"
#import "CRScrollController.h"
#import "NetImageView.h"
#import "WebhtmlViewController.h"

@interface ConsumerPriviliegeViewController () <CRSCDelegate>
{
    int64_t _currentVipLevel;
    
    NSArray * arrImage;
    
    CRScrollController *_scrollCon;
}
@property (retain, nonatomic) IBOutlet UIScrollView *scrollerView;
@property (retain, nonatomic) IBOutlet UIView *showView;

@end

@implementation ConsumerPriviliegeViewController
@synthesize vipLabelTitle = _vipLabelTitle;
@synthesize vipLabel   = _vipLabel;


MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"%@,%@",[@"roger" substringFromIndex:[@"roger" rangeOfString:@"o"].location],[@"roger" substringToIndex:[@"roger" rangeOfString:@"o"].location]);

    _scrollCon = [CRScrollController controllerFromView:_scrollerView];
    _scrollCon.isBackWhite = YES;
    
    _scrollerView.frame = CGRectMake(0, 0, 320, 110);
   
    InitNav(@"用户特权");

    [self initVipLabel];
    
    ADAPI_adv3_Operator_GetBannerListByCategoryCode([self genDelegatorID:@selector(HandleNotification:)], @"148f9765f322a0d1bd478b6eeae3d684");
}

- (void)HandleNotification:(DelegatorArguments *)arguments
{
    if ([arguments isEqualToOperation:ADOP_adv3_Operator_GetBannerListByCategoryCode])
    {
        [arguments logError];
        
        DictionaryWrapper *wrapper = arguments.ret;
        
        if (wrapper.operationSucceed)
        {
            _showView.hidden = YES;
            
            arrImage = wrapper.data;
            [arrImage retain];
            _scrollCon.picArray = arrImage;
            _scrollCon.delegate = self;

        }
        else if(wrapper.operationPromptCode || wrapper.operationErrorCode)
        {
            [AlertUtil showAlert:@"" message:wrapper.operationMessage buttons:@[@"好的"]];
            return;
        }
    }
}

- (void)scrollView:(CRScrollController *)view didSelectPage:(NSInteger)index
{
    PUSH_VIEWCONTROLLER(WebhtmlViewController);
    if (index == 0)
    {
        model.navTitle = @"用户VIP介绍";
    }
    else
    {
        model.navTitle = @"感恩果介绍";
    }
    model.ContentCode = [[[arrImage objectAtIndex:index] wrapper] getString:@"Code"];
}

- (void)initVipLabel
{
    _currentVipLevel = USER_MANAGER.vipLevel;
    NSArray *labelTitle = @[@"购买VIP, 尊享用户VIP特权",@"升级VIP, 提升收益额度",@"至尊VIP7, 彰显VIP特权"];
    NSArray *labeltext = @[@"",@"当前VIP1",@"当前VIP2",@"当前VIP3",@"当前VIP4",@"当前VIP5",@"当前VIP6",@"已达VIP7"];
    _vipLabel.text = labeltext[_currentVipLevel];
    _vipLabelTitle.font= Font(14);
    _vipLabel.textColor = AppColor(204);
    
    _vipLabelTitle.text = labelTitle[1];
    if (_currentVipLevel == 0) _vipLabelTitle.text = labelTitle[0];
    else if (_currentVipLevel == 7) _vipLabelTitle.text = labelTitle[2];
    _vipLabelTitle.font = Font(16);
    _vipLabelTitle.textColor = AppColor(34);
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)onMoveBack:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)dealloc
{
    [arrImage release];
    [_vipButton release];
    [_thankgivingButton release];
    
    [_vipLabel release];
    [_vipLabelTitle release];
    CRDEBUG_DEALLOC();
    
    [_scrollerView release];
    [_scrollCon remove];
    [_showView release];
    [super dealloc];
}

- (void)viewDidUnload
{
    [self setScrollerView:nil];
    [self setVipButton:nil];
    [self setThankgivingButton:nil];
    [super viewDidUnload];
}
- (IBAction)vipJump:(id)sender
{
//    VipPriviliegeViewController *model = WEAK_OBJECT(VipPriviliegeViewController, init);
//    _currentVipLevel = 7;
//    model.currentVipLevel = _currentVipLevel;
//    [self.navigationController pushViewController:model animated:YES];
    PUSH_VIEWCONTROLLER(VipPriviliegeViewController);
    model.currentVipLevel = _currentVipLevel;
}
- (IBAction)thankgivingJump:(id)sender
{
    PUSH_VIEWCONTROLLER(ThankfulFruitViewController);
}
@end
