//
//  RankListViewController.m
//  miaozhuan
//
//  Created by abyss on 14/10/21.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "RankListViewController.h"
#import "RankListCell.h"
#import "ScreeningListVC.h"

#import "JSONKit.h"

@interface RankListViewController () <UITableViewDataSource,UITableViewDelegate>
{
//    NSMutableDictionary *_objectDic;
    
    NSMutableArray *_sectionArray;
    NSMutableArray *_titleArray;
}
@end

CGSize sectionSize = {.height = 40, .width = 320};
CGSize categorySize = {.height = 90, .width = 160};
@implementation RankListViewController

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    InitNav(@"排行榜");

    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self setupMoveFowardButtonWithImage:@"rank-01.png" In:@"rank-01.png"];
    [self getData];
    // Do any additional setup after loading the view from its nib.
}

- (void)onMoveFoward:(UIButton *)sender
{
    if (!_sectionArray) return;
    PUSH_VIEWCONTROLLER(ScreeningListVC);
    model.dataListArr = _sectionArray;
    model.period = 1;
}

- (void)getData
{
    ADAPI_adv3_top([self genDelegatorID:@selector(HandleDataNotification:)]);
}



- (void)HandleDataNotification:(DelegatorArguments*)arguments
{
    [arguments logError];
    DictionaryWrapper *wrapper = arguments.ret;
    if (wrapper.operationSucceed)
    {
        NSString *json = [[wrapper  getDictionary:@"Data"] objectForKey:@"ContentText"];
        NSArray *dic = [[json dataUsingEncoding:NSUTF8StringEncoding] objectFromJSONData];
        
        if (!_sectionArray)
        {
            _sectionArray = [NSMutableArray new];
            _titleArray   = [NSMutableArray new];
        }
        for (NSDictionary *object in dic)
        {
            [_sectionArray addObject:[object valueForKey:@"Items"]];
            [_titleArray addObject:[object valueForKey:@"FieldName"]];
        }
        [self initTableView];
        [_tableView reloadData];
    }
    else
    {
        [HUDUtil showErrorWithStatus:wrapper.operationMessage];
        return;
    }
}

- (void)initTableView
{
    _tableView.delegate     = self;
    _tableView.dataSource   = self;
//    _tableView.panGestureRecognizer.delaysTouchesBegan = YES;
    _tableView.backgroundColor = RGBACOLOR(244, 244, 244, 1);
    _tableView.height += 2.f;
    
    UIView *view = WEAK_OBJECT(UIView, initWithFrame:CGRectMake(0, 0, 320, 10));
    view.backgroundColor = [UIColor clearColor];
    
    _tableView.tableFooterView = view;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)dealloc
{
    [_sectionArray release];
    [_titleArray release];
    [_tableView release];
    CRDEBUG_DEALLOC();
    [super dealloc];
}
- (void)viewDidUnload
{
    [self setTableView:nil];
    [super viewDidUnload];
}

#pragma mark - TableView delegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    static NSString *CellIdentifier = @"RankListCell";
    RankListCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[NSBundle mainBundle] loadNibNamed:@"RankListCell" owner:nil options:nil].lastObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
//    有数据
    if (_sectionArray.count != 0)
    {
        cell.data = _sectionArray;
        NSDictionary *leftDic = _sectionArray[indexPath.section][indexPath.row*2];
        DictionaryWrapper *dic = leftDic.wrapper;
        
        //左边
        cell.leftDic = dic;
        cell.leftTitle.text  = [dic getString:@"Name"];
        cell.leftText.text   = [dic getString:@"Description"];
        [cell.leftImg requestCustom:[dic getString:@"PictureUrl"] width:2*cell.leftImg.width height:2*cell.leftImg.height];
        cell.leftText.top = AppGetTextHeight(cell.leftTitle) + 2;
        cell.leftText.height = [UICommon getHeightFromLabel:cell.leftText].height;
        //右边
        for (int i = 0; i < _sectionArray.count; i ++)
        {
            //如果已经是最后一个！
            if(_sectionArray[indexPath.section][indexPath.row*2] == ((NSArray *)_sectionArray[indexPath.section]).lastObject)
            {
                cell.rightView.hidden = YES;
                cell.leftButton.tag = [dic getInteger:@"Type"];
                cell.last = YES;
                return cell;
            }
            else
            {
                NSDictionary *rightDic = _sectionArray[indexPath.section][indexPath.row*2 + 1];
                DictionaryWrapper *rdic = rightDic.wrapper;
                cell.rightDic = rdic;
                cell.rightTitle.text  = [rdic getString:@"Name"];
                cell.rightText.text   = [rdic getString:@"Description"];
                cell.rightButton.tag  = [rdic getInteger:@"Type"];
                [cell.rightImg requestCustom:[rdic getString:@"PictureUrl"] width:2*cell.rightImg.width height:2*cell.rightImg.height];
                cell.rightText.top = cell.leftText.top;
//                cell.rightText.height = [UICommon getHeightFromLabel:cell.rightText].height;
                cell.rightText.height = cell.leftText.height;
                NSLog(@"------------------------right %f",cell.rightTitle.height);
            }
                
        }
    }
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == _tableView)
    {
        CGFloat sectionHeaderHeight = sectionSize.height;
        if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
            scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
        } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
            scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
        }
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *label = [[[UILabel alloc] init] autorelease];
    label.frame = CGRectMake(15, 2, sectionSize.width, sectionSize.height);
    label.backgroundColor = [UIColor clearColor];
    label.textColor = RGBACOLOR(34, 34, 34, 1);
    label.font = BoldFont(15);
    label.text = _titleArray[section];
    
    UIView *sectionView = [[[UIView alloc] initWithFrame:CGRectMake(0, -1, sectionSize.width, sectionSize.height)] autorelease];
    UIImageView *line = WEAK_OBJECT(UIImageView, initWithFrame:CGRectMake(0, sectionSize.height - 0.5, 320, 0.5));
    line.backgroundColor = RGBACOLOR(220, 220, 220, 1);
    
    if(section != 0)
    {
    UIImageView *line1 = WEAK_OBJECT(UIImageView, initWithFrame:CGRectMake(0, 0, 320, 0.5));
    line1.backgroundColor = RGBACOLOR(220, 220, 220, 1);
    [sectionView addSubview:line1];
    }
    
    [sectionView addSubview:line];
    [sectionView addSubview:label];
    return sectionView;
}

// 标题高
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return sectionSize.height;
}
// CELL高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return categorySize.height;
}
// 榜单数目设定
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    APP_ASSERT(_sectionArray.count == 0);
    return (((NSArray *)[_sectionArray objectAtIndex:section]).count + 1)/2;
}
// 标题分区数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//    APP_ASSERT(_sectionArray.count == 0);
    NSLog(@"%d",_sectionArray.count);
    return _sectionArray.count;
}


@end
