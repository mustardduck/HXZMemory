//
//  GetRedPacketsViewController.m
//  miaozhuan
//
//  Created by Santiago on 14-10-23.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "GetRedPacketsViewController.h"
#import "GetRedPacketsCell.h"
#import "PersonalPreferenceSet.h"
#import "OpenRedPacketViewController.h"
#import "CashFromRedPacketViewController.h"
#import "WebhtmlViewController.h"
#import "LineView.h"
@interface GetRedPacketsViewController ()<UITableViewDataSource,UITableViewDelegate, RefreshProtocol ,RefreshDelegate> {

    int _countOfPacketNotOpened;
    int _countOfPacketOpened;
    float _restMoney;
    int _preferenceSet;//0未设置 1未完成 2已设置
}

@property (retain, nonatomic) IBOutlet UILabel *notOpenedPacketLabel;
@property (retain, nonatomic) IBOutlet UILabel *openedPacketLabel;
@property (retain, nonatomic) IBOutlet UIView *openedRedPacketView;

@property (retain, nonatomic) IBOutlet UITableView *myTable;
@property (retain, nonatomic) IBOutlet UIView *myTableHead;
@property (retain, nonatomic) IBOutlet UIView *myFirstSectionFooter;
@property (retain, nonatomic) IBOutlet UIView *myTableHead2;
@property (retain, nonatomic) IBOutlet UILabel *moneyFromRedPacket1;//有未拆广告时
@property (retain, nonatomic) IBOutlet UILabel *moneyFromRedPacket2;//没有未拆广告
@property (retain, nonatomic) IBOutlet UILabel *settingLabel1;
@property (retain, nonatomic) IBOutlet UILabel *settingLabel;
@property (strong, nonatomic) NSArray *notOpenedListDatasource;
@property (strong, nonatomic) NSArray *openedListDatasource;
@property (retain, nonatomic) IBOutlet LineView *UILineView1;
@property (retain, nonatomic) IBOutlet LineView *UILineView2;

@property (retain, nonatomic) IBOutlet LineView *uiLineView3;
@property (retain, nonatomic) IBOutlet LineView *uiLineView4;
@property (retain, nonatomic) IBOutlet LineView *uiLineView5;
@property (retain, nonatomic) IBOutlet LineView *uiLineView6;
@end

@implementation GetRedPacketsViewController
@synthesize myTable = _myTable;
@synthesize myTableHead = _myTableHead;
@synthesize myTableHead2 = _myTableHead2;
@synthesize myFirstSectionFooter = _myFirstSectionFooter;
@synthesize notOpenedPacketLabel = _notOpenedPacketLabel;
@synthesize moneyFromRedPacket1 = _moneyFromRedPacket1;
@synthesize moneyFromRedPacket2 = _moneyFromRedPacket2;
@synthesize openedRedPacketView = _openedRedPacketView;
@synthesize settingLabel = _settingLabel;
@synthesize settingLabel1 = _settingLabel1;
@synthesize notOpenedListDatasource = _notOpenedListDatasource;
@synthesize openedListDatasource = _openedListDatasource;
MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [_myTable registerNib:[UINib nibWithNibName:@"GetRedPacketsCell" bundle:nil] forCellReuseIdentifier:@"GetRedPacketsCell"];
    
    [self setNavigateTitle:@"收红包"];

    [self setupMoveBackButton];
    
    [self setupMoveFowardButtonWithTitle:@"说明"];
    
    self.myFirstSectionFooter.hidden = YES;
    self.openedRedPacketView.hidden = YES;
    
    [self.UILineView1 setFrame:CGRectMake(0, 60, 320, 0.5)];
    [self.UILineView2 setFrame:CGRectMake(0, 51, 320, 0.5)];
    [self.uiLineView3 setFrame:CGRectMake(0, 0, 320, 0.5)];
    [self.uiLineView4 setFrame:CGRectMake(0, 279.5, 320, 0.5)];
    [self.uiLineView5 setSize:CGSizeMake(320, 0.5)];
    [self.uiLineView6 setSize:CGSizeMake(320, 0.5)];
    //收红包首页信息
    ADAPI_GetRedPacketHome([self genDelegatorID:@selector(getHomePageData:)]);
}

- (void) getHomePageData:(DelegatorArguments*)arguments {

    DictionaryWrapper *wrapper = arguments.ret;
    
    if (wrapper.operationSucceed) {
        
        self.myFirstSectionFooter.hidden = NO;
        self.openedRedPacketView.hidden = NO;
        
        DictionaryWrapper *dataSource = wrapper.data;
        
        _preferenceSet = [dataSource getInt:@"SurveyCompleteType"];
        
        _restMoney = [dataSource getFloat:@"Balance"];
        
        float theMoneyRest = _restMoney*100.00;
        theMoneyRest = floor(theMoneyRest)/100.00;
        
        self.moneyFromRedPacket1.text = [NSString stringWithFormat:@"¥%.2f",theMoneyRest];
        self.moneyFromRedPacket2.text = [NSString stringWithFormat:@"¥%.2f",theMoneyRest];
        
        _countOfPacketNotOpened = [dataSource getInt:@"TotalUnreadAds"];
        _countOfPacketOpened = [dataSource getInt:@"TotalReadAds"];
        
        [self.notOpenedPacketLabel setText:[NSString stringWithFormat:@"未拆的红包广告(%d)",_countOfPacketNotOpened]];
        [self.openedPacketLabel setText:[NSString stringWithFormat:@"已拆的红包广告(%d)",_countOfPacketOpened]];
        
        self.notOpenedListDatasource = [dataSource getArray:@"UnreadedList"];
        self.openedListDatasource = [dataSource getArray:@"ReadedList"];

        if (![[APP_DELEGATE.persistConfig get:@".PREFERENCESET" ]isEqualToString:@"1"]&&_preferenceSet == 0) {
            
            [APP_DELEGATE.persistConfig set:@".PREFERENCESET" value: @"1"];
            
            [AlertUtil showAlert:@"请先完成“偏好设置”"
                            message:@"只需完成设置，就可以开始收现金红包啦"
                            buttons:@[@"知道了"]
                ];
        }
        switch (_preferenceSet) {
                    
                //未设置
            case 0:
                [self.settingLabel setText:@"未设置"];
                [self.settingLabel1 setText:@"未设置"];
                break;
                //未完成
            case 1:
                [self.settingLabel setText:@"未完成"];
                [self.settingLabel1 setText:@"未完成"];
                break;
                //已设置
            case 2:
                [self.settingLabel setText:@"已设置"];
                [self.settingLabel1 setText:@"已设置"];
                break;
            default:
                break;
            }
        [self setTableHeadView];
        [self.myTable reloadData];
    }
}

- (void)onMoveFoward:(UIButton *)sender {
    
    PUSH_VIEWCONTROLLER(WebhtmlViewController)
    model.navTitle = @"红包说明";
    model.ContentCode = @"ca3dca791c18983a470f49b6f2da488d";
}

- (void)onMoveBack:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"BackHome" object:nil];
    if(_delegate != nil && [_delegate respondsToSelector:@selector(calculateRedCount)])
    [_delegate calculateRedCount];
}

- (IBAction)personalPreference:(id)sender {
    
    PersonalPreferenceSet *temp = WEAK_OBJECT(PersonalPreferenceSet, init);
    temp.delegate = self;
    [self.navigationController pushViewController:temp animated:YES];
}

- (IBAction)turnToMoneyFromPacket:(id)sender {
    
    PUSH_VIEWCONTROLLER(CashFromRedPacketViewController);
}

- (void)setTableHeadView {
    
    if (_countOfPacketOpened == 0) {
        
        self.openedRedPacketView.hidden = YES;
    }
    if (_countOfPacketNotOpened == 0) {
        
        [_myTable setTableHeaderView:_myTableHead2];
    }else{
    
        [_myTable setTableHeaderView:_myTableHead];}
}

#pragma mark - RefreshProtocol
- (void)refresh {
    
    ADAPI_GetRedPacketHome([self genDelegatorID:@selector(getHomePageData:)]);
}

- (void)refresh2 {

    ADAPI_GetRedPacketHome([self genDelegatorID:@selector(getHomePageData:)]);
}
#pragma - TableViewDelegates
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    UIView *temp = WEAK_OBJECT(UIView, init);
    return temp;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    if (section == 1) {
       return _myFirstSectionFooter;
    }else{
        return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    if (section == 1) {
        
        return 30;
    }else{
        
        return 0;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        
        return _countOfPacketNotOpened;
    }else{
    
        return _countOfPacketOpened;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 145;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    GetRedPacketsCell *cell = [_myTable dequeueReusableCellWithIdentifier:@"GetRedPacketsCell" forIndexPath:indexPath];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];

    if (indexPath.section == 0) {
        
        cell.adName.text = [[_notOpenedListDatasource[indexPath.row] wrapper] getString:@"Name"];
        NSString *str = [[_notOpenedListDatasource[indexPath.row] wrapper] getString:@"Name"];
        CGSize size = [str sizeWithFont:cell.adName.font constrainedToSize:CGSizeMake(200, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
        [cell.adName setFrame:CGRectMake(105, cell.companyName.frame.origin.y - 10 - size.height, 200, size.height+1)];

        
        if (size.height < 30) {
            
            [cell.adName setFrame:CGRectMake(105, 37, 200, 17)];
            [cell.companyName setFrame:CGRectMake(105, 62, 207, 12)];
            [cell.amountOfReward setFrame:CGRectMake(105, 83, 65, 15)];
            [cell.expireDays setFrame:CGRectMake(105, 107, 164, 11)];
        }else {
        
            [cell.adName setFrame:CGRectMake(105, 22, 200, 37)];
            [cell.companyName setFrame:CGRectMake(105, 67, 207, 12)];
            [cell.amountOfReward setFrame:CGRectMake(105, 88, 65, 15)];
            [cell.expireDays setFrame:CGRectMake(105, 112, 164, 11)];
        }
        
        cell.companyName.text = [[_notOpenedListDatasource[indexPath.row] wrapper]getString:@"EnterpriseName"];
        cell.expireDays.text = [NSString stringWithFormat:@"还有%d天失效",[[_notOpenedListDatasource[indexPath.row]wrapper]getInt:@"ExpireDays"]];
        [cell.redPacketPic requestPicture:[[_notOpenedListDatasource[indexPath.row]wrapper] getString:@"PictureUrl"]];
        cell.amountOfReward.text = [NSString stringWithFormat:@"￥%.2f",[[_notOpenedListDatasource[indexPath.row]wrapper] getFloat:@"MoneyToEarn"]];
        cell.redPacketMarkImage.image = [UIImage imageNamed:@"close_red.png"];
        
        if (indexPath.row == _countOfPacketNotOpened - 1) {
            
            [cell.UILineView setFrame:CGRectMake(0, 144.5, 320, 0.5)];
        }else {
        
            [cell.UILineView setFrame:CGRectMake(16, 144, 304, 0.5)];
        }
    }else {
        
        cell.adName.text = [[_openedListDatasource[indexPath.row] wrapper] getString:@"Name"];
        
        NSString *str = [[_openedListDatasource[indexPath.row] wrapper] getString:@"Name"];
        CGSize size = [str sizeWithFont:cell.adName.font constrainedToSize:CGSizeMake(200, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
        [cell.adName setFrame:CGRectMake(105, cell.companyName.frame.origin.y - 10 - size.height, 200, size.height+1)];
        
        if (size.height < 30) {
            
            [cell.adName setFrame:CGRectMake(105, 37, 200, 15)];
            [cell.companyName setFrame:CGRectMake(105, 62, 207, 12)];
            [cell.amountOfReward setFrame:CGRectMake(105, 83, 65, 15)];
            [cell.expireDays setFrame:CGRectMake(105, 107, 164, 11)];
        }else {
            
            [cell.adName setFrame:CGRectMake(105, 22, 200, 37)];
            [cell.companyName setFrame:CGRectMake(105, 67, 207, 12)];
            [cell.amountOfReward setFrame:CGRectMake(105, 88, 65, 15)];
            [cell.expireDays setFrame:CGRectMake(105, 112, 164, 11)];
        }
        
        cell.companyName.text = [[_openedListDatasource[indexPath.row] wrapper]getString:@"EnterpriseName"];
        cell.expireDays.text = [NSString stringWithFormat:@"还有%d天失效",[[_openedListDatasource[indexPath.row]wrapper]getInt:@"ExpireDays"]];
        [cell.redPacketPic requestPicture:[[_openedListDatasource[indexPath.row]wrapper] getString:@"PictureUrl"]];
        cell.amountOfReward.text = [NSString stringWithFormat:@"￥%.2f",[[_openedListDatasource[indexPath.row]wrapper] getFloat:@"MoneyToEarn"]];
        cell.redPacketMarkImage.image = [UIImage imageNamed:@"open_red.png"];
        
        if (indexPath.row == _countOfPacketOpened - 1) {
            
            [cell.UILineView setFrame:CGRectMake(0, 145, 320, 0.5)];
        }else {
            
            [cell.UILineView setFrame:CGRectMake(16, 144.5, 304, 0.5)];
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    OpenRedPacketViewController *temp = WEAK_OBJECT(OpenRedPacketViewController, init);
    
    if (indexPath.section == 0) {
        
        temp.adsId = [[_notOpenedListDatasource[indexPath.row] wrapper] getInt:@"Id"];
        temp.delegate = self;
        [self.navigationController pushViewController:temp animated:YES];
    }else{
        temp.adsId = [[_openedListDatasource[indexPath.row] wrapper] getInt:@"Id"];
        [self.navigationController pushViewController:temp animated:YES];
        temp.delegate = self;
        return;
    }
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    GetRedPacketsCell *cell = (GetRedPacketsCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.contentView.backgroundColor = AppColor(220);
    return YES;
}
- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    GetRedPacketsCell *cell = (GetRedPacketsCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    [_notOpenedListDatasource release];
    [_openedListDatasource release];
    [_myTable release];
    [_myTableHead release];
    [_myFirstSectionFooter release];
    [_notOpenedPacketLabel release];
    [_openedPacketLabel release];
    [_myTableHead2 release];
    [_moneyFromRedPacket1 release];
    [_moneyFromRedPacket2 release];
    [_openedRedPacketView release];
    [_settingLabel1 release];
    [_settingLabel release];
    [_UILineView1 release];
    [_UILineView2 release];
    [_uiLineView3 release];
    [_uiLineView4 release];
    [_uiLineView5 release];
    [_uiLineView6 release];
//    [_delegate release];
    [super dealloc];
}

- (void)viewDidUnload {
    [self setOpenedListDatasource:nil];
    [self setNotOpenedListDatasource:nil];
    [self setMyTable:nil];
    [self setMyTableHead:nil];
    [self setMyFirstSectionFooter:nil];
    [self setNotOpenedPacketLabel:nil];
    [self setOpenedPacketLabel:nil];
    [self setMyTableHead2:nil];
//    [self setDelegate:nil];
    [super viewDidUnload];
}
@end
