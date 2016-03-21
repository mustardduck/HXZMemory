//
//  ComeFormAdvertViewController.m
//  miaozhuan
//
//  Created by apple on 14/11/6.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "ComeFormAdvertViewController.h"
#import "ComeFormAdvertTableViewCell.h"
#import "MJRefreshController.h"
#import "YFJLeftSwipeDeleteTableView.h"
#import "ConsultationDetailViewController.h"
#import "SelectionButton.h"
#import "UIView+expanded.h"
#import "CRDateCounter.h"
#import "AppPopView.h"

@interface ComeFormAdvertViewController ()
<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray * _contentArray;
    
    MJRefreshController *_MJRefreshCon;
    
    DatePickerViewController *datePickerView;
    
    CGFloat offsetY;
    
    NSString * _dressingType;
    
    AppPopView *_appPopView;
    
    BOOL _hasRefreshTable;
}

@property (retain, nonatomic) IBOutlet YFJLeftSwipeDeleteTableView *comeFormAdvertTableView;
@property (retain, nonatomic) IBOutlet SelectionButton *buxianBtn;
@property (retain, nonatomic) IBOutlet SelectionButton *yinyuanBtn;
@property (retain, nonatomic) IBOutlet SelectionButton *hongbaoBtn;
@property (retain, nonatomic) IBOutlet SelectionButton *jingjiaBtn;
@property (retain, nonatomic) IBOutlet UILabel *strarTimeLable;
@property (retain, nonatomic) IBOutlet UILabel *endTimeLable;
@property (retain, nonatomic) IBOutlet UIButton *strartBtn;
@property (retain, nonatomic) IBOutlet UIButton *endBtn;
@property (retain, nonatomic) IBOutlet UIView *shaixuanView;

@property (retain, nonatomic) IBOutlet UIView *mallShaiXuanView;
@property (retain, nonatomic) IBOutlet SelectionButton *mallBuXianBtn;
@property (retain, nonatomic) IBOutlet SelectionButton *mallYinYuanBtn;
@property (retain, nonatomic) IBOutlet SelectionButton *mallJInBiBtn;
@property (retain, nonatomic) IBOutlet SelectionButton *mallZhiGouBtn;
@property (retain, nonatomic) IBOutlet UIButton *mallStratTimeBtn;
@property (retain, nonatomic) IBOutlet UIButton *mallEndTimeBtn;
@property (retain, nonatomic) IBOutlet UILabel *mallStrartTimeLable;
@property (retain, nonatomic) IBOutlet UILabel *mallEndTimeLable;
@property (retain, nonatomic) IBOutlet UIView *aginShaiXuanView;
@property (retain, nonatomic) IBOutlet UILabel *aginShaiXuanLable;
@property (retain, nonatomic) IBOutlet UIButton *aginShaiXuanBtn;
@property (retain, nonatomic) IBOutlet UILabel *aginShaiXuanBtnLable;

- (IBAction)touchUpInsideBtn:(id)sender;

- (IBAction)mallTouchUpInsideBtn:(id)sender;

- (IBAction)touchUpShaiXuanBtn:(id)sender;

@property(retain, nonatomic) NSString * dressingType;

@property(retain, nonatomic) NSMutableArray * contentArray;

@end

@implementation ComeFormAdvertViewController

@synthesize comeFormAdvertTableView = _comeFormAdvertTableView;

@synthesize buxianBtn = _buxianBtn;
@synthesize yinyuanBtn = _yinyuanBtn;
@synthesize hongbaoBtn = _hongbaoBtn;
@synthesize jingjiaBtn = _jingjiaBtn;
@synthesize strarTimeLable = _strarTimeLable;
@synthesize endTimeLable = _endTimeLable;
@synthesize strartBtn = _strartBtn;
@synthesize endBtn = _endBtn;
@synthesize shaixuanView = _shaixuanView;

@synthesize mallShaiXuanView = _mallShaiXuanView;
@synthesize mallBuXianBtn = _mallBuXianBtn;
@synthesize mallYinYuanBtn = _mallYinYuanBtn;
@synthesize mallJInBiBtn = _mallJInBiBtn;
@synthesize mallZhiGouBtn = _mallZhiGouBtn;
@synthesize mallEndTimeBtn = _mallEndTimeBtn;
@synthesize mallEndTimeLable = _mallEndTimeLable;
@synthesize mallStrartTimeLable = _mallStrartTimeLable;
@synthesize mallStratTimeBtn = _mallStratTimeBtn;
@synthesize aginShaiXuanView = _aginShaiXuanView;
@synthesize aginShaiXuanBtn = _aginShaiXuanBtn;
@synthesize aginShaiXuanLable = _aginShaiXuanLable;

@synthesize dressingType = _dressingType;
@synthesize contentArray = _contentArray;


-(void)viewWillAppear:(BOOL)animated
{
    _comeFormAdvertTableView.frame = CGRectMake(0, 0, 320, [[UIScreen mainScreen] bounds].size.height - 64);
    
    if (_hasRefreshTable)
        [self refreshTableView];
}

//- (void)viewDidAppear:(BOOL)animated
//{
//    _hasRefreshTable = YES;
//}


MTA_viewDidAppear(_hasRefreshTable = YES;)
MTA_viewDidDisappear()
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if ([_type isEqualToString:@"1"])
    {
        InitNav(@"来自广告的咨询");
        _aginShaiXuanLable.text = @"暂无来自广告的咨询";
    }
    else
    {
        InitNav(@"来自商城的咨询");
        _aginShaiXuanLable.text = @"暂无来自商城的咨询";
    }
    
    _dressingType = @"0";
    
    [self setTableviewLoad];
    
    [self setupMoveFowardButtonWithTitle:@"筛选"];
    
    [self setRound];
    
    offsetY = [UICommon getIos4OffsetY];
}

-(void) setRound
{
    [_strartBtn roundCornerBorder];
    
    [_endBtn roundCornerBorder];
    
    [_mallStratTimeBtn roundCornerBorder];
    
    [_mallEndTimeBtn roundCornerBorder];
    
    [_aginShaiXuanBtn roundCornerBorder];
}

//筛选
- (void)onMoveFoward:(UIButton *)sender
{
    [self setConsult];
}

#pragma mark Consult

-(void) setConsult
{
    if (!_appPopView)
    {
        __block ComeFormAdvertViewController *weakSelf = self;
        
        if ([_type isEqualToString:@"1"]) {
            _appPopView = [[AppPopView alloc] initWithAnimateUpOn:self frame:CGRectMake(0, 0, _shaixuanView.width, _shaixuanView.height) left:^{} right:^{
                [weakSelf rightButtonTouched];
            }];
            [_appPopView.contentView addSubview:_shaixuanView];
            _buxianBtn.selected = YES;
        }
        else
        {
            _appPopView = [[AppPopView alloc] initWithAnimateUpOn:self frame:CGRectMake(0, 0, _mallShaiXuanView.width, _mallShaiXuanView.height) left:^{} right:^{
                [weakSelf rightButtonTouched];
            }];
            [_appPopView.contentView addSubview:_mallShaiXuanView];
            _mallBuXianBtn.selected = YES;
        }
        
        _appPopView.titleName = @"筛选";
    }
    [_appPopView show:YES];
    
}

- (void)rightButtonTouched
{
    [_appPopView show:NO];
  
    [self refreshTableView];
}


#pragma mark - tableView delegate

- (void) setTableviewLoad
{
    [_comeFormAdvertTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    NSString * refreshName = @"EnterpriseCounsel/GetAdvertCounselList";
    
    NSString * refreshNameMall = @"EnterpriseCounsel/GetProductCounselList";
    
    __block ComeFormAdvertViewController * weakself = self;
    
    if ([_type isEqualToString:@"1"])
    {
        _MJRefreshCon = [MJRefreshController controllerFrom:_comeFormAdvertTableView name:refreshName];
        
        [_MJRefreshCon setURLGenerator:MJREFRESH_URL_GENERATOR_BLOCK
         {
             return @{
                      @"service":[NSString stringWithFormat:@"api/%@",refreshName],
                      @"parameters":
                          @{@"Type":weakself.dressingType,
                            @"StartTime":weakself.strarTimeLable.text,
                            @"EndTime":weakself.endTimeLable.text,
                            @"PageIndex":@(pageIndex),
                            @"PageSize":@(pageSize)}}.wrapper;
         }];
    }
    else
    {
        _MJRefreshCon = [MJRefreshController controllerFrom:_comeFormAdvertTableView name:refreshNameMall];
        
        [_MJRefreshCon setURLGenerator:MJREFRESH_URL_GENERATOR_BLOCK
         {
             return @{
                      @"service":[NSString stringWithFormat:@"api/%@",refreshNameMall],
                      @"parameters":
                          @{@"Type":weakself.dressingType,
                            @"StartTime":weakself.mallStrartTimeLable.text,
                            @"EndTime":weakself.mallEndTimeLable.text,
                            @"PageIndex":@(pageIndex),
                            @"PageSize":@(pageSize)}}.wrapper;
         }];
    }
    
    {
        MJRefreshOnRequestDone block = MJREFRESH_ON_REQUEST_DONE
        {
            NSArray *array = [[CRDateCounter shareInstance] dateCount:controller.refreshData forKey:@"CounselTime"];
            
            if (!weakself.contentArray)
            {
                weakself.contentArray = [NSMutableArray new];
            }
            [weakself.contentArray removeAllObjects];
            
            weakself.contentArray = [NSMutableArray arrayWithArray:array];

            if (weakself.contentArray.count == 0)
            {
                [weakself.view addSubview:weakself.aginShaiXuanView];
                
                [weakself setupMoveFowardButtonWithTitle:@""];
                
                if ([weakself.type isEqualToString:@"1"])
                {
                    if ([weakself.dressingType isEqualToString:@"0"])
                    {
                        if ([weakself.strarTimeLable.text isEqualToString:@"选择开始时间"] && [weakself.endTimeLable.text isEqualToString:@"选择结束时间"])
                        {
                            weakself.aginShaiXuanBtn.hidden = YES;
                            weakself.aginShaiXuanBtnLable.hidden = YES;
                        }
                    }
                }
                else
                {
                    if ([weakself.dressingType isEqualToString:@"0"])
                    {
                        if ([weakself.mallStrartTimeLable.text isEqualToString:@"选择开始时间"] && [weakself.mallEndTimeLable.text isEqualToString:@"选择结束时间"])
                        {
                            weakself.aginShaiXuanBtn.hidden = YES;
                            weakself.aginShaiXuanBtnLable.hidden = YES;
                        }
                    }
                }
            }
            else
            {
                [weakself.aginShaiXuanView removeFromSuperview];
                
                [weakself setupMoveFowardButtonWithTitle:@"筛选"];
            }
            
            _comeFormAdvertTableView.delegate = self;
            
            _comeFormAdvertTableView.dataSource = self;
            
            [weakself.comeFormAdvertTableView reloadData];
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _contentArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 23;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *label = [[[UILabel alloc] init] autorelease];
    
    label.frame = CGRectMake(15, 0, 290, 23);
    
    label.backgroundColor = [UIColor clearColor];
    
    label.textColor = RGBACOLOR(153, 153, 153, 1);
    
    label.font = [UIFont systemFontOfSize:12];
    
    label.text = [[_contentArray[section][0] wrapper] getString:@"Date"];
    
    UIView *sectionView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 23)] autorelease];

    sectionView.backgroundColor = RGBCOLOR(247, 247, 247);
    
    [sectionView addSubview:label];
    
    return sectionView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return ((NSArray *)_contentArray[section]).count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ComeFormAdvertTableViewCell";
    
    ComeFormAdvertTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[NSBundle mainBundle] loadNibNamed:@"ComeFormAdvertTableViewCell" owner:nil options:nil].lastObject;
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.layer.masksToBounds = YES;
    }
    
    if ([_contentArray[indexPath.section] count] == indexPath.row + 1)
    {
        cell.cellLines.left = 0;
    }
    
    cell.cellLines.top = 79.5;
    
    DictionaryWrapper *dic = [[_contentArray[indexPath.section][indexPath.row] wrapper] getDictionaryWrapper:@"Data"];
    
    if (![dic getBool:@"IsUnread"])
    {
        cell.redVIew.hidden = YES;
    }
    
    cell.cellTitles.text = [dic getString:@"CustomerName"];
    
    cell.cellContent.text = [dic getString:@"Content"];
    
    NSString * times = [dic getString:@"CounselTime"];
    
    times = [UICommon formatDate:times withRange:NSMakeRange(11, 5)];
    
    cell.cellTimes.text = times;
    
    if ([dic getInt:@"Type"] == 1)
    {
        cell.cellImages.image = [UIImage imageNamed:@"yinyuanMallconsult"];
    }
    else if ([dic getInt:@"Type"] == 2)
    {
        cell.cellImages.image = [UIImage imageNamed:@"moneyconsult"];
    }
    else if ([dic getInt:@"Type"] == 3)
    {
        cell.cellImages.image = [UIImage imageNamed:@"jingjiaconsult.png"];
    }
    else if ([dic getInt:@"Type"] == 4)
    {
        cell.cellImages.image = [UIImage imageNamed:@"yinyuanMallconsult"];
    }
    else if ([dic getInt:@"Type"] == 5)
    {
        cell.cellImages.image = [UIImage imageNamed:@"jinbimallconsult.png"];
    }
    else
    {
        cell.cellImages.image = [UIImage imageNamed:@"zhigoumallconsult"];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PUSH_VIEWCONTROLLER(ConsultationDetailViewController);
    DictionaryWrapper *dic = [[_contentArray[indexPath.section][indexPath.row] wrapper] getDictionaryWrapper:@"Data"];
    
    model.consultId = [dic getString:@"CounselId"];
}


- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    ComeFormAdvertTableViewCell *cell = (ComeFormAdvertTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    
    cell.contentView.backgroundColor = AppColor(220);
    
    return YES;
}

- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    ComeFormAdvertTableViewCell *cell = (ComeFormAdvertTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    
    cell.contentView.backgroundColor = [UIColor whiteColor];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == _comeFormAdvertTableView)
    {
        CGFloat sectionHeaderHeight = 23;
        
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

#pragma mark TableViewDelete

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        
        DictionaryWrapper *dic = [[_contentArray[indexPath.section][indexPath.row] wrapper] getDictionaryWrapper:@"Data"];
        
        NSString * CounselId = [dic getString:@"CounselId"];
        NSString * Type = [dic getString:@"Type"];
        
        ADAPI_adv3_DeleteCounsel([self genDelegatorID:@selector(HandleNotification:)], CounselId, Type);
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert)
    {
        
    }
}


#pragma mark HandleNotification

- (void)HandleNotification:(DelegatorArguments *)arguments
{
    if ([arguments isEqualToOperation:ADOP_adv3_DeleteCounsel])
    {
        [arguments logError];
        
        DictionaryWrapper *wrapper = arguments.ret;
        
        if (wrapper.operationSucceed)
        {
            [self refreshTableView];
            
            [HUDUtil showSuccessWithStatus:wrapper.operationMessage];
        }
        else
        {
            [HUDUtil showErrorWithStatus:wrapper.operationMessage];
        }
    }
}


#pragma  mark BtnTouchUpInside

- (IBAction)touchUpInsideBtn:(id)sender
{
    if (sender == _buxianBtn)
    {
        _buxianBtn.selected = YES;
        _yinyuanBtn.selected = NO;
        _hongbaoBtn.selected = NO;
        _jingjiaBtn.selected = NO;
        
        _dressingType = @"0";
    }
    else if (sender == _yinyuanBtn)
    {
        _buxianBtn.selected = NO;
        _yinyuanBtn.selected = YES;
        _hongbaoBtn.selected = NO;
        _jingjiaBtn.selected = NO;
        
        _dressingType = @"1";
    }
    else if (sender == _hongbaoBtn)
    {
        _buxianBtn.selected = NO;
        _yinyuanBtn.selected = NO;
        _hongbaoBtn.selected = YES;
        _jingjiaBtn.selected = NO;
        
        _dressingType = @"2";
    }
    else if (sender == _jingjiaBtn)
    {
        _buxianBtn.selected = NO;
        _yinyuanBtn.selected = NO;
        _hongbaoBtn.selected = NO;
        _jingjiaBtn.selected = YES;
        
        _dressingType = @"3";
    }
    else if (sender == _strartBtn)
    {
        [self setDatePickerView];
        
        datePickerView.picker.date = [NSDate date];
        
        datePickerView.view.tag = 100;
        
        [datePickerView initwithtitles:2];
        
        [APP_DELEGATE.window addSubview:datePickerView.view];
    }
    else if (sender == _endBtn)
    {
        [self setDatePickerView];
        
        datePickerView.picker.date = [NSDate date];
        
        datePickerView.view.tag = 200;
        
        [datePickerView initwithtitles:3];
        
        [APP_DELEGATE.window addSubview:datePickerView.view];
    }
}

- (IBAction)mallTouchUpInsideBtn:(id)sender
{
    if (sender == _mallBuXianBtn)
    {
        _mallBuXianBtn.selected = YES;
        _mallYinYuanBtn.selected = NO;
        _mallJInBiBtn.selected = NO;
        _mallZhiGouBtn.selected = NO;
        
        _dressingType = @"0";
    }
    else if (sender == _mallYinYuanBtn)
    {
        _mallBuXianBtn.selected = NO;
        _mallYinYuanBtn.selected = YES;
        _mallJInBiBtn.selected = NO;
        _mallZhiGouBtn.selected = NO;
        _dressingType = @"4";
    }
    else if (sender == _mallJInBiBtn)
    {
        _mallBuXianBtn.selected = NO;
        _mallYinYuanBtn.selected = NO;
        _mallJInBiBtn.selected = YES;
        _mallZhiGouBtn.selected = NO;
        
        _dressingType = @"5";
    }
    else if (sender == _mallZhiGouBtn)
    {
        _mallBuXianBtn.selected = NO;
        _mallYinYuanBtn.selected = NO;
        _mallJInBiBtn.selected = NO;
        _mallZhiGouBtn.selected = YES;
        
        _dressingType = @"6";
    }
    else if (sender == _mallStratTimeBtn)
    {
        [self setDatePickerView];
        
        datePickerView.picker.date = [NSDate date];
        
        datePickerView.view.tag = 300;
        
        [datePickerView initwithtitles:2];
        
        [APP_DELEGATE.window addSubview:datePickerView.view];
    }
    else if (sender == _mallEndTimeBtn)
    {
        [self setDatePickerView];
        
        datePickerView.picker.date = [NSDate date];
        
        datePickerView.view.tag = 400;
        
        [datePickerView initwithtitles:3];
        
        [APP_DELEGATE.window addSubview:datePickerView.view];
    }
}

- (IBAction)touchUpShaiXuanBtn:(id)sender
{
    [self setConsult];
}

#pragma mark UIPickerView

-(void) setDatePickerView
{
    datePickerView = [[DatePickerViewController alloc]initWithNibName:@"DatePickerViewController" bundle:nil];

    datePickerView.view.frame = CGRectMake(0, 0, 320, 460 + offsetY);
    
    datePickerView.delegate = self;
}

- (void) selectDateCallBack:(NSDate*)date
{
    [datePickerView.view removeFromSuperview];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    
    NSString* text = [dateFormatter stringFromDate:date];
    
    if (datePickerView.view.tag == 100)
    {
        _strarTimeLable.text = text;
        _strarTimeLable.textColor = RGBCOLORFLOAT(34);
    }
    else if (datePickerView.view.tag == 200)
    {
        _endTimeLable.text = text;
        _endTimeLable.textColor = RGBCOLORFLOAT(34);
    }
    else if (datePickerView.view.tag == 300)
    {
        _mallStrartTimeLable.text = text;
        _mallStrartTimeLable.textColor = RGBCOLORFLOAT(34);
    }
    else if (datePickerView.view.tag == 400)
    {
        _mallEndTimeLable.text = text;
        _mallEndTimeLable.textColor = RGBCOLORFLOAT(34);
    }
    
    [dateFormatter release];
    
    dateFormatter = nil;
}

- (void) cancelDateCallBack:(NSDate*)date
{
    [datePickerView.view removeFromSuperview];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
    [_comeFormAdvertTableView release];

    [_contentArray release];
    
    _contentArray = nil;
    
    [_MJRefreshCon release];
    
    [datePickerView release];
    
    datePickerView = nil;
    
    [_appPopView release];
    
    [_buxianBtn release];
    [_yinyuanBtn release];
    [_hongbaoBtn release];
    [_jingjiaBtn release];
    [_strarTimeLable release];
    [_endTimeLable release];
    [_strartBtn release];
    [_endBtn release];
    [_shaixuanView release];
    
    [_mallShaiXuanView release];
    [_mallBuXianBtn release];
    [_mallYinYuanBtn release];
    [_mallJInBiBtn release];
    [_mallZhiGouBtn release];
    [_mallStratTimeBtn release];
    [_mallEndTimeBtn release];
    [_mallStrartTimeLable release];
    [_mallEndTimeLable release];
    [_aginShaiXuanView release];
    [_aginShaiXuanLable release];
    [_aginShaiXuanBtn release];
    [_aginShaiXuanBtnLable release];
    [super dealloc];
}

- (void)viewDidUnload
{
    [self setComeFormAdvertTableView:nil];
    
    [self setBuxianBtn:nil];
    [self setYinyuanBtn:nil];
    [self setHongbaoBtn:nil];
    [self setJingjiaBtn:nil];
    [self setStrarTimeLable:nil];
    [self setEndTimeLable:nil];
    [self setStrartBtn:nil];
    [self setEndBtn:nil];
    [self setShaixuanView:nil];
    [super viewDidUnload];
}

@end
