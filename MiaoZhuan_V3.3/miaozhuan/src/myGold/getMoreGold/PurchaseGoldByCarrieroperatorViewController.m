//
//  PurchaseGoldByCarrieroperatorViewController.m
//  miaozhuan
//
//  Created by apple on 14/12/16.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "PurchaseGoldByCarrieroperatorViewController.h"
#import "UIView+expanded.h"
#import "PurchaseGoldByCarrieroperatorTableViewCell.h"
#import "MJRefreshController.h"
#import "YFJLeftSwipeDeleteTableView.h"
#import "GoldChoiceAddressTableViewCell.h"

@interface PurchaseGoldByCarrieroperatorViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray * ProvinceAgentRegionList;
    
    NSArray * carrierList;
    
    NSString * addressName;
 
    int type;
    
    int close;
}

- (IBAction)touchUpinside:(id)sender;
@property (retain, nonatomic) IBOutlet UIView *lineView;

@property (retain, nonatomic) IBOutlet UIView *choiceView;
@property (retain, nonatomic) IBOutlet UITableView *choiceTable;
@property (retain, nonatomic) IBOutlet UIView *blackView;

@property (retain, nonatomic) IBOutlet UIView *showView;
@property (retain, nonatomic) IBOutlet UITableView *mainTableView;
@property (retain, nonatomic) IBOutlet UIImageView *choiceImage;
@property (retain, nonatomic) IBOutlet UIButton *choiceBtn;
@property (retain, nonatomic) IBOutlet UILabel *choiceCarrierLable;
@property (retain, nonatomic) IBOutlet RRLineView *linetop;
- (IBAction)blackTouch:(id)sender;
@end

@implementation PurchaseGoldByCarrieroperatorViewController

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    InitNav(@"向当地运营商购买");
    
    _linetop.top = 82.5;
    
    [_choiceBtn roundCornerBorder];
    
    _choiceTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (IBAction)blackTouch:(id)sender
{
    _choiceCarrierLable.textColor = RGBCOLOR(34, 34, 34);
    
    _choiceImage.image = [UIImage imageNamed:@"ads_list_down.png"];
    
    _choiceView.hidden = YES;
    
    _blackView.hidden = YES;
    
    _showView.hidden = YES;
    
}

- (IBAction)touchUpinside:(id)sender
{

    type = 1;
    //获取已有运营商区域
    ADAPI_adv3_CustomerGold_GetProvinceAgentRegionList([self genDelegatorID:@selector(HandleNotification:)]);
}


- (void)HandleNotification:(DelegatorArguments *)arguments
{
    [arguments logError];
    
    DictionaryWrapper *wrapper = arguments.ret;
    
    if ([arguments isEqualToOperation:ADOP_adv3_CustomerGold_GetProvinceAgentRegionList])
    {
        if (wrapper.operationSucceed)
        {
            _choiceTable.delegate= self;
            
            _choiceTable.dataSource = self;
            
            _blackView.hidden = NO;
            
            _showView.hidden = NO;
            
            _choiceCarrierLable.textColor = RGBCOLOR(240, 5, 0);
            
            _choiceImage.image = [UIImage imageNamed:@"ads_list_up"];
            
            NSLog(@"---%@",wrapper.data);
            
            ProvinceAgentRegionList = wrapper.data;
            
            [ProvinceAgentRegionList retain];
            
            _choiceView.hidden = NO;
            
            _choiceView.frame =CGRectMake(0, 83, 320, 202);
            
            [_choiceTable reloadData];
            
        }
        else if (wrapper.operationPromptCode || wrapper.operationErrorCode)
        {
            [AlertUtil showAlert:@"" message:wrapper.operationMessage buttons:@[@"好的"]];
            return;
        }
    }
    else if([arguments isEqualToOperation:ADOP_adv3_CustomerGold_GetProvinceAgentByCode])
    {
        if (wrapper.operationSucceed)
        {
            _mainTableView.delegate = self;
            
            _mainTableView.dataSource = self;
            
            _blackView.hidden = YES;

            _showView.hidden = YES;
            
            _mainTableView.frame = CGRectMake(0, 83, 320, 482);
            
            _choiceCarrierLable.textColor = RGBCOLOR(34, 34, 34);
            
            _choiceImage.image = [UIImage imageNamed:@"ads_down.png"];
            
            NSLog(@"---%@",wrapper.data);
            
            carrierList = wrapper.data;
            
            [carrierList retain];
            
            _choiceView.hidden = YES;
            
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
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int hight;
    
    if (type == 1)
    {
        hight = 45;
    }
    else if(type == 2)
    {
        hight = 90;
    }
    return hight;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger count;
    
    if (type == 1)
    {
        count = [ProvinceAgentRegionList count];
    }
    else if(type == 2)
    {
        count = [carrierList count];
    }
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (type == 1)
    {
        static NSString *CellIdentifier = @"GoldChoiceAddressTableViewCell";
        
        GoldChoiceAddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil)
        {
            cell = [[NSBundle mainBundle] loadNibNamed:@"GoldChoiceAddressTableViewCell" owner:nil options:nil].lastObject;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.layer.masksToBounds = YES;
        }
        
        cell.cellLine.top = 44.5;
        cell.cellTitle.text = [[[ProvinceAgentRegionList objectAtIndex:indexPath.row]wrapper]getString:@"Name"];
        
        return cell;
    }
    else if(type == 2)
    {
        static NSString *CellIdentifier = @"PurchaseGoldByCarrieroperatorTableViewCell";
        
        PurchaseGoldByCarrieroperatorTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil)
        {
            cell = [[NSBundle mainBundle] loadNibNamed:@"PurchaseGoldByCarrieroperatorTableViewCell" owner:nil options:nil].lastObject;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.layer.masksToBounds = YES;
        }
//        cell.cellline.top = 89.5;

        cell.cellTitle.text = [[[carrierList objectAtIndex:indexPath.row]wrapper]getString:@"AgentName"];
        cell.cellName.text = [[[carrierList objectAtIndex:indexPath.row]wrapper]getString:@"Name"];
        cell.cellPhone.text = [[[carrierList objectAtIndex:indexPath.row]wrapper]getString:@"Phone"];
        return cell;
    }
    
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (type == 1)
    {
        GoldChoiceAddressTableViewCell *cell = (GoldChoiceAddressTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
        
        cell.cellChoiceImage.image = [UIImage imageNamed:@"ads_list_right.png"];
        
        cell.cellTitle.textColor = RGBCOLOR(240, 5, 0);

        addressName = [[[ProvinceAgentRegionList objectAtIndex:indexPath.row]wrapper]getString:@"Name"];
        
        NSLog(@"-addressname%@",addressName);
        
        _choiceCarrierLable.text = addressName;
        
        type = 2;
        ADAPI_adv3_CustomerGold_GetProvinceAgentByCode([self genDelegatorID:@selector(HandleNotification:)], addressName);
    }
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(type == 2)
    {
        PurchaseGoldByCarrieroperatorTableViewCell *cell = (PurchaseGoldByCarrieroperatorTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
        cell.contentView.backgroundColor = AppColor(220);
    }
    return YES;
}

- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(type == 2)
    {
        PurchaseGoldByCarrieroperatorTableViewCell *cell = (PurchaseGoldByCarrieroperatorTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
        cell.contentView.backgroundColor = [UIColor whiteColor];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
    [_choiceCarrierLable release];
    [_choiceBtn release];
    [_choiceImage release];
    [_mainTableView release];
    [_showView release];
    [_choiceView release];
    [_choiceTable release];
    [_blackView release];
    [_lineView release];
    [_linetop release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setChoiceCarrierLable:nil];
    [self setChoiceBtn:nil];
    [self setChoiceImage:nil];
    [self setMainTableView:nil];
    [self setShowView:nil];
    [self setChoiceView:nil];
    [self setChoiceTable:nil];
    [super viewDidUnload];
}


@end
