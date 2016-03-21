//
//  PersonalPreferenceSet.m
//  miaozhuan
//
//  Created by Santiago on 14-10-27.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "PersonalPreferenceSet.h"
#import "PersonalPreferenceCell.h"
#import "MJRefreshController.h"
#import "NetService.h"
#import "PreferenceDetailViewController.h"
@interface PersonalPreferenceSet ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic ,retain) NSArray *tableDataArray;//表格数据源
@property (nonatomic,retain) NSMutableArray *answersArray;//答案

@property (retain, nonatomic) IBOutlet UITableView *mainTable;
@property (retain, nonatomic) IBOutlet UIView *tableHead;

@property (retain, nonatomic) IBOutlet UIView *uiLineView1;

@end

@implementation PersonalPreferenceSet
@synthesize mainTable = _mainTable;
@synthesize tableHead = _tableHead;
@synthesize tableDataArray = _tableDataArray;
@synthesize answersArray = _answersArray;

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad {
    
    [super viewDidLoad];
    [_mainTable registerNib:[UINib nibWithNibName:@"PersonalPreferenceCell" bundle:nil] forCellReuseIdentifier:@"PersonalPreferenceCell"];
    [_mainTable setTableHeaderView:_tableHead];
    [self setNavigateTitle:@"偏好设置"];
    [self setupMoveBackButton];
    self.mainTable.hidden = YES;
    [self.uiLineView1 setFrame:CGRectMake(0, 79.5, 320, 0.5)];
    
    self.mainTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    ADAPI_adv23_PersonalPreferenceGet([self genDelegatorID:@selector(handleNotification:)]);
}

- (void)viewWillDisappear:(BOOL)animated {

    [self.delegate refresh2];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [_mainTable reloadData];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

- (void)handleNotification:(DelegatorArguments *)arguments{
    
    DictionaryWrapper *wrapper =  arguments.ret;
    
    if (wrapper.operationSucceed)
    {
        NSMutableArray* datas = WEAK_OBJECT(NSMutableArray, init);
        self.mainTable.hidden = NO;
        // Translate Read-Only to Writeable
        for(NSDictionary* item in wrapper.data)
        {
            WDictionaryWrapper* dataItem = WEAK_OBJECT(WDictionaryWrapper, initWith:item);
            
            NSMutableArray* options = WEAK_OBJECT(NSMutableArray, init);
            
            for(NSDictionary* option in [dataItem getArray:@"Options"])
            {
                [options addObject:WEAK_OBJECT(WDictionaryWrapper, initWith:option)];
            }
            
            [dataItem set:@"Options" value:options];
            
            [datas addObject:dataItem];
        }
        
        self.tableDataArray = datas;
    
        [_mainTable reloadData];
    }
    else
    {
        [HUDUtil showErrorWithStatus:wrapper.operationMessage];
    }
}

#pragma mark -UITableViewDelegates
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _tableDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PersonalPreferenceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PersonalPreferenceCell"];
    if (!cell) {
        
        cell = WEAK_OBJECT(PersonalPreferenceCell, initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PersonalPreferenceCell");
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    DictionaryWrapper* itemData = [_tableDataArray[indexPath.row] wrapper];
    
    
    cell.preferenceKind.text = [itemData getString:@"Title"];
    
    if ([itemData getBool:@"IsSelected"]) {
        cell.ifCompleted.text = @"已完成";
        cell.ifCompleted.textColor = [UIColor redColor];
    }
    else{
        cell.ifCompleted.text = @"未完成";
        cell.ifCompleted.textColor = [UIColor colorWithRed:204.0/255 green:204.0/255 blue:204.0/255 alpha:1];
    }
    
    if (indexPath.row == _tableDataArray.count - 1) {
        
        [cell.seperatorLine setFrame:CGRectMake(0, 49.5, 320, 0.5)];
    }else {
    
        [cell.seperatorLine setFrame:CGRectMake(15, 49.5, 305, 0.5)];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PreferenceDetailViewController *detail = WEAK_OBJECT(PreferenceDetailViewController, init);
    [detail setQuestions:_tableDataArray curPage:(int)indexPath.row];
    
    [self.navigationController pushViewController:detail animated:YES];
}
- (void)dealloc {
    [_mainTable release];
    [_tableHead release];
    [_tableDataArray release];
    
    [_uiLineView1 release];
    [super dealloc];
}
- (void)viewDidUnload {
    self.delegate = nil;
    [self setMainTable:nil];
    [self setTableHead:nil];
    [super viewDidUnload];
}
@end
