//
//  PersonalCenterViewController.m
//  test
//
//  Created by 孙向前 on 14-10-21.
//  Copyright (c) 2014年 sunxq_xiaoruan. All rights reserved.
//

#import "PersonalCenterViewController.h"
#import "PersonalCenterTableViewCell.h"

#import "MyCashHomeViewController.h"
#import "CommonSettingViewController.h"
#import "AboutViewController.h"
#import "ThankFulMechanismViewController.h"
#import "UserInfo.h"
#import "PersonalCertificateViewController.h"
#import "OwnSliverManagerViewController.h"
#import "MyGoldMainController.h"
#import "PersonalProfileViewController.h"
#import "ExchangeMangerEntranceViewController.h"


//测试跳转
#import "ApplyToBeMerchantStep2.h"
#import "DisagreeRerurnViewController.h"
#import "ChooseLoticticsViewController.h"
#import "ControlViewController.h"
#import "MyYHMController.h"

typedef NS_ENUM(NSUInteger, PersonnalCenterPushTarget)
{
    PersonnalCenterPushTargetPersonalCertificate = 0,
    PersonnalCenterPushTargetThankFulMechanism,
    PersonnalCenterPushTargetMySilver,
    PersonnalCenterPushTargetMyCash,
    PersonnalCenterPushTargetMyGold,
    PersonnalCenterPushTargetYHM,
    PersonnalCenterPushTargetExchange,
    PersonnalCenterPushTargetCommonSetting,
    PersonnalCenterPushTargetAbout,
};

@interface PersonalCenterViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *_titleArray;
    NSArray *_imgArray;
    
    NSMutableArray *_countArray;
    
    BOOL _isAdmin;
    BOOL _isVip7;
    BOOL _pageCount;
    BOOL _isNormal;
}
@end

@implementation PersonalCenterViewController
@synthesize tableView = _tableView;
@synthesize headView = _headView;
@synthesize vip = _vip;
@synthesize headImg = _headImg;
@synthesize nameL = _nameL;
@synthesize IDL = _IDL;

- (void)dealloc
{
    [_imgArray release];
    [_titleArray release];
    [_headView release];
    [_tableView release];
    
    [_vip release];
    [_headImg release];
    [_nameL release];
    [_IDL release];
    [_lineImageOne release];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
    }
    return self;
}

- (void)viewRefresh
{
    ADAPI_adv3_Me_getCount([self genDelegatorID:@selector(me:)]);
}

- (void)me:(DelegatorArguments *)arg
{
    [arg logError];
    DictionaryWrapper *wrapper = arg.ret;
    if (wrapper.operationSucceed)
    {
        if (!_countArray) _countArray = [NSMutableArray new];
        [_countArray removeAllObjects];
        [_countArray addObject:@([wrapper.data getInt:@"SilverIntegral"])];
        [_countArray addObject:@([wrapper.data getDouble:@"CashIntegral"])];
        [_countArray addObject:@([wrapper.data getDouble:@"GoldIntegral"])];
        [_countArray addObject:@([wrapper.data getDouble:@"BarterCode"])];
        [_countArray retain];
        
        [_headImg requestPic:USER_MANAGER.userPic placeHolder:NO];
        [_headImg setRoundCorner:11.f];
//        [_headImg setBorderWithColor:AppColor(197)];
        _vip.image = [USER_MANAGER getVipPic:(USER_MANAGER.vipLevel)];
        
        int leng = (int)USER_MANAGER.userName.length;
        BOOL tooLong = leng>14;
        _nameL.text = tooLong?[[USER_MANAGER.userName substringToIndex:13] stringByAppendingString:@"..."]:USER_MANAGER.userName;
        if (leng == 0) _nameL.text = @"未编辑姓名";
        if(tooLong) _IDL.top = AppGetTextHeight(_nameL) + 1;
        _IDL.text = [NSString stringWithFormat:@"账号: %@",USER_MANAGER.phone];
        _vip.left = [UICommon getHeightFromLabel:_nameL].width + _nameL.left + 6;
        if (tooLong)
        {
            //
        }
        else
        {
            _vip.top  = _nameL.top + _nameL.height/2 - _vip.height/2;
        }
        [_tableView reloadData];
    }
    else
    {
        [HUDUtil showErrorWithStatus:wrapper.operationMessage];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    _pageCount ++;
    [MTA trackPageViewBegin:NSStringFromClass([self class])];
    
    [self initSetting];
    [_tableView reloadData];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    if (_pageCount > 0)
    {
        [MTA trackPageViewEnd:NSStringFromClass([self class])];
        _pageCount --;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _lineImageOne.top = 89.5;
    [self viewRefresh];
    if (!_countArray) _countArray = [NSMutableArray new];
    [_countArray removeAllObjects];
    _countArray = [NSMutableArray arrayWithArray:@[@0,@0,@0,@0]];
    [_countArray retain];
    [self setNavigateTitle:@"我"];
    [self initSetting];
    [self initTable];
    self.view.backgroundColor = AppColorBackground;
}

- (void)initSetting
{
    NSLog(@"%d",_isAdmin);
    DictionaryWrapper * dic =[APP_DELEGATE.runtimeConfig getDictionary:RUNTIME_USER_LOGIN_INFO].wrapper;

    _isAdmin = [dic getInt:@"EnterpriseStatus"] == 4;
    
    if(USER_MANAGER.vipLevel == 7)
    {
        _isVip7 = YES;
    }
    else
    {
        _isVip7 = NO;
    }
    
    if(_isAdmin)
    {
        _titleArray = @[@"个人认证",@"感恩机制",@"我的银元",@"我的现金",@"我的广告金币",@"我的易货码",@"店小二专用入口",@"通用设置",@"关于秒赚"];
        
        _imgArray = @[@"MeIcon001",@"MeIcon002",@"MeIcon003",@"MeIcon004",@"MeIcon005",@"yhmMINIICON",@"home_managericon",@"MeIcon006",@"MeIcon007"];
    }
    else
    {
        if(_isVip7 == YES)
        {
            if (USER_MANAGER.IsExchangeAdmin == YES)
            {
                _titleArray = @[@"个人认证",@"感恩机制",@"我的银元",@"我的现金",@"我的广告金币",@"我的易货码",@"店小二专用入口",@"通用设置",@"关于秒赚"];
                
                _imgArray = @[@"MeIcon001",@"MeIcon002",@"MeIcon003",@"MeIcon004",@"MeIcon005",@"yhmMINIICON",@"home_managericon",@"MeIcon006",@"MeIcon007"];
            }
            else
            {
                _titleArray = @[@"个人认证",@"感恩机制",@"我的银元",@"我的现金",@"我的广告金币",@"我的易货码",@"通用设置",@"关于秒赚"];
                
                _imgArray = @[@"MeIcon001",@"MeIcon002",@"MeIcon003",@"MeIcon004",@"MeIcon005",@"yhmMINIICON",@"MeIcon006",@"MeIcon007"];
            }
        }
        else
        {
            if (USER_MANAGER.IsExchangeAdmin == YES)
            {
                _titleArray = @[@"个人认证",@"感恩机制",@"我的银元",@"我的现金",@"店小二专用入口",@"通用设置",@"关于秒赚"];
                
                _imgArray = @[@"MeIcon001",@"MeIcon002",@"MeIcon003",@"MeIcon004",@"home_managericon",@"MeIcon006",@"MeIcon007"];
            }
            else
            {
                _titleArray = @[@"个人认证",@"感恩机制",@"我的银元",@"我的现金",@"通用设置",@"关于秒赚"];
                
                _imgArray = @[@"MeIcon001",@"MeIcon002",@"MeIcon003",@"MeIcon004",@"MeIcon006",@"MeIcon007"];
            }
        }
    }
    [_titleArray retain];
    
    [_imgArray retain];
}

- (void)initTable
{
    _tableView.tableHeaderView = _headView;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = AppColorBackground;
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableView delegate

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    PersonalCenterTableViewCell *cell = (PersonalCenterTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.contentView.backgroundColor = AppColor(220);
    return YES;
}
- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    PersonalCenterTableViewCell *cell = (PersonalCenterTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor whiteColor];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger holder = indexPath.row;
    if (holder == 0)
    {
        [UI_MANAGER.mainNavigationController pushViewController:WEAK_OBJECT(PersonalCertificateViewController, init) animated:YES];
        return;
    }
    else if (holder == 1)
    {
        [UI_MANAGER.mainNavigationController pushViewController:WEAK_OBJECT(ThankFulMechanismViewController, init) animated:YES];
        return;
    }
    else if (holder == 2)
    {
        [UI_MANAGER.mainNavigationController pushViewController:WEAK_OBJECT(OwnSliverManagerViewController, init) animated:YES];
        return;
    }
    else if (holder == 3)
    {
        [UI_MANAGER.mainNavigationController pushViewController:WEAK_OBJECT(MyCashHomeViewController, init) animated:YES];
        return;
    }
    else if (holder == 4)
    {
        if(_isVip7 || _isAdmin)
        {
            [UI_MANAGER.mainNavigationController pushViewController:WEAK_OBJECT(MyGoldMainController, init) animated:YES];
            return;
        }
        else
        {
            if (USER_MANAGER.IsExchangeAdmin == YES)
            {
                [UI_MANAGER.mainNavigationController pushViewController:WEAK_OBJECT(ExchangeMangerEntranceViewController, init) animated:YES];
                return;
            }
            else
            {
                [UI_MANAGER.mainNavigationController pushViewController:WEAK_OBJECT(CommonSettingViewController, init) animated:YES];
                return;
            }
        }
        return;
    }
    else if (holder == 5)
    {
        if(_isVip7 || _isAdmin)
        {
            [UI_MANAGER.mainNavigationController pushViewController:WEAK_OBJECT(MyYHMController, init) animated:YES];
            return;
        }
        else
        {
            if (USER_MANAGER.IsExchangeAdmin == YES)
            {
                [UI_MANAGER.mainNavigationController pushViewController:WEAK_OBJECT(CommonSettingViewController, init) animated:YES];
                return;
            }
            else
            {
                [UI_MANAGER.mainNavigationController pushViewController:WEAK_OBJECT(AboutViewController, init) animated:YES];
                return;
            }
        }
        return;
    }
    else if (holder == 6)
    {
        if(_isAdmin)
        {
            [UI_MANAGER.mainNavigationController pushViewController:WEAK_OBJECT(ExchangeMangerEntranceViewController, init) animated:YES];
            return;
        }
        else if (_isVip7)
        {
            if (USER_MANAGER.IsExchangeAdmin == YES)
            {
                [UI_MANAGER.mainNavigationController pushViewController:WEAK_OBJECT(ExchangeMangerEntranceViewController, init) animated:YES];
                return;
            }
            else
            {
                [UI_MANAGER.mainNavigationController pushViewController:WEAK_OBJECT(CommonSettingViewController, init) animated:YES];
                return;
            }
        }
        else
        {
            if (USER_MANAGER.IsExchangeAdmin == YES)
            {
                [UI_MANAGER.mainNavigationController pushViewController:WEAK_OBJECT(AboutViewController, init) animated:YES];
                return;
            }
            else
            {
                [UI_MANAGER.mainNavigationController pushViewController:WEAK_OBJECT(AboutViewController, init) animated:YES];
                return;
            }
        }
        return;
    }
    else if (holder == 7)
    {
        if(_isAdmin)
        {
            [UI_MANAGER.mainNavigationController pushViewController:WEAK_OBJECT(CommonSettingViewController, init) animated:YES];
            return;
        }
        else if (_isVip7)
        {
            if (USER_MANAGER.IsExchangeAdmin == YES)
            {
                [UI_MANAGER.mainNavigationController pushViewController:WEAK_OBJECT(CommonSettingViewController, init) animated:YES];
                return;
            }
            else
            {
                [UI_MANAGER.mainNavigationController pushViewController:WEAK_OBJECT(AboutViewController, init) animated:YES];
                return;
            }
        }
        return;
    }
    else if (holder == 8)
    {
        [UI_MANAGER.mainNavigationController pushViewController:WEAK_OBJECT(AboutViewController, init) animated:YES];
        return;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(_isAdmin)
    {
        if (indexPath.row == 1 ||indexPath.row == 5 || indexPath.row == 6)
        {
            return 61;
        }
        else if (indexPath.row == 8)
        {
            return 60;
        }
        else return 50;
    }
    else if(_isVip7)
    {
        if (USER_MANAGER.IsExchangeAdmin == YES)
        {
            if (indexPath.row == 1 ||indexPath.row == 5 || indexPath.row == 6)
            {
                return 61;
            }
            else if (indexPath.row == 8)
            {
                return 60;
            }
            else return 50;
        }
        else
        {
            if (indexPath.row == 1 ||indexPath.row == 5)
            {
                return 61;
            }
            else if (indexPath.row == 7)
            {
                return 60;
            }
            else return 50;
        }
    }
    else
    {
        if (USER_MANAGER.IsExchangeAdmin == YES)
        {
            if (indexPath.row == 1 ||indexPath.row == 3 ||indexPath.row == 4)
            {
                return 61;
            }
            else if (indexPath.row == 6)
            {
                return 60;
            }
            else return 50;
        }
        else
        {
            if (indexPath.row == 1 ||indexPath.row == 3)
            {
                return 61;
            }
            else if (indexPath.row == 5)
            {
                return 60;
            }
            else return 50;
        }
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"PersonalCenterTableViewCell";
    PersonalCenterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[NSBundle mainBundle] loadNibNamed:@"PersonalCenterTableViewCell" owner:nil options:nil].lastObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.layer.masksToBounds = YES;
    }
    cell.img.image = [UIImage imageNamed:_imgArray[indexPath.row]];
    cell.titleL.text = _titleArray[indexPath.row];
    
    if (indexPath.row == 0)
    {
        UIImageView *icon = WEAK_OBJECT(UIImageView, initWithFrame:CGRectMake(299 - 32 -28, 15, 20, 20));
        UIImageView *icon_1 = WEAK_OBJECT(UIImageView, initWithFrame:CGRectMake(299 - 12 - 20, 15, 20, 20));
        icon_1.image      = USER_MANAGER.IsNameVerified?[UIImage imageNamed:@"MeIcon008"]:[UIImage imageNamed:@"icon008_01"];
        icon.image    = USER_MANAGER.IsPhoneVerified?[UIImage imageNamed:@"MeIcon009"]:[UIImage imageNamed:@"icon009_01"];
        [cell.contentView addSubview:icon];
        [cell.contentView addSubview:icon_1];
    }
    
    int level = USER_MANAGER.vipLevel;
    
    _isNormal = !_isAdmin && level != 7;
    
    if (indexPath.row >= 2 && indexPath.row <= 5)
    {
        UILabel *count = WEAK_OBJECT(UILabel , initWithFrame:CGRectMake(200, 0, 86, 50));
        count.textAlignment = NSTextAlignmentRight;
        count.font = Font(14);
        count.textColor = AppColor(85);
        if(indexPath.row == 2) count.text = [_countArray[indexPath.row - 2] stringValue];
        else if (indexPath.row == 3)
        {
            count.text = [CRHttpAddedManager show_numbersLimitNum:((NSNumber *)_countArray[indexPath.row - 2]).doubleValue toPoint:2];
            count.text = [NSString stringWithFormat:@"￥%@",count.text];
        }
        
        else if (indexPath.row == 4 )
        {
            if (!_isNormal)
            {
                count.text = [CRHttpAddedManager show_numbersLimitNum:((NSNumber *)_countArray[indexPath.row - 2]).doubleValue toPoint:2];
            }
//            else
//            {
//                count.text = [CRHttpAddedManager show_numbersLimitNum:((NSNumber *)_countArray[indexPath.row - 1]).doubleValue toPoint:1];
//            }
        }
        else if ( (indexPath.row == 5)  && !_isNormal)
            count.text = [CRHttpAddedManager show_numbersLimitNum:((NSNumber *)_countArray[indexPath.row - 2]).doubleValue toPoint:2];
        [cell.contentView addSubview:count];
    }

    if (_isAdmin)
    {
        if (indexPath.row != 1 &&indexPath.row != 5 &&indexPath.row != 6 &&indexPath.row != 8)
        {
            UIImageView *line = WEAK_OBJECT(UIImageView, initWithFrame:CGRectMake(45, 49.5, 275, 0.5));
            line.backgroundColor = AppColor(197);
            [cell.contentView addSubview:line];
        }
        else
        {
            UIImageView *line = WEAK_OBJECT(UIImageView, initWithFrame:CGRectMake(0, 50.5, 320, 0.5));
            line.backgroundColor = AppColor(197);
            [cell.contentView addSubview:line];
            
            UIImageView *line1 = WEAK_OBJECT(UIImageView, initWithFrame:CGRectMake(0, 60.5, 320, 0.5));
            line1.backgroundColor = AppColor(197);
            [cell.contentView addSubview:line1];
        }
    }
    else if(_isVip7)
    {
        if (USER_MANAGER.IsExchangeAdmin == YES)
        {
            if (indexPath.row != 1 &&indexPath.row != 5 &&indexPath.row != 6 &&indexPath.row != 8)
            {
                UIImageView *line = WEAK_OBJECT(UIImageView, initWithFrame:CGRectMake(45, 49.5, 275, 0.5));
                line.backgroundColor = AppColor(197);
                [cell.contentView addSubview:line];
            }
            else
            {
                UIImageView *line = WEAK_OBJECT(UIImageView, initWithFrame:CGRectMake(0, 50.5, 320, 0.5));
                line.backgroundColor = AppColor(197);
                [cell.contentView addSubview:line];
                
                
                UIImageView *line1 = WEAK_OBJECT(UIImageView, initWithFrame:CGRectMake(0, 60.5, 320, 0.5));
                line1.backgroundColor = AppColor(197);
                [cell.contentView addSubview:line1];
            }
        }
        else
        {
            if (indexPath.row != 1 &&indexPath.row != 5 &&indexPath.row != 7)
            {
                UIImageView *line = WEAK_OBJECT(UIImageView, initWithFrame:CGRectMake(45, 49.5, 275, 0.5));
                line.backgroundColor = AppColor(197);
                [cell.contentView addSubview:line];
            }
            else
            {
                UIImageView *line = WEAK_OBJECT(UIImageView, initWithFrame:CGRectMake(0, 50.5, 320, 0.5));
                line.backgroundColor = AppColor(197);
                [cell.contentView addSubview:line];
                
                
                UIImageView *line1 = WEAK_OBJECT(UIImageView, initWithFrame:CGRectMake(0, 60.5, 320, 0.5));
                line1.backgroundColor = AppColor(197);
                [cell.contentView addSubview:line1];
            }
        }
    }
    else
    {
        if (USER_MANAGER.IsExchangeAdmin == YES)
        {
            if (indexPath.row != 1 &&indexPath.row != 3 &&indexPath.row != 4 &&indexPath.row != 6)
            {
                UIImageView *line = WEAK_OBJECT(UIImageView, initWithFrame:CGRectMake(45, 49.5, 275, 0.5));
                line.backgroundColor = AppColor(197);
                [cell.contentView addSubview:line];
            }
            else
            {
                UIImageView *line = WEAK_OBJECT(UIImageView, initWithFrame:CGRectMake(0, 50.5, 320, 0.5));
                line.backgroundColor = AppColor(197);
                [cell.contentView addSubview:line];
                
                
                UIImageView *line1 = WEAK_OBJECT(UIImageView, initWithFrame:CGRectMake(0, 60.5, 320, 0.5));
                line1.backgroundColor = AppColor(197);
                [cell.contentView addSubview:line1];
            }
        }
        else
        {
            if (indexPath.row != 1 &&indexPath.row != 3 &&indexPath.row != 5)
            {
                UIImageView *line = WEAK_OBJECT(UIImageView, initWithFrame:CGRectMake(45, 49.5, 275, 0.5));
                line.backgroundColor = AppColor(197);
                [cell.contentView addSubview:line];
            }
            else
            {
                UIImageView *line = WEAK_OBJECT(UIImageView, initWithFrame:CGRectMake(0, 50.5, 320, 0.5));
                line.backgroundColor = AppColor(197);
                [cell.contentView addSubview:line];
                
                
                UIImageView *line1 = WEAK_OBJECT(UIImageView, initWithFrame:CGRectMake(0, 60.5, 320, 0.5));
                line1.backgroundColor = AppColor(197);
                [cell.contentView addSubview:line1];
            }
        }
    }
    return cell;
}

- (IBAction)headTouch:(id)sender
{
    [UI_MANAGER.mainNavigationController pushViewController:WEAK_OBJECT(PersonalProfileViewController, init) animated:YES];
}
@end
