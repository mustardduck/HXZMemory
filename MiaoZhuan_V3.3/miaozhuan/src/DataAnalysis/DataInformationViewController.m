//
//  DataInformationViewController.m
//  miaozhuan
//
//  Created by abyss on 14/11/10.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "DataInformationViewController.h"
#import "DataInformationItemTableViewCell.h"
#import "RRAttributedString.h"

@interface DataInformationViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSArray *_layoutArray;
    
    DictionaryWrapper *_netData;
    NSMutableArray *_itemArray;
}
@property (retain, nonatomic) IBOutlet UIImageView *add_line;
@property (retain, nonatomic) IBOutlet UIImageView *endLine;
@property (retain, nonatomic) IBOutlet UILabel *lblWatched;
@property (retain, nonatomic) IBOutlet CRLabel *lblWatchedNum;
@end

@implementation DataInformationViewController

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.type == DataCategroyYin)
    {
        ADAPI_adv3_SilverAdvert([self genDelegatorID:@selector(data:)], self.advertID);
    }
    else ADAPI_adv3_DirectAdvert([self genDelegatorID:@selector(data:)], self.advertID);
    _bar.showLabel = NO;
    //button
    [_topBt setBorderWithColor:AppColor(204)];
    [_topBt setRoundCorner];
    //img
    [_topImg setBorderWithColor:AppColor(197)];
    [_topImg requestIcon:nil];
    InitNav(@"数据统计详情");
    
    // Do any additional setup after loading the view from its nib.
}

- (void)data:(DelegatorArguments *)arg
{
    [arg logError];
    DictionaryWrapper *wrapper = arg.ret;
    if (wrapper.operationSucceed)
    {
        if (!_netData)
        {
            _netData = [DictionaryWrapper new];
        }
        _netData = wrapper.data;
        [self configureSubView];
        _tableView.hidden = YES;
        _add_line.hidden = YES;
        
        if (!_itemArray)
        {
            _itemArray = [NSMutableArray new];
        }
        for (NSDictionary *dic in [wrapper.data getArray:@"SilverProductList"])
        {
            [_itemArray addObject:dic.wrapper];
            if (_itemArray.count > 0)
            {
                _tableView.delegate = self;
                _tableView.dataSource = self;
                _tableView.tableHeaderView = _header;
            }
        }
        [_tableView reloadData];
    }
    else
    {
        [HUDUtil showErrorWithStatus:wrapper.operationMessage];
    }
}

- (void)configureSubView
{
    _layoutArray = @[
  @[@"播出次数",@"收看人数",@"绑定总价值",@"已消耗银元",@"剩余银元"],
  @[@"预计投放(人)",@"已到达人数",@"广告计划播放天数",@"已播放天数",@"剩余天数",@"已收看人数"]];
    [_layoutArray retain];
    //view
    NSArray *array = _layoutArray[self.type];
    _text_1.text = array[0];
    _text_2.text = array[1];
    
    NSString *str = [NSString stringWithFormat:@"%@  %d%@",array[2],!self.type?[_netData getInt:@"TotalSilver"]:[_netData getInt:@"CountDays"],self.type?@"天":@"银元"];
    _text_3.attributedText = [RRAttributedString setText:str color:AppColor(153) range:self.type ? NSMakeRange(0, 9) : NSMakeRange(0, 7)];
    
    _text_4.text = _layoutArray[self.type][3];
    _text_5.text = _layoutArray[self.type][4];
    
    if (self.type) {
        _lblWatched.text = array[5];
        _lblWatchedNum.text = [_netData getString:@"ReadCount"];
    }
    
    //bar
    _bar.smoothCorner = YES;
    
    [_topImg requestCustom:[_netData getString:@"PictureUrl"] width:_topImg.width height:_topImg.height placeHolder:nil];
    _flagImg.backgroundColor = (![_netData getBool:@"State"])?AppColorRed:AppColorGray153;
    _flagL.text = (![_netData getBool:@"State"])?@"正在播放":self.type == 0?@"播放结束":@"已结束";
    
    _topLabel.text = [_netData getString:@"Name"];
    _onPlayNum.numbers = (!self.type?[_netData getString:@"PV"]:[_netData getString:@"Total"]).floatValue;
    _reciveNum.numbers = ([_netData getString:@"CV"]).floatValue;

    _total_1.text = !self.type?[_netData getString:@"ConsumeSilver"]:[_netData getString:@"PushDays"];
    _total_2.text = !self.type?[_netData getString:@"RemainSilver"]:[_netData getString:@"RemainDays"];
    
    _bar.percentNum = ((float)_total_1.text.integerValue / ( _total_1.text.integerValue + _total_2.text.integerValue ))*100;
    
    NSString *timeHolder = @"广告截止时间 ";
    NSString *retTime    = nil;
    NSString *time       = [UICommon formatTime:[_netData getString:@"EndTime"]];
    if (time.length > 10)
    {
        time = [time substringToIndex:10];
        retTime = [NSString stringWithFormat:@"%@年%@月%@日",[time substringToIndex:4],[time substringWithRange:NSMakeRange(5, 2)],[time substringFromIndex:8]];
    }
    _dateL.text = [timeHolder stringByAppendingString:retTime];
}

- (void)viewDidLayoutSubviews
{
    _tableView.height = _itemArray.count*110 + 29;
    _endLine.height = .5f;
    _add_line.height = .5f;
    _endLine.top = _tableView.height + 306 + 1;
    _endLine.hidden = YES;
    ((UIScrollView *)self.view).contentSize = CGSizeMake(self.view.width, 310 +  _tableView.height);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)dealloc {
//    [_netData release];
    [_topImg release];
    [_topLabel release];
    [_onPlayNum release];
    [_reciveNum release];
    [_tableView release];
    [_flagImg release];
    [_topBt release];
    [_bar release];
    [_header release];
    [_flagL release];
    [_text_1 release];
    [_text_2 release];
    [_totalL release];
    [_total_1 release];
    [_total_2 release];
    [_dateL release];
    [_text_3 release];
    [_text_4 release];
    [_text_5 release];
    CRDEBUG_DEALLOC();
    [_add_line release];
    [_endLine release];
    [_lblWatched release];
    [_lblWatchedNum release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setTopImg:nil];
    [self setTopLabel:nil];
    [self setOnPlayNum:nil];
    [self setReciveNum:nil];
    [self setTableView:nil];
    [self setFlagImg:nil];
    [self setTopBt:nil];
    [self setBar:nil];
    [self setHeader:nil];
    [self setFlagL:nil];
    [self setText_1:nil];
    [self setText_2:nil];
    [self setTotalL:nil];
    [self setTotal_1:nil];
    [self setTotal_2:nil];
    [self setDateL:nil];
    [self setText_3:nil];
    [self setText_4:nil];
    [self setText_5:nil];
    [super viewDidUnload];
}
- (IBAction)jumpAction:(id)sender
{
    PUSH_VIEWCONTROLLER(DataInformationJumpViewController);
    
//    DataInformationJumpViewController *model = WEAK_OBJECT(DataInformationJumpViewController, init);
//    [CRHttpAddedManager mz_pushViewController:model];
    model.type = self.type;
    model.advertID = self.advertID;
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    DataInformationItemTableViewCell *cell = (DataInformationItemTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.contentView.backgroundColor = AppColor(220);
    return YES;
}
- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    DataInformationItemTableViewCell *cell = (DataInformationItemTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor whiteColor];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_itemArray.count > 0 )
    {
        _add_line.hidden = NO;
        _tableView.hidden = NO;
        [self viewDidLayoutSubviews];
    }
    return _itemArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"DataInformationItemTableViewCell";
    DataInformationItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[NSBundle mainBundle] loadNibNamed:@"DataInformationItemTableViewCell" owner:nil options:nil].lastObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.img setBorderWithColor:AppColor(197)];
    }
    DictionaryWrapper *data = [_itemArray[indexPath.row] wrapper];
    
    [cell.img requestMiddle:[data getString:@"PictureUrl"]];
    cell.advertName.text = [data getString:@"Name"];
    cell.price.text = [data getString:@"Price"];
    cell.bandNum.text = [data getString:@"Count"];
    cell.changeNum.text = [data getString:@"Sell"];
    if([SystemUtil aboveIOS7_0]) cell.separatorInset = UIEdgeInsetsMake(0, -15, 0, 0);
    
    return cell;
}

@end
