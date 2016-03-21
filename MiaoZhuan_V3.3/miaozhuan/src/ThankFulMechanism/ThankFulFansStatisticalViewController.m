//
//  ThankFulFansStatisticalViewController.m
//  miaozhuan
//
//  Created by apple on 14/11/24.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "ThankFulFansStatisticalViewController.h"
#import "ThanksShareTableViewCell.h"
#import "Redbutton.h"
#import "UIView+expanded.h"
#import "FansDetailViewController.h"
#import "RRAttributedString.h"
#import "Share_Method.h"
#import "ThankfulFruitViewController.h"
#import "WebhtmlViewController.h"
#import "PhoneAuthenticationViewController.h"
#import "RRAttributedString.h"
#import "DatePickerViewController.h"
#import "UICommon.h"
@interface ThankFulFansStatisticalViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate,DatePickerDelegate,UITextFieldDelegate>
{
    NSMutableArray * result;
    
    DictionaryWrapper* dic;
    
    DatePickerViewController *datePickerView;
    
    CGFloat offsetY;
    
    int searchTag;
    
    BOOL search;
}
@property (retain, nonatomic) IBOutlet Redbutton *shareBtn;
@property (retain, nonatomic) IBOutlet UILabel *fansCountLable;
@property (retain, nonatomic) IBOutlet UITableView *thanksTableView;
@property (retain, nonatomic) IBOutlet UILabel *getfansCountLable;
@property (retain, nonatomic) IBOutlet UILabel *losefansCountLable;
@property (retain, nonatomic) IBOutlet UIScrollView *thanksScroller;
@property (retain, nonatomic) IBOutlet UIButton *fansCountBtn;
@property (retain, nonatomic) IBOutlet UILabel *getMoneyCount;
@property (retain, nonatomic) IBOutlet UILabel *loseMoneyCount;

@property (retain, nonatomic) IBOutlet UIView *alertView;
@property (retain, nonatomic) IBOutlet UILabel *alertLable;
@property (retain, nonatomic) IBOutlet UIButton *alertBtnOne;
@property (retain, nonatomic) IBOutlet UIButton *alertBtnTwo;
@property (retain, nonatomic) IBOutlet UILabel *alertNeedNumLable;
@property (retain, nonatomic) IBOutlet Redbutton *shareBtnTwo;

@property (retain, nonatomic) IBOutlet UIView *noFansView;

- (IBAction)alertBtnTouch:(id)sender;

@property (retain, nonatomic) IBOutlet UIView *showView;

@property (retain, nonatomic) IBOutlet UIView *lineVIewOne;
@property (retain, nonatomic) IBOutlet UIView *lineViewTwo;

- (IBAction)touchUpInsideBtn:(id)sender;

@property (retain, nonatomic) IBOutlet UIButton *bgBtnView;

- (IBAction)bgBtn:(id)sender;


@property (retain, nonatomic) IBOutlet UIView *shareView;

- (IBAction)timeBtn:(id)sender;
@property (retain, nonatomic) IBOutlet UIButton *startTimeBtn;

@property (retain, nonatomic) IBOutlet UIButton *endTimeBtn;
@property (retain, nonatomic) IBOutlet UITextField *startTimeTxt;
@property (retain, nonatomic) IBOutlet UITextField *endTimeTxt;
@property (retain, nonatomic) IBOutlet UIView *timeVIew;
- (IBAction)search:(id)sender;

@property (retain, nonatomic) IBOutlet UIButton *btnsearch;
@property (retain, nonatomic) IBOutlet UIView *lineViews;
@property (retain, nonatomic) IBOutlet UILabel *searchLable;
@end

@implementation ThankFulFansStatisticalViewController

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if([_xtitle isEqualToString:@""])
        InitNav(@"我的粉丝");
    else
        InitNav(@"感恩分享");
    
    [self setupMoveFowardButtonWithTitle:@"说明"];
    
    [_timeVIew roundCornerBorder];
    
     _bgBtnView.hidden = YES;
    
    _thanksTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    _lineVIewOne.frame = CGRectMake(0, 82.5, 290, 0.5);
    
    _lineViewTwo.frame = CGRectMake(145, 82.5, 0.5, 50);
    
    _alertBtnOne.frame = CGRectMake(0, 83, 145, 50);
    
    _alertBtnTwo.frame = CGRectMake(145.5, 83, 144.5, 50);
    
    _thanksTableView.scrollEnabled = NO;
    
    [_thanksScroller setContentSize:CGSizeMake(320, 660)];
    
    [_thanksScroller addSubview:_shareView];
    
    _shareView.frame =CGRectMake(0, 497, 320, 145);
    
    [_shareBtn roundCorner];
    
    _alertView.layer.masksToBounds = YES;
    _alertView.layer.cornerRadius = 8.0;
    _alertView.layer.borderWidth = 0.5;
    _alertView.layer.borderColor = [[UIColor clearColor] CGColor];
    
    _lineViews.frame = CGRectMake(221, 0, 0.5, 35);
    
    _endTimeTxt.frame = CGRectMake(122, 0, 106, 35);
    
    _endTimeBtn.frame = CGRectMake(122, 0, 70, 35);
    
    search = YES;
}

-(void)viewWillAppear:(BOOL)animated
{
    offsetY = [UICommon getIos4OffsetY];
    //判断是否手机认证
    dic =[APP_DELEGATE.runtimeConfig getDictionary:RUNTIME_USER_LOGIN_INFO].wrapper;
    [dic retain];
    
    if ([dic getBool:@"IsPhoneVerified"])
    {
        searchTag = 1;
        
        ADAPI_adv3_MemberCampaign_Summary([self genDelegatorID:@selector(HandleNotification:)],@"0",@"",@"");
    }
    else
    {
        [self.view addSubview:_noFansView];
    }
}

- (IBAction) onMoveFoward:(UIButton*) sender
{
    PUSH_VIEWCONTROLLER(WebhtmlViewController);
    model.navTitle = @"说明";
    model.ContentCode = @"b54478c2cca4bf8d89cbcca9d7582798";
}

- (void)HandleNotification:(DelegatorArguments *)arguments
{
    if ([arguments isEqualToOperation:ADOP_adv3_MemberCampaign_Summary])
    {
        [arguments logError];
        
        DictionaryWrapper *wrapper = arguments.ret;
        
        if (wrapper.operationSucceed)
        {
            if (searchTag == 2)
            {
                _searchLable.text = [NSString stringWithFormat:@"你直接发展的粉丝构成了第一层，他们再发展的粉丝构成了其他层，累积截至%@至%@统计如下:",_startTimeTxt.text,_endTimeTxt.text];
                _searchLable.frame = CGRectMake(15, 126, 290, 47);
                _searchLable.numberOfLines = 3;
            }
            else
            {
                _searchLable.text = [NSString stringWithFormat:@"你直接发展的粉丝构成了第一层，他们再发展的粉丝构成了其他层，累积截至昨日统计如下:"];
                _searchLable.frame = CGRectMake(15, 135, 290, 35);
                _searchLable.numberOfLines = 2;
            }
            
            
            _showView.hidden = YES;
            
            DictionaryWrapper * dics = wrapper.data;
            
            _getfansCountLable.text = [NSString stringWithFormat:@"已获得银元总数：%@",[UICommon getStringToTwoDigitsAfterDecimalPointPlaces:[dics getDouble:@"EarnByFans"] withAppendStr:nil]];
            
            _losefansCountLable.text = [NSString stringWithFormat:@"已损失银元总数：%@",[UICommon getStringToTwoDigitsAfterDecimalPointPlaces:[dics getDouble:@"Miss"] withAppendStr:nil]];
            
            _getMoneyCount.text = [NSString stringWithFormat:@"已获得现金总数：%@",[UICommon getStringToTwoDigitsAfterDecimalPointPlaces:[dics getDouble:@"EarnCashByFans"] withAppendStr:nil]];
            
            _loseMoneyCount.text = [NSString stringWithFormat:@"已损失现金总数：%@",[UICommon getStringToTwoDigitsAfterDecimalPointPlaces:[dics getDouble:@"CashMiss"] withAppendStr:nil]];
            
            NSAttributedString * nowattributedStringOne = [RRAttributedString setText:_getfansCountLable.text color:RGBCOLOR(153,153,153) range:NSMakeRange(0, 8)];
            
            _getfansCountLable.attributedText = nowattributedStringOne;
            
            NSAttributedString * nowattributedStringTwo = [RRAttributedString setText:_losefansCountLable.text color:RGBCOLOR(153,153,153) range:NSMakeRange(0, 8)];
            
            _losefansCountLable.attributedText = nowattributedStringTwo;
            
            NSAttributedString * nowattributedStringThree = [RRAttributedString setText:_getMoneyCount.text color:RGBCOLOR(153,153,153) range:NSMakeRange(0, 8)];
            
            _getMoneyCount.attributedText = nowattributedStringThree;
            
            NSAttributedString * nowattributedStringFour = [RRAttributedString setText:_loseMoneyCount.text color:RGBCOLOR(153,153,153) range:NSMakeRange(0, 8)];
            
            _loseMoneyCount.attributedText = nowattributedStringFour;

            if (!result)
            {
                result = [NSMutableArray new];
            }
            else
            {
                [result removeAllObjects];
            }
            [result addObjectsFromArray:[dics getArray:@"Details"]];
            
            if (search != NO)
            {
                _fansCountLable.text = [NSString stringWithFormat:@"%d个",[[[result objectAtIndex:0]wrapper]getInt:@"FansCount"]];
            }
            
            NSLog(@"---result%@",result);
            
            [_thanksTableView reloadData];
            
            _thanksTableView.delegate = self;
            
            _thanksTableView.dataSource = self;
            
        }
        else if ([wrapper getInteger:@"Code"] == 32062)
        {
            [self.view addSubview:_noFansView];
        }
        else
        {
            [AlertUtil showAlert:@"" message:wrapper.operationMessage buttons:@[@"好的"]];
            return;
        }
    }
}

- (IBAction)alertBtnTouch:(id)sender
{
    if (sender == _alertBtnOne)
    {
        [[Share_Method shareInstance] getShareDataWithShareData:@{@"Key":@"b48f4584ef5fb324cf5c4a803ed8e575"}];
    }
    else if (sender == _alertBtnTwo)
    {
        PUSH_VIEWCONTROLLER(ThankfulFruitViewController);
    }
    
    _bgBtnView.hidden = YES;
    
    [_alertView removeFromSuperview];
}

- (IBAction)touchUpInsideBtn:(id)sender
{
    if (sender == _fansCountBtn)
    {
        PUSH_VIEWCONTROLLER(FansDetailViewController);
        
        _startTimeTxt.text = @"";
        _endTimeTxt.text = @"";
        
        _endTimeTxt.frame = CGRectMake(122, 0, 106, 35);
        
        _endTimeBtn.frame = CGRectMake(122, 0, 70, 35);
        
        [_endTimeTxt setEnabled:NO];
        _endTimeTxt.clearButtonMode = UITextFieldViewModeNever;
    }
    else if (sender == _shareBtn)
    {
        [[Share_Method shareInstance] getShareDataWithShareData:@{@"Key":@"b48f4584ef5fb324cf5c4a803ed8e575"}];
    }
    else if (sender == _shareBtnTwo)
    {
        if ([dic getBool:@"IsPhoneVerified"])
        {
            //分享
            [[Share_Method shareInstance] getShareDataWithShareData:@{@"Key":@"b48f4584ef5fb324cf5c4a803ed8e575"}];
        }
        else
        {
            //手机认证
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"" message:@"您尚未通过手机认证，暂时无法分享" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"去认证", nil];
            [alert show];
            [alert release];
        }
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        PUSH_VIEWCONTROLLER(PhoneAuthenticationViewController);
    }
}

- (IBAction)bgBtn:(id)sender
{
    _bgBtnView.hidden = YES;
    
    [_alertView removeFromSuperview];
}


#pragma mark - tableView delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ThanksShareTableViewCell";
    ThanksShareTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[NSBundle mainBundle] loadNibNamed:@"ThanksShareTableViewCell" owner:nil options:nil].lastObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.layer.masksToBounds = YES;
    }
    
    
    cell.cellLines.top = 44.5;
    if (indexPath.row == 5)
    {
        cell.cellLines.left = 0;
    }
    
    if ([[[result objectAtIndex:indexPath.row] wrapper] getBool:@"IsUnLocked"] == NO)
    {
        cell.backgroundColor = AppColorBackground;
        
        cell.cellJieSuo.hidden = NO;
        
        cell.layerNumCell.textColor = RGBACOLOR(204, 204, 204, 1);
        
        cell.recommendNumCell.textColor = RGBACOLOR(204, 204, 204, 1);
        
        cell.qualifiedNumCell.textColor = RGBACOLOR(204, 204, 204, 1);
        
        cell.getNumCell.textColor = RGBACOLOR(204, 204, 204, 1);
    }
    else
    {
        cell.cellJieSuo.hidden = YES;
    }
    
    cell.layerNumCell.text = [NSString stringWithFormat:@"%d",[[[result objectAtIndex:indexPath.row] wrapper] getInt:@"FansCount"]];
    
    cell.recommendNumCell.text = [NSString stringWithFormat:@"%d",[[[result objectAtIndex:indexPath.row] wrapper] getInt:@"VerifyCount"]];

    cell.qualifiedNumCell.text = [NSString stringWithFormat:@"%@",[UICommon getStringToTwoDigitsAfterDecimalPointPlaces:[[[result objectAtIndex:indexPath.row] wrapper] getDouble:@"EarnByFans"] withAppendStr:nil]];

    
    cell.getNumCell.text = [NSString stringWithFormat:@"%@",[UICommon getStringToTwoDigitsAfterDecimalPointPlaces:[[[result objectAtIndex:indexPath.row] wrapper] getDouble:@"CashEarnByFans"]withAppendStr:nil]];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ThanksShareTableViewCell *cell = (ThanksShareTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
    
    if (cell.cellJieSuo.hidden == NO)
    {
        _bgBtnView.hidden = NO;
        
//        int num = [[[result objectAtIndex:0] wrapper] getInt:@"VerifyCount"];
        
        DictionaryWrapper* dicsss =[APP_DELEGATE.runtimeConfig getDictionary:RUNTIME_USER_LOGIN_INFO].wrapper;
        
        NSInteger thankslevel = [dicsss getInt:@"ThankfulLevel"];
        
        int now =(int) indexPath.row;
        
        int needNum = now + 1 - thankslevel ;
        
        _alertNeedNumLable.text = [NSString stringWithFormat:@"还需%d个合格粉丝",needNum];

        _alertLable.text = [NSString stringWithFormat:@"才能获取第%d层的感恩银元",now + 1];
        
        NSAttributedString * attributedString = [RRAttributedString setText:_alertNeedNumLable.text color:RGBCOLOR(240, 5, 0) range:NSMakeRange(2, 1)];
        
        _alertNeedNumLable.attributedText = attributedString;
        
        NSAttributedString * attributedStringTwo = [RRAttributedString setText:_alertLable.text color:RGBCOLOR(240, 5, 0) range:NSMakeRange(5, 1)];
        
        _alertLable.attributedText = attributedStringTwo;
        
        [self.view addSubview:_alertView];
        
        if ([[UIScreen mainScreen] bounds].size.height < 568)
        {
            _alertView.frame = CGRectMake(15, 95, _alertView.width, _alertView.height);
        }
        else
        {
            _alertView.frame = CGRectMake(15, 135, _alertView.width, _alertView.height);
        }
    }
}

- (IBAction)search:(id)sender
{
    search = NO;
    
    NSDate * startDate = [UICommon dateShortFromString:_startTimeTxt.text];
    
    NSDate * endDate = [UICommon dateShortFromString:_endTimeTxt.text];
    
    BOOL is = [datePickerView checkField:startDate endDate:endDate];
    
    if( is == YES)
    {
        return;
    }
    
    if ([_startTimeTxt.text isEqualToString:@""] && [_endTimeTxt.text isEqualToString:@""])
    {
        searchTag = 1;
        
        ADAPI_adv3_MemberCampaign_Summary([self genDelegatorID:@selector(HandleNotification:)],@"0",@"",@"");
    }
    else
    {
        searchTag = 2;
        
        if ([_endTimeTxt.text isEqualToString:@""])
        {
            NSDate* date = [[NSDate alloc] init];
            
            NSDate * maxdate = [[NSDate alloc] init];
            
            maxdate = [date dateByAddingTimeInterval:-60*60*24];
            
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            
            dateFormatter.dateFormat = @"yyyy-MM-dd";
            
             NSString* endtext = [dateFormatter stringFromDate:maxdate];
            
            _endTimeTxt.text = endtext;
            
            ADAPI_adv3_MemberCampaign_Summary([self genDelegatorID:@selector(HandleNotification:)],@"0",_startTimeTxt.text,_endTimeTxt.text);
            
            _endTimeTxt.frame = CGRectMake(115, 0, 106, 35);
            
            _endTimeBtn.frame = CGRectMake(115, 0, 70, 35);
            _endTimeTxt.clearButtonMode = UITextFieldViewModeAlways;
            
            [_endTimeTxt setEnabled:YES];
        }
        else if ([_startTimeTxt.text isEqualToString:@""])
        {
            NSDate* date = [[NSDate alloc] init];
            
            NSDate * mindate = [[NSDate alloc] init];
            
            mindate = [date dateByAddingTimeInterval:- 90*(60*60*24)];
            
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            
            dateFormatter.dateFormat = @"yyyy-MM-dd";
            
            NSString* endtext = [dateFormatter stringFromDate:mindate];
            
            _startTimeTxt.text = endtext;
            
            ADAPI_adv3_MemberCampaign_Summary([self genDelegatorID:@selector(HandleNotification:)],@"0",_startTimeTxt.text,_endTimeTxt.text);
            
            _endTimeTxt.frame = CGRectMake(115, 0, 106, 35);
            
            _endTimeBtn.frame = CGRectMake(115, 0, 70, 35);
            _endTimeTxt.clearButtonMode = UITextFieldViewModeAlways;
            
            [_endTimeTxt setEnabled:YES];
        }
        else
        {
            ADAPI_adv3_MemberCampaign_Summary([self genDelegatorID:@selector(HandleNotification:)],@"0",_startTimeTxt.text,_endTimeTxt.text);
        }
    }
}

- (IBAction)timeBtn:(id)sender
{
    if (sender == _startTimeBtn)
    {
        [self setDatePickerView];
        
        NSDate* date = [[NSDate alloc] init];
        
        datePickerView.view.tag = 100;
        
        NSDate* mindate = [[NSDate alloc] init];
        
        mindate = [date dateByAddingTimeInterval:- 90*(60*60*24)];//当前系统时间－90天
        
        NSDate * maxdate = [[NSDate alloc] init];
        
        maxdate = [date dateByAddingTimeInterval:-60*60*24];
        
        datePickerView.picker.date = mindate;
        
        datePickerView.picker.minimumDate = mindate;
        
        datePickerView.picker.maximumDate = maxdate;
        
        [datePickerView initwithtitles:0];
        
        [self.view addSubview:datePickerView.view];

    }
    else if (sender == _endTimeBtn)
    {
        [self setDatePickerView];
        
        NSDate* date = [[NSDate alloc] init];
        
        datePickerView.view.tag = 101;
        
        NSDate* mindate = [[NSDate alloc] init];
        
        mindate = [date dateByAddingTimeInterval:- 90*(60*60*24)];//当前系统时间-90天
        
        NSDate * maxdate = [[NSDate alloc] init];
        
        maxdate = [date dateByAddingTimeInterval:-60*60*24];
        
        datePickerView.picker.date = maxdate;
        
        datePickerView.picker.minimumDate = mindate;
        
        datePickerView.picker.maximumDate = maxdate;
        
        [datePickerView initwithtitles:0];
        
        [self.view addSubview:datePickerView.view];

    }
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
        _startTimeTxt.text = text;
    }
    else
    {
        _endTimeTxt.text = text;
    }
    
    if (![_startTimeTxt.text isEqualToString:@""] && ![_endTimeTxt.text isEqualToString:@""])
    {
        _endTimeTxt.frame = CGRectMake(115, 0, 106, 35);
        
        _endTimeBtn.frame = CGRectMake(115, 0, 70, 35);
        _endTimeTxt.clearButtonMode = UITextFieldViewModeAlways;
        
        [_endTimeTxt setEnabled:YES];
    }
    
    [dateFormatter release];
    
    dateFormatter = nil;
}

- (void) cancelDateCallBack:(NSDate*)date
{
    [datePickerView.view removeFromSuperview];
}


- (BOOL)textFieldShouldClear:(UITextField *)textField;
{
    _startTimeTxt.text = @"";
    _endTimeTxt.text = @"";
    
    _endTimeTxt.frame = CGRectMake(122, 0, 106, 35);
    
    _endTimeBtn.frame = CGRectMake(122, 0, 70, 35);
    
    [_endTimeTxt setEnabled:NO];
    _endTimeTxt.clearButtonMode = UITextFieldViewModeNever;
    return YES;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
    [_shareBtn release];
    [_fansCountLable release];
    [_thanksTableView release];
    [_getfansCountLable release];
    [_losefansCountLable release];
    [_thanksScroller release];
    [_fansCountBtn release];
    [_getMoneyCount release];
    [_loseMoneyCount release];
    [_alertView release];
    [_alertLable release];
    [_alertBtnOne release];
    [_alertBtnTwo release];
    [_showView release];
    [_bgBtnView release];
    [_alertNeedNumLable release];
    [_shareBtnTwo release];
    [_noFansView release];
    [_lineVIewOne release];
    [_lineViewTwo release];
    [_shareView release];
    [_endTimeBtn release];
    [_startTimeBtn release];
    [_startTimeTxt release];
    [_endTimeTxt release];
    [_timeVIew release];
    [_btnsearch release];
    [_lineViews release];
    [_searchLable release];
    [super dealloc];
}

@end
