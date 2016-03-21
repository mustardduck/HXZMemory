//
//  NotiftCenterViewController.m
//  miaozhuan
//
//  Created by abyss on 14/11/13.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "NotiftCenterViewController.h"
#import "NotifyClassTableViewCell.h"
#import "CRSegHeader.h"
#import "UserInfo.h"
#import "CRDateCounter.h"
#import "NCSupporter.h"

#import "CRHolderView.h"

@interface NotiftCenterViewController () <UITableViewDataSource,UITableViewDelegate,cr_SegHeaderDelegate>
{
    NSMutableArray *_timeOfHeader;
    NSMutableArray *_netData;
    NSMutableArray *_localTimeOfHeader;
    
    BOOL _IsEnterprise;
    int _pageIndex;
    
    NSIndexPath *_deletePath;
    NSInteger _deletePageIndex;
}
@property (retain, nonatomic) IBOutlet CRSegHeader *header;
@end
#define CRNC_TIME_EXSIT(_index) (((NSString *)_timeOfHeader[_index]).length > 3)
@implementation NotiftCenterViewController

- (void)viewWillAppear:(BOOL)animated
{
//    _pageIndex = 0;
    ADAPI_adv3_Message_Index([self genDelegatorID:@selector(NCNotify:)]);
}

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad
{
    [super viewDidLoad];

    _IsEnterprise = USER_MANAGER.IsEnterpriseId;
    InitNav(@"消息中心");
    
    [self configureTableView];
    [self configureHeader];
}

- (void)NCNotify:(DelegatorArguments *)arg
{
    [arg logError];
    if (arg.ret.operationSucceed)
    {
        NSLog(@"%@",arg.ret.dictionary);
        DictionaryWrapper *dic = arg.ret.data;
        [dic retain];
        
        //Header================================================================================================
        _timeOfHeader = [NSMutableArray new];
        [_timeOfHeader addObject:[dic getString:@"UserMsgLastTime"]==nil?@"":[dic getString:@"UserMsgLastTime"]];
        [_timeOfHeader addObject:[dic getString:@"EnterpriseMsgLastTime"]==nil?@"":[dic getString:@"EnterpriseMsgLastTime"]];
        [_timeOfHeader addObject:[dic getString:@"AccountMsgLastTime"]==nil?@"":[dic getString:@"AccountMsgLastTime"]];
        
        //loading
        _localTimeOfHeader = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:CRNC_TIMEOFHEADER_KEY]];
        [_localTimeOfHeader retain];
        if (_localTimeOfHeader.count < 1 || _localTimeOfHeader == nil)
            _localTimeOfHeader = [[NSMutableArray alloc] initWithObjects:@"2012-11-27T18:16:17.53",@"2012-11-27T18:16:17.53",@"2012-11-27T18:16:17.53", nil];
        
        //第一次
        if (CRNC_TIME_EXSIT(0))
        {
            _localTimeOfHeader[0] = _timeOfHeader[0];
            [[NSUserDefaults standardUserDefaults] setObject:_localTimeOfHeader forKey:CRNC_TIMEOFHEADER_KEY];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        
        //_header point
        for (int i = 0; i < 3; i ++)
        {
            int holder = i;
            int buttonIndex = i;
            if (!_IsEnterprise&&i == 1) {holder = 2;i = 3;}
            if ([[NSDate dateFromString:[UICommon format19Time:_localTimeOfHeader[holder]]] timeIntervalSinceDate:[NSDate dateFromString:[UICommon format19Time:_timeOfHeader[holder]]]] < 0)
            {
                if (i == 3) i = 2;
                 _localTimeOfHeader[i] = _timeOfHeader[i];
                [[NSUserDefaults standardUserDefaults] setObject:_localTimeOfHeader forKey:CRNC_TIMEOFHEADER_KEY];
                [[NSUserDefaults standardUserDefaults] synchronize];
                [_header bringPointForIndex:buttonIndex show:YES];
            }
            else
            {
                [_header bringPointForIndex:buttonIndex show:NO];
            }
        }
        //Header================================================================================================
        
        _netData = [[NSMutableArray alloc] initWithObjects:[NSMutableArray new],[NSMutableArray new],[NSMutableArray new], nil];
        [NCSupporter fitData:dic at:_netData];
        [_tableView reloadData];
        [self button:nil didBetouch:_pageIndex];
    }
}

- (void)configureTableView
{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

- (void)configureHeader
{
    _tableView.backgroundColor = AppColorBackground;
    self.view.backgroundColor = AppColorBackground;
    _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    _header.hasPoint = YES;
    _header.buttonArray = _IsEnterprise?@[@"用户消息",@"商家消息",@"账户消息"]:@[@"用户消息",@"账户消息"];
    _header.delegate = self;
    _header.autoawakIndex = 1;
}

- (void)button:(UIButton *)button didBetouch:(NSInteger)buttonIndex
{
    [self displayHoder:NO];
    
    _pageIndex = (int)buttonIndex;
    int holder = _pageIndex;
    if (!_IsEnterprise && buttonIndex == 1)
    {
        holder = 2;
    }
    if (CRNC_TIME_EXSIT(buttonIndex))
    {
        _localTimeOfHeader[holder] = _timeOfHeader[buttonIndex];
        [[NSUserDefaults standardUserDefaults] setObject:_localTimeOfHeader forKey:CRNC_TIMEOFHEADER_KEY];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    if (_netData && [(NSArray *)_netData[holder] count] == 0)
    {
        [self showHolderWithImg:@"028_a" text2:@"您暂时没有消息哦"];
        [self setHolderDefaultHight:40];
        [_tableView reloadData];
    }
    [_tableView reloadData];
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
    [_timeOfHeader release];
    [_netData release];
    [_localTimeOfHeader release];
    [_header release];
    [_tableView release];
    [super dealloc];
}
- (void)viewDidUnload
{
    [self setTableView:nil];
    [self setHeader:nil];
    [super viewDidUnload];
}

#pragma mark - TableView Delegate

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        // Delete the row from the data source
        int holder = _pageIndex;
        if (!_IsEnterprise && _pageIndex == 1)
        {
            holder = 2;
        }
        _deletePath = indexPath;
        [_deletePath retain];
        _deletePageIndex = holder;
        NSArray *deleteList = [NCSupporter getDeleteArrayBy:[_netData[holder][indexPath.row] wrapper]];
        ADAPI_adv3_MessageDeleteType([self genDelegatorID:@selector(typeDelete:)], deleteList);
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert)
    {
    }
}

- (void)typeDelete:(DelegatorArguments *)arg
{
    [arg logError];
    if (arg.ret.operationSucceed)
    {
        if (!_deletePath) return;
        [_netData[_deletePageIndex] removeObjectAtIndex:_deletePath.row];
        [_tableView deleteRowsAtIndexPaths:@[_deletePath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    NotifyClassTableViewCell *cell = (NotifyClassTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.contentView.backgroundColor = AppColor(220);
    return YES;
}
- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    NotifyClassTableViewCell *cell = (NotifyClassTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor whiteColor];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NotifyClassTableViewCell *cell = (NotifyClassTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];

    int holder = _pageIndex;
    if (!_IsEnterprise && _pageIndex == 1) holder = 2;
    NSMutableDictionary *tempDic = [NSMutableDictionary dictionaryWithDictionary:_netData[holder][indexPath.row]];
    [tempDic setObject:@0 forKey:@"count"];
    _netData[holder][indexPath.row] = (NSDictionary *)tempDic;
    [_tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    [cell jump];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int holder = _pageIndex;
    if (!_IsEnterprise && _pageIndex == 1) holder = 2;
    
    if (!_netData || ((NSArray *)_netData[holder]).count == 0) return 0;
    
    return [(NSArray *)_netData[holder] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int holder = _pageIndex;
    if (!_IsEnterprise && _pageIndex == 1) holder = 2;
    
    static NSString *CellIdentifier = @"NotifyClassTableViewCell";
    NotifyClassTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[NSBundle mainBundle] loadNibNamed:@"NotifyClassTableViewCell" owner:nil options:nil].lastObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.highlighted = YES;
    }
    
    cell.data = [_netData[holder][indexPath.row] wrapper];
    if (indexPath.row == ((NSArray *)_netData[holder]).count - 1)
    {
        cell.line.left = 0;
        [cell.layer needsDisplay];
    }
    
    if (indexPath.row == 0)
    {
        UIView *view = WEAK_OBJECT(UIView, initWithFrame:CGRectMake(0, 0, 320, 0.5));
        view.backgroundColor = AppColor(204);
        [cell.contentView addSubview:view];
    }
    
    return cell;
}
@end
