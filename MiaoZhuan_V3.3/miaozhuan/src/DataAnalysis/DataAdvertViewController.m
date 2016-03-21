//
//  DataAdvertViewController.m
//  miaozhuan
//
//  Created by abyss on 14/11/10.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "DataAdvertViewController.h"
#import "MyDataViewController.h"
#import "DataAdvertTableViewCell.h"
#import "DataInformationViewController.h"
#import "MJRefreshController.h"
#import "AppPopView.h"

@interface DataAdvertViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    MJRefreshController *_MJRefreshCon;
    
    AppPopView *_popView;
    NSArray *_dataArray;
    
//    NSMutableArray *_netDataArray;
}
@property (retain, nonatomic) AppPopView *popView;
@property (retain, nonatomic) IBOutlet UILabel *onlyEndL;
@property (retain, nonatomic) IBOutlet UILabel *onlyPlayL;
@property (retain, nonatomic) IBOutlet UIButton *bt;
@property (retain, nonatomic) IBOutlet UIButton *bt_1;
@property (retain, nonatomic) IBOutlet UIButton *bt_2;
@end

@implementation DataAdvertViewController
@synthesize tableView = _tableView;

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _requestType = 0;
    [self initNav];
    [self initTableView];
    
    
//    _netDataArray = [NSMutableArray new];
    _noDataView.hidden = YES;
    _bt.bottom = SCREENHEIGHT - 8 - 64;
    // Do any additional setup after loading the view from its nib.
}

- (void)initNav
{
    _dataArray = @[
  @{@"nav":@"银元广告",@"text_1":@"播放次数",@"text_2":@"消耗银元"},
  @{@"nav":@"红包广告",@"text_1":@"预计投放",@"text_2":@"已到达量"}];
    [_dataArray retain];
    NSString *tmp = [_dataArray[self.type] objectForKey:@"nav"];
    NSString *nav = [NSString stringWithFormat:@"%@数据统计",tmp];
    if([nav isEqualToString:@"红包广告数据统计"]) nav = @"红包广告数据统计";
    InitNav(nav);
}

- (void)initTableView
{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
//    _tableView.panGestureRecognizer.delaysTouchesBegan = YES;
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    NSString * refreshName = self.type? @"api/VipEnterpriseAnalysis/DirectAdvertSnap":@"api/VipEnterpriseAnalysis/SilverAdvertSnap";
    
    _MJRefreshCon = [MJRefreshController controllerFrom:_tableView name:refreshName];
    
        __block DataAdvertViewController *weakself = self;
    
    [_MJRefreshCon setURLGenerator:MJREFRESH_URL_GENERATOR_BLOCK
     {
         if( weakself.requestType == 3) weakself.requestType = 0;
         NSDictionary * dic =@{@"PageIndex":@(pageIndex), @"PageSize":@(pageSize), @"type":@(weakself.requestType)};
         NSDictionary *pramaDic= @{@"service":refreshName,@"parameters":dic};
         return pramaDic.wrapper;

     }];
    
    {
        MJRefreshOnRequestDone block = MJREFRESH_ON_REQUEST_DONE
        {
            NSLog(@"%@",netData);
            if(controller.refreshCount == 0)
                weakself.noDataView.hidden = NO;
            else
                weakself.noDataView.hidden = YES;
        };
        
        [_MJRefreshCon setOnRequestDone:block];
        [_MJRefreshCon setPageSize:50];
        [_MJRefreshCon retain];
    }
    
    [self refreshTableView];
}

- (void) refreshTableView
{
    [_MJRefreshCon refreshWithLoading];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_MJRefreshCon release];
    [_tableView release];
    [_noDataView release];
    [_shaixuan release];
    [_bt release];
    [_onlyEndL release];
    [_onlyPlayL release];
    [_bt_1 release];
    [_bt_2 release];
    
    CRDEBUG_DEALLOC();
    [super dealloc];
}
- (void)viewDidUnload {
    [self setTableView:nil];
    [self setNoDataView:nil];
    [self setShaixuan:nil];
    [self setBt:nil];
    [self setOnlyEndL:nil];
    [self setOnlyPlayL:nil];
    [self setBt_1:nil];
    [self setBt_2:nil];
    [super viewDidUnload];
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    DataAdvertTableViewCell *cell = (DataAdvertTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.contentView.backgroundColor = AppColor(220);
    return YES;
}
- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    DataAdvertTableViewCell *cell = (DataAdvertTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor whiteColor];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DataAdvertTableViewCell *cell = (DataAdvertTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    PUSH_VIEWCONTROLLER(DataInformationViewController);
    model.type = self.type;
    model.advertID = cell.advertID;
#warning !
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 145;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _MJRefreshCon.refreshCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"DataAdvertTableViewCell";
    DataAdvertTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[NSBundle mainBundle] loadNibNamed:@"DataAdvertTableViewCell" owner:nil options:nil].lastObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.text_1.text = [_dataArray[self.type] objectForKey:@"text_1"];
        cell.text_2.text = [_dataArray[self.type] objectForKey:@"text_2"];
        [cell.advertImg setBorderWithColor:AppColor(197)];
    }
    
//    if (!_netDataArray || _netDataArray.count == 0) return cell;
//    DictionaryWrapper *data = [_netDataArray[indexPath.row] wrapper];
    DictionaryWrapper *data = [_MJRefreshCon dataAtIndex:(int)indexPath.row];
    
    cell.type = self.type==0 ? 0 : 1;
    
    [cell.advertImg requestCustom:[data getString:@"PictureUrl"] width:cell.advertImg.width height:cell.advertImg.height placeHolder:nil];
    cell.flagL.text = @"正在播放";
    cell.flagImg.backgroundColor = (![data getBool:@"State"])?AppColorRed:AppColorGray153;
    cell.flagL.text = (![data getBool:@"State"])?@"正在播放":self.type == 0?@"播放结束":@"已结束";
//    cell.advertName.text = [data getString:@"Name"];
//    CGSize size = [cell.advertName.text sizeWithFont:Font(15)];
    cell.name = [data getString:@"Name"];
    //zhi
    cell.playNum.text = !self.type?[data getString:@"Count"]:[data getString:@"Total"];
    cell.costNum.text = !self.type?[data getString:@"Silver"]:[data getString:@"CV"];
    cell.lblWatched.text = [data getString:@"ReadCount"];
    cell.advertID = !self.type?[data getInt:@"SilverAdvertId"]:[data getInt:@"DirectAdvertId"];
    return cell;
}

#pragma mark - touch
- (IBAction)bt:(id)sender
{
    if (!_popView)
    {
        __block DataAdvertViewController *weakSelf = self;
        _popView = [[AppPopView alloc] initWithAnimateUpOn:self frame:CGRectMake(0, 0, _shaixuan.width, _shaixuan.height) left:^{} right:^{
            [weakSelf.popView show:NO];
            [weakSelf refreshTableView];
        }];
        _popView.titleName = @"筛选";
        [_popView.contentView addSubview:_shaixuan];
    }
    [_popView show:YES];
    
    [_bt_1 setSelected:YES];
    [_bt_2 setSelected:YES];
    [self onlyEnd:_bt_1];
    [self onlyPlay:_bt_2];
    _requestType = 0;
    [self onlyEnd:_bt_1];
}

- (IBAction)onlyEnd:(UIButton *)sender
{
    
    [sender setSelected:!sender.selected];
//    [_bt_2 setSelected:NO];
//    _onlyPlayL.textColor = AppColorBlack43;
    
    if (sender.selected)
    {
        _requestType += 2;
        _onlyEndL.textColor = AppColorRed;
    }
    else
    {
        _requestType -= 2;
        _onlyEndL.textColor = AppColorBlack43;
    }
}

- (IBAction)onlyPlay:(UIButton *)sender
{
    [sender setSelected:!sender.selected];
//    [_bt_1 setSelected:NO];
//    _onlyEndL.textColor = AppColorBlack43;

    if (sender.selected)
    {
        _requestType += 1;
        _onlyPlayL.textColor = AppColorRed;
    }
    else
    {
        _requestType -= 0;
        _onlyPlayL.textColor = AppColorBlack43;
    }
}

@end
