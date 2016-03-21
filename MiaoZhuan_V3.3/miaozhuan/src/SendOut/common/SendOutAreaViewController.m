//
//  SendOutAreaViewController.m
//  miaozhuan
//
//  Created by 孙向前 on 14-11-17.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "SendOutAreaViewController.h"
#import "AreaListViewController.h"
#import "AreaTitleCell.h"
#import "GaoDeMapViewController.h"
#import "AccurateLocationViewController.h"
#import "AccurateLocationViewController.h"
#import "WebhtmlViewController.h"
#import "RRLineView.h"

@interface SendOutAreaViewController ()<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,GetMapInformation>{
    BOOL _isAllCountry;
}

@property (retain, nonatomic) IBOutlet UITableView *tableView;

@property (retain, nonatomic) NSArray *headerTitles;
@property (retain, nonatomic) NSArray *sectionTitles;
@property (nonatomic, retain) NSMutableArray *status;
@property (nonatomic, retain) NSMutableArray *locationInfos;

@end

@implementation SendOutAreaViewController

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupMoveBackButton];
    [self setNavigateTitle:@"投放区域"];
    [self setupMoveFowardButtonWithTitle:@"说明"];
    
    self.locationInfos = [NSMutableArray array];
    
    [self setExtraCellLineHidden:_tableView];
    
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self _initData];
}

- (void)_initData{
    
    NSArray *country = [[NSUserDefaults standardUserDefaults] valueForKey:@"Country"];
    NSArray *locations = [[NSUserDefaults standardUserDefaults] valueForKey:@"CurrentLocations"];
    
    _status = nil;
    if (!self.status) {
        NSString *str = [NSString stringWithFormat:@"已定位%ld个精准地址",(long)locations.count];
        self.status = [NSMutableArray arrayWithArray:@[[NSMutableArray arrayWithArray:@[@"", @"未设置", @"未设置",@"未设置"]],[NSMutableArray arrayWithArray:@[locations.count ? str : @"未设置"]]]];
    }
    
    NSArray *p = [[NSUserDefaults standardUserDefaults] valueForKey:@"Province"];
    NSArray *c = [[NSUserDefaults standardUserDefaults] valueForKey:@"City"];
    NSArray *d = [[NSUserDefaults standardUserDefaults] valueForKey:@"District"];

    [self createStr:p withIndex:1];
    [self createStr:c withIndex:2];
    [self createStr:d withIndex:3];
    
    if (country.count) {
        _isAllCountry = YES;
    }
    self.headerTitles = @[@"通过设置区域投放广告", @"通过精准定位投放广告"];
    self.sectionTitles = @[@[@"全国投放", @"省级区域投放", @"市级区域投放", @"区级区域投放"], @[@"精准定位投放"]];
    [self.tableView reloadData];
}

- (void)createStr:(NSArray *)array withIndex:(int)index{
    if (!array.count) {
        return;
    }
    NSString *str = [array componentsJoinedByString:@","];
    if (!str.length) {
        return;
    }
    [_status[0] removeObjectAtIndex:index];
    [_status[0] insertObject:str atIndex:index];
    [self.tableView reloadData];
}

#pragma mark - UITableViewDelegate/UITableViewDatasource
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 35;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = WEAK_OBJECT(UIView, initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 35));
    UILabel *lblTitle = WEAK_OBJECT(UILabel, initWithFrame:CGRectMake(15, 10, 250, 20));
    lblTitle.textColor = RGBCOLOR(153, 153, 153);
    lblTitle.text = _headerTitles[section];
    lblTitle.font = Font(14);
    
    RRLineView *lineview = WEAK_OBJECT(RRLineView, initWithFrame:CGRectMake(0, 34.5, SCREENWIDTH, 1));
    
    [view addSubviews:lblTitle, lineview, nil];
    return view;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _headerTitles.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_sectionTitles[section] count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"Cell";
    AreaTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"AreaTitleCell" owner:self options:nil] firstObject];
    }
    
    if (!indexPath.row && !indexPath.section) {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    } else {
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    }
    
    BOOL flag = (!indexPath.row && !indexPath.section);
    cell.lblContent.hidden = cell.lblSwitch.hidden = flag;
    cell.areaSwitch.hidden = !flag;

    cell.dataArray = @[[_sectionTitles[indexPath.section] objectAtIndex:indexPath.row],[_status[indexPath.section] objectAtIndex:indexPath.row]];
    
    if (!indexPath.row && !indexPath.section) {
        [cell.areaSwitch addTarget:self action:@selector(switchClicked:) forControlEvents:UIControlEventValueChanged];
    }
    
    if (_isAllCountry && !indexPath.section) {
        [cell.areaSwitch setOn:YES];
        if (indexPath.row >= 1 && indexPath.row < 4) {
            cell.userInteractionEnabled = NO;
            cell.lblTitle.textColor = RGBCOLOR(204, 204, 204);

        } else {
            cell.userInteractionEnabled = YES;
            cell.lblTitle.textColor = RGBCOLOR(34, 34, 34);
        }
    }
        
    if ([_sectionTitles[indexPath.section] count] == indexPath.row + 1) {
        cell.lineview.width = 320;
        cell.lineview.left = 0;
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (!indexPath.row && !indexPath.section) {
        return;
    }
    if (_isAllCountry && !indexPath.section) {
        if (indexPath.row < 4) {
            return;
        }
    }
    if (indexPath.section) {
        NSArray *ls = [[NSUserDefaults standardUserDefaults] valueForKey:@"CurrentLocations"];
        if (ls.count) {
            UIActionSheet *sheet = [[[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"更改投放区域" otherButtonTitles:@"删除此区域", nil] autorelease];
            sheet.tag = 22222;
            [sheet showInView:self.view];
        } else {
            GaoDeMapViewController *map = WEAK_OBJECT(GaoDeMapViewController, init);
            map.delegate = self;
            [UI_MANAGER.mainNavigationController pushViewController:map animated:YES];
        }
        return;
    }
    AreaTitleCell *cell = (AreaTitleCell *)[tableView cellForRowAtIndexPath:indexPath];
    NSString *area = cell.lblContent.text;
    if ([area isEqualToString:@"未设置"]) {
        //跳转
        [self turnToAreaList:indexPath.row];
    } else {
        //弹框提示
        UIActionSheet *actionsheet = [[[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"更改区域设置" otherButtonTitles:@"删除此区域", nil] autorelease];
        actionsheet.tag = indexPath.row;
        [actionsheet showInView:self.view];
    }
}

#pragma mark - GetMapInformationDelegate
- (void)getDataArray:(NSArray*)array{
    NSDictionary *temp = @{
                           @"Province" : @"",
                           @"City" : @"",
                           @"District" : @"",
                           @"PutRegionalType" : @"1",
                           @"LocationType" : @"",
                           @"Lng" : @"",
                           @"Lat" : @"",
                           @"DetailAddress":@""
                           };
    for (NSDictionary *dic in array) {
        NSMutableDictionary *tempDic = [NSMutableDictionary dictionaryWithDictionary:temp];
        [tempDic setValue:[[dic wrapper] getString:@"latitude"] forKey:@"Lat"];
        [tempDic setValue:[[dic wrapper] getString:@"longtitude"] forKey:@"Lng"];
        [tempDic setValue:[[dic wrapper] getString:@"location"] forKey:@"DetailAddress"];
        [_locationInfos addObject:tempDic];
    }
    if (_locationInfos.count) {
        NSArray *history = [[NSUserDefaults standardUserDefaults] valueForKey:@"UploadData"];
        NSMutableArray *adDic = [NSMutableArray arrayWithArray:history];
        
        if (![adDic containsObject:_locationInfos]) {
            [adDic addObjectsFromArray:_locationInfos];
        }
        
        [[NSUserDefaults standardUserDefaults] setValue:adDic forKey:@"UploadData"];
        [[NSUserDefaults standardUserDefaults] setValue:_locationInfos forKey:@"Locations"];
        [[NSUserDefaults standardUserDefaults] setValue:_locationInfos forKey:@"CurrentLocations"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [self _initData];
        [self.tableView reloadData];
    }
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"IsChanged"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (actionSheet.tag == 22222) {
        if (buttonIndex == 1) {
            
            self.locationInfos = [NSMutableArray array];
            
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"CurrentLocations"];
            
            NSArray *history = [[NSUserDefaults standardUserDefaults] valueForKey:@"UploadData"];
            NSMutableArray *temp = [NSMutableArray arrayWithArray:history];
            for (NSDictionary *dic in history) {
                if ([[dic wrapper] getInt:@"PutRegionalType"] == 1) {
                    [temp removeObject:dic];
                }
            }
            [[NSUserDefaults standardUserDefaults] setValue:temp forKey:@"UploadData"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            [self _initData];
        } else if (buttonIndex == 0){
            PUSH_VIEWCONTROLLER(AccurateLocationViewController);
        }
        
    } else {
        if (buttonIndex == 0) {
            //更改
            [self turnToAreaList:actionSheet.tag];
        } else if (buttonIndex == 1) {
            //删除
            NSInteger index = actionSheet.tag;
            NSArray *names = @[@"Province",@"City",@"District"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:names[index - 1]];
            [_status[0] removeObjectAtIndex:index];
            [_status[0] insertObject:@"未设置" atIndex:index];
            NSArray *history = [[NSUserDefaults standardUserDefaults] valueForKey:@"UploadData"];
            NSMutableArray *temp = [NSMutableArray arrayWithArray:history];
            for (NSDictionary *dic in history) {
                if ([[dic wrapper] getInt:@"PutRegionalType"] == index + 2) {
                    [temp removeObject:dic];
                }
            }
            [[NSUserDefaults standardUserDefaults] setValue:temp forKey:@"UploadData"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [self.tableView reloadData];
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"IsChanged"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }

    }
}

#pragma mark - 事件
- (void)onMoveBack:(UIButton *)sender{
    if (_isAllCountry) {
        NSDictionary *temp = @{
                               @"Province" : @"",
                               @"City" : @"",
                               @"District" : @"",
                               @"PutRegionalType" : @"2",
                               @"LocationType" : @"",
                               @"Lng" : @"",
                               @"Lat" : @"",
                               };
        NSArray *history = [[NSUserDefaults standardUserDefaults] valueForKey:@"UploadData"];
        NSMutableArray *adDic = [NSMutableArray arrayWithArray:history];
        for (NSDictionary *dic in history) {
            if (![[[dic wrapper]getString:@"PutRegionalType"] isEqualToString:@"1"]) {
                [adDic removeObject:dic];
            }
        }
        [adDic addObject:temp];
        [[NSUserDefaults standardUserDefaults] setValue:adDic forKey:@"UploadData"];
        [[NSUserDefaults standardUserDefaults] setValue:@[temp] forKey:@"Country"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    if (self.block) {
        NSArray *areas = [[NSUserDefaults standardUserDefaults] valueForKey:@"UploadData"];
        self.block(areas);
    }
    [UI_MANAGER.mainNavigationController popViewControllerAnimated:YES];
}
- (void)onMoveFoward:(UIButton *)sender{
    //说明
    PUSH_VIEWCONTROLLER(WebhtmlViewController);
    model.navTitle = @"说明";
    model.ContentCode = @"a1c3cf25cc098e32fa0d9653302442bf";
}
- (void)switchClicked:(UISwitch *)sw{
    _isAllCountry = sw.isOn;
    if (!_isAllCountry) {
        NSArray *array = [[NSUserDefaults standardUserDefaults] valueForKey:@"UploadData"];
        for (NSDictionary *dic in array) {
            if ([dic.wrapper getInt:@"PutRegionalType"] == 2) {
                
                NSArray *history = [[NSUserDefaults standardUserDefaults] valueForKey:@"UploadData"];
                NSMutableArray *adDic = [NSMutableArray arrayWithArray:history];
                for (NSDictionary *dic in history) {
                    if (![[[dic wrapper]getString:@"PutRegionalType"] isEqualToString:@"1"]) {
                        [adDic removeObject:dic];
                    }
                }
                [[NSUserDefaults standardUserDefaults] setValue:adDic forKey:@"UploadData"];
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"Country"];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }
        }
    } else {
        NSArray *history = [[NSUserDefaults standardUserDefaults] valueForKey:@"UploadData"];
        NSMutableArray *adDic = [NSMutableArray arrayWithArray:history];
        for (NSDictionary *dic in history) {
            if (![[[dic wrapper]getString:@"PutRegionalType"] isEqualToString:@"1"]) {
                [adDic removeObject:dic];
            }
        }
        [[NSUserDefaults standardUserDefaults] setValue:adDic forKey:@"UploadData"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"Country"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"Province"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"City"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"District"];
    }
    [self _initData];
}
-(void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = WEAK_OBJECT(UIView, initWithFrame:CGRectZero);
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}
- (void)turnToAreaList:(NSInteger)area
{
    AreaListViewController *arealist = WEAK_OBJECT(AreaListViewController, init);
    arealist.level = area;
    arealist.titleName = _sectionTitles[0][area];
    [UI_MANAGER.mainNavigationController pushViewController:arealist animated:YES];
}

#pragma mark - 内存管理
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    
    [_locationInfos release];
    [_status release];
    [_headerTitles release];
    [_sectionTitles release];
    [_tableView release];
    [super dealloc];
}
@end
