//
//  ConsultAndAnswerViewController.m
//  miaozhuan
//
//  Created by Santiago on 14-12-6.
//  Copyright (c) 2014年 zdit. All rights reserved.
//  

#import "ConsultAndAnswerViewController.h"
#import "ConsultAndAnswerCell.h"
#import "MerchantDetailViewController.h"
@interface ConsultAndAnswerViewController ()<UITableViewDataSource, UITableViewDelegate, DelMessageCell>

@property (retain, nonatomic) IBOutlet UIView *tableHead;
@property (retain, nonatomic) IBOutlet UITableView *mainTable;
@property (retain, nonatomic) IBOutlet UILabel *fromMerchantLabel;
@property (retain, nonatomic) IBOutlet UILabel *fromUserLabel;
@property (retain, nonatomic) IBOutlet UIView *littleRedLine;
@property (strong, nonatomic) MJRefreshController *mjCon;
@property (strong, nonatomic) NSArray *dataSource;
@property (assign, nonatomic) int messageType;
@property (retain, nonatomic) IBOutlet UIView *noDataView;
@property (retain, nonatomic) IBOutlet UIView *UILineView;
@end

@implementation ConsultAndAnswerViewController
@synthesize tableHead = _tableHead;
@synthesize mainTable = _mainTable;
@synthesize fromMerchantLabel = _fromMerchantLabel;
@synthesize fromUserLabel = _fromUserLabel;
@synthesize littleRedLine = _littleRedLine;
@synthesize mjCon = _mjCon;
@synthesize dataSource = _dataSource;
@synthesize messageType = _messageType;
@synthesize noDataView = _noDataView;
@synthesize UILineView = _UILineView;

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setTitle:@"咨询回复"];
    [self setupMoveBackButton];
    [self.mainTable registerNib:[UINib nibWithNibName:@"ConsultAndAnswerCell" bundle:nil] forCellReuseIdentifier:@"ConsultAndAnswerCell"];
    [self.mainTable setTableHeaderView:_tableHead];
    self.mainTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.messageType = 101;
    [self configRefreshItemWithMessageType];
    [self.UILineView setFrame:CGRectMake(0, 0, 320, 0.5)];
}


- (void)configRefreshItemWithMessageType{

 
    NSString *refreshName = @"api/Message/ConsultMsg";
    self.mjCon = [MJRefreshController controllerFrom:_mainTable name:refreshName];
    
    __block ConsultAndAnswerViewController *weakSelf = self;
    
    [self.mjCon setURLGenerator:MJREFRESH_URL_GENERATOR_BLOCK {
    
        return @{
                 @"service":refreshName,
              @"parameters":@{
                        @"Type":[NSString stringWithFormat:@"%d",_messageType],
                   @"PageIndex":@(pageIndex),
                    @"PageSize":@(pageSize)}
                 }.wrapper;
    }];
    
    MJRefreshOnRequestDone block = MJREFRESH_ON_REQUEST_DONE {
    
        if (netData.operationSucceed) {
            
            DictionaryWrapper *wrapper = netData.data;
            weakSelf.dataSource = [wrapper getArray:@"PageData"];
            if ([_dataSource  count] > 0) {
                
                _noDataView.hidden = YES;
            }else {
            
                _noDataView.hidden = NO;
            }
        }else{
        
            [HUDUtil showErrorWithStatus:netData.operationMessage];
        }
        [_mainTable reloadData];
    };
    
    [_mjCon setOnRequestDone:block];
    [_mjCon setPageSize:10];
    [_mjCon refreshWithLoading];
}
//来自商家
- (IBAction)fromMerchant:(id)sender {
    
    [self.fromMerchantLabel setFont:[UIFont systemFontOfSize:17]];
    [self.fromMerchantLabel setTextColor:[UIColor redColor]];
    [self.fromUserLabel setFont:[UIFont systemFontOfSize:14]];
    [self.fromUserLabel setTextColor:[UIColor blackColor]];

    [UIView animateWithDuration:0.3
                     animations:^{
                         [self.littleRedLine setFrame:CGRectMake(41, 38, 78, 2)];
                     }];
    self.messageType = 101;
    [_mjCon refreshWithLoading];
}

//来自客户
- (IBAction)fromUser:(id)sender {

    [self.fromMerchantLabel setFont:[UIFont systemFontOfSize:14]];
    [self.fromUserLabel setFont:[UIFont systemFontOfSize:17]];
    [self.fromMerchantLabel setTextColor:[UIColor blackColor]];
    [self.fromUserLabel setTextColor:[UIColor redColor]];
    
    [UIView animateWithDuration:0.3
                     animations:^{
                         [self.littleRedLine setFrame:CGRectMake(201, 38, 78, 2)];
                     }];
    self.messageType = 102;
    [_mjCon refreshWithLoading];
}

#pragma mark - DelMessageCell
-(void) deleteMessage:(ConsultAndAnswerCell*)cell atIndexPath:(NSIndexPath*)indexPath {
//cell里面必须确定indexpath，type，id不为空
    [_mjCon removeDataAtIndex:(int)indexPath.row andView:UITableViewRowAnimationLeft];
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _mjCon.refreshCount;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if (_messageType == 101) {
        
        DictionaryWrapper *wrapper = [[_mjCon dataAtIndex:(int)indexPath.row] wrapper];
        DictionaryWrapper *item = [wrapper getDictionaryWrapper:@"RelatedDataInfo"];
        
        MerchantDetailViewController *temp = WEAK_OBJECT(MerchantDetailViewController, init);
        temp.comefrom = @"0";
        temp.enId = [NSString stringWithFormat:@"%d",[item getInt:@"EnterpriseId"]];
        [self.navigationController pushViewController:temp animated:YES];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    ConsultAndAnswerCell *cell = [_mainTable dequeueReusableCellWithIdentifier:@"ConsultAndAnswerCell" forIndexPath:indexPath];
    
    int distinguishHeight = 0;
    
    //来自商家
    if (_messageType == 101) {
    
        distinguishHeight = 0;
        [cell.delMessageImage setOrigin:CGPointMake(292, 24)];
        cell.fromCompanyName.hidden = NO;
        cell.fromMerchantTitle.hidden = NO;
        [cell.topGrayView setHeight:43];
    }else {
    
        distinguishHeight = -19;
        [cell.delMessageImage setOrigin:CGPointMake(292, 14)];
        cell.fromCompanyName.hidden = YES;
        cell.fromMerchantTitle.hidden = YES;
        [cell.topGrayView setHeight:24];
    }

    
    DictionaryWrapper *wrapper = [[_mjCon dataAtIndex:(int)indexPath.row] wrapper];
    cell.delegate = self;
    cell.thisIndexPath = indexPath;
    cell.cellType = _messageType;
    cell.messageID = [wrapper getString:@"MsgId"];
    
    
    
    NSString *string = [wrapper getString:@"MsgDate"];
    NSMutableString *resultStr = WEAK_OBJECT(NSMutableString, init);
    NSArray *array = [string componentsSeparatedByString:@"T"];
    
    if ([array count] >= 2) {
        
        NSDate *today=[NSDate date];
        
        NSDate *yesterday =[NSDate dateWithTimeIntervalSinceNow:-(24*60*60)];
        
        NSDateFormatter *formatter = [[NSDateFormatter  alloc ]  init ];
        
        [formatter setDateFormat:@"yyyy-MM-dd"];
        
        NSString *todayString = [formatter stringFromDate:today];
        NSString *yesterdayString = [formatter stringFromDate:yesterday];
        
        [formatter release];
        
        if ([todayString isEqualToString:array[0]]) {
            
            [resultStr appendString:@"今天"];
        }else if([yesterdayString isEqualToString:array[0]]){
        
            [resultStr appendString:@"昨天"];
        }else {
            
            [resultStr appendString:array[0]];
        }
        string = array[1];
        array = [string componentsSeparatedByString:@":"];
    }
    
    if ([array count] >= 2) {
        [resultStr appendString:@" "];
        [resultStr appendString:array[0]];
        [resultStr appendString:@":"];
        [resultStr appendString:array[1]];
    }
    
    cell.messageDate.text = resultStr;
    
    DictionaryWrapper *messageData = [[wrapper getDictionary:@"RelatedDataInfo"] wrapper];
    cell.consultText.text = [messageData getString:@"Question"];
    cell.answerText.text = [messageData getString:@"Reply"];
    cell.fromCompanyName.text = [messageData getString:@"Name"];
    
    CGSize size1 = [[messageData getString:@"Question"] sizeWithFont:[UIFont systemFontOfSize:13] constrainedToSize:CGSizeMake(270, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
    CGSize size2 = [[messageData getString:@"Reply"] sizeWithFont:[UIFont systemFontOfSize:13] constrainedToSize:CGSizeMake(270, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
    
    [cell.consultText setFrame:CGRectMake(35, 71 + distinguishHeight, 270, size1.height)];
    [cell.consultMessage setOrigin:CGPointMake(10, 72 + distinguishHeight)];
    
    [cell.littleGrayLine setFrame:CGRectMake(35, cell.consultText.frame.origin.y+size1.height+15, 285, 1)];
    [cell.answerImage setFrame:CGRectMake(10, cell.littleGrayLine.frame.origin.y+15, 15, 15)];
    [cell.answerText setFrame:CGRectMake(35, cell.littleGrayLine.frame.origin.y+14, 270, size2.height)];
    
    if ([messageData getString:@"EarlyReply"]&&![[messageData getString:@"EarlyReply"] isEqualToString:@""]) {
    
        cell.earlierReplyView.hidden = NO;
        cell.earlierReplyText.text = [NSString stringWithFormat:@"               %@",[messageData getString:@"EarlyReply"]];
        
        CGSize size3 = [[NSString stringWithFormat:@"               %@",[messageData getString:@"EarlyReply"]] sizeWithFont:[UIFont systemFontOfSize:13] constrainedToSize:CGSizeMake(270, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
        
        [cell.earlierReplyView setFrame:CGRectMake(35, cell.answerText.frame.origin.y+cell.answerText.frame.size.height+10, 270, size3.height+20)];
        [cell.earlierReplyText setFrame:CGRectMake(10, 10, 250, size3.height)];
        [cell.UIButtomLineView setOrigin:CGPointMake(0, cell.earlierReplyView.origin.y + cell.earlierReplyView.frame.size.height + 14)];
    }else {
    
        cell.earlierReplyView.hidden = YES;
        [cell.UIButtomLineView setOrigin:CGPointMake(0, cell.answerText.origin.y + cell.answerText.frame.size.height + 14)];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    DictionaryWrapper *wrapper = [[_mjCon dataAtIndex:(int)indexPath.row] wrapper];
    DictionaryWrapper *messageData = [[wrapper getDictionary:@"RelatedDataInfo"] wrapper];
    CGSize size1 = [[messageData getString:@"Question"] sizeWithFont:[UIFont systemFontOfSize:13] constrainedToSize:CGSizeMake(270, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
    CGSize size2 = [[messageData getString:@"Reply"] sizeWithFont:[UIFont systemFontOfSize:13] constrainedToSize:CGSizeMake(270, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
    
    int distinguishHeight = 0;
    
    //来自商家
    if (_messageType == 101) {
        
        distinguishHeight = 0;
    }else {
        
        distinguishHeight = -19;
    }
    
    if ([messageData getString:@"EarlyReply"]&&![[messageData getString:@"EarlyReply"] isEqualToString:@""]) {
        
        CGSize size3 = [[NSString stringWithFormat:@"               %@",[messageData getString:@"EarlyReply"]] sizeWithFont:[UIFont systemFontOfSize:13] constrainedToSize:CGSizeMake(270, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
        return 183+size1.height+size2.height+size3.height-39 + distinguishHeight;
    }else {
        
        return 140+size1.height+size2.height-26 + distinguishHeight;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {

    UIView *temp = WEAK_OBJECT(UIView, init);
    return temp;
}
- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}
- (void)dealloc {
    
    [_dataSource release];
    [_mjCon release];
    [_tableHead release];
    [_mainTable release];
    [_fromMerchantLabel release];
    [_fromUserLabel release];
    [_littleRedLine release];
    [_noDataView release];
    [_UILineView release];
    [super dealloc];
}
@end
