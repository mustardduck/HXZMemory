//
//  AccurateLocationViewController.m
//  miaozhuan
//
//  Created by 孙向前 on 14-11-27.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "AccurateLocationViewController.h"
#import "AreaListCell.h"
#import "HistoryLocationsViewController.h"
#import "GaoDeMapViewController.h"

@interface AccurateLocationViewController ()<GetMapInformation, UITableViewDataSource, UITableViewDelegate>

@property (retain, nonatomic) IBOutlet UITableView *tableVIew;

@property (nonatomic, retain) NSMutableArray *dataArray;
@property (nonatomic, assign) NSInteger currentRow;

@end

@implementation AccurateLocationViewController

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad {
    [super viewDidLoad];

    _currentRow = -1;
    
    [self setupMoveBackButton];
    [self setNavigateTitle:@"精准定位"];

    self.tableVIew.panGestureRecognizer.delaysTouchesBegan = YES;
//    [self setExtraCellLineHidden:self.tableVIew];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSArray *array = [[NSUserDefaults standardUserDefaults] valueForKey:@"CurrentLocations"];
    self.dataArray = [NSMutableArray arrayWithArray:array];
    [self.tableVIew reloadData];
}

#pragma mark - UITableViewDelegate/UITableViewDatasource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_dataArray count];
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle != UITableViewCellEditingStyleDelete) {
        return;
    }
    [_dataArray removeObjectAtIndex:indexPath.row];
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    [[NSUserDefaults standardUserDefaults] setValue:_dataArray forKey:@"CurrentLocations"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"Cell";
    AreaListCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"AreaListCell" owner:self options:nil] firstObject];
        cell.lblArea.font = Font(16);
        cell.imgArrow.hidden = NO;
        cell.btnSelected.hidden = YES;
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    }
    if (indexPath.row == _dataArray.count - 1) {
        cell.line.hidden = YES;
    }
    cell.lblArea.text = [[_dataArray[indexPath.row] wrapper] getString:@"DetailAddress"];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    GaoDeMapViewController *map = WEAK_OBJECT(GaoDeMapViewController, init);
    map.latidiute = [[[_dataArray[indexPath.row] wrapper] getString:@"Lat"] doubleValue];
    map.longitude = [[[_dataArray[indexPath.row] wrapper] getString:@"Lng"] doubleValue];
    map.delegate = self;
    _currentRow = indexPath.row;
    [UI_MANAGER.mainNavigationController pushViewController:map animated:YES];
}
//-(void)setExtraCellLineHidden: (UITableView *)tableView
//{
//    UIView *view = WEAK_OBJECT(UIView, initWithFrame:CGRectZero);
//    view.backgroundColor = [UIColor clearColor];
//    [tableView setTableFooterView:view];
//}

#pragma GetMapInformation
- (void)getDataArray:(NSArray*)array{

    NSDictionary *temp = @{
                           @"Province" : @"",
                           @"City" : @"",
                           @"District" : @"",
                           @"PutRegionalType" : @"1",
                           @"LocationType" : @"",
                           @"Lng" : @"",
                           @"Lat" : @""
                           };
    NSArray *history = [[NSUserDefaults standardUserDefaults] valueForKey:@"CurrentLocations"];
    NSMutableArray *mArray = [NSMutableArray arrayWithArray:history];
    for (WDictionaryWrapper *wdic in array) {
        
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:temp];
        [dic setValue:[wdic getString:@"latitude"] forKey:@"Lat"];
        [dic setValue:[wdic getString:@"longtitude"] forKey:@"Lng"];
        [dic setValue:[wdic getString:@"location"] forKey:@"DetailAddress"];
        
        if (_currentRow == -1) {
            for (NSDictionary *dic in mArray) {
                if ([[[dic wrapper] getString:@"DetailAddress"] isEqualToString:[wdic getString:@"location"]]) {
                    return;
                }
            }
            [mArray addObject:dic];
        } else {
            [mArray replaceObjectAtIndex:_currentRow withObject:dic];
        }
    }
    [[NSUserDefaults standardUserDefaults] setValue:mArray forKey:@"CurrentLocations"];
    [[NSUserDefaults standardUserDefaults] setValue:mArray forKey:@"Locations"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"IsChanged"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    self.dataArray = nil;
    self.dataArray = mArray;
    [self.tableVIew reloadData];
    
    _currentRow = -1;
}

#pragma mark - 事件
//新增
- (IBAction)addNewAddressClicked:(id)sender {
    _currentRow = -1;
    GaoDeMapViewController *map = WEAK_OBJECT(GaoDeMapViewController, init);
    map.delegate = self;
    [UI_MANAGER.mainNavigationController pushViewController:map animated:YES];
}
//历史
- (IBAction)historyListClicked:(id)sender {
    PUSH_VIEWCONTROLLER(HistoryLocationsViewController);
}

- (void)onMoveBack:(UIButton *)sender{
    
    NSArray *history = [[NSUserDefaults standardUserDefaults] valueForKey:@"UploadData"];
    NSMutableArray *adDic = [NSMutableArray arrayWithCapacity:0];
    for (NSDictionary *dic in history) {
        if ([[dic wrapper] getInt:@"PutRegionalType"] != 1) {
            [adDic addObject:dic];
        }
    }
    [adDic addObjectsFromArray:_dataArray];

    [[NSUserDefaults standardUserDefaults] setValue:adDic forKey:@"UploadData"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 内存管理
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc {
    [_dataArray release];
    [_tableVIew release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setTableVIew:nil];
    [super viewDidUnload];
}
@end
