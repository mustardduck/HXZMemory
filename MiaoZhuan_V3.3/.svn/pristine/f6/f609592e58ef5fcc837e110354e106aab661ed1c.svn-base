//
//  YiHuoEDuMangerViewController.m
//  miaozhuan
//
//  Created by apple on 15/6/3.
//  Copyright (c) 2015年 zdit. All rights reserved.
//

#import "YiHuoEDuMangerViewController.h"
#import "YiHuoEDuMangerTableViewCell.h"
#import "Redbutton.h"
#import "WebhtmlViewController.h"
#import "BuyYiHuoEDuViewController.h"
#import "DetailYiHuoEDuViewController.h"

@interface YiHuoEDuMangerViewController ()
<UITableViewDelegate,UITableViewDataSource>
{
    NSArray * arrtitle;
}
@property (retain, nonatomic) IBOutlet UILabel *keyongeduNumLable;
@property (retain, nonatomic) IBOutlet UILabel *keyongeduTimeLable;
@property (retain, nonatomic) IBOutlet UILabel *dongjieeduNumLable;
@property (retain, nonatomic) IBOutlet UILabel *dongjieTimeLable;
@property (retain, nonatomic) IBOutlet UIButton *dongjieWenHaoBtn;
- (IBAction)touchUpInside:(id)sender;
@property (retain, nonatomic) IBOutlet RRLineView *topline;
@property (retain, nonatomic) IBOutlet UITableView *tableview;

@property (retain, nonatomic) IBOutlet NSLayoutConstraint *lineHight;

@property (retain, nonatomic) IBOutlet UIView *blackView;
@property (retain, nonatomic) IBOutlet UIView *blackTwoView;
@property (retain, nonatomic) IBOutlet Redbutton *okBtn;
@property (retain, nonatomic) IBOutlet UILabel *lableOne;
@property (retain, nonatomic) IBOutlet UILabel *labelTwo;
@property (retain, nonatomic) IBOutlet UILabel *lableThree;
@property (retain, nonatomic) IBOutlet NSLayoutConstraint *twoTop;
@property (retain, nonatomic) IBOutlet NSLayoutConstraint *threeTop;
@end

@implementation YiHuoEDuMangerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    InitNav(@"易货额度");
    
    [self setupMoveFowardButtonWithTitle:@"说明"];
    
    arrtitle = [[[NSArray alloc] initWithObjects:@"购买易货额度",@"易货额度明细", nil]retain];
    
    [self setload];
    
    ADAPI_adv3_3_BarterQuota_Index([GLOBAL_DELEGATOR_MANAGER addDelegator:self selector:@selector(handleAdvertShelf:)]);
}

- (void)handleAdvertShelf:(DelegatorArguments *)arguments
{
    DictionaryWrapper* wrapper = arguments.ret;
    
    if (wrapper.operationSucceed)
    {
        DictionaryWrapper *result = wrapper.data;
        
        NSString * keyongtime = [result getString:@"DueDate"];
        
        if (!keyongtime || [keyongtime isKindOfClass:[NSNull class]])
        {
            _keyongeduTimeLable.hidden = YES;
        }
        else
        {
            _keyongeduTimeLable.hidden = NO;
        }

        
        if ([result getDouble:@"RemainBarterQuota"] >= 1000000000000)
        {
            _keyongeduNumLable.text = @"无限额度";
        }
        else if ([result getDouble:@"RemainBarterQuota"] == 0)
        {
            _keyongeduTimeLable.hidden = YES;
        }
        else
        {
            _keyongeduNumLable.text =[NSString stringWithFormat:@"%@", [UICommon getStringToTwoDigitsAfterDecimalPointPlaces:[result getDouble:@"RemainBarterQuota"]withAppendStr:nil]];
        }
        
        
        _dongjieeduNumLable.text =[NSString stringWithFormat:@"%@", [UICommon getStringToTwoDigitsAfterDecimalPointPlaces:[result getDouble:@"FrozenBarterQuota"]withAppendStr:nil]];
        
        
        _keyongeduTimeLable.text = [NSString stringWithFormat:@"有效期至%@",[UICommon formatDate:keyongtime]];
        
        NSString * dongjietime = [result getString:@"DueDate"];
        
        if (!dongjietime || [dongjietime isKindOfClass:[NSNull class]])
        {
            _dongjieTimeLable.hidden = YES;
        }
        else
        {
            _dongjieTimeLable.hidden = NO;
            
            if ([result getDouble:@"FrozenBarterQuota"] == 0)
            {
                _dongjieTimeLable.hidden = YES;
            }
        }
        
        _dongjieTimeLable.text = [NSString stringWithFormat:@"有效期至%@",[UICommon formatDate:dongjietime]];
    }
    else
    {
        [HUDUtil showErrorWithStatus:wrapper.operationMessage];
        return;
    }
}


-(void) setload
{
    _lineHight.constant = 0.5;
    
    _topline.frame = CGRectMake(0, 205, 375, 0.5);
    
    _blackTwoView.layer.masksToBounds = YES;
    _blackTwoView.layer.cornerRadius = 5.0;
    _blackTwoView.layer.borderWidth = 0.5;
    _blackTwoView.layer.borderColor = [[UIColor clearColor] CGColor];
    
    _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    _tableview.scrollEnabled = NO;
    
    _tableview.delegate = self;
    _tableview.dataSource = self;
    
    [_tableview reloadData];
}

- (void) onMoveFoward:(UIButton *)sender
{
    WebhtmlViewController *view = WEAK_OBJECT(WebhtmlViewController, init);
    view.navTitle = @"易货额度说明";
    view.ContentCode = @"0018da881a4be850a0195f1e4ded6677";
    [self.navigationController pushViewController:view animated:YES];
}

- (IBAction)touchUpInside:(id)sender
{
    if (sender == _dongjieWenHaoBtn)
    {
        [self.view addSubview:_blackView];
        _blackView.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height - 64);
        if ([[UIScreen mainScreen] bounds].size.height < 667)
        {
            _lableOne.font = Font(12);
            _labelTwo.font = Font(12);
            _lableThree.font = Font(12);
//            _twoTop.constant = 48;
//            _threeTop.constant = 76;
        }
    }
    else if(sender == _okBtn)
    {
        [_blackView removeFromSuperview];
    }
}

#pragma mark - tableView delegate

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
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"YiHuoEDuMangerTableViewCell";
    YiHuoEDuMangerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[NSBundle mainBundle] loadNibNamed:@"YiHuoEDuMangerTableViewCell" owner:nil options:nil].lastObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.layer.masksToBounds = YES;
    }
    
    if (indexPath.row == 1)
    {
        cell.lineCellLeft.constant = -15;
    }
    
    cell.titleCell.text = arrtitle[indexPath.row];
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        PUSH_VIEWCONTROLLER(BuyYiHuoEDuViewController);
    }
    else if (indexPath.row == 1)
    {
        PUSH_VIEWCONTROLLER(DetailYiHuoEDuViewController);
    }
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    YiHuoEDuMangerTableViewCell *cell = (YiHuoEDuMangerTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.contentView.backgroundColor = AppColor(220);
    return YES;
}

- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    YiHuoEDuMangerTableViewCell *cell = (YiHuoEDuMangerTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor whiteColor];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

- (void)dealloc {
    [_keyongeduNumLable release];
    [_keyongeduTimeLable release];
    [_dongjieeduNumLable release];
    [_dongjieTimeLable release];
    [_dongjieWenHaoBtn release];
    [_tableview release];
    [arrtitle release];
    [_topline release];
    [_blackView release];
    [_blackTwoView release];
    [_okBtn release];
    [_lineHight release];
    [_lableOne release];
    [_labelTwo release];
    [_lableThree release];
    [_twoTop release];
    [_threeTop release];
    [super dealloc];
}

@end
