//
//  ScreenedResultListVC.m
//  guanggaoban
//
//  Created by CQXianMai on 14-8-10.
//  Copyright (c) 2014年 Arvin. All rights reserved.
//

#import "ScreenedResultListVC.h"
//#import "FansCountListCell.h"
#import "ScreenResListCell.h"
//#import "LoginManager.h"
#import "UIView+expanded.h"
//#import "MJRefreshController.h"

@interface ScreenedResultListVC ()
{
//    MJRefreshController *_MJRefreshCon;
    
    NSInteger _nameType;
    NSInteger _timeType;
    NSString *_markDate;
}
@end

@implementation ScreenedResultListVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initNavItem];

    _nameType = [[_searchDic valueForKey:@"type"] integerValue];
    _timeType = [[_searchDic valueForKey:@"period"] integerValue];
    _markDate = [[_searchDic valueForJSONStrKey:@"startDay"] retain];
    [self layoutView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    
//    [_MJRefreshCon release];
//    _MJRefreshCon = nil;
    [_markDate release];
    _markDate = nil;
    [_searchDic release];
    _searchDic = nil;
    
    [_rankInfoLbl release];
    [_selectResultList release];
    [_noDataLbl release];
    [super dealloc];
}

- (void)initNavItem
{
    [self setNavigateTitle:@"历史榜单"];
    [self setupMoveBackButton];
}

- (void)layoutView
{
    self.rankInfoLbl.text = _rankInfoStr;
    self.noDataLbl.hidden = YES;
    
//    _MJRefreshCon = [MJRefreshController controllerFrom:_selectResultList name:@"adv23-top-search"];
//    [_MJRefreshCon retain];
//    
//    [_MJRefreshCon setURLGenerator:^DictionaryWrapper *(NSString *refreshName, int pageIndex, int pageSize) {
//        NSDictionary *dic = @{};
//        return dic.wrapper;
//    }];
//
//    {
//        __block ScreenedResultListVC *weakself = self;
//        MJRefreshOnRequestDone block = ^(MJRefreshController *controller, BOOL byHeader, DictionaryWrapper *netData)
//        {
//            weakself.noDataLbl.hidden = (controller.refreshCount > 0) ? YES : NO;
//        };
//        
//        [_MJRefreshCon setOnRequestDone:block];
//        [_MJRefreshCon setPageSize:50];
//        [_MJRefreshCon refreshWithLoading];
//    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//        return _MJRefreshCon.refreshCount;
    return 1;
}

- (UITableViewCell *)cellForRowByUserRankList:(UITableView *)tableView index:(NSIndexPath *)indexPath
{
//    NSInteger row = [indexPath row];
//
//    FansCountListCell *cell = nil;
//    
//    cell = [tableView dequeueReusableCellWithIdentifier:@"FansCountListCell"];
//    
//    if (cell == nil){
//        
//        NSArray * nibs = [[NSBundle mainBundle] loadNibNamed:@"FansCountListCell" owner:self options:nil];
//        
//        if ([nibs count] > 0) {
//            cell = nibs[0];
//        }
//        
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        
//    }
//    
//    NSDictionary * dic = [_mCon dataAtIndex:row];
//    
//    BOOL isShowIcon = NO;
//    
//    if(_nameType == 102)
//    {
//        isShowIcon = YES;
//    }
//    
//    cell.rankLbl.text = [dic valueForJSONStrKey:@"Rank"];
//    
//    [cell.photoImgView allRoundCorner];
//    
//    [cell.photoImgView requestIcon:[dic valueForJSONStrKey:@"PictureUrl"] placeHolder:@"defaultTouxiang"];
//    
//    NSString * name = [dic valueForJSONStrKey:@"Title"];
//    
//    if(name.length > 5)
//    {
//        name = [name substringToIndex:5];
//    }
//    
//    cell.titleNameLbl.text = name;
//    
//    cell.phoneLbl.text = [UICommon hidePhoneText:[dic valueForJSONStrKey:@"Phone"]];
//    
//    [cell adjustView:[dic valueForJSONStrKey:@"Value"]
//             strFont:[UIFont systemFontOfSize:14]
//            showIcon: isShowIcon];
//    
//    CGRect rectFrame = cell.rightView.frame;
//    
//    rectFrame.origin.x = 320 -  15 - rectFrame.size.width;
//    
//    rectFrame.origin.y = 25;
//    
//    cell.rightView.frame = rectFrame;
//    
//    return cell;

    return [UITableViewCell new];
}

- (UITableViewCell *)cellForRowByComRankList:(UITableView *)tableView index:(NSIndexPath *)indexPath{
    NSInteger row = [indexPath row];
    
    ScreenResListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ScreenResListCell"];
    if (cell == nil) {
        NSArray * nib = [[NSBundle mainBundle] loadNibNamed:@"ScreenResListCell" owner:self options:nil];
        
        if ([nib count] > 0) {
            cell = nib[0];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
//    NSDictionary * dic = [_mCon dataAtIndex:row];
//    [cell initCellWithDic:dic];
    return cell;
  
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    if (_nameType/100 == 1) {
        cell = [self cellForRowByUserRankList:tableView index:indexPath];
    }
    else {
        cell = [self cellForRowByComRankList:tableView index:indexPath];
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
