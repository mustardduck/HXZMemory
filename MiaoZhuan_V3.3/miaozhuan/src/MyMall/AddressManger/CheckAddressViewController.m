//
//  CheckAddressViewController.m
//  miaozhuan
//
//  Created by apple on 14/12/31.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "CheckAddressViewController.h"
#import "CheckAddressTableViewCell.h"
#import "MJRefreshController.h"
#import "YFJLeftSwipeDeleteTableView.h"
#import "RRLineView.h"
#import "ShippingAddressMangerViewController.h"

@interface CheckAddressViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    MJRefreshController *_MJRefreshCon;
    
    NSMutableArray * arrResult;
}

@property (retain, nonatomic) IBOutlet YFJLeftSwipeDeleteTableView *mainTableView;

@property (nonatomic, retain) DictionaryWrapper *selectAddress;

@end

@implementation CheckAddressViewController

-(void)viewWillAppear:(BOOL)animated
{
    ADAPI_adv3_ShippingAddress_ShippingAddressList([self genDelegatorID:@selector(HandleNotification:)]);
}

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    InitNav(@"选择地址管理");
    
    [self setupMoveFowardButtonWithTitle:@"管理"];
    
    _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (IBAction) onMoveFoward:(UIButton*) sender
{
    PUSH_VIEWCONTROLLER(ShippingAddressMangerViewController);
}


- (void)HandleNotification:(DelegatorArguments *)arguments
{
    if ([arguments isEqualToOperation:ADOP_adv3_ShippingAddress_ShippingAddressList])
    {
        [arguments logError];
        
        DictionaryWrapper *wrapper = arguments.ret;
        
        if (wrapper.operationSucceed)
        {
            arrResult = wrapper.data;
            
            [arrResult retain];
            
            if (arrResult.count == 0) {
                return;
            }
            
            for (NSDictionary *dic in arrResult) {
                if ([[dic wrapper] getBool:@"IsPrimary"])
                {
                    self.selectAddress = dic.wrapper;
                    break;
                }
            }
            
            [_mainTableView reloadData];
        }
        else if (wrapper.operationPromptCode || wrapper.operationErrorCode)
        {
            [AlertUtil showAlert:@"" message:wrapper.operationMessage buttons:@[@"好的"]];
            return;
        }
    }
}

#pragma mark - tableView delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (arrResult.count == 0)
    {
        return 1;
    }
    else
    {
        return [arrResult count];
    }
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
    return 130;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CheckAddressTableViewCell";
    CheckAddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[NSBundle mainBundle] loadNibNamed:@"CheckAddressTableViewCell" owner:nil options:nil].lastObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.layer.masksToBounds = YES;
    }
    
        
    if ([[[arrResult objectAtIndex:indexPath.section]wrapper]getBool:@"IsPrimary"])
    {
        cell.cellImage.image = [UIImage imageNamed:@"shippingAddressManger.png"];
    }
    
    cell.cellTitle.text = [NSString stringWithFormat:@"收货人：%@",[[[arrResult objectAtIndex:indexPath.section]wrapper]getString:@"Name"]];
    
    cell.cellPhone.text = [NSString stringWithFormat:@"%@",[[[arrResult objectAtIndex:indexPath.section]wrapper]getString:@"Phone"]];
    
#define CTJ_ISNIL_DIC(_key) [[[arrResult objectAtIndex:indexPath.section]wrapper]getString:_key]? [[[arrResult objectAtIndex:indexPath.section]wrapper]getString:_key]:@""
    
    NSString * Province = CTJ_ISNIL_DIC(@"ProvinceName");
    NSString * City = CTJ_ISNIL_DIC(@"CityName");
    NSString * District = CTJ_ISNIL_DIC(@"DistrictName");
    NSString * address = CTJ_ISNIL_DIC(@"Address");
    
    cell.cellAddress.text = [NSString stringWithFormat:@"收货地址：%@%@%@%@",Province,City,District,address];

    RRLineView * line = [[[RRLineView alloc] initWithFrame:CGRectMake(0, 129, 320, 1)]autorelease];
    [cell.contentView addSubview: line];
    
    NSString *adsId = [[[arrResult objectAtIndex:indexPath.section]wrapper] getString:@"Id"];
    if ([adsId isEqualToString:_addressId]) {
        cell.checkFlag = YES;
    } else {
        cell.checkFlag = NO;
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CheckAddressTableViewCell *cell = nil;
    for (int i = 0; i < arrResult.count; i++)
    {
        NSIndexPath *a1 = [NSIndexPath indexPathWithIndex:i];
        a1 = [a1 indexPathByAddingIndex:0];
        NSLog(@"%@",a1);
        cell = (CheckAddressTableViewCell*)[tableView cellForRowAtIndexPath:a1];
        cell.checkFlag = NO;
    }
    
    cell = (CheckAddressTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
    NSLog(@"indexPath : %@",indexPath);
    if (cell.checkFlag)
    {
        cell.checkFlag = NO;
    }
    else
    {
        cell.checkFlag = YES;
    }
    
    self.selectAddress = [arrResult[indexPath.section] wrapper];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == _mainTableView)
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


- (void)onMoveBack:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
    
    if (self.block && _selectAddress) {
        self.block(_selectAddress);
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}


- (void)dealloc
{
    _block = nil;
    [_addressId release];
    [_selectAddress release];
    [arrResult release];
    [_mainTableView release];
    [super dealloc];
}

- (void)viewDidUnload
{
    [self setMainTableView:nil];
    [super viewDidUnload];
}
@end
