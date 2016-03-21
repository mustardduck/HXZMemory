//
//  SalesReturnAndAfterSaleViewController.m
//  miaozhuan
//
//  Created by Santiago on 14-12-8.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "SalesReturnAndAfterSaleViewController.h"
#import "SalesReturnAndAfterSaleCell.h"
#import "SalesReturnDetailViewController.h"
#import "DisagreeRerurnViewController.h"
#import "StartApealViewController.h"
#import "ReturnSucceedViewController.h"
#import "ApealingViewController.h"
#import "ApealingResultViewController.h"
@interface SalesReturnAndAfterSaleViewController ()<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, DisagreeReturnDelegate, StartApealDelegate>

@property (retain, nonatomic) IBOutlet UIView *tableHead;
@property (retain, nonatomic) IBOutlet UITableView *mainTable;
@property (retain, nonatomic) IBOutlet UIButton *btn1;
@property (retain, nonatomic) IBOutlet UIButton *btn2;
@property (retain, nonatomic) IBOutlet UIButton *btn3;
@property (retain, nonatomic) IBOutlet UIButton *btn4;
@property (retain, nonatomic) IBOutlet UIButton *btn5;
@property (retain, nonatomic) IBOutlet UIButton *btn6;
@property (retain, nonatomic) IBOutlet UILabel *label1;
@property (retain, nonatomic) IBOutlet UILabel *label2;
@property (retain, nonatomic) IBOutlet UILabel *label3;
@property (retain, nonatomic) IBOutlet UILabel *label4;
@property (retain, nonatomic) IBOutlet UILabel *label5;
@property (retain, nonatomic) IBOutlet UILabel *label6;
@property (retain, nonatomic) IBOutlet UITextField *merchantNameTextField;
@property (strong, nonatomic) WDictionaryWrapper *postDataWrapper;
@property (strong, nonatomic) MJRefreshController *mjCon;
@property (retain, nonatomic) IBOutlet UIView *noContentView;
@property (strong, nonatomic) NSString *idstring;

@property (retain, nonatomic) IBOutlet UIView *UILineView;
@property (retain, nonatomic) IBOutlet UIView *UILineView2;

@property (retain, nonatomic) IBOutlet UIView *UILineView3;
@property (retain, nonatomic) IBOutlet UIView *UILineView4;
@property (retain, nonatomic) IBOutlet UIView *UILineView5;
@property (retain, nonatomic) IBOutlet UIView *UILineView6;
@end

@implementation SalesReturnAndAfterSaleViewController
@synthesize tableHead = _tableHead;
@synthesize mainTable = _mainTable;
@synthesize btn1 = _btn1;
@synthesize btn2 = _btn2;
@synthesize btn3 = _btn3;
@synthesize btn4 = _btn4;
@synthesize btn5 = _btn5;
@synthesize btn6 = _btn6;
@synthesize label1 = _label1;
@synthesize label2 = _label2;
@synthesize label3 = _label3;
@synthesize label4 = _label4;
@synthesize label5 = _label5;
@synthesize label6 = _label6;
@synthesize merchantNameTextField = _merchantNameTextField;
@synthesize postDataWrapper = _postDataWrapper;
@synthesize mjCon = _mjCon;
@synthesize noContentView = _noContentView;
@synthesize type = _type;
@synthesize idstring = _idstring;
MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setupMoveBackButton];
    [self setTitle:@"退货/售后"];
    [self.mainTable registerNib:[UINib nibWithNibName:@"SalesReturnAndAfterSaleCell" bundle:nil] forCellReuseIdentifier:@"SalesReturnAndAfterSaleCell"];
    self.mainTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addDoneToKeyboard:_merchantNameTextField];
  
    if ([SystemUtil aboveIOS7_0]) {
        _mainTable.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    }
    
    self.postDataWrapper = WEAK_OBJECT(WDictionaryWrapper, init);
    
    if (_type) {
        
        switch (_type) {
            case 1:
                //发起退货
                [self.btn1 setTitleColor:RGBCOLOR(240, 5, 0) forState:UIControlStateNormal];
                
                [self.btn2 setTitleColor:RGBCOLOR(34, 34, 34) forState:UIControlStateNormal];
                
                [self.btn3 setTitleColor:RGBCOLOR(34, 34, 34) forState:UIControlStateNormal];
                
                [self.btn4 setTitleColor:RGBCOLOR(34, 34, 34) forState:UIControlStateNormal];
                
                [self.btn5 setTitleColor:RGBCOLOR(34, 34, 34) forState:UIControlStateNormal];
                
                [self.btn6 setTitleColor:RGBCOLOR(34, 34, 34) forState:UIControlStateNormal];
                
                [self.label1 setTextColor:RGBCOLOR(240, 5, 0)];
                
                [self.label2 setTextColor:RGBCOLOR(153, 153, 153)];
                
                [self.label3 setTextColor:RGBCOLOR(153, 153, 153)];
                
                [self.label4 setTextColor:RGBCOLOR(153, 153, 153)];
                
                [self.label5 setTextColor:RGBCOLOR(153, 153, 153)];
                
                [self.label6 setTextColor:RGBCOLOR(153, 153, 153)];
                
                [self.postDataWrapper set:@"SubOrderStatus" string:@"401"];
                break;
            case 2:
                //待退货
                
                [self.btn1 setTitleColor:RGBCOLOR(34, 34, 34) forState:UIControlStateNormal];
                
                [self.btn2 setTitleColor:RGBCOLOR(240, 5, 0) forState:UIControlStateNormal];
                
                [self.btn3 setTitleColor:RGBCOLOR(34, 34, 34) forState:UIControlStateNormal];
                
                [self.btn4 setTitleColor:RGBCOLOR(34, 34, 34) forState:UIControlStateNormal];
                
                [self.btn5 setTitleColor:RGBCOLOR(34, 34, 34) forState:UIControlStateNormal];
                
                [self.btn6 setTitleColor:RGBCOLOR(34, 34, 34) forState:UIControlStateNormal];
                
                [self.label1 setTextColor:RGBCOLOR(153, 153, 153)];
                
                [self.label2 setTextColor:RGBCOLOR(240, 5, 0)];
                
                [self.label3 setTextColor:RGBCOLOR(153, 153, 153)];
                
                [self.label4 setTextColor:RGBCOLOR(153, 153, 153)];
                
                [self.label5 setTextColor:RGBCOLOR(153, 153, 153)];
                
                [self.label6 setTextColor:RGBCOLOR(153, 153, 153)];

                [self.postDataWrapper set:@"SubOrderStatus" string:@"402"];
                break;
            case 3:
                //待确认退货
                
                [self.btn1 setTitleColor:RGBCOLOR(34, 34, 34) forState:UIControlStateNormal];
                
                [self.btn2 setTitleColor:RGBCOLOR(34, 34, 34) forState:UIControlStateNormal];
                
                [self.btn3 setTitleColor:RGBCOLOR(240, 5, 0) forState:UIControlStateNormal];
                
                [self.btn4 setTitleColor:RGBCOLOR(34, 34, 34) forState:UIControlStateNormal];
                
                [self.btn5 setTitleColor:RGBCOLOR(34, 34, 34) forState:UIControlStateNormal];
                
                [self.btn6 setTitleColor:RGBCOLOR(34, 34, 34) forState:UIControlStateNormal];
                
                [self.label1 setTextColor:RGBCOLOR(153, 153, 153)];
                
                [self.label2 setTextColor:RGBCOLOR(153, 153, 153)];
                
                [self.label3 setTextColor:RGBCOLOR(240, 5, 0)];
                
                [self.label4 setTextColor:RGBCOLOR(153, 153, 153)];
                
                [self.label5 setTextColor:RGBCOLOR(153, 153, 153)];
                
                [self.label6 setTextColor:RGBCOLOR(153, 153, 153)];
                
                [self.postDataWrapper set:@"SubOrderStatus" string:@"403"];
                break;
            case 4:
                //退货成功
                
                [self.btn1 setTitleColor:RGBCOLOR(34, 34, 34) forState:UIControlStateNormal];
                
                [self.btn2 setTitleColor:RGBCOLOR(34, 34, 34) forState:UIControlStateNormal];
                
                [self.btn3 setTitleColor:RGBCOLOR(34, 34, 34) forState:UIControlStateNormal];
                
                [self.btn4 setTitleColor:RGBCOLOR(240, 5, 0) forState:UIControlStateNormal];
                
                [self.btn5 setTitleColor:RGBCOLOR(34, 34, 34) forState:UIControlStateNormal];
                
                [self.btn6 setTitleColor:RGBCOLOR(34, 34, 34) forState:UIControlStateNormal];
                
                [self.label1 setTextColor:RGBCOLOR(153, 153, 153)];
                
                [self.label2 setTextColor:RGBCOLOR(153, 153, 153)];
                
                [self.label3 setTextColor:RGBCOLOR(153, 153, 153)];
                
                [self.label4 setTextColor:RGBCOLOR(240, 5, 0)];
                
                [self.label5 setTextColor:RGBCOLOR(153, 153, 153)];
                
                [self.label6 setTextColor:RGBCOLOR(153, 153, 153)];
                
                [self.postDataWrapper set:@"SubOrderStatus" string:@"404"];
                break;
            case 5:
                //仲裁中
                
                [self.btn1 setTitleColor:RGBCOLOR(34, 34, 34) forState:UIControlStateNormal];
                
                [self.btn2 setTitleColor:RGBCOLOR(34, 34, 34) forState:UIControlStateNormal];
                
                [self.btn3 setTitleColor:RGBCOLOR(34, 34, 34) forState:UIControlStateNormal];
                
                [self.btn4 setTitleColor:RGBCOLOR(34, 34, 34) forState:UIControlStateNormal];
                
                [self.btn5 setTitleColor:RGBCOLOR(240, 5, 0) forState:UIControlStateNormal];
                
                [self.btn6 setTitleColor:RGBCOLOR(34, 34, 34) forState:UIControlStateNormal];
                
                [self.label1 setTextColor:RGBCOLOR(153, 153, 153)];
                
                [self.label2 setTextColor:RGBCOLOR(153, 153, 153)];
                
                [self.label3 setTextColor:RGBCOLOR(153, 153, 153)];
                
                [self.label4 setTextColor:RGBCOLOR(153, 153, 153)];
                
                [self.label5 setTextColor:RGBCOLOR(240, 5, 0)];
                
                [self.label6 setTextColor:RGBCOLOR(153, 153, 153)];
                
                [self.postDataWrapper set:@"SubOrderStatus" string:@"405"];
                break;
            case 6:
                //仲裁完毕
                
                [self.btn1 setTitleColor:RGBCOLOR(34, 34, 34) forState:UIControlStateNormal];
                
                [self.btn2 setTitleColor:RGBCOLOR(34, 34, 34) forState:UIControlStateNormal];
                
                [self.btn3 setTitleColor:RGBCOLOR(34, 34, 34) forState:UIControlStateNormal];
                
                [self.btn4 setTitleColor:RGBCOLOR(34, 34, 34) forState:UIControlStateNormal];
                
                [self.btn5 setTitleColor:RGBCOLOR(34, 34, 34) forState:UIControlStateNormal];
                
                [self.btn6 setTitleColor:RGBCOLOR(240, 5, 0) forState:UIControlStateNormal];
                
                [self.label1 setTextColor:RGBCOLOR(153, 153, 153)];
                
                [self.label2 setTextColor:RGBCOLOR(153, 153, 153)];
                
                [self.label3 setTextColor:RGBCOLOR(153, 153, 153)];
                
                [self.label4 setTextColor:RGBCOLOR(153, 153, 153)];
                
                [self.label5 setTextColor:RGBCOLOR(153, 153, 153)];
                
                [self.label6 setTextColor:RGBCOLOR(240, 5, 0)];
                
                [self.postDataWrapper set:@"SubOrderStatus" string:@"406"];
                break;
                
            default:
                break;
        }
    }else {
    
        [self.postDataWrapper set:@"SubOrderStatus" string:@"401"];
    }
    
    [self.postDataWrapper set:@"OrderStatus" string:@"4"];
    [self.postDataWrapper set:@"EnterpriseId" string:[APP_DELEGATE.runtimeConfig getString:RUNTIME_USER_LOGIN_INFO".EnterpriseId"]];
    [self.postDataWrapper set:@"Keyword" string:@""];

    [self setRefreshItem];
    
    [self.UILineView setFrame:CGRectMake(0, 0, 320, 0.5)];
    [self.UILineView2 setFrame:CGRectMake(0, 39.5, 320, 0.5)];
    
    [self.UILineView3 setWidth:0.5];
    [self.UILineView4 setWidth:0.5];
    [self.UILineView5 setWidth:0.5];
    [self.UILineView6 setWidth:0.5];

    ADAPI_SalesAndAfterSaleStatusCount([self genDelegatorID:@selector(getStatusRequest:)]);
}

- (void)getStatusRequest:(DelegatorArguments*)arguments {

    DictionaryWrapper* wrapper = arguments.ret;
    if (wrapper.operationSucceed) {

        DictionaryWrapper *item = wrapper.data;
        
        [_label1 setText:[item getString:@"LaunchReturnCount"]];
        [_label2 setText:[item getString:@"WaitingReturnCount"]];
        [_label3 setText:[item getString:@"WaitingReturnConfirmCount"]];
        [_label4 setText:[item getString:@"SuccessReturnCount"]];
        [_label5 setText:[item getString:@"AppealingCount" ]];
        [_label6 setText:[item getString:@"AppealedCount"]];
    }else {
        
        [HUDUtil showErrorWithStatus:wrapper.operationMessage];
    }
}

- (void)hiddenKeyboard {

    [_merchantNameTextField resignFirstResponder];
}

- (void)setRefreshItem {

    NSString *refreshName = @"api/GoldOrder/GetOrderList";
    self.mjCon = [MJRefreshController controllerFrom:_mainTable name:refreshName];
    [self.mjCon setURLGenerator:^DictionaryWrapper *(NSString *refreshName, int pageIndex, int pageSize) {

        [self.postDataWrapper set:@"PageIndex" value:@(pageIndex)];
        [self.postDataWrapper set:@"PageSize" value:@(pageSize)];
        
        return @{
                 @"service":refreshName,
                 @"parameters":_postDataWrapper.dictionary
                 }.wrapper;
    }];
    
    MJRefreshOnRequestDone block = MJREFRESH_ON_REQUEST_DONE {
    
        if (netData.operationSucceed) {
            
        }else {
        
            [HUDUtil showErrorWithStatus:@"请求数据失败!"];
        }
        [_mainTable reloadData];
    };
    [self.mjCon setOnRequestDone:block];
    [self.mjCon setPageSize:30];
    [self.mjCon refreshWithLoading];
}
//statusChanged
- (IBAction)statusChanged:(UIButton*)sender {
    
    switch (sender.tag) {
            
        case 1:
            //发起退货
            
            [self.btn1 setTitleColor:RGBCOLOR(240, 5, 0) forState:UIControlStateNormal];
            
            [self.btn2 setTitleColor:RGBCOLOR(34, 34, 34) forState:UIControlStateNormal];
            
            [self.btn3 setTitleColor:RGBCOLOR(34, 34, 34) forState:UIControlStateNormal];
            
            [self.btn4 setTitleColor:RGBCOLOR(34, 34, 34) forState:UIControlStateNormal];
            
            [self.btn5 setTitleColor:RGBCOLOR(34, 34, 34) forState:UIControlStateNormal];
            
            [self.btn6 setTitleColor:RGBCOLOR(34, 34, 34) forState:UIControlStateNormal];
            
            [self.label1 setTextColor:RGBCOLOR(240, 5, 0)];
            
            [self.label2 setTextColor:RGBCOLOR(153, 153, 153)];
            
            [self.label3 setTextColor:RGBCOLOR(153, 153, 153)];
            
            [self.label4 setTextColor:RGBCOLOR(153, 153, 153)];
            
            [self.label5 setTextColor:RGBCOLOR(153, 153, 153)];
            
            [self.label6 setTextColor:RGBCOLOR(153, 153, 153)];
            
            [self.postDataWrapper set:@"SubOrderStatus" string:@"401"];
            [_mjCon refreshWithLoading];
            
            break;
        case 2:
            //待退货
            
            [self.btn1 setTitleColor:RGBCOLOR(34, 34, 34) forState:UIControlStateNormal];
            
            [self.btn2 setTitleColor:RGBCOLOR(240, 5, 0) forState:UIControlStateNormal];
            
            [self.btn3 setTitleColor:RGBCOLOR(34, 34, 34) forState:UIControlStateNormal];
            
            [self.btn4 setTitleColor:RGBCOLOR(34, 34, 34) forState:UIControlStateNormal];
            
            [self.btn5 setTitleColor:RGBCOLOR(34, 34, 34) forState:UIControlStateNormal];
            
            [self.btn6 setTitleColor:RGBCOLOR(34, 34, 34) forState:UIControlStateNormal];
            
            [self.label1 setTextColor:RGBCOLOR(153, 153, 153)];
            
            [self.label2 setTextColor:RGBCOLOR(240, 5, 0)];
            
            [self.label3 setTextColor:RGBCOLOR(153, 153, 153)];
            
            [self.label4 setTextColor:RGBCOLOR(153, 153, 153)];
            
            [self.label5 setTextColor:RGBCOLOR(153, 153, 153)];
            
            [self.label6 setTextColor:RGBCOLOR(153, 153, 153)];

            [self.postDataWrapper set:@"SubOrderStatus" string:@"402"];
            [_mjCon refreshWithLoading];
            
            break;
        case 3:
            //待确认退货
            
            [self.btn1 setTitleColor:RGBCOLOR(34, 34, 34) forState:UIControlStateNormal];
            
            [self.btn2 setTitleColor:RGBCOLOR(34, 34, 34) forState:UIControlStateNormal];
            
            [self.btn3 setTitleColor:RGBCOLOR(240, 5, 0) forState:UIControlStateNormal];
            
            [self.btn4 setTitleColor:RGBCOLOR(34, 34, 34) forState:UIControlStateNormal];
            
            [self.btn5 setTitleColor:RGBCOLOR(34, 34, 34) forState:UIControlStateNormal];
            
            [self.btn6 setTitleColor:RGBCOLOR(34, 34, 34) forState:UIControlStateNormal];
            
            [self.label1 setTextColor:RGBCOLOR(153, 153, 153)];
            
            [self.label2 setTextColor:RGBCOLOR(153, 153, 153)];
            
            [self.label3 setTextColor:RGBCOLOR(240, 5, 0)];
            
            [self.label4 setTextColor:RGBCOLOR(153, 153, 153)];
            
            [self.label5 setTextColor:RGBCOLOR(153, 153, 153)];
            
            [self.label6 setTextColor:RGBCOLOR(153, 153, 153)];
            
            [self.postDataWrapper set:@"SubOrderStatus" string:@"403"];
            [_mjCon refreshWithLoading];
            
            break;
        case 4:
            //退货成功
            
            [self.btn1 setTitleColor:RGBCOLOR(34, 34, 34) forState:UIControlStateNormal];
            
            [self.btn2 setTitleColor:RGBCOLOR(34, 34, 34) forState:UIControlStateNormal];
            
            [self.btn3 setTitleColor:RGBCOLOR(34, 34, 34) forState:UIControlStateNormal];
            
            [self.btn4 setTitleColor:RGBCOLOR(240, 5, 0) forState:UIControlStateNormal];
            
            [self.btn5 setTitleColor:RGBCOLOR(34, 34, 34) forState:UIControlStateNormal];
            
            [self.btn6 setTitleColor:RGBCOLOR(34, 34, 34) forState:UIControlStateNormal];
            
            [self.label1 setTextColor:RGBCOLOR(153, 153, 153)];
            
            [self.label2 setTextColor:RGBCOLOR(153, 153, 153)];
            
            [self.label3 setTextColor:RGBCOLOR(153, 153, 153)];
            
            [self.label4 setTextColor:RGBCOLOR(240, 5, 0)];
            
            [self.label5 setTextColor:RGBCOLOR(153, 153, 153)];
            
            [self.label6 setTextColor:RGBCOLOR(153, 153, 153)];
            
            [self.postDataWrapper set:@"SubOrderStatus" string:@"404"];
            [_mjCon refreshWithLoading];
            
            break;
        case 5:
            //仲裁中
            
            [self.btn1 setTitleColor:RGBCOLOR(34, 34, 34) forState:UIControlStateNormal];
            
            [self.btn2 setTitleColor:RGBCOLOR(34, 34, 34) forState:UIControlStateNormal];
            
            [self.btn3 setTitleColor:RGBCOLOR(34, 34, 34) forState:UIControlStateNormal];
            
            [self.btn4 setTitleColor:RGBCOLOR(34, 34, 34) forState:UIControlStateNormal];
            
            [self.btn5 setTitleColor:RGBCOLOR(240, 5, 0) forState:UIControlStateNormal];
            
            [self.btn6 setTitleColor:RGBCOLOR(34, 34, 34) forState:UIControlStateNormal];
            
            [self.label1 setTextColor:RGBCOLOR(153, 153, 153)];
            
            [self.label2 setTextColor:RGBCOLOR(153, 153, 153)];
            
            [self.label3 setTextColor:RGBCOLOR(153, 153, 153)];
            
            [self.label4 setTextColor:RGBCOLOR(153, 153, 153)];
            
            [self.label5 setTextColor:RGBCOLOR(240, 5, 0)];
            
            [self.label6 setTextColor:RGBCOLOR(153, 153, 153)];
            
            [self.postDataWrapper set:@"SubOrderStatus" string:@"405"];
            [_mjCon refreshWithLoading];
            
            break;
        case 6:
            //仲裁完毕
            
            [self.btn1 setTitleColor:RGBCOLOR(34, 34, 34) forState:UIControlStateNormal];
            
            [self.btn2 setTitleColor:RGBCOLOR(34, 34, 34) forState:UIControlStateNormal];
            
            [self.btn3 setTitleColor:RGBCOLOR(34, 34, 34) forState:UIControlStateNormal];
            
            [self.btn4 setTitleColor:RGBCOLOR(34, 34, 34) forState:UIControlStateNormal];
            
            [self.btn5 setTitleColor:RGBCOLOR(34, 34, 34) forState:UIControlStateNormal];
            
            [self.btn6 setTitleColor:RGBCOLOR(240, 5, 0) forState:UIControlStateNormal];
            
            [self.label1 setTextColor:RGBCOLOR(153, 153, 153)];
            
            [self.label2 setTextColor:RGBCOLOR(153, 153, 153)];
            
            [self.label3 setTextColor:RGBCOLOR(153, 153, 153)];
            
            [self.label4 setTextColor:RGBCOLOR(153, 153, 153)];
            
            [self.label5 setTextColor:RGBCOLOR(153, 153, 153)];
            
            [self.label6 setTextColor:RGBCOLOR(240, 5, 0)];
            
            [self.postDataWrapper set:@"SubOrderStatus" string:@"406"];
            [_mjCon refreshWithLoading];
            
            break;
        default:
            break;
    }
}

#pragma mark - DisagreeReturnDelegate&&StartApealDelegate
- (void)refresh {

    [_mjCon refreshWithLoading];
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField {

    NSLog(@"%f",[textField.text floatValue]);
    NSLog(@"%f",[textField.text doubleValue]);
    
    [self.postDataWrapper set:@"Keyword" string:textField.text];
    
    if (![textField.text isEqualToString:@""]||!textField.text) {

        [_mjCon refreshWithLoading];
    }
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return 0.001;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    UIView *temp = WEAK_OBJECT(UIView, init);
    [temp setBackgroundColor:RGBCOLOR(239, 239, 244)];
    return temp;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (_mjCon.refreshCount > 0) {
    
        self.noContentView.hidden = YES;
    }else {
    
        self.noContentView.hidden = NO;
    }
    return _mjCon.refreshCount;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    
    DictionaryWrapper *wrapper = [[_mjCon dataAtIndex:(int)indexPath.row] wrapper];
    int orderStatus = [wrapper getInt:@"OrderStatus"];
    
    if (orderStatus <= 499 && orderStatus >=400) {
        
        SalesReturnDetailViewController *temp = WEAK_OBJECT(SalesReturnDetailViewController, init);
        temp.type = 2;
        temp.orderId = [wrapper getInt:@"OrderId"];
        temp.status = [wrapper getInt:@"OrderStatus"];
        temp.creatTime = [wrapper getString:@"CreateTime"];
        [self.navigationController pushViewController:temp animated:YES];
    }
    
    if (orderStatus == 931) {
        
        PUSH_VIEWCONTROLLER(ReturnSucceedViewController);
    }
    
    if (orderStatus >=500 && orderStatus <=599) {
        
        PUSH_VIEWCONTROLLER(ApealingViewController);
    }
    
    if (orderStatus == 941) {
        
        ApealingResultViewController *temp = WEAK_OBJECT(ApealingResultViewController, init);
        temp.orderId = [wrapper getInt:@"OrderId"];
        [self.navigationController pushViewController:temp animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    DictionaryWrapper *wrapper = [[_mjCon dataAtIndex:(int)indexPath.row] wrapper];
    
    if ([wrapper getInt:@"OrderStatus"] == 401||[wrapper getInt:@"OrderStatus"] == 403||[wrapper getInt:@"OrderStatus"] == 404) {
     
        return 241;
    }else {
    
        return 191;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SalesReturnAndAfterSaleCell *cell = [_mainTable dequeueReusableCellWithIdentifier:@"SalesReturnAndAfterSaleCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    DictionaryWrapper *wrapper = [[_mjCon dataAtIndex:(int)indexPath.row] wrapper];
    NSArray *productArray = [wrapper getArray:@"OrderProducts"];
    DictionaryWrapper *tData;
    if ([productArray count] > 0) {
         tData = [productArray[0] wrapper];
    }
    //退货售后 401用户发起退货 view1
    //403商家已经拒绝退货 view2
    //404商家等待确认退货 view3
    switch ([wrapper getInt:@"OrderStatus"]) {
            
        case 401:
            cell.bottomView1.hidden = NO;
            cell.bottomView2.hidden = YES;
            cell.bottomView3.hidden = YES;
            cell.withoutView123VIew.hidden = YES;
            break;
            
        case 403:
            cell.bottomView1.hidden = YES;
            cell.bottomView2.hidden = NO;
            cell.bottomView3.hidden = YES;
            cell.withoutView123VIew.hidden = YES;
            break;
            
        case 404:
            cell.bottomView1.hidden = YES;
            cell.bottomView2.hidden = YES;
            cell.bottomView3.hidden = NO;
            cell.withoutView123VIew.hidden = YES;
            break;
            
        default:
            cell.bottomView1.hidden = YES;
            cell.bottomView2.hidden = YES;
            cell.bottomView3.hidden = YES;
            cell.withoutView123VIew.hidden = NO;
            break;
    }
    
    cell.userPhoneNumber.text = [NSString stringWithFormat:@"用户：%@",[wrapper getString:@"UserName"]];
    
    if ([wrapper getString:@"PayDate"]&&![[wrapper getString:@"PayDate"] isEqualToString:@""]) {
        
        NSLog(@"%@",[wrapper getString:@"PayDate"]);
        NSString *nstring = [wrapper getString:@"PayDate"];
        NSArray *array = [nstring componentsSeparatedByString:@"-"];
        NSMutableString *item = WEAK_OBJECT(NSMutableString, init);
        
        if ([array count] == 3) {
            
            [item appendString:array[1]];
            [item appendString:@"-"];
            [item appendString:array[2]];
        }
        
        NSLog(@"%@",item);
        NSArray *array2 = [item componentsSeparatedByString:@"T"];
        NSMutableString *item2 = WEAK_OBJECT(NSMutableString,init);
        
        if ([array2 count] == 2) {
            
            [item2 appendString:array2[0]];
            [item2 appendString:@" "];
            [item2 appendString:array2[1]];
        }
        
        NSArray *array3 = [item2 componentsSeparatedByString:@"."];
        if ([array3 count] > 1) {
            
            cell.orderTime.text = [NSString stringWithFormat:@"下单时间：%@",array3[0]];
        }else {
        
            cell.orderTime.text = [NSString stringWithFormat:@"下单时间：%@",[wrapper getString:@"PayDate"]];
        }
    }
    
    [cell.productPic requestPic:[tData getString:@"PictureUrl"] placeHolder:YES];
    
    cell.productPic.layer.borderWidth = 0.5;
    cell.productPic.layer.borderColor = [RGBCOLOR(204, 204, 204) CGColor];

    
    cell.productStatement.text = [tData getString:@"ProductName"];
    cell.productStyle.text = [tData getString:@"ProdutSpce"];
//    CGSize size1 = [[tData getString:@"ProdutSpce"] sizeWithFont:[UIFont systemFontOfSize:11] constrainedToSize:CGSizeMake(MAXFLOAT, 11) lineBreakMode:NSLineBreakByWordWrapping];
    
//    [cell.productStyle setFrame:CGRectMake(75, 104, size1.width+5, 11)];
    [cell.numberOfProducts setFrame:CGRectMake(cell.littleX.frame.origin.x+cell.littleX.frame.size.width+5, 104, 92, 11)];
    
    cell.numberOfProducts.text = [NSString stringWithFormat:@"%d",[tData getInt:@"Qty"]];
    cell.singlePrice.text = [NSString stringWithFormat:@"%.2f",[tData getFloat:@"UnitPrice"]];
    cell.price.text = [NSString stringWithFormat:@"%.2f",[wrapper getFloat:@"OrderAmount"]];
    
    CGSize prizeSize = [[NSString stringWithFormat:@"%.2f",[wrapper getFloat:@"OrderAmount"]] sizeWithFont:[UIFont systemFontOfSize:11] constrainedToSize:CGSizeMake(MAXFLOAT, 11) lineBreakMode:NSLineBreakByWordWrapping];

    [cell.price setFrame:CGRectMake(46, 152, prizeSize.width+4, 11)];
    [cell.labelAfterPrice setFrame:CGRectMake(46+prizeSize.width+5, 151, 221, 11)];
    cell.labelAfterPrice.text = [NSString stringWithFormat:@"（包含运费%.2f）",[wrapper getFloat:@"DeliveryPrice"]];
    
    cell.timeLeftLabel.text = [wrapper getString:@"LeftCloseTime"];
    cell.timeLeftLabel3.text = [wrapper getString:@"LeftCloseTime"];
    
    cell.rejectReturn.tag = [wrapper getInt:@"OrderId"];
    cell.agreeReturn.tag = [wrapper getInt:@"OrderId"];
    cell.startArbitrament.tag = [wrapper getInt:@"OrderId"];
    cell.confirmProduct.tag = [wrapper getInt:@"OrderId"];
    
    [cell.rejectReturn addTarget:self action:@selector(rejectReturn:) forControlEvents:UIControlEventTouchUpInside];
    [cell.agreeReturn addTarget:self action:@selector(agreeReturn:) forControlEvents:UIControlEventTouchUpInside];
    [cell.startArbitrament addTarget:self action:@selector(arbitrament:) forControlEvents:UIControlEventTouchUpInside];
    [cell.confirmProduct addTarget:self action:@selector(confirmProducts:) forControlEvents:UIControlEventTouchUpInside];
    
    if (indexPath.row == 0) {
        
        cell.UILineView.hidden = YES;
    }else {
    
        cell.UILineView.hidden = NO;
    }
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {

    UIView *temp = WEAK_OBJECT(UIView, init);
    [temp setBackgroundColor:RGBCOLOR(239, 239, 244)];
    return temp;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {

    return 1;
}

//拒绝退货
- (void)rejectReturn:(UIButton*)sender {

    DisagreeRerurnViewController *temp = WEAK_OBJECT(DisagreeRerurnViewController, init);
    temp.orderId = (int)sender.tag;
    temp.delegate = self;
    [self.navigationController pushViewController:temp animated:YES];
}

//同意退货
- (void)agreeReturn:(UIButton*)sender {

    NSString *idStr = [NSString stringWithFormat:@"%ld",(long)sender.tag];
    ADAPI_adv3_GoldOrder_EnterpriseOrderOperate ([self genDelegatorID:@selector(agreeReturnRequest:)],idStr,@"12");
}

- (void)agreeReturnRequest:(DelegatorArguments*)arguments {

    DictionaryWrapper *wrapper = arguments.ret;
    if (wrapper.operationSucceed) {
        
        [_mjCon refreshWithLoading];
        [HUDUtil showSuccessWithStatus:@"操作成功！"];
    }else {
    
        [HUDUtil showErrorWithStatus:@"操作失败！"];
    }
}

//发起仲裁
- (void)arbitrament:(UIButton*)sender {

    [AlertUtil showAlert:@"确认发起申诉?"
                 message:@"您确认需要官方介入申诉结果吗"
                 buttons:@[
                           @"取消",
                           @{
                               @"title":@"确定",
                               @"delegator":ALERT_VIEW_DELEGATOR_BLOCK({
        
                                    StartApealViewController *temp = WEAK_OBJECT(StartApealViewController, init);
                                    temp.orderId = (int)sender.tag;
                                    temp.delegate = self;
                                    [self.navigationController pushViewController:temp animated:YES];
    })}]];
}

//确认货物
- (void)confirmProducts:(UIButton*)sender {

    self.idstring = [NSString stringWithFormat:@"%ld",(long)sender.tag];
    
    [AlertUtil showAlert:nil
                 message:@"确定退回的商品无误并确定本次退货吗？"
                 buttons:@[
                           @"取消",
                           @{
                               @"title":@"确定",
                               @"delegator":ALERT_VIEW_DELEGATOR_BLOCK({
        
        ADAPI_adv3_GoldOrder_EnterpriseOrderOperate ([self genDelegatorID:@selector(conFirmProductsRequestSucceed:)],_idstring,@"15");
    })}]];
}

- (void)conFirmProductsRequestSucceed:(DelegatorArguments*)arguments {

    DictionaryWrapper *wrapper = arguments.ret;
    if (wrapper.operationSucceed) {
        
        [_mjCon refreshWithLoading];
        [HUDUtil showSuccessWithStatus:@"操作成功！"];
    }else {
        
        [HUDUtil showErrorWithStatus:@"操作失败！"];
    }
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    
    [_idstring release];
    [_postDataWrapper release];
    [_tableHead release];
    [_mainTable release];
    [_btn1 release];
    [_btn2 release];
    [_btn3 release];
    [_btn4 release];
    [_btn5 release];
    [_btn6 release];
    [_merchantNameTextField release];
    [_noContentView release];
    [_UILineView release];
    [_UILineView2 release];
    [_UILineView3 release];
    [_UILineView4 release];
    [_UILineView5 release];
    [_UILineView6 release];
    [_label1 release];
    [_label2 release];
    [_label3 release];
    [_label4 release];
    [_label5 release];
    [_label6 release];
    [super dealloc];
}

- (void)viewDidUnload {
    [self setTableHead:nil];
    [super viewDidUnload];
}
@end
