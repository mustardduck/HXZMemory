//
//  MyYHMController.m
//  miaozhuan
//
//  Created by momo on 15/5/28.
//  Copyright (c) 2015年 zdit. All rights reserved.
//

#import "MyYHMController.h"
#import "WebhtmlViewController.h"
#import "MyYHMListController.h"

@interface MyYHMController ()

@property (retain, nonatomic) IBOutlet UILabel *totalNumLbl;
@property (retain, nonatomic) IBOutlet UIButton *firstBtn;
@property (retain, nonatomic) IBOutlet UILabel *firstLbl;
@property (retain, nonatomic) IBOutlet UIButton *secondBtn;
@property (retain, nonatomic) IBOutlet UILabel *secondLbl;
@property (retain, nonatomic) IBOutlet UIButton *thirdBtn;
@property (retain, nonatomic) IBOutlet UILabel *thirdLbl;
@property (retain, nonatomic) IBOutlet UIButton *forthBtn;
@property (retain, nonatomic) IBOutlet UILabel *forthLbl;
@property (retain, nonatomic) IBOutlet UILabel *fifthLbl;
@property (retain, nonatomic) IBOutlet UIButton *fifthBtn;

@end

@implementation MyYHMController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setNavigateTitle:@"我的易货码"];
    [self setupMoveBackButton];
    [self setupMoveFowardButtonWithTitle:@"说明"];
}

-(void)viewWillAppear:(BOOL)animated
{
    ADAPI_adv3_3_BarterCodeIndex([GLOBAL_DELEGATOR_MANAGER addDelegator:self selector:@selector(HandleNotification:)]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) onMoveFoward:(UIButton *)sender
{
    WebhtmlViewController *view = WEAK_OBJECT(WebhtmlViewController, init);
    view.navTitle = @"易货码说明";
    view.ContentCode = @"2531f3cf22e5677cf53524f33b43bc15";
    [self.navigationController pushViewController:view animated:YES];
}

-(void)HandleNotification: (DelegatorArguments *)arguments
{
    if ([arguments isEqualToOperation:ADOP_adv3_3_BarterCodeIndex])
    {
        [arguments logError];
        
        DictionaryWrapper* wrapper = arguments.ret;
        
        if (wrapper.operationSucceed)
        {
            BOOL isDiscount = [wrapper.data getBool:@"IsBarterCodeActive"];
            
            if(isDiscount)
            {
                _firstLbl.text = @"进行中";
            }
            
            _totalNumLbl.text = [NSString stringWithFormat:@"%.2f", [wrapper.data getFloat:@"LeftBarterCode"]];
            
            _secondLbl.text = [NSString stringWithFormat:@"%.2f", [wrapper.data getFloat:@"ExchangeEarnBarterCode"]];

            _thirdLbl.text = [NSString stringWithFormat:@"%.2f", [wrapper.data getFloat:@"BarterConsumeTotal"]];

            _forthLbl.text = [NSString stringWithFormat:@"%.2f", [wrapper.data getFloat:@"BarterMallTotal"]];
            
            _fifthLbl.text = [NSString stringWithFormat:@"%.2f", [wrapper.data getFloat:@"OtherBarterTotal"]];

        }
        else
        {
            [HUDUtil showErrorWithStatus:wrapper.operationMessage];
        }
    }

}

- (IBAction)touchUpInsideOn:(id)sender {
    if(sender == _firstBtn)
    {
        WebhtmlViewController *view = WEAK_OBJECT(WebhtmlViewController, init);
        view.navTitle = @"抢兑易货码";
        view.ContentCode = @"2f493aad6ab52bcc64d75db989d48483";
        [self.navigationController pushViewController:view animated:YES];
    }
    else if(sender == _secondBtn)
    {
        PUSH_VIEWCONTROLLER(MyYHMListController);
        model.cellType = DHHD_YHM;
    }
    else if(sender == _thirdBtn)
    {
        PUSH_VIEWCONTROLLER(MyYHMListController);
        model.cellType = YHXH_YHM;
    }
    else if(sender == _forthBtn)
    {
        PUSH_VIEWCONTROLLER(MyYHMListController);
        model.cellType = YHHK_YHM;
    }
    else if(sender == _fifthBtn)
    {
        PUSH_VIEWCONTROLLER(MyYHMListController);
        model.cellType = QT_YHM;
    }
}

- (void)dealloc {
    [_fifthBtn release];
    [_fifthLbl release];
    [_totalNumLbl release];
    [_firstBtn release];
    [_firstLbl release];
    [_secondBtn release];
    [_secondLbl release];
    [_thirdBtn release];
    [_thirdLbl release];
    [_forthBtn release];
    [_forthLbl release];
    [super dealloc];
}
@end
