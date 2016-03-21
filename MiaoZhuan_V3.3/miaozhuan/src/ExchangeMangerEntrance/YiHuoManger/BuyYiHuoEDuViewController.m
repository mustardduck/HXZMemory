//
//  BuyYiHuoEDuViewController.m
//  miaozhuan
//
//  Created by apple on 15/6/3.
//  Copyright (c) 2015年 zdit. All rights reserved.
//

#import "BuyYiHuoEDuViewController.h"
#import "BuyYiHuoEDuTableViewCell.h"
#import "RRAttributedString.h"
#import "JSONKit.h"

@interface BuyYiHuoEDuViewController ()
<UITableViewDataSource,UITableViewDelegate>
{
    NSArray * arrNum;
    
    DictionaryWrapper * ExtraData;
}
@property (retain, nonatomic) IBOutlet UILabel *keyongEDuLable;
@property (retain, nonatomic) IBOutlet UILabel *timeLable;

@property (retain, nonatomic) IBOutlet UITableView *tableview;
@property (retain, nonatomic) IBOutlet UIView *topView;

@property (retain, nonatomic) NSArray *dataArray;
@property (retain, nonatomic) IBOutlet UIButton *blackView;
@property (retain, nonatomic) IBOutlet UILabel *qinglingLableOne;
@property (retain, nonatomic) IBOutlet UILabel *qinglingTimeLable;
@property (retain, nonatomic) IBOutlet UILabel *diejiaLableOne;
@property (retain, nonatomic) IBOutlet UILabel *diejiaTimeLable;
@property (retain, nonatomic) IBOutlet UIView *blackOneView;
@property (retain, nonatomic) IBOutlet UIView *blackTwoView;
@property (retain, nonatomic) IBOutlet NSLayoutConstraint *linehight;
@property (retain, nonatomic) IBOutlet NSLayoutConstraint *lableHeight;

- (IBAction)touchBtn:(id)sender;

@property (retain, nonatomic) IBOutlet NSLayoutConstraint *lineOne;
@property (retain, nonatomic) IBOutlet NSLayoutConstraint *lineTwo;
@property (retain, nonatomic) IBOutlet NSLayoutConstraint *lineThree;
@property (retain, nonatomic) IBOutlet NSLayoutConstraint *lineFour;
@property (retain, nonatomic) IBOutlet UIView *showVIew;

@end

@implementation BuyYiHuoEDuViewController

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    InitNav(@"购买易货额度");
    
    [self setload];

    ADAPI_adv3_3_BarterQuota_PriceList([GLOBAL_DELEGATOR_MANAGER addDelegator:self selector:@selector(handleAdvertShelf:)]);
}

-(void) setload
{
    _linehight.constant = 0.5;
    _lineOne.constant = 0.5;
    _lineTwo.constant = 0.5;
    _lineThree.constant = 0.5;
    _lineFour.constant = 0.5;

    
    _blackTwoView.layer.masksToBounds = YES;
    _blackTwoView.layer.cornerRadius = 5.0;
    _blackTwoView.layer.borderWidth = 0.5;
    _blackTwoView.layer.borderColor = [[UIColor clearColor] CGColor];
    
    _topView.frame = CGRectMake(0, 0, 320, 160);
    
    _tableview.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height - 64);
    
    _tableview.tableHeaderView = _topView;
    
    _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
//    if ([[UIScreen mainScreen] bounds].size.height < 667) {
//        _qinglingLableOne.font = Font(13);
//        _qinglingTimeLable.font = Font(13);
//        _diejiaLableOne.font = Font(13);
//        _diejiaTimeLable.font = Font(13);
//    }
}

- (void)handleAdvertShelf:(DelegatorArguments *)arguments{
    DictionaryWrapper* result = arguments.ret;
    
    if (result.operationSucceed)
    {
        NSLog(@"-%@",[result.data getString:@"ExtraData"]);
        
        ExtraData = [[[result.data getString:@"ExtraData"] objectFromJSONString] wrapper];
        
        NSString * time = [ExtraData getString:@"DueDate"];
        
        if (!time || [time isKindOfClass:[NSNull class]])
        {
            _lableHeight.constant = 36;
            _timeLable.hidden = YES;
        }
        
        double text = [ExtraData getDouble:@"RemainBarterQuota"];
        
        if ([ExtraData getDouble:@"RemainBarterQuota"] >= 1000000000000){
            _keyongEDuLable.text = [NSString stringWithFormat:@"可用易货额度：无限额度"];
        }
        else
        {
            _keyongEDuLable.text = [NSString stringWithFormat:@"可用易货额度：%.2f",text];
        }
        
        NSAttributedString * nowattributedStringFour = [RRAttributedString setText:_keyongEDuLable.text color:RGBCOLOR(34,34,34) range:NSMakeRange(0, 7)];
        
        _keyongEDuLable.attributedText = nowattributedStringFour;
        
        _timeLable.text = [NSString stringWithFormat:@"有效期：%@",[UICommon formatDate:time]];
        
        [ExtraData retain];
        
        self.dataArray = [result.data getArray:@"PageData"];
        
        _showVIew.hidden = YES;
        
        _tableview.delegate = self;
        _tableview.dataSource = self;
        
        [_tableview reloadData];
    }
    else
    {
        [HUDUtil showErrorWithStatus:result.operationMessage];
        return;
    }
}

#pragma mark - tableView delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
//    return 10;
//}
//
//- (UIView *)tableView:(UITableView *)tableView viewForFooterrInSection:(NSInteger)section
//{
//    UIView *sectionView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 375, 10)] autorelease];
//    sectionView.backgroundColor = [UIColor clearColor];
//    return sectionView;
//}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"BuyYiHuoEDuTableViewCell";
    BuyYiHuoEDuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[NSBundle mainBundle] loadNibNamed:@"BuyYiHuoEDuTableViewCell" owner:nil options:nil].lastObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.layer.masksToBounds = YES;
    }
    
    if (indexPath.row +1 == _dataArray.count)
    {
        cell.lineCell.constant = -15;
    }
    
    cell.buyBtnCell.tag = indexPath.row;
    [cell.buyBtnCell addTarget:self action:@selector(buyAds:) forControlEvents:UIControlEventTouchUpInside];
    cell.dataDic = _dataArray[indexPath.row];
    return cell;
}

- (void)buyAds:(UIButton *)button
{
    NSInteger row = button.tag;

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString * newTime = [UICommon format19Time:[ExtraData getString:@"DueDate"]];
    
    NSDate *date = [dateFormatter dateFromString:newTime];
    
    NSDate *yearday;
    
//    if (![ExtraData getString:@"DueDate"] || [[ExtraData getString:@"DueDate"] isKindOfClass:[NSNull class]])
//    {
        yearday =[NSDate dateWithTimeIntervalSinceNow:+(24*60*60)*367];
//    }
//    else
//    {
//        
//        yearday = [NSDate dateWithTimeInterval:+(24*60*60)*365 +(24*60*60) sinceDate:date];
//    }
    
    NSDateFormatter *formatter = [[NSDateFormatter  alloc] init];
    
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString *todayTime = [formatter stringFromDate:yearday];
    
    NSString * time = [UICommon formatDate:todayTime];
    
    _qinglingLableOne.text = [NSString stringWithFormat:@"本次新增购买额度：%.2f",[[_dataArray[row] wrapper] getDouble:@"BarterQuota"]];
    
    _qinglingTimeLable.text = [NSString stringWithFormat:@"有效期至：%@",time];
    
    _diejiaLableOne.text = [NSString stringWithFormat:@"在当前额度上增加额度：%.2f",[[_dataArray[row] wrapper] getDouble:@"BarterQuota"]];
    
    if (row +1 == _dataArray.count)
    {
        _qinglingLableOne.text = [NSString stringWithFormat:@"本次新增购买额度：无限额度"];
        _diejiaLableOne.text = [NSString stringWithFormat:@"在当前额度上增加额度：无限额度"];
    }
    
    
    NSAttributedString *String = [RRAttributedString setText:_qinglingLableOne.text color:RGBCOLOR(153,153,153) range:NSMakeRange(0, 9)];
    
    _qinglingLableOne.attributedText = String;
    
    NSAttributedString *Stringone = [RRAttributedString setText:_diejiaLableOne.text color:RGBCOLOR(153,153,153) range:NSMakeRange(0, 11)];
    
    _diejiaLableOne.attributedText = Stringone;
    
    
    if (![ExtraData getString:@"DueDate"] || [[ExtraData getString:@"DueDate"] isKindOfClass:[NSNull class]])
    {
        _diejiaTimeLable.text = [NSString stringWithFormat:@"有效期至：%@",time];
    }
    else
    {
         _diejiaTimeLable.text = [NSString stringWithFormat:@"有效期：%@",[UICommon formatDate:[ExtraData getString:@"DueDate"]]];
    }
    
    _blackOneView.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height - 64);
    
    [self.view addSubview:_blackOneView];

}

- (IBAction)touchBtn:(id)sender
{
    [_blackOneView removeFromSuperview];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

- (void)dealloc {
    [_tableview release];
    [_topView release];
    [_blackView release];
    [_qinglingLableOne release];
    [_qinglingTimeLable release];
    [_diejiaLableOne release];
    [_diejiaTimeLable release];
    [_keyongEDuLable release];
    [_timeLable release];
    [_blackOneView release];
    [_blackTwoView release];
    [_linehight release];
    [_lineOne release];
    [_lineTwo release];
    [_lineThree release];
    [_lineFour release];
    [ExtraData release];
    [_lableHeight release];
    [_showVIew release];
    [super dealloc];
}

@end
