//
//  CollectConsultViewController.m
//  miaozhuan
//
//  Created by apple on 14/11/12.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "CollectConsultViewController.h"
#import "CollectConsultTableViewCell.h"
#import "MJRefreshController.h"
#import "YFJLeftSwipeDeleteTableView.h"
#import "SelectionButton.h"
#import "RRNavBarDrawer.h"
#import "AppPopView.h"
#import "UIView+expanded.h"
#import "Redbutton.h"
#import "ConsultationDetailViewController.h"
#import "SetUpLableViewController.h"
#import "AppPopView.h"
#import "MarkView.h"

@interface CollectConsultViewController ()<UITableViewDataSource,UITableViewDelegate,RRNavBarDrawerDelegate>
{
    MJRefreshController *_MJRefreshCon;
    
    /** 是否已打开抽屉 */
    BOOL _isOpen;
    
    RRNavBarDrawer *navBarDrawer;
    
    CGFloat offsetY;
    
    //是否左移
    BOOL isLeft;
    
    NSString * _dressingType;
    
//    NSMutableArray * _contentArray;
    
    AppPopView *_appPopView;
    
    NSMutableArray * checkArray;
    
    CollectConsultTableViewCell *_cell;
    
    NSString * setlableName;
    
    BOOL _hasRefreshTable;
}
@property (retain, nonatomic) IBOutlet YFJLeftSwipeDeleteTableView *mainTableView;
@property (retain, nonatomic) IBOutlet SelectionButton *buxianBtn;
@property (retain, nonatomic) IBOutlet SelectionButton *comeFormAdvertBtn;
@property (retain, nonatomic) IBOutlet SelectionButton *comeFormMallBtn;
@property (retain, nonatomic) IBOutlet UIButton *startBtn;
@property (retain, nonatomic) IBOutlet UIButton *endBtn;
@property (retain, nonatomic) IBOutlet UILabel *startTimeLable;
@property (retain, nonatomic) IBOutlet UILabel *endTimeLable;
@property (retain, nonatomic) IBOutlet UIView *shaiXuanView;
@property (retain, nonatomic) IBOutlet UIView *showView;
@property (retain, nonatomic) IBOutlet UIButton *setUplableBtn;
@property (retain, nonatomic) IBOutlet Redbutton *deleateBtn;
@property (retain, nonatomic) IBOutlet UIView *nohaveConsultView;
@property (retain, nonatomic) IBOutlet UIButton *againShaiXuanBtn;
@property (retain, nonatomic) IBOutlet UIView *lineView;


@property (retain, nonatomic) NSString * dressingType;
//@property (retain, nonatomic) NSMutableArray * contentArray;


- (IBAction)touchUpInSideBtn:(id)sender;

@end

@implementation CollectConsultViewController

-(void)viewWillAppear:(BOOL)animated
{
    [self setLoad];
    
    if (_hasRefreshTable)
    [self refreshTableView];
}


MTA_viewDidAppear(_hasRefreshTable = YES;)
MTA_viewDidDisappear()
- (void)viewDidLoad
{
    [super viewDidLoad];
    InitNav(@"来自收藏的咨询");
    
    offsetY = [UICommon getIos4OffsetY];
    
     _dressingType = @"0";
    
    _lineView.frame = CGRectMake(0, 0, 320, 0.5);
    
    [self setTableviewLoad];
}

-(void) setLoad
{
    _mainTableView.frame = CGRectMake(0, 0, 320, [[UIScreen mainScreen] bounds].size.height - 64);
    
    _showView.frame = CGRectMake(0, [[UIScreen mainScreen] bounds].size.height-124, 320, 60);
    
    [_startBtn roundCornerBorder];
    
    [_endBtn roundCornerBorder];

    [_setUplableBtn roundCorner];
    
    _setUplableBtn.enabled = NO;
    
    _setUplableBtn.backgroundColor = RGBCOLOR(204,204,204);
    
    _deleateBtn.enabled = NO;
    
    _deleateBtn.backgroundColor = RGBCOLOR(204,204,204);
    
    [_deleateBtn roundCorner];
    
    [_againShaiXuanBtn roundCornerBorder];
    
    NSArray *array = @[@{@"normal":@"shaixuanconsult",@"hilighted":@"shaixuanconsulthover",@"title":@"筛选"},@{@"normal":@"banjiconsult",@"hilighted":@"banjiconsulthover",@"title":@"编辑"}];
    
    navBarDrawer = STRONG_OBJECT(RRNavBarDrawer, initWithView:self.view andInfoArray:array);
    
    navBarDrawer.delegate = self;
}

#pragma mark Consult

-(void) setConsult
{
    if (!_appPopView)
    {
        __block CollectConsultViewController *weakSelfs = self;
        
        _appPopView = [[AppPopView alloc] initWithAnimateUpOn:self frame:CGRectMake(0, 0, _shaiXuanView.width, _shaiXuanView.height) left:^{} right:^
        {
            [weakSelfs rightButtonTouched];
        }];
        
        [_appPopView.contentView addSubview:_shaiXuanView];
        _buxianBtn.selected = YES;
        
        _appPopView.titleName = @"筛选";
    }
    [_appPopView show:YES];
}

- (void)rightButtonTouched
{
    [_appPopView show:NO];
    
    [self refreshTableView];
}

#pragma mark - rrnavbardrawer delegate
- (void)didClickItem:(RRNavBarDrawer *)drawer atIndex:(NSInteger)index
{
    if (index == 0)
    {
        [self setConsult];
    }
    else
    {
        _mainTableView.frame = CGRectMake(0, 0, 320, [[UIScreen mainScreen] bounds].size.height - 124);
        
        isLeft = YES;
        
        [self refreshTableView];
        
        [self setupMoveBackButtonWithTitle:@"取消"];
    }
    [self onMoveFoward:nil];
}

#pragma mark onMove

- (IBAction) onMoveFoward:(UIButton*) sender{
    _isOpen = !_isOpen;
    if (!_isOpen) {
        [navBarDrawer openNavBarDrawer];
    } else {
        [navBarDrawer closeNavBarDrawer];
    }
}

- (IBAction) onMoveBack:(UIButton *)sender
{
    if (isLeft)
    {
        _mainTableView.frame = CGRectMake(0, 0, 320, [[UIScreen mainScreen] bounds].size.height - 64);
        
        isLeft = NO;
        
        [self refreshTableView];
        
        InitNav(@"收藏的咨询");
        
        [checkArray removeAllObjects];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - tableView delegate

- (void) setTableviewLoad
{
    [_mainTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    NSString * refreshName = @"EnterpriseCounsel/GetFavoriteCounselList";
    
    _MJRefreshCon = [MJRefreshController controllerFrom:_mainTableView name:refreshName];
    
    __block CollectConsultViewController * weakself = self;
    
    [_MJRefreshCon setURLGenerator:MJREFRESH_URL_GENERATOR_BLOCK
     {
         NSLog(@"-------%@",@{
                       @"service":[NSString stringWithFormat:@"api/%@",refreshName],
                       @"parameters":
                           @{@"CategoryId":weakself.dressingType,
                             @"PageIndex":@(pageIndex),
                             @"PageSize":@(pageSize)}}.wrapper);
         return @{
                  @"service":[NSString stringWithFormat:@"api/%@",refreshName],
                  @"parameters":
                      @{@"CategoryId":weakself.dressingType,
                        @"PageIndex":@(pageIndex),
                        @"PageSize":@(pageSize)}}.wrapper;
     }];
    
    {
        MJRefreshOnRequestDone block = MJREFRESH_ON_REQUEST_DONE
        {
            if (netData.operationSucceed)
            {
                if (controller.refreshCount == 0)
                {
                    [weakself.view addSubview:weakself.nohaveConsultView];
                    
                    [weakself setupMoveFowardButtonWithImage:@"" In:@""];
                    
                    if ([weakself.dressingType isEqualToString:@"0"])
                    {
                        weakself.againShaiXuanBtn.hidden = YES;
                    }
                }
                else
                {
                    [weakself.nohaveConsultView removeFromSuperview];
                    
                    [weakself setupMoveFowardButtonWithImage:@"more.png" In:@"morehover.png"];
                }
                
                _mainTableView.delegate = self;
                _mainTableView.dataSource = self;

            }
            else
            {
                NSLog(@"==========wrong");
                [HUDUtil showErrorWithStatus:netData.operationMessage];
            }
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int hight = 0;
    
    if ([[_MJRefreshCon dataAtIndex:(int)indexPath.row] getString:@"LabelName"] == nil || [[[_MJRefreshCon dataAtIndex:(int)indexPath.row] getString:@"LabelName"] isEqualToString:@""])
    {
        hight = 80;
    }
    else
    {
        hight =100;
    }
    return hight;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _MJRefreshCon.refreshCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CollectConsultTableViewCell";
    
    CollectConsultTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[NSBundle mainBundle] loadNibNamed:@"CollectConsultTableViewCell" owner:nil options:nil].lastObject;
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.layer.masksToBounds = YES;
    }
    
    if ([[_MJRefreshCon dataAtIndex:(int)indexPath.row] getString:@"LabelName"] == nil || [[[_MJRefreshCon dataAtIndex:(int)indexPath.row] getString:@"LabelName"] isEqualToString:@""])
    {
        cell.cellLInes.left = 25;
        cell.cellLInes.top = 79.5;
        
        cell.mark.hidden = YES;
    }
    else
    {
        RRLineView * line = [[RRLineView alloc] initWithFrame:CGRectMake(25, 99.5, 320, 0.5)];
        [cell.contentView addSubview:line];
        
        cell.cellLInes.hidden = YES;
        
//        cell.cellLInes.left = 25;
//        cell.cellLInes.top = 99;
        
        [cell.mark smallMark:[UIImage imageNamed:@"lableImagetwo"] content:[[_MJRefreshCon dataAtIndex:(int)indexPath.row] getString:@"LabelName"]];
    }
    
    cell.imageFlag = isLeft;
    
    cell.titleCell.text = [[_MJRefreshCon dataAtIndex:(int)indexPath.row] getString:@"CustomerName"];
    
    cell.contentCell.text = [[_MJRefreshCon dataAtIndex:(int)indexPath.row] getString:@"Content"];
    
    NSDate *today = [NSDate date];
    
    NSDate *yesterday =[NSDate dateWithTimeIntervalSinceNow:-(24*60*60)];
    
    NSDateFormatter *formatter = [[NSDateFormatter  alloc ]  init ];
    
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString *todayTime = [formatter stringFromDate:today];
    NSString *yesterdayTime = [formatter stringFromDate:yesterday];
    
    NSString * time = [[_MJRefreshCon dataAtIndex:(int)indexPath.row] getString:@"FavoriteTime"];
    
    NSString * celldodaytime = [UICommon formatDate:time];
    
    if ([celldodaytime isEqualToString:todayTime])
    {
//        time = [UICommon formatDate:time withRange:NSMakeRange(11, 5)];
//        
//        cell.dataCell.text = time;
        cell.dataCell.text = @"今天";
    }
    else if ([celldodaytime isEqualToString:yesterdayTime])
    {
        cell.dataCell.text = @"昨天";
    }
    else
    {
        cell.dataCell.text = celldodaytime;
    }
    
    [formatter release];
    
    NSString * type = [[_MJRefreshCon dataAtIndex:(int)indexPath.row] getString:@"Type"];
    
    if ([type isEqualToString:@"1"])
    {
        cell.logoImageCell.image = [UIImage imageNamed:@"yinyuanMallconsult"];
    }
    else if ([type isEqualToString:@"2"])
    {
        cell.logoImageCell.image = [UIImage imageNamed:@"moneyconsult"];
    }
    else if ([type isEqualToString:@"3"])
    {
        cell.logoImageCell.image = [UIImage imageNamed:@"jingjiaconsult.png"];
    }
    else if ([type isEqualToString:@"4"])
    {
        cell.logoImageCell.image = [UIImage imageNamed:@"yinyuanMallconsult"];
    }
    else if ([type isEqualToString:@"5"])
    {
        cell.logoImageCell.image = [UIImage imageNamed:@"jinbimallconsult.png"];
    }
    else
    {
        cell.logoImageCell.image = [UIImage imageNamed:@"zhigoumallconsult"];
    }
    

    if (!checkArray && checkArray.count == 0) return cell;
    
    NSString* temp = [[_MJRefreshCon dataAtIndex:(int)indexPath.row] getString:@"CounselId"];
    
    for (NSString* str in checkArray)
    {
        if ([temp isEqualToString:str])
            cell.checkFlag = YES;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CollectConsultTableViewCell *cell = (CollectConsultTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
    if (isLeft)
    {
        if (!checkArray)
        {
            checkArray = [[NSMutableArray alloc] init];
        }
        
        if (cell.checkFlag)
        {
            cell.checkFlag = NO;
            
            [checkArray removeObject:[[_MJRefreshCon dataAtIndex:(int)indexPath.row] getString:@"CounselId"]];
            
            if (checkArray.count == 0)
            {
                _setUplableBtn.enabled = NO;
                
                _setUplableBtn.backgroundColor = RGBCOLOR(204,204,204);
                
                _deleateBtn.enabled = NO;
                
                _deleateBtn.backgroundColor = RGBCOLOR(204,204,204);
            }
            
        }else
        {
            cell.checkFlag = YES;
            
            [checkArray addObject:[[_MJRefreshCon dataAtIndex:(int)indexPath.row] getString:@"CounselId"]];
            
            _setUplableBtn.enabled = YES;
            
            _setUplableBtn.backgroundColor = RGBCOLOR(255,132,0);
            
            _deleateBtn.enabled = YES;
            
            _deleateBtn.backgroundColor = RGBCOLOR(240,5,0);
        }
        
        setlableName = [[_MJRefreshCon dataAtIndex:(int)indexPath.row] getString:@"LabelName"];
    }
    else
    {
        PUSH_VIEWCONTROLLER(ConsultationDetailViewController);
        model.consultId = [[_MJRefreshCon dataAtIndex:(int)indexPath.row] getString:@"CounselId"];
    }
    
//    NSLog(@"---%@",setlableName);
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    CollectConsultTableViewCell *cell = (CollectConsultTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.contentView.backgroundColor = AppColor(220);
    return YES;
}

- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    CollectConsultTableViewCell *cell = (CollectConsultTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor whiteColor];
}


#pragma mark BtnTouchUpInside

- (IBAction)touchUpInSideBtn:(id)sender
{
    if (sender == _buxianBtn)
    {
        _buxianBtn.selected = YES;
        _comeFormAdvertBtn.selected = NO;
        _comeFormMallBtn.selected = NO;
        _dressingType = @"0";
    }
    else if (sender == _comeFormAdvertBtn)
    {
        _buxianBtn.selected = NO;
        _comeFormAdvertBtn.selected = YES;
        _comeFormMallBtn.selected = NO;
        _dressingType = @"1";
    }
    else if (sender == _comeFormMallBtn)
    {
        _buxianBtn.selected = NO;
        _comeFormAdvertBtn.selected = NO;
        _comeFormMallBtn.selected = YES;
        _dressingType = @"2";
    }
    else if (sender == _againShaiXuanBtn)
    {
        [self setConsult];
    }
    else if (sender == _setUplableBtn)
    {
        if (checkArray.count == 0)
        {
            [AlertUtil showAlert:@"" message:@"请选择您要设置标签的咨询！" buttons:@[@"好的"]];
        }
        else
        {
            PUSH_VIEWCONTROLLER(SetUpLableViewController);
            model.CounselIds = checkArray;
            
            if (checkArray.count > 1)
            {
                model.LableName = @"";
            }
            else
            {
                model.LableName = setlableName;
            }
            
            
            _mainTableView.frame = CGRectMake(0, 0, 320, [[UIScreen mainScreen] bounds].size.height -64);
            
            isLeft = NO;
            
            InitNav(@"来自收藏的咨询");

            [self refreshTableView];
            
            [checkArray removeAllObjects];
        }
    }
    else if (sender == _deleateBtn)
    {
        if (checkArray.count == 0)
        {
            [AlertUtil showAlert:@"" message:@"请选择您要删除的咨询！" buttons:@[@"好的"]];
        }
        else
        {
            ADAPI_adv3_CancelFavorite([self genDelegatorID:@selector(HandleNotification:)], checkArray);
        }
    }
}


- (void)HandleNotification:(DelegatorArguments *)arguments
{
    if ([arguments isEqualToOperation:ADOP_adv3_CancelFavorite])
    {
        [arguments logError];
        
        DictionaryWrapper *wrapper = arguments.ret;
        
        if (wrapper.operationSucceed)
        {
            _mainTableView.frame = CGRectMake(0, 0, 320, [[UIScreen mainScreen] bounds].size.height -64);
            
            isLeft = NO;
            
            InitNav(@"来自收藏的咨询");
            
            [self refreshTableView];
            
            [HUDUtil showSuccessWithStatus:wrapper.operationMessage];
        }
        else
        {
            [HUDUtil showErrorWithStatus:wrapper.operationMessage];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
    [checkArray release];
    
    checkArray = nil;
    
    [_appPopView release];
    
    _appPopView = nil;
    
    [_MJRefreshCon release];
    
    [_mainTableView release];
    [_buxianBtn release];
    [_comeFormAdvertBtn release];
    [_comeFormMallBtn release];
    [_startBtn release];
    [_endBtn release];
    [_startTimeLable release];
    [_endTimeLable release];
    [_shaiXuanView release];
    [_showView release];
    [_setUplableBtn release];
    [_deleateBtn release];
    [_nohaveConsultView release];
    [_againShaiXuanBtn release];
    [_lineView release];
    [super dealloc];
}

- (void)viewDidUnload
{
    [self setMainTableView:nil];
    [self setBuxianBtn:nil];
    [self setComeFormAdvertBtn:nil];
    [self setComeFormMallBtn:nil];
    [self setStartBtn:nil];
    [self setEndBtn:nil];
    [self setStartTimeLable:nil];
    [self setEndTimeLable:nil];
    [self setShaiXuanView:nil];
    [super viewDidUnload];
}

@end
