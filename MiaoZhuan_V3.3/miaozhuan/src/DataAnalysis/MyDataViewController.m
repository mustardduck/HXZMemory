//
//  MyDataViewController.m
//  miaozhuan
//
//  Created by abyss on 14/11/8.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "MyDataViewController.h"
#import "LineChart.h"
#import "LCLineChartView.h"
#import "Addtion+LinaChart.h"
#import "BarDataTableViewCell.h"
#import "KDGoalBar.h"
#import "CRFlatButton.h"
#import "ControlViewController.h"
#import "KxMenu.h"

#import "DataAnalysis.h"

@class LCLineChartView;
@interface MyDataViewController ()<UITableViewDataSource,UITableViewDelegate,KxMenuDelegate,UIScrollViewDelegate>
@property (retain, nonatomic) IBOutlet UIView *vv2;
@property (retain, nonatomic) IBOutlet UIView *vv1;
@property (retain, nonatomic) IBOutlet KDGoalBar *roundBar;
@property (retain, nonatomic) IBOutlet UIView *tableHeader;
@property (retain, nonatomic) IBOutlet CRFlatButton *flatSementControl;

@property (retain, nonatomic) IBOutlet UIButton *eyeBt;
@property (retain, nonatomic) IBOutlet UIView *boxView;
@end

@implementation MyDataViewController
{
    LineChartView *chartView;
    
    LCLineChartData *d;
    LCLineChartData *s;
    
    NSMutableArray *chartData;
    NSMutableArray *_timeLabelArray;
    
    NSArray *titleArray;
    
    NSArray *_tableNetData;
    NSArray *_PVNetData;
    NSArray *_CVNetData;
}

- (void)viewWillAppear:(BOOL)animated
{
    ADAPI_adv3_MyBusinessSnap([self genDelegatorID:@selector(dataAnalysisSnap:)]);
}

- (void) onMoveFoward:(UIButton *)sender
{
    // show menu
    if(![KxMenu isOpen])
    {
        NSArray *menuItems =
        @[
          
          [KxMenuItem menuItem:@"首页"
                         image:[UIImage imageNamed:@"preview_menu_0_0"]
                     highlight:[UIImage imageNamed:@"preview_menu_0_1"]
                        target:self
                        action:@selector(pushMenuItem:)],
          ];
        
        
        CGRect rect = sender.frame;
        rect.origin.y = self.navigationController.navigationBar.frame.size.height;
        
        [KxMenu showMenuInView:self.navigationController.view
                      fromRect:rect
                     menuItems:menuItems
                     itemWidth:100.f];
        [KxMenu sharedMenu].delegate = self;
    }
    else
    {
        [KxMenu dismissMenu];
    }

}

//打开Menu
- (void) pushMenuItem:(id)sender
{
    NSLog(@"%@", sender);
}

-(void)which_tag_clicked:(int)tag
{
    NSLog(@"shit :%d", tag);
    
    //秒赚首页
    if(tag == 0)
    {
        NSMutableArray *newStack = [NSMutableArray new];
        for (UIViewController *view in UI_MANAGER.mainNavigationController.viewControllers)
        {
            if (! [view isKindOfClass:[DataAnalysis class]] && ! [view isKindOfClass:[MyDataViewController class]])
            {
                [newStack addObject:view];
            }
        }
        UI_MANAGER.mainNavigationController.viewControllers = newStack;
        [newStack release];
    }
}


MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad
{
    [super viewDidLoad];
    InitNav(@"我的商家");
    
    UIView *vvv1 = WEAK_OBJECT(UIView, initWithFrame:CGRectMake(159.5, 7, 0.5, 40));
    UIView *vvv2 = WEAK_OBJECT(UIView, initWithFrame:CGRectMake(159.5, 12, 0.5, 40));
    vvv1.backgroundColor = RGBACOLOR(246, 105, 102, 1);
    vvv2.backgroundColor = RGBACOLOR(81, 79, 86, 1);
    [_vv1 addSubview:vvv1];
    [_vv2 addSubview:vvv2];
    
    [self setupMoveFowardButtonWithImage:@"more.png" In:@"morehover.png"];

    
    [self initRoundBar];
    ((UIScrollView *)self.view).contentSize = CGSizeMake(self.view.width, self.view.height);
    ((UIScrollView *)self.view).showsVerticalScrollIndicator = NO;
    ((UIScrollView *)self.view).delegate = self;
    {
        UIView *view = WEAK_OBJECT(UIView, initWithFrame:CGRectMake(0, - 200, 320, 200));
        view.backgroundColor = AppColorRed;
        [self.view addSubview:view];
    }
//    ((UIScrollView *)self.view).panGestureRecognizer.delaysTouchesBegan = YES;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    UIView *line_t1 = WEAK_OBJECT(UIView, initWithFrame:CGRectMake(15, 79.5, 320, 0.5));
    line_t1.backgroundColor = AppColor(204);
    
    UIView *line_t2 = WEAK_OBJECT(UIView, initWithFrame:CGRectMake(0, 389.5, 320, 0.5));
    line_t2.backgroundColor = AppColor(204);
    
    UIView *line_t3 = WEAK_OBJECT(UIView, initWithFrame:CGRectMake(0,246.5, 320, 0.5));
    line_t3.backgroundColor = AppColor(204);
    
    [_lineChartView addSubview:line_t3];
//    [_tableHeader addSubview:line_t1];
    _tableView.tableHeaderView = _tableHeader;
    
//    [_tableView addSubview:line_t2];
//    _tableView.tableFooterView = line_t2;
    [_flatSementControl addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
    //ios6
    {
        _flatSementControl.top -= 16;
        if ([SystemUtil aboveIOS7_0])
        {
            _flatSementControl.top += 16;
        }
    }
    
    [self initChartView];
    [_tableView addSubview:_boxView];
    _boxView.frame = CGRectMake(127, 40, _boxView.width, _boxView.height);
//    titleArray = @[@"银元广告",@"红包广告(精准直投)",@"兑换商城",@"易货商城",@"直购商城",@"竞价商城",@"其他"];
    
    if ([SystemUtil aboveIOS7_0])
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleBlackOpaque;
}

- (void)initRoundBar
{
    _roundBar.allowDragging = NO;
    _roundBar.allowSwitching = NO;
    _roundBar.allowTap = NO;
    [_roundBar setBarColor:AppColorWhite];
}

- (void)initChartView
{
    chartView = [[LineChartView alloc] initWithFrame:CGRectMake(5, 345, 315, 154)];
    [chartView showLegend:NO animated:NO];
    chartView.xStepsCount = 7;
    
    [self.view addSubview:chartView];
    
    _timeLabelArray = [NSMutableArray new];
    
    for (int i = 0; i < 7; i++)
    {
        UILabel *label = WEAK_OBJECT(UILabel, init);
        label.frame = CGRectMake( 30 + 43*i, 482, 200, 15);
        label.textAlignment = NSTextAlignmentLeft;
        label.font = Font(10);
        label.textColor = AppColor(85);
        [_timeLabelArray addObject:label];
        [self.view addSubview:label];
    }
}

- (void)viewDidLayoutSubviews
{
    
    int c_min = 0;
    int c_max = 0;
    
    if(_chooseIndex == 0)
    {
        if(_num_1_min_count < _num_1_min_pre)
            c_min = _num_1_min_count;
        else
            c_min = _num_1_min_pre;
        
        if(_num_1_max_count < _num_1_max_pre)
            c_max = _num_1_max_pre;
        else
            c_max = _num_1_max_count;
    }
    
    else if(_chooseIndex == 1)
    {
        if(_num_2_min_count < _num_2_min_pre)
            c_min = _num_2_min_count;
        else
            c_min = _num_2_min_pre;
        
        if(_num_2_max_count < _num_2_max_pre)
            c_max = _num_2_max_pre;
        else
            c_max = _num_2_max_count;
    }
    
    
    NSString *str_max = [NSString stringWithFormat:@"%d",c_max];
    NSString *str_min = [NSString stringWithFormat:@"%d",c_min];
    
    if(str_max.length && c_max > 0)
    {
        int base = 1;
        
        for (int i = 0; i < str_max.length - 1; i++) {
            base = base * 10;
        }
        
        int num = c_max / base;
        
        if(c_max % base > 0)
            c_max = (num + 1) * base;
    }
    
    if(str_min.length && c_min > 0)
    {
        int base = 1;
        
        for(int i = 0 ; i < str_min.length - 1; i++)
        {
            base = base * 10;
        }
        
        int num = c_min / base;
        
        c_min = num * base;
    }
    
    if([str_max isEqualToString:@"0"] || [str_max isKindOfClass:[NSNull class]] || c_max < 10)
        c_max = 10;
    
    if([str_min isEqualToString:@"0"] || [str_min isKindOfClass:[NSNull class]])
        c_min = 0;
    
    
    
    int yStep = (c_max - c_min)/5;
    
    NSString *str_yStep = [NSString stringWithFormat:@"%d",yStep];
    
    if(str_yStep.length && str_yStep.length  == 1)
    {
        if((c_max - c_min)%5 > 0)
            yStep ++;
    }
    
    if(str_yStep.length && str_yStep.length  == 2)
    {
        int num = yStep / 10;
        if(yStep % 10 > 0)
            yStep = (num+1) * 10;
    }
    
    chartView.yMin = c_min;
    chartView.yMax = c_max;
    chartView.ySteps = @[[NSString stringWithFormat:@"%.0f", chartView.yMin],
                         [NSString stringWithFormat:@"%.0f", chartView.yMin + yStep * 1],
                         [NSString stringWithFormat:@"%.0f", chartView.yMin + yStep * 2],
                         [NSString stringWithFormat:@"%.0f", chartView.yMin + yStep * 3],
                         [NSString stringWithFormat:@"%.0f", chartView.yMin + yStep * 4],
                         [NSString stringWithFormat:@"%.0f", chartView.yMin + yStep * 5],];
    chartView.data = chartData;
    
    [super viewDidLayoutSubviews];
}

-(void)refreshUI
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)segmentAction:(CRFlatButton *)Seg
{
    
    NSUInteger Index = Seg.selectedSegmentIndex;
    float min = INT_MAX;
    float max = INT_MIN;
    [_eyeBt setSelected:NO];
    
    
    if(!d)
    {
        d = [[LCLineChartData alloc] initWithColor:AppColorRed];
        d.tag = 0;
    }
    if (!s)
    {
        s = [[LCLineChartData alloc] initWithColor:RGBACOLOR(61, 144, 238, 1)];
        s.tag = 1;
    }
    
    _chooseIndex = Index;
    
    switch (Index)
    {
        case 0:
        {
            __block NSArray *d_data = _PVNetData;
            d.getData = ^(NSUInteger item)
            {
                NSInteger count = [d_data[0] count];
                if (item < count)
                {
                    float temp = [[d_data[0][item] wrapper] getFloat:@"Count"];
                    NSString *str = [[[d_data[0][item] wrapper] getString:@"Time"] substringWithRange:NSMakeRange(5, 5)];
                    ((UILabel *)_timeLabelArray[item]).text =  str;
                    [((UILabel *)_timeLabelArray[item]).layer needsDisplay];
                    return [LineChartDataItem dataItemWithX:(float)item y:temp  xLabel:nil dataLabel:@(temp).stringValue];
                }
                else
                {
                    return [LineChartDataItem dataItemWithX:(float)item y:0  xLabel:nil dataLabel:@(0).stringValue];
                }
            };
            
            s.getData = ^(NSUInteger item)
            {
                NSInteger count = [d_data[0] count];
                if (item < count)
                {
                    float temp = [[d_data[1][item] wrapper] getFloat:@"Count"];
                    return [LineChartDataItem dataItemWithX:(float)item y:temp  xLabel:nil dataLabel:@(temp).stringValue];
                }
                else
                {
                    return [LineChartDataItem dataItemWithX:(float)item y:0  xLabel:nil dataLabel:@(0).stringValue];
                }
            };
            
            for (NSArray *array in d_data)
            {
                for (NSDictionary *dic in array)
                {
                    NSNumber *temp = [dic objectForKey:@"Count"];
                    if (temp.floatValue < min) min = temp.floatValue;
                    if (temp.floatValue > max) max = temp.floatValue;
                }
            }
            break;
        }
        case 1:
        {
            __block NSArray *s_data = _CVNetData;
            d.getData = ^(NSUInteger item)
            {
                NSInteger count = [s_data[0] count];
                if (item < count)
                {
                    float temp = [[s_data[0][item] wrapper] getFloat:@"Count"];
                    return [LineChartDataItem dataItemWithX:(float)item y:temp  xLabel:nil dataLabel:@(temp).stringValue];
                }
                else
                {
                    return [LineChartDataItem dataItemWithX:(float)item y:0  xLabel:nil dataLabel:@(0).stringValue];
                }
            };
            
            s.getData = ^(NSUInteger item)
            {
                NSInteger count = [s_data[1] count];
                if (item < count)
                {
                    float temp = [[s_data[1][item] wrapper] getFloat:@"Count"];
                    return [LineChartDataItem dataItemWithX:(float)item y:temp  xLabel:nil dataLabel:@(temp).stringValue];
                }
                else
                {
                    return [LineChartDataItem dataItemWithX:(float)item y:0  xLabel:nil dataLabel:@(0).stringValue];
                }
            };
            
            for (NSArray *array in s_data)
            {
                for (NSDictionary *dic in array)
                {
                    NSNumber *temp = [dic objectForKey:@"Count"];
                    if (temp.floatValue < min) min = temp.floatValue;
                    if (temp.floatValue > max) max = temp.floatValue;
                }
            }
            break;
        }
    }
    
    if (!chartData)
    {
        chartData = [NSMutableArray new];
    }
    [chartData removeAllObjects];
    
    if (min>max) {min = 0.f ; max = 100.f;}
    
    [chartView setYaxesFrom:min to:max];
    [chartData addObject:d];
    [chartData retain];
    [chartView.layer setNeedsDisplay];
    
    [self viewDidLayoutSubviews];
}

- (IBAction)eyeTouch:(UIButton *)sender
{
    [sender setSelected:!sender.selected];
    
    {
        if (sender.selected)
        {
            [chartData addObject:s];
            [chartView.layer setNeedsDisplay];
        }
        else
        {
            [chartData removeObject:s];
            [chartView.layer setNeedsDisplay];
        }
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)dataAnalysisSnap:(DelegatorArguments *)arg
{
    
    _num_1_max_count = 0;
    _num_1_min_count = 0;
    _num_1_max_pre = 0;
    _num_1_min_pre = 0;
    
    _num_2_max_count = 0;
    _num_2_min_count = 0;
    _num_2_max_pre = 0;
    _num_2_min_pre = 0;
    
    [arg logError];
    DictionaryWrapper *wrapper = arg.ret;
    if (wrapper.operationSucceed)
    {
        DictionaryWrapper *netData = wrapper.data;
        
        NSArray *PVlist = [netData getArray:@"PVList"];
        NSArray *LastPVList = [netData getArray:@"LastPVList"];
        _PVNetData = @[PVlist,LastPVList];
        [_PVNetData retain];
        NSArray *CVList = [netData getArray:@"CVList"];
        NSArray *LastCVList = [netData getArray:@"LastCVList"];
        _CVNetData = @[CVList,LastCVList];
        [_CVNetData retain];
        
        [_roundBar setPercent:[netData getInt:@"Beyong"] animated:YES];
//        [_roundBar setPercent:91 animated:YES];
        
        _num_1.numbers = [netData getLong:@"TotalPV"];
        _num_2.numbers = [netData getLong:@"TotalCV"];
        _num_3.numbers = [PVlist count]>0?[[PVlist.lastObject wrapper] getInt:@"Count"]:0;
        _num_4.numbers = [CVList count]>0?[[CVList.lastObject wrapper] getInt:@"Count"]:0;
        
        
        _tableNetData = [netData getArray:@"Source"];
        [_tableNetData retain];
        [self segmentAction:_flatSementControl];
        
        [_tableView reloadData];
        
        
        
        if(PVlist && ![PVlist isKindOfClass:[NSNull class]])
        {
            if(PVlist.count > 0)
            {
                _num_1_min_count = [[PVlist.lastObject wrapper] getInt:@"Count"];

                for(NSDictionary *dic in PVlist)
                {
                   DictionaryWrapper  *dataDic = dic.wrapper;
                    
                    int count = [dataDic getInt:@"Count"];
                    if(_num_1_max_count < count)
                        _num_1_max_count = count;
                    
                    if(_num_1_min_count > count)
                        _num_1_min_count = count;
                }
            }
        }
        
        if(CVList && ![CVList isKindOfClass:[NSNull class]])
        {
            if(CVList.count > 0)
            {
                _num_2_min_count = [[CVList.lastObject wrapper] getInt:@"Count"];
                
                for(NSDictionary *dic in CVList)
                {
                    DictionaryWrapper  *dataDic = dic.wrapper;
                    
                    int count = [dataDic getInt:@"Count"];
                    if(_num_2_max_count < count)
                        _num_2_max_count = count;
                    
                    if(_num_2_min_count > count)
                        _num_2_min_count = count;
                }
            }
        }
        
        if(LastPVList && ![LastPVList isKindOfClass:[NSNull class]])
        {
            if(LastPVList.count > 0)
            {
                _num_1_min_pre = [[LastPVList.lastObject wrapper] getInt:@"Count"];
                
                for(NSDictionary *dic in LastPVList)
                {
                    DictionaryWrapper  *dataDic = dic.wrapper;
                    
                    int count = [dataDic getInt:@"Count"];
                    if(_num_1_max_pre < count)
                        _num_1_max_pre = count;
                    
                    if(_num_1_min_pre > count)
                        _num_1_min_pre = count;
                }
            }
        }
        
        if(LastCVList && ![LastCVList isKindOfClass:[NSNull class]])
        {
            if(LastCVList.count > 0)
            {
                _num_2_min_pre = [[LastCVList.lastObject wrapper] getInt:@"Count"];
                
                for(NSDictionary *dic in LastCVList)
                {
                    DictionaryWrapper  *dataDic = dic.wrapper;
                    
                    int count = [dataDic getInt:@"Count"];
                    if(_num_2_max_pre < count)
                        _num_2_max_pre = count;
                    
                    if(_num_2_min_pre > count)
                        _num_2_min_pre = count;
                }
            }
        }
        
        [self viewDidLayoutSubviews];
    }
    else
    {
        [HUDUtil showErrorWithStatus:wrapper.operationMessage];
    }
}

- (void)dealloc {
    [_lineChartView release];
    [_tableView release];
    [_roundBar release];
    [_tableHeader release];
    [_flatSementControl release];
    [_num_1 release];
    [_num_2 release];
    [_num_3 release];
    [_num_4 release];
    [_eyeBt release];
    [_boxView release];
    CRDEBUG_DEALLOC();
    [_vv1 release];
    [_vv2 release];
    [super dealloc];
}

- (void)viewDidUnload {
    [self setLineChartView:nil];
    [self setTableView:nil];
    [self setRoundBar:nil];
    [self setTableHeader:nil];
    [self setFlatSementControl:nil];
    [self setNum_1:nil];
    [self setNum_2:nil];
    [self setNum_3:nil];
    [self setNum_4:nil];
    [self setEyeBt:nil];
    [self setBoxView:nil];
    [super viewDidUnload];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    BarDataTableViewCell *cell = (BarDataTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.contentView.backgroundColor = AppColor(220);
    return YES;
}
- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    BarDataTableViewCell *cell = (BarDataTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor whiteColor];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _tableNetData.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"BarDataTableViewCell";
    BarDataTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[NSBundle mainBundle] loadNibNamed:@"BarDataTableViewCell" owner:nil options:nil].lastObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    DictionaryWrapper *data = [_tableNetData[indexPath.row] wrapper];
    cell.num.text = [data getString:@"Count"];
    cell.titleL.text = [data getString:@"Name"];
    cell.data = [data getDouble:@"Percent"];
    
    return cell;
}

#pragma mark - touch
- (IBAction)wenhao:(UIButton *)sender
{
    _boxView.hidden = !_boxView.hidden;
}

@end
