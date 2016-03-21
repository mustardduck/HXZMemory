//
//  FansDetailViewController.m
//  miaozhuan
//
//  Created by apple on 14/11/25.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "FansDetailViewController.h"
#import "FansDetailTableViewCell.h"
#import "MJRefreshController.h"
#import "YFJLeftSwipeDeleteTableView.h"
#import "UserInfo.h"
@interface FansDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    MJRefreshController *_MJRefreshCon;
}
@property (retain, nonatomic) IBOutlet UITableView *fansTableView;

@end

@implementation FansDetailViewController

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad
{
    [super viewDidLoad];
    InitNav(@"粉丝明细");
    
    _fansTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    if ([[UIScreen mainScreen] bounds].size.height < 568)
    {
        _fansTableView.frame = CGRectMake(0, 0, 320, [[UIScreen mainScreen] bounds].size.height + 64);
    }
    else
    {
        _fansTableView.frame = CGRectMake(0, 0, 320, [[UIScreen mainScreen] bounds].size.height);
    }
    
    [self setTableviewLoad];
}

#pragma mark - tableView delegate

- (void) setTableviewLoad
{
    [_fansTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    NSString * refreshName = @"MemberCampaign/Level1Report";
    
    _MJRefreshCon = [MJRefreshController controllerFrom:_fansTableView name:refreshName];
    
    [_MJRefreshCon setURLGenerator:MJREFRESH_URL_GENERATOR_BLOCK
     {
         return @{
                  @"service":[NSString stringWithFormat:@"api/%@",refreshName],
                  @"parameters":
                      @{@"PageIndex":@(pageIndex),
                        @"PageSize":@(pageSize)}}.wrapper;
     }];
    
    {
        MJRefreshOnRequestDone block = MJREFRESH_ON_REQUEST_DONE
        {
            if (netData.operationSucceed)
            {

            }
            else
            {
                [HUDUtil showErrorWithStatus:netData.operationMessage];
            }
        };
        
        [_MJRefreshCon setOnRequestDone:block];
        [_MJRefreshCon setPageSize:30];
        [_MJRefreshCon retain];
    }
    
    [self refreshTableView];
}

- (void) refreshTableView
{
    [_MJRefreshCon refreshWithLoading];
}

#pragma mark - tableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _MJRefreshCon.refreshCount;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *sectionView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 10)] autorelease];
    sectionView.backgroundColor = RGBCOLOR(239, 239, 244);
    
    RRLineView *linetop = WEAK_OBJECT(RRLineView, init);
    linetop.frame = CGRectMake(0, 9.5, 320, 0.5);
    [sectionView addSubview:linetop];
    
    return sectionView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 113;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"FansDetailTableViewCell";
    FansDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[NSBundle mainBundle] loadNibNamed:@"FansDetailTableViewCell" owner:nil options:nil].lastObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.layer.masksToBounds = YES;
    }
    
    [[_MJRefreshCon dataAtIndex:(int)indexPath.row]getString:@"Name"];
    
    if ([[_MJRefreshCon dataAtIndex:(int)indexPath.section]getString:@"Name"] == nil || [[[_MJRefreshCon dataAtIndex:(int)indexPath.section]getString:@"Name"] isEqualToString:@""])
    {
        cell.nameLable.text = [NSString stringWithFormat:@"匿名用户(%@)",[[_MJRefreshCon dataAtIndex:(int)indexPath.section]getString:@"Phone"]];
    }
    else
    {
        cell.nameLable.text = [NSString stringWithFormat:@"%@(%@)",[[_MJRefreshCon dataAtIndex:(int)indexPath.section]getString:@"Name"],[[_MJRefreshCon dataAtIndex:(int)indexPath.section]getString:@"Phone"]];
    }
    
    NSString * str = cell.nameLable.text;
    
    int VipLevel = [[_MJRefreshCon dataAtIndex:(int)indexPath.section]getInt:@"VipLevel"];
    
    NSLog(@"%d",VipLevel);
    
    cell.cellVipImage.image = [USER_MANAGER getVipPic:VipLevel];

    CGSize size = [UICommon getSizeFromString:str
                                     withSize:CGSizeMake(MAXFLOAT, 16)
                                     withFont:15];
    
    cell.cellVipImage.frame = CGRectMake(size.width + 87, 42, 30, 15);
    
    if ([[_MJRefreshCon dataAtIndex:(int)indexPath.section]getBool:@"IsVerified"])
    {
        cell.verifyLable.text = @"已验证";
        cell.remindBtn.hidden = YES;
    }
    else
    {
        cell.verifyLable.text = @"未验证";
        cell.verifyLable.textColor = RGBACOLOR(240, 5, 0, 1);
        
        [cell.remindBtn addTarget:self action:@selector(remindBtnTouch:) forControlEvents:UIControlEventTouchUpInside];
        cell.remindBtn.tag = indexPath.section;
    }
    
    [cell.cellImages requestPic:[[_MJRefreshCon dataAtIndex:(int)indexPath.section]getString:@"IconUrl"] placeHolder:NO];
    
    cell.cellHeGeLable.text = [NSString stringWithFormat:@"已发展合格粉丝：%d人",[[_MJRefreshCon dataAtIndex:(int)indexPath.section]getInt:@"VerifyCount"]];
    
    cell.cellNoHeGeLable.text = [NSString stringWithFormat:@"未手机验证粉丝：%d人",[[_MJRefreshCon dataAtIndex:(int)indexPath.section]getInt:@"UnVerifyCount"]];
    
    cell.cellLine.top = 112.5;
    
    return cell;
}

//提醒粉丝验证
- (void)remindBtnTouch:(UIButton *)button
{
    ADAPI_adv3_1_MemberCampaign_RemindFansPhoneVerify([self genDelegatorID:@selector(HandleNotification:)],[NSString stringWithFormat:@"%d",[[_MJRefreshCon dataAtIndex:button.tag]getInt:@"CustomerId"]]);
}

- (void)HandleNotification:(DelegatorArguments *)arguments
{
    if ([arguments isEqualToOperation:ADOP_adv3_1_MemberCampaign_RemindFansPhoneVerify])
    {
        [arguments logError];
        
        DictionaryWrapper *wrapper = arguments.ret;
        
        if (wrapper.operationSucceed)
        {
            [HUDUtil showSuccessWithStatus:wrapper.operationMessage];
        }
        else
        {
            [HUDUtil showErrorWithStatus:wrapper.operationMessage];
        }
    }
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FansDetailTableViewCell *cell = (FansDetailTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
    
    cell.checkView.backgroundColor = [UIColor redColor];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == _fansTableView)
    {
        CGFloat sectionHeaderHeight = 10;
        
        if (scrollView.contentOffset.y <= sectionHeaderHeight&&scrollView.contentOffset.y >= 0)
        {
            scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
        }
        else if (scrollView.contentOffset.y >= sectionHeaderHeight)
        {
            scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
        }
    }
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

- (void)dealloc
{
    [_fansTableView release];
    [super dealloc];
}

- (void)viewDidUnload
{
    [self setFansTableView:nil];
    [super viewDidUnload];
}
@end
