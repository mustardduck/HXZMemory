//
//  ShippingAddressMangerViewController.m
//  miaozhuan
//
//  Created by apple on 14/12/20.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "ShippingAddressMangerViewController.h"
#import "ShippingAddressMangerTableViewCell.h"
#import "MJRefreshController.h"
#import "YFJLeftSwipeDeleteTableView.h"
#import "AddShippingAddressViewController.h"
#import "DetailShippingViewController.h"
#import "RRLineView.h"

@interface ShippingAddressMangerViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    MJRefreshController *_MJRefreshCon;
    
    NSMutableArray * arrResult;
}
@property (retain, nonatomic) IBOutlet YFJLeftSwipeDeleteTableView *mainTableView;

@property (retain, nonatomic) IBOutlet UIView *topView;

- (IBAction)mainTopBtn:(id)sender;
@end

@implementation ShippingAddressMangerViewController

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    InitNav(@"收货地址管理");
    
    _mainTableView.tableHeaderView = _topView;
    
//    _mainTableView.delegate = self;
//    
//    _mainTableView.dataSource = self;
    
    _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [_mainTableView reloadData];
}

-(void)viewWillAppear:(BOOL)animated
{
    ADAPI_adv3_ShippingAddress_ShippingAddressList([self genDelegatorID:@selector(HandleNotification:)]);
}

- (void)HandleNotification:(DelegatorArguments *)arguments
{
    if ([arguments isEqualToOperation:ADOP_adv3_ShippingAddress_ShippingAddressList])
    {
        [arguments logError];
        
        DictionaryWrapper *wrapper = arguments.ret;
        
        if (wrapper.operationSucceed)
        {
            if ([wrapper.data isKindOfClass:[NSNull class]]) {
                arrResult = [NSMutableArray arrayWithCapacity:0];
            } else {
                arrResult = wrapper.data;
            }
            
            [arrResult retain];
            
            if (arrResult == nil || [arrResult isEqual:[NSNull null]])
            {
                return;
            }
            else
            {
                _mainTableView.delegate = self;
                
                _mainTableView.dataSource = self;
                
                [_mainTableView reloadData];
            }
        }
        else if (wrapper.operationPromptCode || wrapper.operationErrorCode)
        {
            [AlertUtil showAlert:@"" message:wrapper.operationMessage buttons:@[@"好的"]];
            return;
        }
    }
}

- (IBAction)mainTopBtn:(id)sender
{
    PUSH_VIEWCONTROLLER(AddShippingAddressViewController);
    model.type = @"1";
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
    static NSString *CellIdentifier = @"ShippingAddressMangerTableViewCell";
    ShippingAddressMangerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[NSBundle mainBundle] loadNibNamed:@"ShippingAddressMangerTableViewCell" owner:nil options:nil].lastObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.layer.masksToBounds = YES;
    }
    
    cell.cellline.top = 129.5;
    
    if (arrResult.count == 0)
    {
        
    }
    else
    {
        cell.cellShowVIew.hidden = YES;
        
        if ([[[arrResult objectAtIndex:indexPath.section]wrapper]getBool:@"IsPrimary"])
        {
            cell.cellImages.image = [UIImage imageNamed:@"shippingAddressManger.png"];
        }
        
        cell.cellShippingName.text = [NSString stringWithFormat:@"收货人：%@",[[[arrResult objectAtIndex:indexPath.section]wrapper]getString:@"Name"]];
        
        cell.cellShippingPhone.text = [NSString stringWithFormat:@"%@",[[[arrResult objectAtIndex:indexPath.section]wrapper]getString:@"Phone"]];

#define CTJ_ISNIL_DIC(_key) [[[arrResult objectAtIndex:indexPath.section]wrapper]getString:_key]? [[[arrResult objectAtIndex:indexPath.section]wrapper]getString:_key]:@""
        
        NSString * Province = CTJ_ISNIL_DIC(@"ProvinceName");
        NSString * City = CTJ_ISNIL_DIC(@"CityName");
        NSString * District = CTJ_ISNIL_DIC(@"DistrictName");
        NSString * address = CTJ_ISNIL_DIC(@"Address");
        
        cell.cellShippingAddress.text = [NSString stringWithFormat:@"收货地址：%@%@%@%@",Province,City,District,address];

        if (cell.cellShippingAddress.text.length <= 18)
        {
            cell.cellShippingName.frame = CGRectMake(15, 64, 163, 16);
            cell.cellShippingPhone.frame = CGRectMake(190, 64, 90, 16);
            cell.cellShippingAddress.frame = CGRectMake(15, 92, 265, 16);
        }
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (arrResult.count == 0)
    {
        
    }
    else
    {
        PUSH_VIEWCONTROLLER(DetailShippingViewController);
        model.shippingId = [NSString stringWithFormat:@"%d",[[[arrResult objectAtIndex:indexPath.section]wrapper]getInt:@"Id"]];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == _mainTableView)
    {
        CGFloat sectionHeaderHeight = 23;
        
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


- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShippingAddressMangerTableViewCell *cell = (ShippingAddressMangerTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.contentView.backgroundColor = AppColor(220);
    return YES;
}

- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShippingAddressMangerTableViewCell *cell = (ShippingAddressMangerTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    [_mainTableView release];
    [_topView release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setMainTableView:nil];
    [self setTopView:nil];
    [super viewDidUnload];
}

@end
