//
//  AuditStatementViewController.m
//  miaozhuan
//
//  Created by Santiago on 14-11-20.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "AuditStatementViewController.h"
#import "ControlViewController.h"
@interface AuditStatementViewController ()

@property (retain, nonatomic) IBOutlet UIImageView *statementImage;
@property (retain, nonatomic) IBOutlet UILabel *statementTitle;
@property (retain, nonatomic) IBOutlet UILabel *statementDetail;
@property (retain, nonatomic) IBOutlet UIButton *statementButton;
@property (retain, nonatomic) IBOutlet UILabel *tempLeft;
@property (retain, nonatomic) IBOutlet UILabel *tempRight;
@end

@implementation AuditStatementViewController
@synthesize statementImage = _statementImage;
@synthesize statementTitle = _statementTitle;
@synthesize statementDetail = _statementDetail;
@synthesize statementButton = _statementButton;
@synthesize tempLeft = _tempLeft;
@synthesize tempRight = _tempRight;

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setupMoveBackButtonWithTitle:@""];
    [self setTitle:@"发广告"];
    [self setUpFrame:self.audicStatement];
}

- (void)setUpFrame:(int)statement {

    switch (statement) {
        case 0:
            _statementImage.image = [UIImage imageNamed:@"auditing"];
            _statementTitle.text = @"您的商家申请，正在审核中";
            
            _statementDetail.text = @"客服将在24小时内给出审核结果\n客服热线: 400-019-3588";
            
            _statementButton.hidden = YES;
            
            _tempLeft.hidden = YES;
            _tempRight.hidden = YES;
            break;
        case 1:
             _statementImage.image = [UIImage imageNamed:@"auditFail"];
             _statementTitle.text = @"您的商家申请失败";
            
            _statementDetail.text = @"您可以重新编辑审核失败的信息,\n再次发起审核";
            
            _statementButton.hidden = NO;
            [_statementButton setTitle:@"立即编辑" forState:UIControlStateNormal];
            [_statementButton addTarget:self action:@selector(reditApplyToBeMerchantStep1) forControlEvents:UIControlEventTouchUpInside];
            
            _tempLeft.hidden = YES;
            _tempRight.hidden = YES;
            break;
        case 2:
            _statementImage.image = [UIImage imageNamed:@"auditSucceed"];
            
            [_statementTitle setSize:CGSizeMake(320, 46)];

            _statementTitle.text = @"您的商家申请成功";
            
            [_statementDetail setFrame:CGRectMake(0, _statementButton.frame.origin.y-37, 320, 20)];
            _statementDetail.text = @"您可以激活您的商家权限了";
            
            _statementButton.hidden = NO;
            [_statementButton setTitle:@"立即激活" forState:UIControlStateNormal];
            [_statementButton addTarget:self action:@selector(enableItRightNow) forControlEvents:UIControlEventTouchUpInside];
            
            _tempLeft.hidden = NO;
            _tempRight.hidden = NO;
            break;
        default:
            break;
    }
}

//立即编辑
- (void)reditApplyToBeMerchantStep1 {
    
    UINavigationController* navigationController = self.navigationController;
    [navigationController popViewControllerAnimated:FALSE];
    [navigationController popViewControllerAnimated:FALSE];
}

//立即激活
- (void)enableItRightNow {
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    //设置到发广告页面?????
}

- (void)onMoveBack:(UIButton *)sender {
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)dealloc {
    [_statementImage release];
    [_statementTitle release];
    [_statementDetail release];
    [_statementButton release];
    [_tempLeft release];
    [_tempRight release];
    [super dealloc];
}
@end
