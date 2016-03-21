//
//  ApealingResultViewController.m
//  miaozhuan
//
//  Created by Santiago on 14-12-30.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "ApealingResultViewController.h"

@interface ApealingResultViewController ()
@property (retain, nonatomic) IBOutlet UIView *UILineView;
@property (retain, nonatomic) IBOutlet UIView *UILineView2;
@property (retain, nonatomic) IBOutlet UIView *apealContentView;
@property (retain, nonatomic) IBOutlet UILabel *officalLabel;
@property (retain, nonatomic) IBOutlet UIButton *officalPhoneBtn;
@property (retain, nonatomic) IBOutlet UIScrollView *mainScrollerView;
@end

@implementation ApealingResultViewController
@synthesize orderId = _orderId;
MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupMoveBackButton];
    [self setTitle:@"协商退货"];
    self.UILineView.height = 0.5;
    ADAPI_ApealingResult([self genDelegatorID:@selector(requestData:)], _orderId);
    [self.UILineView2 setFrame:CGRectMake(0, 329.5, 320, 0.5)];
    
}

- (void)requestData:(DelegatorArguments*)arguments {

    DictionaryWrapper *wrapper = arguments.ret;
    DictionaryWrapper *item = wrapper.data;
    if (wrapper.operationSucceed) {
        
        self.merchantAccount.text = [NSString stringWithFormat:@"%.2f",[item getFloat:@"EnterpriseGold"]];
        self.userAccount.text = [NSString stringWithFormat:@"%.2f",[item getFloat:@"CustomerGold"]];
        self.productBelongsToWho.text = [item getString:@"ProductOwner"];
        self.apealStatement.text = [item getString:@"Comment"];
        
        [self.apealStatement setupLabelFrameWithString:[item getString:@"Comment"] andFont:14.f andWidth:self.apealStatement.frame.size.width];
        
        [self.mainScrollerView bringSubviewToFront:self.apealContentView];
        [self.apealContentView bringSubviewToFront:self.apealStatement];
        
        float extraHeight = self.apealStatement.frame.size.height - 52;
        
        [self.apealContentView setSize:CGSizeMake(320, 330 + extraHeight)];
        [self.UILineView2 setOrigin:CGPointMake(0, self.apealContentView.frame.size.height - 0.5)];
        
        [self.officalLabel setOrigin:CGPointMake(self.officalLabel.origin.x, self.officalLabel.origin.y + extraHeight)];
        [self.officalPhoneBtn setOrigin:CGPointMake(self.officalPhoneBtn.origin.x, self.officalPhoneBtn.origin.y + extraHeight)];
        
        [self.mainScrollerView setContentSize:CGSizeMake(320, self.officalLabel.bottom + 180)];
    }else {
        
        [HUDUtil showErrorWithStatus:@"请求数据失败"];
    }
}

- (IBAction)officalNumber:(id)sender {
    
    if([CTSIMSupportGetSIMStatus() isEqualToString:kCTSIMSupportSIMStatusNotInserted]){
        
        [HUDUtil showErrorWithStatus:@"请先插入SIM卡"];
    }else{
        
        [[UICommon shareInstance]makeCall:@"4004193588"];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)dealloc {
    [_merchantAccount release];
    [_userAccount release];
    [_productBelongsToWho release];
    [_apealStatement release];
    [_UILineView release];
    [_UILineView2 release];
    [_apealContentView release];
    [_officalLabel release];
    [_officalPhoneBtn release];
    [_mainScrollerView release];
    [super dealloc];
}
@end
