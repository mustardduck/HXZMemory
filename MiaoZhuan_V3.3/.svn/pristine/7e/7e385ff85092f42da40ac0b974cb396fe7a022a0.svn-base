//
//  DetailSiteChangeViewController.m
//  miaozhuan
//
//  Created by apple on 14/12/26.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "DetailSiteChangeViewController.h"
#import "RRAttributedString.h"
#import "DetailSiteChangeTableViewCell.h"
#import "Redbutton.h"
#import "GaoDeMapViewController.h"
#import "QRCodeGenerator.h"
#import "RRLineView.h"
@interface DetailSiteChangeViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
{
    DictionaryWrapper * dic;
    NSArray * addressArr;
}
@property (retain, nonatomic) IBOutlet UIScrollView *scrollerView;

//兑换二维码
@property (retain, nonatomic) IBOutlet UIView *topVIew;
@property (retain, nonatomic) IBOutlet UIImageView *changeErweimaView;
@property (retain, nonatomic) IBOutlet UILabel *changeErweiMaNumLable;
@property (retain, nonatomic) IBOutlet UIView *changeErweiMaView;

//商品信息
@property (retain, nonatomic) IBOutlet UIView *changShipPingView;
@property (retain, nonatomic) IBOutlet UILabel *changeShippingNameLable;
@property (retain, nonatomic) IBOutlet UILabel *changeShippingNeedMoneyLable;
@property (retain, nonatomic) IBOutlet UILabel *changeNumLable;
@property (retain, nonatomic) IBOutlet UILabel *changeTimeLable;
@property (retain, nonatomic) IBOutlet UILabel *changeMoneyAllLable;

@property (retain, nonatomic) IBOutlet UITableView *addressTableVIew;

@property (retain, nonatomic) IBOutlet UIView *tableTopVIew;

@property (retain, nonatomic) IBOutlet UIView *BtnView;
@property (retain, nonatomic) IBOutlet Redbutton *cheXiaoBtn;

- (IBAction)touchUpInside:(id)sender;

@end

@implementation DetailSiteChangeViewController

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad
{
    [super viewDidLoad];
    InitNav(_ProductName);
    

    
    [_addressTableVIew setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    ADAPI_adv3_ExchangeManagement_CustomerGetExchangeOrderDetail([self genDelegatorID:@selector(HandleNotification:)], _OrderNo);
}

- (void)HandleNotification:(DelegatorArguments *)arguments
{
    if ([arguments isEqualToOperation:ADOP_adv3_ExchangeManagement_CustomerGetExchangeOrderDetail])
    {
        [arguments logError];
        
        DictionaryWrapper *wrapper = arguments.ret;
        
        if (wrapper.operationSucceed)
        {
            dic = wrapper.data;
            [dic retain];
            
            [self ResultLoad:dic];
        }
        else if (wrapper.operationErrorCode || wrapper.operationPromptCode)
        {
            [AlertUtil showAlert:@"" message:wrapper.operationMessage buttons:@[@"好的"]];
        }
    }
    else if ([arguments isEqualToOperation:ADOP_adv3_ExchangeManagement_CustomerCancelExchangeOrder])
    {
        [arguments logError];
        
        DictionaryWrapper *wrapper = arguments.ret;
        
        if (wrapper.operationSucceed)
        {
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"撤销成功" message:@"银元已退回您的银元账户" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alert show];
            alert.tag = 2;
            [alert release];
        }
        else if (wrapper.operationErrorCode || wrapper.operationPromptCode)
        {
            [AlertUtil showAlert:@"" message:wrapper.operationMessage buttons:@[@"好的"]];
        }
    }
}

-(void) ResultLoad : (DictionaryWrapper *) result
{
    addressArr = [result getArray:@"ExchangeAddresses"];
    
    [addressArr retain];
    
    _changeErweiMaView.layer.borderWidth = 0.5;
    _changeErweiMaView.layer.borderColor = [RGBCOLOR(204, 204, 204) CGColor];
    
    _changeErweimaView.layer.borderWidth = 0.5;
    _changeErweimaView.layer.borderColor = [RGBCOLOR(204, 204, 204) CGColor];

    
    //二维码
    _changeErweiMaNumLable.text = [result getString:@"ExchangeNo"];
    
    //生成二维码
    NSString * HexPhone = [result getString:@"ExchangeNo"];
    _changeErweimaView.image = [QRCodeGenerator qrImageForString:HexPhone imageSize:_changeErweimaView.bounds.size.width];

    //商品信息
    _changeShippingNameLable.text = [result getString:@"ProductName"];
    _changeShippingNeedMoneyLable.text = [NSString stringWithFormat:@"所需银元  %d",[result getInt:@"TotalPrice"]];
    
    NSString * time = [result getString:@"OrderTime"];
    
    time = [UICommon format19Time:time];
    
    _changeTimeLable.text = [NSString stringWithFormat:@"下单时间  %@",time];
    _changeNumLable.text = [NSString stringWithFormat:@"兑换数量  %d",[result getInt:@"ItemCount"]];
    _changeMoneyAllLable.text = [NSString stringWithFormat:@"订单编号  %@",[result getString:@"OrderNo"]];
    
    NSAttributedString * attributedStringOne= [RRAttributedString setText:_changeShippingNeedMoneyLable.text color:RGBCOLOR(153, 153, 153) range:NSMakeRange(0, 6)];
    
    _changeShippingNeedMoneyLable.attributedText = attributedStringOne;
    
    
    NSAttributedString * attributedStringTwo= [RRAttributedString setText:_changeNumLable.text color:RGBCOLOR(153, 153, 153) range:NSMakeRange(0, 6)];
    
    _changeNumLable.attributedText = attributedStringTwo;
    
    NSAttributedString * attributedStringThree= [RRAttributedString setText:_changeTimeLable.text color:RGBCOLOR(153, 153, 153) range:NSMakeRange(0, 6)];
    
    _changeTimeLable.attributedText = attributedStringThree;
    
    NSAttributedString * attributedStringFour= [RRAttributedString setText:_changeMoneyAllLable.text color:RGBCOLOR(153, 153, 153) range:NSMakeRange(0, 6)];
    
    _changeMoneyAllLable.attributedText = attributedStringFour;
    
    
    [_scrollerView addSubview:_topVIew];
    [_scrollerView addSubview:_changShipPingView];
    [_scrollerView addSubview:_tableTopVIew];
    [_scrollerView addSubview:_addressTableVIew];
    
    _topVIew.frame = CGRectMake(0, 10, 320, 215);
    _changShipPingView.frame = CGRectMake(0, 235, 320, 164);
    _tableTopVIew.frame = CGRectMake(0, 409, 320, 30);
    
    RRLineView * line = [[RRLineView alloc] initWithFrame:CGRectMake(0, 0, 320, 0.5)];
    [_tableTopVIew addSubview:line];
    
    if ([result getInt:@"ExchangeStatus"] == 0)
    {
        //撤销
        _addressTableVIew.frame = CGRectMake(0, 439, 320, (addressArr.count * 210) - 30);
        
        [_scrollerView setContentSize:CGSizeMake(320, _topVIew.frame.size.height + _changShipPingView.frame.size.height + _tableTopVIew.frame.size.height + _addressTableVIew.frame.size.height + 40)];
        
        _scrollerView.frame = CGRectMake(0, 0, 320, [[UIScreen mainScreen] bounds].size.height -64 - 65);
        
        [self.view addSubview:_BtnView];
        
        _BtnView.frame = CGRectMake(0, [[UIScreen mainScreen] bounds].size.height -64 - 65, 320, 65);
    }
    else
    {
        _scrollerView.frame = CGRectMake(0, 0, 320, [[UIScreen mainScreen] bounds].size.height -64);
        
        _addressTableVIew.frame = CGRectMake(0, 439, 320, (addressArr.count * 210) - 30);
        
        [_scrollerView setContentSize:CGSizeMake(320, _topVIew.frame.size.height + _changShipPingView.frame.size.height + _tableTopVIew.frame.size.height + _addressTableVIew.frame.size.height + 40)];
    }
    
    [_addressTableVIew reloadData];
    _addressTableVIew.delegate = self;
    _addressTableVIew.dataSource= self;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [addressArr count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 0;
    }
    else
    {
        return 30;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *sectionView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 30)] autorelease];
    sectionView.backgroundColor = [UIColor whiteColor];
    
    RRLineView *linetop = WEAK_OBJECT(RRLineView, initWithFrame:CGRectMake(61, 20, 82, 0.5));
    [sectionView addSubview:linetop];
    
    RRLineView *linetoptwo = WEAK_OBJECT(RRLineView, initWithFrame:CGRectMake(172, 20, 82, 0.5));
    linetoptwo.backgroundColor = RGBACOLOR(204, 204, 204, 1);
    [sectionView addSubview:linetoptwo];

    UILabel * lable = WEAK_OBJECT(UILabel, initWithFrame:CGRectMake(151, 10, 20, 20));
    lable.text = @"或";
    lable.textColor = RGBCOLOR(153, 153, 153);
    lable.font = Font(15);
    [sectionView addSubview:lable];
    
    return sectionView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 180;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"DetailSiteChangeTableViewCell";
    
    DetailSiteChangeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[NSBundle mainBundle] loadNibNamed:@"DetailSiteChangeTableViewCell" owner:nil options:nil].lastObject;
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.layer.masksToBounds = YES;
    }
    
    cell.cellAddressLable.text = [[[addressArr objectAtIndex:indexPath.section]wrapper]getString:@"DetailedAddress"];
    cell.cellPhoneLable.text = [[[addressArr objectAtIndex:indexPath.section]wrapper]getString:@"ContactNumber"];
    cell.cellTimeLable.text = [[[addressArr objectAtIndex:indexPath.section]wrapper]getString:@"ExchangeTime"];

    cell.cellLineOne.frame = CGRectMake(0, 179.5, 320, 0.5);
    
    if ([addressArr count] == indexPath.section + 1)
    {
        cell.cellLineOne.hidden = NO;
    }
    
    [cell.cellMapBtn addTarget:self action:@selector(mapBtnTouch:) forControlEvents:UIControlEventTouchUpInside];
    cell.cellMapBtn.tag = indexPath.section;
    
    [cell.cellPhoneBtn addTarget:self action:@selector(PhoneBtnTouch:) forControlEvents:UIControlEventTouchUpInside];
    cell.cellPhoneBtn.tag = indexPath.section;
    
    return cell;
}

- (void)mapBtnTouch:(UIButton *)button
{
    //地图
    PUSH_VIEWCONTROLLER(GaoDeMapViewController);
    model.longitude = [[[addressArr objectAtIndex:button.tag]wrapper]getDouble:@"Lng"];
    model.latidiute = [[[addressArr objectAtIndex:button.tag]wrapper]getDouble:@"Lat"];
    model.markScrollWithMap = 1;
    model.hiddenRightItem = YES;
}

- (void)PhoneBtnTouch:(UIButton *)button
{
    //电话
    [[UICommon shareInstance]makeCall:[[[addressArr objectAtIndex:button.tag]wrapper]getString:@"ContactNumber"]];
}

- (IBAction)touchUpInside:(id)sender
{
    //撤销
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"" message:@"确定撤销本次兑换吗" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
    [alert release];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 2)
    {
        if (buttonIndex == 0)
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    else
    {
        if (buttonIndex == 1)
        {
            ADAPI_adv3_ExchangeManagement_CustomerCancelExchangeOrder([self genDelegatorID:@selector(HandleNotification:)], _OrderNo);
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
    [_cheXiaoBtn release];
    [_BtnView release];
    [_tableTopVIew release];
    [dic release];
    [addressArr release];
    [_addressTableVIew release];
    [_changeMoneyAllLable release];
    [_changeTimeLable release];
    [_changeNumLable release];
    [_changeShippingNeedMoneyLable release];
    [_changeShippingNameLable release];
    [_changShipPingView release];
    [_changeErweiMaView release];
    [_changeErweiMaNumLable release];
    [_changeErweimaView release];
    [_topVIew release];
    [_scrollerView release];
    [super dealloc];
}
- (void)viewDidUnload
{
    [self setAddressTableVIew:nil];
    [self setChangeMoneyAllLable:nil];
    [self setChangeTimeLable:nil];
    [self setChangeNumLable:nil];
    [self setChangeShippingNeedMoneyLable:nil];
    [self setChangeShippingNameLable:nil];
    [self setChangShipPingView:nil];
    [self setChangeErweiMaView:nil];
    [self setChangeErweiMaNumLable:nil];
    [self setChangeErweimaView:nil];
    [self setTopVIew:nil];
    [self setScrollerView:nil];
    [super viewDidUnload];
}

@end
