//
//  AreaListViewController.m
//  miaozhuan
//
//  Created by 孙向前 on 14-11-17.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "AreaListViewController.h"
#import "BaserHoverView.h"
#import "NSDictionary+expanded.h"
#import "pinyin.h"
#import "AccurateService.h"
#import "AreaListCell.h"

@interface AreaListViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain) NSMutableDictionary *history;//历史数据
@property (nonatomic, copy) NSString *curLevel;
@property (nonatomic, retain) NSMutableDictionary *userInfo;//显示数据源
@property (nonatomic, copy) NSString *provinceId;
@property (nonatomic, copy)NSString *cityId;
@property (nonatomic, retain) NSMutableArray *selectedItems;//选中数据
@property (nonatomic, retain) NSMutableArray *uploadData;//上传data
@property (nonatomic, retain) NSMutableArray *cities;//城市名称
@property (nonatomic, retain) NSArray *names;

@property (nonatomic, copy) NSString *pId;
@property (nonatomic, copy) NSString *cId;
@property (nonatomic, copy) NSString *dId;

@property (nonatomic, copy) NSString *pName;
@property (nonatomic, copy) NSString *cName;
@property (nonatomic, copy) NSString *dName;

@property (retain, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation AreaListViewController

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupMoveBackButton];
    [self setNavigateTitle:_titleName];
    [self setupMoveFowardButtonWithTitle:@"保存"];
    
    [self _initData];
    
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    [self setExtraCellLineHidden:_tableView];
    ADAPI_Region_GetAllBaiduRegionList([GLOBAL_DELEGATOR_MANAGER addDelegator:self selector:@selector(handleAllRegion:)]);
}

- (void)_initData{
    self.names = @[@"ProvinceId", @"CityId", @"DistrictId"];
    self.uploadData = [NSMutableArray arrayWithCapacity:0];
    self.history = [NSMutableDictionary dictionary];
    _selectedItems = [NSMutableArray new];
    
    NSArray *array = [[NSUserDefaults standardUserDefaults] valueForKey:@"UploadData"];
    if (array) {
        _uploadData = nil;
        self.uploadData = [NSMutableArray arrayWithArray:array];
    }

    self.cities = [NSMutableArray arrayWithCapacity:0];
    
}

-(void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = WEAK_OBJECT(UIView, initWithFrame:CGRectZero);
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}

- (void)handleAllRegion:(DelegatorArguments *)arguments{
    DictionaryWrapper* dic = arguments.ret;
    
    if (dic.operationSucceed) {
        NSLog(@"%@",dic.data);
        if (![dic.data count]) {
            [self createHoverViewWhenNoData];
        }
        _tableView.hidden = NO;
        NSMutableDictionary *mdict = [NSMutableDictionary dictionary];
        for (NSDictionary *dict in dic.data)
        {
            NSString *str = [[dict wrapper] getString:@"Spell"];
            if (str)
            {
                int level = [[dict wrapper] getInt:@"Level"];
                if (level == 1) {
                    [mdict setObjects:dict forKey:[[NSString stringWithFormat:@"%c",pinyinFirstLetter([str characterAtIndex:0])] uppercaseString]];
                }
            }
        }
        if (mdict.count) {
            [_history setValue:mdict forKey:@"1"];
            self.userInfo = mdict;
            [self.tableView reloadData];
        }
        
    } else {
        
        [HUDUtil showErrorWithStatus:dic.operationMessage];
        return;
    }

}

//无数据hoverview
- (void)createHoverViewWhenNoData
{
    BaserHoverView *hover = STRONG_OBJECT(BaserHoverView, initWithTitle:@"抱歉" message:@"没有筛选到数据");
    hover.frame = self.view.bounds;
    [self.view addSubview:hover];
    [hover release];
}

#pragma mark - UITableViewDelegate/UITableViewDatasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [[self.userInfo allKeys] count];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[self.userInfo objectForKey:[[[self.userInfo allKeys] sortedArrayUsingSelector:@selector(compare:)] objectAtIndex:section]] count];
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    NSString *title = [[self.userInfo allKeys] sortedArrayUsingSelector:@selector(compare:)][section];
    UIView *view = WEAK_OBJECT(UIView, initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 20));
    view.backgroundColor = AppColorBackground;
    UILabel *lblTitle = WEAK_OBJECT(UILabel, initWithFrame:CGRectMake(15, 5, 200, 10));
    lblTitle.textColor = RGBCOLOR(153, 153, 153);
    lblTitle.font = Font(12);
    lblTitle.text = title;
    [view addSubview:lblTitle];
    return view;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *temp = [self.userInfo valueForKey:[[[self.userInfo allKeys] sortedArrayUsingSelector:@selector(compare:)] objectAtIndex:indexPath.section]];
    NSDictionary *dict = [temp objectAtIndex:indexPath.row];
    NSString *identify = dict.description;
    AreaListCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"AreaListCell" owner:self options:nil] firstObject];
    }
    
    BOOL flag = ([[dict wrapper] getInt:@"Level"] < _level);
    cell.btnSelected.hidden = flag;
    cell.imgArrow.hidden = !flag;
    
    if (!cell.btnSelected.hidden) {
        
        cell.btnSelected.tag = indexPath.row + indexPath.section *10000;
        [cell.btnSelected addTarget:self action:@selector(selectClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        [self isSelectedWithCell:cell dic:dict];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    } else {
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    }
    
    cell.line.top = 49.5;
    if (indexPath.row == temp.count - 1) {
        cell.line.left = 0;
    } else {
        cell.line.left = 15;
    }
    
    self.curLevel = [[dict wrapper] getString:@"Level"];
    cell.dataDic = dict;
    return cell;
}

- (void)isSelectedWithCell:(AreaListCell *)cell dic:(NSDictionary *)dict{
    if (!_uploadData.count) {
        return;
    }
    for (NSDictionary *dic in _uploadData) {
        NSString *regionId = [[dict wrapper] getString:@"RegionId"];
        if ([regionId isEqualToString:[dic.wrapper getString:_names[_level-1]]]) {
            cell.btnSelected.selected = YES;
            if ([_cities containsObject:[dict.wrapper getString:@"Name"]]) {
                return;
            }
            [_cities addObject:[dict.wrapper getString:@"Name"]];
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (_level <= [_curLevel integerValue]) {
        return;
    }
    
    NSDictionary *dict = [[self.userInfo valueForKey:[[[self.userInfo allKeys] sortedArrayUsingSelector:@selector(compare:)] objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row];
    [_selectedItems addObject:[[dict wrapper] getString:@"Name"]];
    if (_level == 2 || _level == 3) {
        NSString *parentId = [[dict wrapper] getString:@"RegionId"];
        ADAPI_Region_GetBaiduRegionList([GLOBAL_DELEGATOR_MANAGER addDelegator:self selector:@selector(handleRegionList:)], parentId);
    }
    switch ([_curLevel intValue]) {
        case 1:
            self.pId = [[dict wrapper] getString:@"RegionId"];
            self.pName = [[dict wrapper] getString:@"Name"];
            break;
        case 2:
            self.cId = [[dict wrapper] getString:@"RegionId"];
            self.cName = [[dict wrapper] getString:@"Name"];
            break;
        case 3:
            self.dId = [[dict wrapper] getString:@"RegionId"];
            self.dName = [[dict wrapper] getString:@"Name"];
            break;
        default:
            break;
    }
    
    if ([_curLevel isEqualToString:@"1"]) {
        self.provinceId = [[dict wrapper] getString:@"RegionId"];
    } else if ([_curLevel isEqualToString:@"2"]){
        self.cityId = [[dict wrapper] getString:@"RegionId"];
    }
}

- (void)handleRegionList:(DelegatorArguments *)arguments{
    DictionaryWrapper* dic = arguments.ret;
    
    if (dic.operationSucceed) {
        if (![dic.data count]) {
            [self createHoverViewWhenNoData];
        }
        NSMutableDictionary *mdict = [NSMutableDictionary dictionary];
        for (NSDictionary *dict in dic.data) {
            NSString *str = [[dict wrapper] getString:@"Name"];
            if (str) {
                [mdict setObjects:dict forKey:[[NSString stringWithFormat:@"%c",pinyinFirstLetter([str characterAtIndex:0])] uppercaseString]];
            }
        }
        [self.history setValue:mdict forKey:[[dic.data[0] wrapper] getString:@"Level"]];
        self.userInfo = mdict;
        [self.tableView reloadData];
    } else {
        
        [HUDUtil showErrorWithStatus:dic.operationMessage];
        return;
    }
}

#pragma mark - 事件
- (void)onMoveBack:(UIButton *)sender{
    if ([_curLevel isEqualToString:@"1"]) {
        [UI_MANAGER.mainNavigationController popViewControllerAnimated:YES];
        return;
    }
    self.userInfo = [_history valueForKey:[NSString stringWithFormat:@"%d", [_curLevel intValue] - 1]];
    [self.tableView reloadData];
}
- (void)onMoveFoward:(UIButton *)sender{
    if (!_uploadData.count) {
        [HUDUtil showErrorWithStatus:@"暂无可保存内容"];
        return;
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(AreaList:selected:forKey:)])
    {
        [_delegate AreaList:self selected:_uploadData.lastObject forKey:0];
    }
    NSArray *ns = @[@"Province",@"City",@"District"];
    [[NSUserDefaults standardUserDefaults] setValue:_cities forKey:ns[_level - 1]];
    [[NSUserDefaults standardUserDefaults] setValue:_uploadData forKey:@"UploadData"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [UI_MANAGER.mainNavigationController popViewControllerAnimated:YES];
    
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"IsChanged"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)selectClicked:(UIButton *)button{
    
    NSInteger row = button.tag % 10000;
    NSInteger section = button.tag / 10000;
 
    NSDictionary *dict = [[self.userInfo valueForKey:[[[self.userInfo allKeys] sortedArrayUsingSelector:@selector(compare:)] objectAtIndex:section]] objectAtIndex:row];
    
    switch ([_curLevel intValue]) {
        case 1:
            self.pId = [[dict wrapper] getString:@"RegionId"];
            self.pName = [[dict wrapper] getString:@"Name"];
            break;
        case 2:
            self.cId = [[dict wrapper] getString:@"RegionId"];
            self.cName = [[dict wrapper] getString:@"Name"];
            break;
        case 3:
            self.dId = [[dict wrapper] getString:@"RegionId"];
            self.dName = [[dict wrapper] getString:@"Name"];
            break;
        default:
            break;
    }
    
    NSDictionary *temp = @{
                           @"ProvinceId" : self.pId.length ? self.pId : @"",
                           @"CityId" : self.cId ? self.cId : @"",
                           @"DistrictId" : self.dId ? self.dId : @"",
                           @"Province" : self.pName.length ? self.pName : @"",
                           @"City" : self.cName ? self.cName : @"",
                           @"District" : self.dName ? self.dName : @"",
                           @"PutRegionalType" : @(_level + 2),
                           @"LocationType" : @"",
                           @"Lng" : @"",
                           @"Lat" : @"",
                           @"District" : [[dict wrapper] getString:@"Name"]
                           };
    
    for (NSDictionary *dic in _uploadData)
    {
        NSString *hId = [dic.wrapper getString:_names[_level-1]];
        if ([hId isEqualToString:[[dict wrapper] getString:@"RegionId"]]) {
            [_uploadData removeObject:dic];
            [_cities removeObject:[dict.wrapper getString:@"Name"]];
            [self.tableView reloadData];
            return;
        }
    }
    [_uploadData addObject:temp];
    [self.tableView reloadData];
    
}

#pragma mark - 内存管理
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    [_pId release];
    [_cId release];
    [_dId release];
    [_cities release];
    [_uploadData release];
    [_provinceId release];
    [_cityId release];
    [_userInfo release];
    [_curLevel release];
    [_history release];
    [_titleName release];
    [_tableView release];
    [_selectedItems release];
    [super dealloc];
}

@end
