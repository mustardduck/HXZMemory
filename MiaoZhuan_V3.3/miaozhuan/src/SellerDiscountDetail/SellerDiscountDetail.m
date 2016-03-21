//
//  SellerDiscountDetail.m
//  sss
//
//  Created by luocena on 4/27/15.
//  Copyright (c) 2015 luocena. All rights reserved.
//

#import "SellerDiscountDetail.h"
#import "SellerDiscountTableViewCell.h"
#import "SharedData.h"
#import "Model_PostBoard.h"
#import "NetImageView.h"
#import "ScrollerViewWithTime.h"
#import "PreviewViewController.h"
#import "IWSellerDiscountPublish.h"
#import "IWSellerDiscountHeaderTableViewCell.h"
#import "IWSellerDiscountFooterTableViewCell.h"
#import "IWCompanyIntroTableViewCell.h"
#import "VIPPrivilegeViewController.h"

static NSString *identifier = @"SellerDiscountTableViewCell";
//static IWSellerDiscountHeaderTableViewCell *sellerDiscountHeaderTableViewCell = nil;
static IWSellerDiscountFooterTableViewCell *sellerDiscountFooterTableViewCell = nil;

#define kBuyVipAlertTag 114


@interface SellerDiscountDetail ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate,UIAlertViewDelegate>

{
    DiscountInfo *_discountinfo;
    EnterpriseNewInfo *_enterpriceInfo;
}
@property (retain, nonatomic) IBOutlet UIScrollView *scrollView_TopBanner;
@property (strong, nonatomic) IBOutlet UIView *tableViewHeader;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIView *tableviewFooter;
@property (retain, nonatomic) IBOutlet UILabel *lableDiscountTitle;
@property (retain, nonatomic) IBOutlet UILabel *lableRefreshTime;
@property (retain, nonatomic) IBOutlet UILabel *lablePublishTime;
@property (strong, nonatomic)NSArray * data;

@property (strong, nonatomic) IBOutlet UIButton *buttonContinuePublish;

@property (retain, nonatomic) IBOutlet NSLayoutConstraint *layoutConstraintPublishView;
@property (retain, nonatomic) IBOutlet NetImageView *imageviewCertificate;



@end

@implementation SellerDiscountDetail
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _data = [[NSArray alloc] initWithObjects:@"期限:",@"类别:",@"公司:",@"电话:",@"地址:",@"说明:", nil];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"SellerDiscountTableViewCell" bundle:nil] forCellReuseIdentifier:@"SellerDiscountTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"IWSellerDiscountHeaderTableViewCell" bundle:nil] forCellReuseIdentifier:@"IWSellerDiscountHeaderTableViewCell"];
    
    
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    if([UICommon getSystemVersion] >= 7.0f){
        self.tableView.estimatedRowHeight = 30 ; // 设置为一个接近“平均”行高的值
    }
    
    [self.buttonContinuePublish setBackgroundImage:[[UIImage imageNamed:@"ads_invate"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5) resizingMode:UIImageResizingModeStretch] forState:UIControlStateNormal];
    [self.buttonContinuePublish setBackgroundImage:[[UIImage imageNamed:@"ads_invatehover"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5) resizingMode:UIImageResizingModeStretch] forState:UIControlStateHighlighted];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleUpdateSuccessAction:) name:UpdateSuccessAction object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleUpdateFailureAction:) name:UpdateFailureAction object:nil];
    
    [self loadData];
    
    //    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //        [self createBannerViewWithImages:publicUrl];
    //    });
}

-(void) loadData{
    if (self.isPreview) {
        self.layoutConstraintPublishView.constant = 0;
        _discountinfo = [SharedData getInstance].discountDraft;
        _discountinfo.discountPublishTime = [UICommon usaulFormatTime:[NSDate date] formatStyle:@"yyyy-MM-dd"];
        _discountinfo.discountRefreshTime = [UICommon usaulFormatTime:[NSDate date] formatStyle:@"yyyy-MM-dd"];
        _enterpriceInfo = [SharedData getInstance].enterpriseInfo;
    }else if (self.isOffline){
        _enterpriceInfo = [SharedData getInstance].enterpriseInfo;
        if(_enterpriceInfo == nil){
            [[API_PostBoard getInstance] engine_outside_postBoardManage_enterpriseInfo];
        }
        [[API_PostBoard getInstance] engine_outside_discountManage_detailsId:self.discountId];
    }
    else if (self.isForceOffLine){
        self.layoutConstraintPublishView.constant = 0;
        _enterpriceInfo = [SharedData getInstance].enterpriseInfo;
        if(_enterpriceInfo == nil){
            [[API_PostBoard getInstance] engine_outside_postBoardManage_enterpriseInfo];
        }
        [[API_PostBoard getInstance] engine_outside_discountManage_detailsId:self.discountId];
    }
    else{
        self.layoutConstraintPublishView.constant = 0;
        [[API_PostBoard getInstance] engine_outside_postBoard_DiscountDetailsID:self.discountId];
    }
}




-(void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

#pragma mark - UITableViewDataSource

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    if (_discountinfo.discountIsNeedVoucher &&_discountinfo.discountVoucherPic.pictureURL.length >0) {
        return 3;
    }else{
        tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, X(self.view), 20)];
        return 2;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }else if (section == 1){
        return [_data count];
    }else if (section == 2){
        return 1;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.section == 0) {
        //        static dispatch_once_t onceToken;
        
        IWSellerDiscountHeaderTableViewCell* sellerDiscountHeaderTableViewCell = (IWSellerDiscountHeaderTableViewCell*)[self.tableView dequeueReusableCellWithIdentifier:@"IWSellerDiscountHeaderTableViewCell"];
        
        //只会走一次
        //        dispatch_once(&onceToken, ^{
        //            sellerDiscountHeaderTableViewCell = (IWSellerDiscountHeaderTableViewCell*)[self.tableView dequeueReusableCellWithIdentifier:@"IWSellerDiscountHeaderTableViewCell"];
        //
        //        });
        
        if (_discountinfo == nil) {
            return 300;
        }else{
            if(_discountinfo.discountTitle.length == 0){
                sellerDiscountHeaderTableViewCell.lableName.text= @"未填写";
                sellerDiscountHeaderTableViewCell.lableName.textColor = [UIColor grayColor];
            }else{
                sellerDiscountHeaderTableViewCell.lableName.text = _discountinfo.discountTitle;
            }
            
            if (_discountinfo.discountPublishTime.length == 0) {
                sellerDiscountHeaderTableViewCell.lablePublichTime.text = [UICommon usaulFormatTime:[NSDate date] formatStyle:@"yyyy-MM-dd"];
            }else{
                sellerDiscountHeaderTableViewCell.lablePublichTime.text = [_discountinfo.discountPublishTime substringToIndex:10];
            }
            
            
            
            CGFloat height = [self getHeaderCellHeight:sellerDiscountHeaderTableViewCell];
            return height;
        }
    }else if (indexPath.section == 1){
        
        static SellerDiscountTableViewCell *cell = nil;
        static dispatch_once_t onceToken;
        //只会走一次
        dispatch_once(&onceToken, ^{
            cell = (SellerDiscountTableViewCell*)[self.tableView dequeueReusableCellWithIdentifier:@"SellerDiscountTableViewCell"];
        });
        switch (indexPath.row) {
            case 0:{
                if(_discountinfo.discountHasDiscountDate){
                    cell.lableSellerDiscountContent.text = [NSString stringWithFormat:@"%@ - %@",[[[_discountinfo.discountDiscountStartDate stringByReplacingOccurrencesOfString:@"T" withString:@" "] substringToIndex:10] stringByReplacingOccurrencesOfString:@"-" withString:@"/"],[[[_discountinfo.discountDiscountEndDate stringByReplacingOccurrencesOfString:@"T" withString:@" "] substringToIndex:10] stringByReplacingOccurrencesOfString:@"-" withString:@"/"]];
                }else{
                    cell.lableSellerDiscountContent.text = @"不限时";
                }
            }break;
            case 1:{
                //类别
                cell.lableSellerDiscountContent.text = _enterpriceInfo.enterpriseIndustry;
            }break;
            case 2:{
                cell.lableSellerDiscountContent.text = _enterpriceInfo.enterpriseName;
            }break;
                
            case 3: {
                return 30.0;
            }break;
            case 4:{
                cell.lableSellerDiscountContent.text = _enterpriceInfo.enterpriseAddress;
            } break;
            case 5:{
                if(_discountinfo.discountContent.length == 0){
                    cell.lableSellerDiscountContent.text = @"未填写";
                }else{
                    cell.lableSellerDiscountContent.text = _discountinfo.discountContent;
                }
            } break;
                
            default:
                break;
        }
        CGFloat height = [self getCenterCellHeight:cell];
        if(indexPath.row == 3)
            return 30;
        return height;
    }
    else if (indexPath.section == 2){
        return 310;
    }
    return 0;
}

//header view 计算
-(CGFloat) getHeaderCellHeight:(IWSellerDiscountHeaderTableViewCell *)cell
{
//    [cell layoutIfNeeded];
//    [cell updateConstraintsIfNeeded];
//    CGSize s =  [cell.lableName sizeThatFits:CGSizeMake(cell.lableName.frame.size.width, FLT_MAX)];
//    [cell.lableName layoutIfNeeded];
//    return s.height + 293 + 1 + 10;
    CGFloat preMaxWaith = [UIScreen mainScreen].bounds.size.width-70; //[UIScreen mainScreen].bounds.size.width-108;
    [cell.lableName setPreferredMaxLayoutWidth:preMaxWaith];
    [cell.lableName layoutIfNeeded];
    
    
    CGFloat height = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;

    return height + 1;
    
    
}

//center view 计算
- (CGFloat)getCenterCellHeight:(SellerDiscountTableViewCell*)cell
{
//    [cell layoutIfNeeded];
//    [cell updateConstraintsIfNeeded];
    
    CGFloat preMaxWaith = [UIScreen mainScreen].bounds.size.width-75; //[UIScreen mainScreen].bounds.size.width-108;
    [cell.lableSellerDiscountContent setPreferredMaxLayoutWidth:preMaxWaith];
    [cell.lableSellerDiscountContent layoutIfNeeded];
    
    CGFloat height = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    return height + 1;
}

#pragma mark -- 是否是某天
-(BOOL)isSomeDay:(NSDate *)date DateString:(NSString *)dateString{
    BOOL flag = NO;
    NSString *someDay = [UICommon usaulFormatTime:date formatStyle:@"yyyy-MM-dd"];
    if([someDay isEqualToString:dateString]){
        flag = YES;
    }
    
    return flag;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        //        if (sellerDiscountHeaderTableViewCell == nil) {
        IWSellerDiscountHeaderTableViewCell *sellerDiscountHeaderTableViewCell = (IWSellerDiscountHeaderTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"IWSellerDiscountHeaderTableViewCell"];
        sellerDiscountHeaderTableViewCell.selectionStyle = UITableViewCellSelectionStyleNone;
        //        }
        
        if(_discountinfo.discountTitle.length == 0){
            sellerDiscountHeaderTableViewCell.lableName.text= @"未填写";
            sellerDiscountHeaderTableViewCell.lableName.textColor = [UIColor grayColor];
        }else{
            sellerDiscountHeaderTableViewCell.lableName.text = _discountinfo.discountTitle;
            sellerDiscountHeaderTableViewCell.lableName.textColor = RGBCOLOR(34, 34, 34);
        }

        
        if(self.isPreview){
            sellerDiscountHeaderTableViewCell.lableRefreshTime.text = @"今天";
            sellerDiscountHeaderTableViewCell.lablePublichTime.text = [_discountinfo.discountPublishTime substringToIndex:10];
        }else{
            NSString * discountRefreshTime = [_discountinfo.discountRefreshTime componentsSeparatedByString:@"T"][0];
            if (_discountinfo) {
                
                if ([self isSomeDay:[NSDate date] DateString:discountRefreshTime]) {
                    sellerDiscountHeaderTableViewCell.lableRefreshTime.text = @"今天";
                }else if ([self isSomeDay:[NSDate dateWithTimeIntervalSinceNow:-(24*60*60)] DateString:discountRefreshTime]){
                    sellerDiscountHeaderTableViewCell.lableRefreshTime.text = @"昨天";
                }else{
                    sellerDiscountHeaderTableViewCell.lableRefreshTime.text = discountRefreshTime;
                }
                
                sellerDiscountHeaderTableViewCell.lablePublichTime.text = [_discountinfo.discountPublishTime substringToIndex:10];
                sellerDiscountHeaderTableViewCell.lableName.text = _discountinfo.discountTitle;
                
                [sellerDiscountHeaderTableViewCell.lableName layoutIfNeeded];
            }
        }
        if([_discountinfo.discountPublicPics count] > 0){
            
            NSMutableArray *publicUrl = [[NSMutableArray alloc] init];
            for (int i = 0; i < [_discountinfo.discountPublicPics count]; i++) {
                PictureInfo *obj = _discountinfo.discountPublicPics[i];
                [publicUrl addObject:obj.pictureURL];
            }
            sellerDiscountHeaderTableViewCell.imageDefaultNoPic.hidden = YES;
            if ([publicUrl count]) {
                [sellerDiscountHeaderTableViewCell createBannerViewWithImages:publicUrl];
                
                __block typeof(self) weakself = self;
                sellerDiscountHeaderTableViewCell.tapSellerDiscountHeaderTapGes = ^(NSInteger pageIndex){
                    PreviewViewController *model = [[PreviewViewController alloc] init];
                    model.currentPage = pageIndex;
                    NSMutableArray *pics = [NSMutableArray array];
                    for (int i = 0; i < publicUrl.count; i ++) {
                        [pics addObject:@{@"PictureUrl":publicUrl[i]}];
                    }
                    model.dataArray = pics;
                    [weakself presentViewController:model animated:NO completion:nil];
                };
            }
        }
        sellerDiscountHeaderTableViewCell.selectionStyle = UITableViewCellSelectionStyleNone;
        CGFloat preMaxWaith =[UIScreen mainScreen].bounds.size.width - 30;
        [sellerDiscountHeaderTableViewCell.lableName setPreferredMaxLayoutWidth:preMaxWaith];
        [sellerDiscountHeaderTableViewCell.lableName layoutIfNeeded];
        
        
        return sellerDiscountHeaderTableViewCell;
    }else if (indexPath.section == 1){
        SellerDiscountTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SellerDiscountTableViewCell"];// forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.lableSellerDiscountTitle.text = _data[indexPath.row];
        
        switch (indexPath.row) {
            case 0:{
                if(_discountinfo.discountHasDiscountDate){
                    cell.lableSellerDiscountContent.text = [NSString stringWithFormat:@"%@ - %@",[[[_discountinfo.discountDiscountStartDate stringByReplacingOccurrencesOfString:@"T" withString:@" "] substringToIndex:10] stringByReplacingOccurrencesOfString:@"-" withString:@"/"],[[[_discountinfo.discountDiscountEndDate stringByReplacingOccurrencesOfString:@"T" withString:@" "] substringToIndex:10] stringByReplacingOccurrencesOfString:@"-" withString:@"/"]];
                }else{
                    cell.lableSellerDiscountContent.text = @"不限时";
                }
            }break;
            case 1:{
                //类别
                cell.lableSellerDiscountContent.text = _enterpriceInfo.enterpriseIndustry;
            }break;
            case 2:{
                cell.lableSellerDiscountContent.text = _enterpriceInfo.enterpriseName;
            }break;
                
            case 3: {
                
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
            case 4:{
                cell.lableSellerDiscountContent.text = _enterpriceInfo.enterpriseAddress;
                 cell.lableSellerDiscountContent.textColor = RGBCOLOR(34, 34, 34);
            } break;
            case 5:{
                if(_discountinfo.discountContent.length == 0){
                    cell.lableSellerDiscountContent.text = @"未填写";
                    cell.lableSellerDiscountContent.textColor = [UIColor grayColor];
                }else{
                    cell.lableSellerDiscountContent.text = _discountinfo.discountContent;
                    cell.lableSellerDiscountContent.textColor = RGBCOLOR(34, 34, 34);
                }
            } break;
                
            default:
                break;
        }
        CGFloat preMaxWaith =[UIScreen mainScreen].bounds.size.width-108;
        [cell.lableSellerDiscountContent setPreferredMaxLayoutWidth:preMaxWaith];
        [cell.lableSellerDiscountContent layoutIfNeeded];
        
        return cell;
        
    }else if (indexPath.section == 2){
        if (sellerDiscountFooterTableViewCell == nil) {
            sellerDiscountFooterTableViewCell = (IWSellerDiscountFooterTableViewCell*)[self.tableView dequeueReusableCellWithIdentifier:@"IWSellerDiscountFooterTableViewCell"];
            if (sellerDiscountFooterTableViewCell == nil) {
                sellerDiscountFooterTableViewCell = [[[NSBundle mainBundle] loadNibNamed:@"IWSellerDiscountFooterTableViewCell" owner:self options:nil] lastObject];
                sellerDiscountFooterTableViewCell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
        }
        [sellerDiscountFooterTableViewCell.imageviewVoucher requestPicture:_discountinfo.discountVoucherPic.pictureURL];
        return sellerDiscountFooterTableViewCell;
    }
    return nil;
}

#pragma mark -- 进入编辑前检查
-(BOOL)checkBeforeEnterPublish{
    BOOL flag = NO;
    
    if([[SharedData getInstance] discountManageInfo].discountTodayRestCount < 1){
        if([SharedData getInstance].personalInfo.userIsEnterpriseVip){
            [HUDUtil showErrorWithStatus:[NSString stringWithFormat:@"今天已经发布了%d条",[[SharedData getInstance] discountManageInfo].discountVipPublishCount]];
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"发布限制" message:[NSString stringWithFormat:@"已发布%d条信息，是否购买VIP获取特权",[[SharedData getInstance] discountManageInfo].discountNormalPublishCount] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"去购买", nil];
            alert.tag = kBuyVipAlertTag;
            [alert show];
        }
    }else{
        flag = YES;
    }
    
    return flag;
}

- (IBAction)buttonClickContinuePublish:(UIButton *)sender {
    
    if (self.isOffline) {
        if(![self checkBeforeEnterPublish]){
            return;
        }
        IWSellerDiscountPublish *vc = [[IWSellerDiscountPublish alloc] initWithNibName:NSStringFromClass([IWSellerDiscountPublish class]) bundle:nil];
        vc.isDraft = YES;
        vc.draftID = _discountinfo.discountId;
        vc.isContinuePublish = YES;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    
    if (_discountinfo.discountTitle.length == 0) {
        [HUDUtil showErrorWithStatus:@"优惠标题未填写"]; return;
    }
    
    if (_discountinfo.discountContent.length == 0) {
        [HUDUtil showErrorWithStatus:@"优惠内容未填写"]; return;;
    }
    if ([_discountinfo.discountPublicPics count] == 0){
        [HUDUtil showErrorWithStatus:@"宣传图片未上传"]; return;
    }
    if (_discountinfo.discountIsNeedVoucher && _discountinfo.discountVoucherPic.pictureURL.length == 0) {
        [HUDUtil showErrorWithStatus:@"凭证图片未上传"]; return;
    }
    
    NSMutableArray *publicUrl = [[NSMutableArray alloc] init];
    for (int i = 0; i < [_discountinfo.discountPublicPics count]; i++) {
        PictureInfo *obj = _discountinfo.discountPublicPics[i];
        [publicUrl addObject:obj.pictureId];
    }
    
    [[API_PostBoard getInstance] engine_outside_discountManage_publish:_discountinfo.discountId.length > 0? _discountinfo.discountId :@"0"
                                                                 title:_discountinfo.discountTitle
                                                               content:_discountinfo.discountContent
                                                                images:publicUrl
                                                         isNeedVoucher:_discountinfo.discountIsNeedVoucher
                                                             voucherId:_discountinfo.discountVoucherPic.pictureId
                                                           hasDiscount:_discountinfo.discountHasDiscountDate
                                                         discountStart:_discountinfo.discountDiscountStartDate
                                                           discountEnd:_discountinfo.discountDiscountEndDate
                                                           onlineCount:_discountinfo.discountOnlineDayCount];
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
            [self.tableView reloadData];
        }else{
            [HUDUtil showErrorWithStatus:dict[@"msg"]];
        }
    }else if (type == ut_discountManage_publish){
        if(ret == 1)
        {
            [HUDUtil showSuccessWithStatus:@"优惠信息发布成功"];
        }else{
            [HUDUtil showErrorWithStatus:dict[@"msg"]];
        }
    }else if(type == ut_postBoard_DiscountDetails){
        if(ret == 1)
        {
            PostBoardDiscount *postBoardDiscount = [SharedData getInstance].postBoardDiscountDetail;
            _enterpriceInfo = postBoardDiscount.enterpriseInfo;
            _discountinfo = postBoardDiscount.discountInfo;
            
            if (self.isOffline) {
                [SharedData getInstance].discountDraft = _discountinfo;
            }
            
            
            [self.tableView reloadData];
        }else{
            [HUDUtil showSuccessWithStatus:dict[@"msg"]];
        }
    }else if (type == ut_discountManage_details){
        _discountinfo = [SharedData getInstance].discountDetailInfo;
        [self.tableView reloadData];
    }
}
-(void) handleUpdateFailureAction:(NSNotification *) note{
    [HUDUtil showErrorWithStatus:@"网络不给力，请检查后重试"];
    //    NSDictionary *dict = [note userInfo];
    //    update_type type = [[dict objectForKey:@"update"]intValue];
    //    if(type ==  ut_postBoard_DiscountDetails || type == ut_discountManage_details)
    //    {
    //        NSLog(@"\n\ndict :%@\n\n", dict);
    //    }else if (type == ut_postBoard_DiscountDetails){
    //        NSLog(@"\n\ndict :%@\n\n", dict);
    //    }
}

- (IBAction)tapGestureRecognizer:(UITapGestureRecognizer *)sender {
    
    UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"下载图片" otherButtonTitles: nil];
    [action showInView:self.view];
    
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 0) { //下载
        UIImageWriteToSavedPhotosAlbum(self.imageviewCertificate.image, self, @selector(imageSavedToPhotosAlbum:didFinishSavingWithError:contextInfo:), nil);
    }else{
        
    }
}
/**
 *  图片保存
 *
 */
- (void)imageSavedToPhotosAlbum:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (!error) {
        [HUDUtil showSuccessWithStatus:@"凭证保存成功"];
    }else
    {
        [HUDUtil showErrorWithStatus:[error description]];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark uialertview delegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(alertView.tag == kBuyVipAlertTag){
        if(buttonIndex == 1){
            //购买VIP页面
            VIPPrivilegeViewController *vipvc = [[VIPPrivilegeViewController alloc] init];
            [CRHttpAddedManager mz_pushViewController:vipvc];
        }
    }
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


@end
