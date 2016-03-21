//
//  AboutViewController.m
//  miaozhuan
//
//  Created by abyss on 14/11/24.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "AboutViewController.h"
#import "QRCodeGenerator.h"
#import "NetImageView.h"
#import "UserInfo.h"
#import "ThankFulMechanismTableViewCell.h"
#import "FeedbackViewController.h"
#import "WebhtmlViewController.h"
#import "CRPoint.h"
#import "SystemUtil.h"
#import <StoreKit/StoreKit.h>
#import "RRLineView.h"

@interface AboutViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,SKStoreProductViewControllerDelegate>
{
    NSArray * titlearray;
    
    UILabel *_text;
//    CRPoint *_point;
    
    UIView * _point;
    
    BOOL      _downFlag;
    NSString* _downloadUrl;
    
    SKStoreProductViewController *_storeBox;
}
@property (retain, nonatomic) IBOutlet UILabel *versionL;
@property (retain, nonatomic) IBOutlet UIImageView *codeImg;
@property (retain, nonatomic) IBOutlet UIScrollView *mainScrollView;
@property (retain, nonatomic) IBOutlet UITableView *mainTableView;

@end

@implementation AboutViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    ADAPI_adv3_Checkver([self genDelegatorID:@selector(handleAbout:)]);
    InitNav(@"关于秒赚");
    _versionL.text = [NSString stringWithFormat:@"秒赚 %@",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
    
    _codeImg.layer.borderWidth = 0.5;
    _codeImg.layer.borderColor = [RGBCOLOR(197, 197, 197) CGColor];
    
    //生成二维码
    NSString * HexPhone = [self TenToSixteen:USER_MANAGER.phone];
    NSString * erWeiUrl = [NSString stringWithFormat:@"http://down.inkey.com/Download/Down/%@" , HexPhone];
    _codeImg.image = [QRCodeGenerator qrImageForString:erWeiUrl imageSize:_codeImg.bounds.size.width];
    
    titlearray = [[NSArray alloc] initWithObjects:@"帮助/反馈",@"功能介绍",@"公司简介",@"版本检测",@"去评分",nil];
    
    _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    _mainTableView.scrollEnabled = NO;
    
    if ([[UIScreen mainScreen] bounds].size.height < 568)
    {
        [_mainScrollView setContentSize:CGSizeMake(320, 640)];
    }
}

- (void)handleAbout:(DelegatorArguments *)arg
{
    if (arg.ret.operationSucceed)
    {
        DictionaryWrapper *warpper = arg.ret.data;
        
        if ([warpper getInt:@"Status"] > 1)
        {
            _downFlag       = YES;
            
            _text.text      = @"发现新版本";
            _text.textColor = AppColorRed;
            _text.font      = Font(14);
            
            _downloadUrl = [warpper getString:@"Downurl"];
            if (_downloadUrl.length < 1) _downloadUrl = @"";
        }
        else
        {
            _text.text = @"当前已是最新版本";
            _text.textColor = AppColorGray153;
            _text.font = Font(14);
        }
    }
}

-(NSString *)TenToSixteen : (NSString *)tenStr  //10进制字符串转换成16进制字符串
{
    long long tenInt = [tenStr longLongValue];
    NSMutableString * HexStr = [[[NSMutableString alloc] init] autorelease];
    do {
        [HexStr appendString:[NSString stringWithFormat:@"%llx" , tenInt % 16 ]];
        tenInt = tenInt / 16;
    }while (tenInt);
    NSString * hexStr = [self reverseString:HexStr];
    return hexStr;
}

-(NSMutableString *)reverseString : (NSString *)str  //倒序字符串
{
    NSMutableString * reverseStr = [[[NSMutableString alloc] init] autorelease];
    int count = [str length];
    for(int i = count - 1 ; i >= 0 ; i --)
    {
        char c = [str characterAtIndex:i];
        [reverseStr appendString:[NSString stringWithFormat:@"%c" , c]];
    }
    return  reverseStr;
}

#pragma mark - tableView delegate

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *sectionView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 1)] autorelease];
    RRLineView *linetop = WEAK_OBJECT(RRLineView, initWithFrame:CGRectMake(0, 0, 320, 1));
    linetop.backgroundColor = RGBACOLOR(204, 204, 204, 1);
    [sectionView addSubview:linetop];
    
    return sectionView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [titlearray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ThankFulMechanismTableViewCell";
    ThankFulMechanismTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[NSBundle mainBundle] loadNibNamed:@"ThankFulMechanismTableViewCell" owner:nil options:nil].lastObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.layer.masksToBounds = YES;
    }
    
    if (indexPath.row == 1)
    {
        _point = [[UIView alloc]initWithFrame:CGRectMake(87, 20, 8, 8)];
        
        [cell.contentView addSubview:_point];
        
        _point.backgroundColor = RGBCOLOR(255, 132, 0);
        
        [_point setRoundCornerAll];
        
//        _point = [[[CRPoint alloc] initWithNum:0 In:AppColorRed at:CGPointMake(88, 24)] autorelease];
        [cell.contentView addSubview:_point];
        
        NSString *base = @"FunctionFlag";
        NSString *key  = [base stringByAppendingString:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
        id objet = [[NSUserDefaults standardUserDefaults] objectForKey:key];
        if (objet == nil) _point.hidden = NO;
        else _point.hidden = YES;
    }
    
    if (indexPath.row == 3)
    {
        _text = [[[UILabel alloc] initWithFrame:CGRectMake(130, 14, 160, 20)] autorelease];
        [cell.contentView addSubview:_text];
        _text.textAlignment = NSTextAlignmentRight;
    }
    
    if (indexPath.row == 4)
    {
        cell.cellLines.left = 0;
    }
    
    cell.cellLines.top = 49.5;
    cell.thankfullcellTitle.text = titlearray[indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        PUSH_VIEWCONTROLLER(FeedbackViewController);
    }
    else if(indexPath.row == 1)
    {
        PUSH_VIEWCONTROLLER(WebhtmlViewController);
        model.navTitle = @"功能介绍";
        model.ContentCode = @"b65d31f5ed436d7da0e1fbd1c271a2b0";
        
        NSString *base = @"FunctionFlag";
        NSString *key  = [base stringByAppendingString:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
        [[NSUserDefaults standardUserDefaults] setObject:@(1) forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
        _point.hidden = YES;
    }
    else if(indexPath.row == 2)
    {
        PUSH_VIEWCONTROLLER(WebhtmlViewController);
        model.navTitle = @"公司简介";
        model.ContentCode = @"458a7934b00e2571e1c647a099722de9";
    }
    else if(indexPath.row == 3)
    {
        if(!_downFlag) return;
        
        NSString *url = [NSString stringWithFormat:@"http://a.zdit.cn"];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
    }
    else if(indexPath.row == 4)
    {
        NSString * nsAppId = @"839432696";
        
        NSString  * nsStringToOpen = [NSString  stringWithFormat: @"itms://itunes.apple.com/us/app/miao-zhuan-guang-gao/id839432696?l=zh&ls=1&mt=8&id=%@",nsAppId  ];
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:nsStringToOpen]];
    }
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    ThankFulMechanismTableViewCell *cell = (ThankFulMechanismTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.contentView.backgroundColor = AppColor(220);
    return YES;
}

- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    ThankFulMechanismTableViewCell *cell = (ThankFulMechanismTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor whiteColor];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
    [_point release];
    [_versionL release];
    [_codeImg release];
    [_mainScrollView release];
    [_mainTableView release];
    [super dealloc];
}

- (void)viewDidUnload
{
    [self setVersionL:nil];
    [self setCodeImg:nil];
    [self setMainScrollView:nil];
    [self setMainTableView:nil];
    [super viewDidUnload];
}
@end
