//
//  PersonalCertificateViewController.m
//  miaozhuan
//
//  Created by apple on 14/11/27.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "PersonalCertificateViewController.h"
#import "ThankFulMechanismTableViewCell.h"
#import "PhoneAuthenticationViewController.h"
#import "RealNameAuthenticationViewController.h"
#import "RRLineView.h"

@interface PersonalCertificateViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSArray * Titlearray;
    
    NSString * IsPhoneVerified;
    NSString * IdentityStatus;
    
    DictionaryWrapper* dic;
}
@property (retain, nonatomic) IBOutlet UITableView *mainTableView;

@end

@implementation PersonalCertificateViewController
@synthesize mainTableView = _mainTableView;

-(void)viewWillAppear:(BOOL)animated
{
     dic =[APP_DELEGATE.runtimeConfig getDictionary:RUNTIME_USER_LOGIN_INFO].wrapper;
    
    if ([dic getBool:@"IsPhoneVerified"])
    {
        NSString* phone = [APP_DELEGATE.persistConfig getString:USER_INFO_NAME];
        
        NSString *str = [phone stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
        
        IsPhoneVerified = str;
    }
    else
    {
        IsPhoneVerified = @"未认证";
    }
    
    
    if ([dic getInt:@"IdentityStatus"] == 0)
    {
        IdentityStatus = @"未认证";
    }
    else if([dic getInt:@"IdentityStatus"] == 1)
    {
        IdentityStatus = @"认证成功";
    }
    else if([dic getInt:@"IdentityStatus"] == 2)
    {
        IdentityStatus = @"认证失败";
    }
    else if([dic getInt:@"IdentityStatus"] == 3)
    {
        IdentityStatus = @"认证中";
    }
    
    [IsPhoneVerified retain];
    
    [_mainTableView reloadData];
}

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    InitNav(@"个人认证");
    
    Titlearray = [[NSArray alloc] initWithObjects:@"手机认证",@"实名认证",nil];
    
    _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    _mainTableView.scrollEnabled = NO;
}

#pragma mark - tableView delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *sectionView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 10)] autorelease];
    RRLineView *linetop = WEAK_OBJECT(RRLineView, initWithFrame:CGRectMake(0, 9, 320, 1));
    [sectionView addSubview:linetop];
    
    return sectionView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [Titlearray count];
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
    
    if (indexPath.row == 0)
    {
        cell.isThankFulcellLable.text = IsPhoneVerified;
    }
    else
    {
        cell.isThankFulcellLable.text = IdentityStatus;
    }
    
    
    if (indexPath.row == 1)
    {
        cell.cellLines.left = 0;
        cell.cellLines.top = 49.5;
    }
    
    cell.thankfullcellTitle.text = Titlearray[indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        PUSH_VIEWCONTROLLER(PhoneAuthenticationViewController);
    }
    else
    {
        PUSH_VIEWCONTROLLER(RealNameAuthenticationViewController);
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
    [Titlearray release];
    
    [IsPhoneVerified release];
    
    [_mainTableView release];
    [super dealloc];
}

- (void)viewDidUnload
{
    [self setMainTableView:nil];
    [super viewDidUnload];
}
@end
