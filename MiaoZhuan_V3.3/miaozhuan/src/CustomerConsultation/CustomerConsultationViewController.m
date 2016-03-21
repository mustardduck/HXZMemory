//
//  CustomerConsultationViewController.m
//  miaozhuan
//
//  Created by apple on 14/11/5.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "CustomerConsultationViewController.h"
#import "CustomerTableViewCell.h"
#import "ComeFormAdvertViewController.h"
#import "CollectConsultViewController.h"
#import "RRLineView.h"

@interface CustomerConsultationViewController ()
<UITableViewDataSource,UITableViewDelegate>
{
    NSArray * titlearray;
    NSArray * contentarray;
    
    DictionaryWrapper* dic;
}
@property (retain, nonatomic) IBOutlet  UITableView * customerTableView;

@end

@implementation CustomerConsultationViewController

@synthesize customerTableView = _customerTableView;

-(void)viewWillAppear:(BOOL)animated
{
    ADAPI_adv3_GetSummaryCounsel([self genDelegatorID:@selector(HandleNotification:)]);
}

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    InitNav(@"客户咨询");
    
    _customerTableView.delegate = self;
    
    _customerTableView.dataSource = self;
    
    _customerTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    _customerTableView.scrollEnabled = NO;
    
    titlearray = [@[@[@"来自广告的咨询",@"来自商城的咨询"],@[@"收藏的咨询"]] retain];
    
    contentarray = [@[@[@"包括捡银元、收红包、竞价广告",@"包括兑换、易货商城"],@[@"管理您感兴趣的咨询"]] retain];
}

- (void)HandleNotification:(DelegatorArguments *)arguments
{
    if ([arguments isEqualToOperation:ADOP_adv3_GetSummaryCounsel])
    {
        [arguments logError];
        
        DictionaryWrapper *wrapper = arguments.ret;
        
        if (wrapper.operationSucceed)
        {
            dic = [wrapper.data retain];
            
            [_customerTableView reloadData];
        }
        else if (wrapper.operationPromptCode || wrapper.operationErrorCode)
        {
            [HUDUtil showErrorWithStatus:wrapper.operationMessage];
        }
    }
}

#pragma mark - tableView delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *sectionView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 10)] autorelease];
    RRLineView *linetop = WEAK_OBJECT(RRLineView, initWithFrame:CGRectMake(0, 9.5, 320, 0.5));
    [sectionView addSubview:linetop];
    
    return sectionView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 2;
    }
    else
    {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CustomerTableViewCell";
    CustomerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[NSBundle mainBundle] loadNibNamed:@"CustomerTableViewCell" owner:nil options:nil].lastObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.layer.masksToBounds = YES;
    }
    
    if (indexPath.section == 0)
    {
        if (indexPath.row == 0)
        {
            cell.customerCellLine.left = 15;
            cell.numCellImage.num = [dic getInt:@"AdvertCounselCount"];
        }
        else
        {
            cell.numCellImage.num = [dic getInt:@"ProductCounselCount"];
        }
        cell.numCellImage.hidden = NO;
    }
    else
    {
        cell.numCellImage.hidden = YES;
    }
    
    cell.customerCellLine.top = 59.5;
    cell.customerCellTitle.text = titlearray[indexPath.section][indexPath.row];
    cell.customerCellContents.text = contentarray[indexPath.section][indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        PUSH_VIEWCONTROLLER(ComeFormAdvertViewController);
        
        if (indexPath.row == 0)
        {
            model.type = @"1";
        }
        else
        {
            model.type = @"2";
        }
    }
    else
    {
        PUSH_VIEWCONTROLLER(CollectConsultViewController);
    }
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    CustomerTableViewCell *cell = (CustomerTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.contentView.backgroundColor = AppColor(220);
    return YES;
}

- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    CustomerTableViewCell *cell = (CustomerTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor whiteColor];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
    [_customerTableView release];
    
    [titlearray release];
    
    titlearray = nil;
    
    [contentarray release];
    
    contentarray = nil;
    
    [dic release];
    
    dic = nil;
    
    [super dealloc];
}

- (void)viewDidUnload
{
    [self setCustomerTableView:nil];
    [super viewDidUnload];
}
@end
