//
//  BusinessInfoViewController.m
//  miaozhuan
//
//  Created by abyss on 14/11/10.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "BusinessInfoViewController.h"
#import "RCCommonTableViewCell.h"

#import "BusinessInfoManagerViewController.h"
#import "ZiZhiViewController.h"
#import "PermissonViewController.h"
#import "BusinessPlaceController.h"

@interface BusinessInfoViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSArray *_dataArray;
}
@end

@implementation BusinessInfoViewController
@synthesize tableView = _tableView;

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad {
    [super viewDidLoad];
    
    InitNav(@"商家信息");
    _dataArray = @[@[@"商家基本信息"],@[@"商家资质",@"兑换承诺书",@"经营场所"]];
    [_dataArray retain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.view.backgroundColor = AppColorBackground;
    _tableView.backgroundColor = AppColorBackground;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
    [_dataArray release];
    [_tableView release];
    CRDEBUG_DEALLOC();
    [super dealloc];
}
- (void)viewDidUnload {
    [self setTableView:nil];
    [super viewDidUnload];
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    RCCommonTableViewCell *cell = (RCCommonTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.contentView.backgroundColor = AppColor(220);
    return YES;
}
- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    RCCommonTableViewCell *cell = (RCCommonTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor whiteColor];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        PUSH_VIEWCONTROLLER(BusinessInfoManagerViewController);
    }
    else if (indexPath.row == 0)
    {
        PUSH_VIEWCONTROLLER(ZiZhiViewController);
    }
    else if(indexPath.row == 1)
    {
        PUSH_VIEWCONTROLLER(PermissonViewController);
    }
    else
    {
        PUSH_VIEWCONTROLLER(BusinessPlaceController);
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *sectionView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 10)] autorelease];
    sectionView.backgroundColor = [UIColor clearColor];
    return sectionView;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return ((NSArray *)_dataArray[section]).count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"RCCommonTableViewCell";
    RCCommonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[NSBundle mainBundle] loadNibNamed:@"RCCommonTableViewCell" owner:nil options:nil].lastObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.layer.masksToBounds = YES;
        cell.titleL.left = 15;
        cell.img.hidden = YES;
    }
    
    cell.titleL.text = _dataArray[indexPath.section][indexPath.row];
    [cell layoutTheLineWithIndexPath:indexPath andEnd:_dataArray];
    
    return cell;
}

@end
