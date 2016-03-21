//
//  AccurateManagerViewController.m
//  miaozhuan
//
//  Created by 孙向前 on 14-11-13.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "AccurateManagerViewController.h"
#import "AccurateManageCell.h"
#import "RRPointView.h"
#import "AboutAccurateViewController.h"
#import "BuyAccurateAdsViewController.h"
#import "AddAccurateAdsViewController.h"
#import "DraftBoxViewController.h"
#import "AccurateService.h"
#import "WebhtmlViewController.h"
#import "RRLineView.h"

@interface AccurateManagerViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (retain, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, retain) DictionaryWrapper *dataDic;
@property (nonatomic, retain) NSArray *titles;

@end

@implementation AccurateManagerViewController

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigateTitle:@"红包广告发布与管理"];
    [self setupMoveBackButton];
    
    [self _initData];
    [self setExtraCellLineHidden:_tableView];
    
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"ClearTime"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"CurrentDirectAdId"];
    [AccurateService clearData];
    ADAPI_DirectAdvert_Snap([GLOBAL_DELEGATOR_MANAGER addDelegator:self selector:@selector(handleDiretAdSnap:)]);
}
-(void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = [self createTableFooterView];
    [tableView setTableFooterView:view];
}

- (void)_initData{
    self.titles = @[
                    @[@"关于红包广告"],
                    @[@"查看红包广告条数",@"购买红包广告条数"],
                    @[@"新增红包广告",@"草稿箱"],
                    @[@"审核成功的红包广告",@"审核中的红包广告",@"审核失败的红包广告"],
                    @[@"已播完的红包广告"]
                    ];
}

- (void)handleDiretAdSnap:(DelegatorArguments *)arguments{
    DictionaryWrapper* dic = arguments.ret;
    if (dic.operationSucceed) {
        self.dataDic = [@{
                          @"Remain":[dic.data getString:@"Remain"],
                          @"Frozen":[dic.data getString:@"Frozen"],
                          @"草稿箱":@"0",
                          @"审核成功的红包广告":[dic.data getString:@"UnreadVerifyTrue"],
                          @"审核中的红包广告":@"0",
                          @"审核失败的红包广告":[dic.data getString:@"UnreadVerifyFalse"],
                          @"已播完的红包广告":@"0"
                          } wrapper];
        NSLog(@"%@", [dic getDictionary:@"Data"]);
        [[NSUserDefaults standardUserDefaults] setValue:[dic.data getString:@"Remain"] forKey:@"TotalAdsNum"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [self.tableView reloadData];
    } else {
        
        [HUDUtil showErrorWithStatus:dic.operationMessage];
        return;
    }

}

#pragma mark - UITableViewDelegate/UITableViewDatasource
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *sectionView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 10)] autorelease];
    RRLineView *linebottom = WEAK_OBJECT(RRLineView, initWithFrame:CGRectMake(0, 10, 320, 0.5));
    RRLineView *lineTop = nil;
    if (section) {
        lineTop = WEAK_OBJECT(RRLineView, initWithFrame:CGRectMake(0, 0, 320, 0.5));
    }
    [sectionView addSubviews:linebottom, lineTop, nil];
    sectionView.backgroundColor = AppColorBackground;
    return sectionView;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _titles.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0 && indexPath.section == 1)
    {
        return 72;
    }
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_titles[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"Cell";
    AccurateManageCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"AccurateManageCell" owner:self options:nil] firstObject];
        cell.backgroundColor = [UIColor clearColor];
    }
    
    if (indexPath.row == 0 && indexPath.section == 1)
    {
        cell.lblAccView.hidden = NO;
        cell.lblAccAdsCount.text = [NSString stringWithFormat:@"%d条", [_dataDic getInt:@"Remain"]];
        cell.lblDJAdsCount.text = [NSString stringWithFormat:@"%d条", [_dataDic getInt:@"Frozen"]];
        cell.line2.top = 71.5;
        cell.userInteractionEnabled = NO;
    }
    else
    {
        
        NSString *title = [_titles[indexPath.section] objectAtIndex:indexPath.row];
        NSInteger num = [_dataDic getInt:title];
        if (num) {
            RRPointView *pointView = WEAK_OBJECT(RRPointView, initWithFrame:CGRectMake(270, 13, 18, 18) bgColor:nil textColor:nil fontSize:11 num:num);
            [cell.contentView addSubview:pointView];
        }
        cell.lblAccView.hidden = YES;
        cell.lblTitle.text = title;
        cell.line1.top = 49.5;
        if (indexPath.row == [_titles[indexPath.section] count] - 1) {
            cell.line1.hidden = YES;
        } else {
            cell.line1.hidden = NO;
        }

    }
        return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (!indexPath.section) {
        PUSH_VIEWCONTROLLER(WebhtmlViewController);
        model.navTitle = @"关于红包广告";
        model.ContentCode = @"f3298d1962e41e20e8c049bb7c5ad625";

    } else if (indexPath.section == 1 && indexPath.row == 1){
        PUSH_VIEWCONTROLLER(BuyAccurateAdsViewController);
    } else if (indexPath.section == 2) {
        if (indexPath.row) {
            DraftBoxViewController *draft = WEAK_OBJECT(DraftBoxViewController, init);
            draft.state = 0;
            [UI_MANAGER .mainNavigationController pushViewController:draft animated:YES];
        } else {
            PUSH_VIEWCONTROLLER(AddAccurateAdsViewController);
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"IsChanged"];
        }
    } else if (indexPath.section == 3) {
        DraftBoxViewController *draft = WEAK_OBJECT(DraftBoxViewController, init);
        draft.state = !indexPath.row ? 1 : (int)indexPath.row + 3;
        [UI_MANAGER .mainNavigationController pushViewController:draft animated:YES];
    } else if (indexPath.section == 4) {
        DraftBoxViewController *draft = WEAK_OBJECT(DraftBoxViewController, init);
        draft.state = 6;
        [UI_MANAGER .mainNavigationController pushViewController:draft animated:YES];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (UIView *)createTableFooterView{
    UIView *view = WEAK_OBJECT(UIView, initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 15));
    RRLineView *lineTop = WEAK_OBJECT(RRLineView, initWithFrame:CGRectMake(0, 0, 320, 0.5));
    view.backgroundColor = AppColorBackground;
    [view addSubview:lineTop];
    return view;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == _tableView)
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc {
    [_dataDic release];
    [_titles release];
    [_tableView release];
    [super dealloc];
}
@end
