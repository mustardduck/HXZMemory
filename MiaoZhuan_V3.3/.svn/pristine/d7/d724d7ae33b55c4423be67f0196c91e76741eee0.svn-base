//
//  SellerDiscountEnterPrice.m
//  sss
//
//  Created by luocena on 4/27/15.
//  Copyright (c) 2015 luocena. All rights reserved.
//

#import "IWCompanyIntroViewController.h"
#import "SellerDiscountTableViewCell.h"
#import "SharedData.h"
#import "API_PostBoard.h"
//#import "BusinessInfoManagerViewController.h"
#import "MerchantDetailViewController.h"
#import "NetImageView.h"
#import "IWCompanyIntroTableViewCell.h"

    
static NSString *identifier = @"SellerDiscountTableViewCell";
@interface IWCompanyIntroViewController ()
{
    NSArray * _dataTitle;
    EnterpriseNewInfo * _enterpriceInfo;
}
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (retain, nonatomic) IBOutlet UIView *tableViewHeader;

@property (retain, nonatomic) IBOutlet NetImageView *imageViewCover;
@property (retain, nonatomic) IBOutlet UILabel *lableEnterpriseName;
@property (retain, nonatomic) IBOutlet UIImageView *imageViewVIP;
@property (retain, nonatomic) IBOutlet UIImageView *imagViewSilver;
@property (retain, nonatomic) IBOutlet UIImageView *imageViewGold;
@property (retain, nonatomic) IBOutlet UIImageView *imageViewZhi;






@end

@implementation IWCompanyIntroViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dataTitle = @[@"性质:",@"行业:",@"规模:",@"地址:",@"特色:",@"简介:",@"电话:",@"",@""];
    self.imageViewCover.layer.masksToBounds = YES;
    self.imageViewCover.clipsToBounds = YES;
    self.imageViewCover.layer.cornerRadius = 10.0;
    self.imageViewCover.layer.borderWidth = 0.5;
    self.imageViewCover.layer.borderColor = RGBCOLOR(197, 197, 197).CGColor;

    [self.tableView registerNib:[UINib nibWithNibName:@"SellerDiscountTableViewCell" bundle:nil] forCellReuseIdentifier:@"SellerDiscountTableViewCell"];
    
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    if([UICommon getSystemVersion] >= 7.0f){
        self.tableView.estimatedRowHeight = 50.0; // 设置为一个接近“平均”行高的值
    }
    self.tableView.tableHeaderView = self.tableViewHeader;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleUpdateSuccessAction:) name:UpdateSuccessAction object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleUpdateFailureAction:) name:UpdateFailureAction object:nil];
    
    [self loadData];
}

-(void) loadData{
    if (self.isDraft) {
        [[API_PostBoard getInstance] engine_outside_postBoardManage_enterpriseInfo];
    }
}

- (void)handleUpdateSuccessAction:(NSNotification *)note
{
    
    NSDictionary *dict = [note userInfo];
    update_type type = [[dict objectForKey:@"update"]intValue];
    int ret = [[dict objectForKey:@"ret"] intValue];
    
    if(type == ut_postBoardManage_enterpriseInfo)
    {
        if(ret == 1)
        {
            _enterpriceInfo = [SharedData getInstance].enterpriseInfo;
            
            [_imageViewCover requestPicture:_enterpriceInfo.enterpriseLogo];
            
            _lableEnterpriseName.text = _enterpriceInfo.enterpriseName;
            _imageViewVIP.image = [UIImage imageNamed:!_enterpriceInfo.enterPriseIsVIP ? @"fatopvip":@"fatopviphover"];
            _imagViewSilver.image = [UIImage imageNamed:!_enterpriceInfo.enterPriseIsSilver ? @"fatopyin" : @"fatopyinhover"];
            _imageViewGold.image = [UIImage imageNamed:!_enterpriceInfo.enterPriseIsGold ? @"fatopjin":@"fatopjinhover"];
            _imageViewZhi.image = [UIImage imageNamed:!_enterpriceInfo.enterPriseIsDirect ? @"fatopzhi":@"fatopzhihover"];
            [self.tableView reloadData];
        }else{
            [HUDUtil showErrorWithStatus:dict[@"msg"]];
        }
    }else if (type == ut_postBoard_DiscountDetails){
        if(ret == 1)
        {
            _enterpriceInfo = [SharedData getInstance].postBoardDiscountDetail.enterpriseInfo;
            
            _lableEnterpriseName.text = _enterpriceInfo.enterpriseName;
            [_imageViewCover requestPicture:_enterpriceInfo.enterpriseLogo];
            _imageViewVIP.image = [UIImage imageNamed:!_enterpriceInfo.enterPriseIsVIP ? @"fatopvip":@"fatopviphover"];
            _imagViewSilver.image = [UIImage imageNamed:!_enterpriceInfo.enterPriseIsSilver ? @"fatopyin" : @"fatopyinhover"];
            _imageViewGold.image = [UIImage imageNamed:!_enterpriceInfo.enterPriseIsGold ? @"fatopjin":@"fatopjinhover"];
            _imageViewZhi.image = [UIImage imageNamed:!_enterpriceInfo.enterPriseIsDirect ? @"fatopzhi":@"fatopzhihover"];
            [self.tableView reloadData];
        }else
        {
            
        }
    }else if (type == ut_postBoard_recruitmentDetails){
        if (ret == 1) {
            _enterpriceInfo = [SharedData getInstance].postBoardRecruitmentDetail.enterpriseInfo;
            [_imageViewCover requestPicture:_enterpriceInfo.enterpriseLogo];
            
            _lableEnterpriseName.text = _enterpriceInfo.enterpriseName;
            _imageViewVIP.image = [UIImage imageNamed:!_enterpriceInfo.enterPriseIsVIP ? @"fatopvip":@"fatopviphover"];
            _imagViewSilver.image = [UIImage imageNamed:!_enterpriceInfo.enterPriseIsSilver ? @"fatopyin" : @"fatopyinhover"];
            _imageViewGold.image = [UIImage imageNamed:!_enterpriceInfo.enterPriseIsGold ? @"fatopjin":@"fatopjinhover"];
            _imageViewZhi.image = [UIImage imageNamed:!_enterpriceInfo.enterPriseIsDirect ? @"fatopzhi":@"fatopzhihover"];
            [self.tableView reloadData];
        } else {
        }
    }else if (type == ut_postBoard_attractBusinessDetails){
        if (ret == 1) {
            
            _enterpriceInfo = [SharedData getInstance].postBoardAttractBusinessDetail.enterpriseInfo;
            [_imageViewCover requestPicture:_enterpriceInfo.enterpriseLogo];
            _lableEnterpriseName.text = _enterpriceInfo.enterpriseName;
            _imageViewVIP.image = [UIImage imageNamed:!_enterpriceInfo.enterPriseIsVIP ? @"fatopvip":@"fatopviphover"];
            _imagViewSilver.image = [UIImage imageNamed:!_enterpriceInfo.enterPriseIsSilver ? @"fatopyin" : @"fatopyinhover"];
            _imageViewGold.image = [UIImage imageNamed:!_enterpriceInfo.enterPriseIsGold ? @"fatopjin":@"fatopjinhover"];
            _imageViewZhi.image = [UIImage imageNamed:!_enterpriceInfo.enterPriseIsDirect ? @"fatopzhi":@"fatopzhihover"];
            [self.tableView reloadData];
        } else {
        }
    }
}

-(void) handleUpdateFailureAction:(NSNotification *) note{
    
    NSDictionary *dict = [note userInfo];
    update_type type = [[dict objectForKey:@"update"]intValue];
    int ret = [[dict objectForKey:@"ret"] intValue];
    if(type == ut_recruitmentManage_publish)
    {
        if(ret == 1)
        {
            NSLog(@"\n\ndict :%@\n\n", dict);
        }else{
            NSLog(@"\n\nNot 1\n\n");
        }
    }
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataTitle.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    // Dequeue a cell for the particular layout required (you will likely need to substitute
    // the reuse identifier dynamically at runtime, instead of a static string as below).
    // Note that this method will init and return a new cell if there isn't one available in the reuse pool,
    // so either way after this line of code you will have a cell with the correct constraints ready to go.
    
    static SellerDiscountTableViewCell *cell = nil;
    static dispatch_once_t onceToken;
    //只会走一次
    dispatch_once(&onceToken, ^{
        cell = (SellerDiscountTableViewCell*)[self.tableView dequeueReusableCellWithIdentifier:@"SellerDiscountTableViewCell"];
    });

    switch (indexPath.row) {
        case 0:{
            cell.lableSellerDiscountContent.text = _enterpriceInfo.enterpriseCompanyKind.length > 0 ?_enterpriceInfo.enterpriseCompanyKind:@"未填写";
        } break;
            
        case 1:{
            cell.lableSellerDiscountContent.text = _enterpriceInfo.enterpriseIndustry;
        } break;
            
        case 2:{
            cell.lableSellerDiscountContent.text = _enterpriceInfo.enterpriseCompanySize.length > 0? _enterpriceInfo.enterpriseCompanySize : @"未填写";
        }break;
            
        case 3:{
            cell.lableSellerDiscountContent.text = _enterpriceInfo.enterpriseAddress;
        }break;
        case 4:{
            cell.lableSellerDiscountContent.text =  _enterpriceInfo.enterpriseProperty;
        }break;
        case 5:{
            cell.lableSellerDiscountContent.text = _enterpriceInfo.enterpriseIntroduction;
        }break;
        case 6:{
            return 30;
        }break;
            
        default:
            cell.lableSellerDiscountContent.text = @"";
            break;
    }
    
    //calculate
    CGFloat height = [self getCellHeight:cell];
//    if (indexPath.row == 5) {
//        if (height-40 > 0)
//            height = height-40;
//    }
    return height;
}

- (CGFloat)getCellHeight:(SellerDiscountTableViewCell*)cell
{

    
    [cell layoutIfNeeded];
    [cell updateConstraintsIfNeeded];
    
    CGFloat preMaxWaith = [UIScreen mainScreen].bounds.size.width-70; //[UIScreen mainScreen].bounds.size.width-108;
    [cell.lableSellerDiscountContent setPreferredMaxLayoutWidth:preMaxWaith];
    [cell.lableSellerDiscountContent layoutIfNeeded];
    
    
    CGFloat height = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    return height + 1;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SellerDiscountTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SellerDiscountTableViewCell"];// forIndexPath:indexPath];
    
    cell.lableSellerDiscountTitle.text = _dataTitle[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    switch (indexPath.row) {
        case 0:{
            cell.lableSellerDiscountContent.text = _enterpriceInfo.enterpriseCompanyKind.length > 0 ?_enterpriceInfo.enterpriseCompanyKind:@"未填写";
            if(_enterpriceInfo.enterpriseCompanyKind.length == 0){
                cell.lableSellerDiscountContent.textColor = [UIColor grayColor];
            }else{
                cell.lableSellerDiscountContent.textColor = RGBCOLOR(34, 34, 34);
            }
        } break;
            
        case 1:{
            cell.lableSellerDiscountContent.text = _enterpriceInfo.enterpriseIndustry;
        } break;
            
        case 2:{
            cell.lableSellerDiscountContent.text = _enterpriceInfo.enterpriseCompanySize.length > 0? _enterpriceInfo.enterpriseCompanySize : @"未填写";
            if(_enterpriceInfo.enterpriseCompanySize.length == 0){
                cell.lableSellerDiscountContent.textColor = [UIColor grayColor];
            }else{
                cell.lableSellerDiscountContent.textColor = RGBCOLOR(34, 34, 34);
            }
        }break;
            
        case 3:{
            cell.lableSellerDiscountContent.text = _enterpriceInfo.enterpriseAddress;
        }break;
        case 4:{
            cell.lableSellerDiscountContent.text =  _enterpriceInfo.enterpriseProperty;
        }break;
        case 5:{
            cell.lableSellerDiscountContent.text = _enterpriceInfo.enterpriseIntroduction;
        }break;
        case 6:{
            IWCompanyIntroTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"IWCompanyIntroTableViewCell"];
            if (cell == nil) {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"IWCompanyIntroTableViewCell" owner:self options:nil] lastObject];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            cell.lableTelePhone.text = _enterpriceInfo.enterpriseContactPhone;
            [cell.lableTelePhone setNeedsDisplay];
            cell.cellButtonClick = ^(void){

                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@",_enterpriceInfo.enterpriseContactPhone]]]; //拨号
            };
            [cell.contentView setNeedsUpdateConstraints];
            [cell.contentView updateConstraintsIfNeeded];
            return cell;
        }break;
            
        default:
            cell.lableSellerDiscountContent.text = @"";
            break;
    }

//    CGFloat preMaxWaith = self.tableView.frame.size.width - 108; //[UIScreen mainScreen].bounds.size.width-108;
//    [cell.lableSellerDiscountContent setPreferredMaxLayoutWidth:preMaxWaith];
//    [cell.lableSellerDiscountContent layoutIfNeeded];
    return cell;
}

/**
 *  了解更多
 *
 *  @param sender
 */
- (IBAction)buttonClickKownMore:(UIButton *)sender {

//    BusinessInfoManagerViewController *vc = [[BusinessInfoManagerViewController alloc] initWithNibName:NSStringFromClass([BusinessInfoManagerViewController class]) bundle:nil];
    
//    [self.navigationController pushViewController:vc animated:YES];
    
    
    if (_enterpriceInfo) {
        MerchantDetailViewController *detail = [[MerchantDetailViewController alloc] initWithNibName:NSStringFromClass([MerchantDetailViewController class]) bundle:nil];
        if ([_enterpriceInfo.enterpriseId integerValue] == 0) {
            detail.enId = [NSString stringWithFormat:@"%@",[SharedData getInstance].personalInfo.userEnterpriseId];
        }else{
            detail.enId = [NSString stringWithFormat:@"%@",_enterpriceInfo.enterpriseId];
        }
        
        if (self.postBoardType == kPostBoardAttractBusiness) {
            detail.comefrom = @"8";
        }else if (self.postBoardType == kPostBoardDiscount){
            detail.comefrom = @"9";
        }else if (self.postBoardType == kPostBoardRecruit){
            detail.comefrom = @"7";
        }else{
            detail.comefrom = @"0";
        }
        [self.navigationController pushViewController:detail animated:YES];
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    // Force your tableview margins (this may be a bad idea)
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];    }
    
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
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

@end
