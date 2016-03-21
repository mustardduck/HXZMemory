//
//  PSOrganizationInfoViewController.m
//  miaozhuan
//
//  Created by 孙向前 on 15-3-16.
//  Copyright (c) 2015年 zdit. All rights reserved.
//

#import "PSOrganizationInfoViewController.h"
#import "NetImageView.h"
#import "RRLineView.h"
#import "PutInCell.h"
#import "HeaderView.h"
#import "RRNormalButton.h"
#import "PsAdvertListViewController.h"
#import "PSAsDetailController.h"

@interface PSOrganizationInfoViewController ()

@property (retain, nonatomic) IBOutlet NetImageView *orzLogo;
@property (retain, nonatomic) IBOutlet UILabel *orzName;
@property (retain, nonatomic) IBOutlet UILabel *orzMark;
@property (retain, nonatomic) IBOutlet UILabel *orzPhone;
@property (retain, nonatomic) IBOutlet UILabel *orzAddress;
@property (retain, nonatomic) IBOutlet UITableView *tableview;
@property (retain, nonatomic) IBOutlet UIView *phoneAndAddressView;
@property (retain, nonatomic) IBOutlet UIView *contentView;
@property (retain, nonatomic) IBOutlet UIView *mainView;
@property (retain, nonatomic) IBOutlet UIScrollView *scrollView;

@property (nonatomic, retain) DictionaryWrapper *dataDic;

@end

@implementation PSOrganizationInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigateTitle:@"组织详情"];
    [self setupMoveBackButton];
    
    [self loadData];
}

- (void)loadData{
    if (!_orzId.length) {
        return;
    }
    ADAPI_PublicServiceOrg_Detail([GLOBAL_DELEGATOR_MANAGER addDelegator:self selector:@selector(handlePSDetail:)], _orzId, _comeFrom.length ? _comeFrom : @"");
}

#pragma mark - UITableViewDelegate/UITableViewDatasource

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30.f;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [BaseHeaderView createHeaderView:section withTitle:@"播放的公益广告"];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
  
    if ([[_dataDic wrapper] getBool:@"HasMoreAdvert"]) {
        return 60;
    }
    return 10;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    if (![[_dataDic wrapper] getBool:@"HasMoreAdvert"]) {
        
        UIView *view = WEAK_OBJECT(UIView, initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 10));
        view.backgroundColor = [UIColor clearColor];
        
        return view;
    } else {
        UIView *view = WEAK_OBJECT(UIView, initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 60));
        
        UIImageView *imgArrow = WEAK_OBJECT(UIImageView, initWithImage:[UIImage imageNamed:@"ads_img_bg.png"]);
        imgArrow.frame = CGRectMake(301, 18, 6, 12);
        
        RRLineView *linebottom = WEAK_OBJECT(RRLineView, initWithFrame:CGRectMake(0, 50, SCREENWIDTH, 0.5));
        [view addSubview:linebottom];
        
        RRNormalButton *btnClick = [RRNormalButton buttonWithType:UIButtonTypeCustom];
        btnClick.tag = section;
        btnClick.frame = CGRectMake(0, 0, SCREENWIDTH, 50);
        [btnClick setBackgroundColor:[UIColor whiteColor]];
        btnClick.titleLabel.font = Font(14);
        btnClick.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        btnClick.contentEdgeInsets = UIEdgeInsetsMake(0,15, 0, 0);
        [btnClick setTitleColor:RGBCOLOR(40, 130, 220) forState:UIControlStateNormal];
        [btnClick setTitle:@"查看所有投放中的广告" forState:UIControlStateNormal];
        [btnClick addTarget:self action:@selector(showAll:) forControlEvents:UIControlEventTouchUpInside];
        
        view.backgroundColor = [UIColor clearColor];
        [view addSubviews:btnClick,imgArrow, nil];
        return view;
        
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 145;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger count = [[[_dataDic wrapper] getArray:@"Adverts"] count];
    NSInteger acccount = [[_dataDic wrapper] getBool:@"HasMoreAdvert"] ? 3 : count;
    return acccount;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"Cell";
    PutInCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"PutInCell" owner:self options:nil] firstObject];
    }
    cell.lblSubTitle.hidden = YES;
    cell.dataDic = [[[_dataDic wrapper] getArray:@"Adverts"][indexPath.row] wrapper];
    cell.lblTitle.top = 145 / 2 - cell.lblTitle.height / 2;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DictionaryWrapper *dic = [[[_dataDic wrapper] getArray:@"Adverts"][indexPath.row] wrapper];
    PUSH_VIEWCONTROLLER(PSAsDetailController);
    model.notShow = YES;
    model.adId = [dic getString:@"Id"];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - actions
//数据返回
- (void)handlePSDetail:(DelegatorArguments *)arguments{
    DictionaryWrapper *ret = arguments.ret;
    if (ret.operationSucceed) {
        self.dataDic = ret.data;
        [self loadUI:ret.data];
    } else {
        [HUDUtil showErrorWithStatus:ret.operationMessage];return;
    }
}
//刷新页面
- (void)loadUI:(DictionaryWrapper *)dic{
    NSString *cName = [dic getString:@"Name"];
    CGSize size = [UICommon getSizeFromString:cName withSize:CGSizeMake(180, MAXFLOAT) withFont:18];
    _orzName.height = size.height > 35 ? 43 : size.height;
    if (size.height < 25) {
        _orzName.top = 30;
    } else {
        _orzName.top = 20;
    }
    _orzName.text = cName;
    
    [_orzLogo requestWithRecommandSize:[dic getString:@"LogoUrl"]];
    [_orzLogo setRoundCorner:11];
    
    //电话按钮位置
    [self setMobileButtonPosition:[dic getString:@"Tel"] address:[dic getString:@"Address"]];
    //scrollview动态高度
    [self setHeightForScrollView:[dic getString:@"Introduction"]];
}
//电话按钮和地址位置
- (void)setMobileButtonPosition:(NSString *)phoneNum address:(NSString *)address{
    CGSize size = [UICommon getSizeFromString:phoneNum
                                     withSize:CGSizeMake(MAXFLOAT, 21)
                                     withFont:19];
    _orzPhone.width = size.width;
    _orzPhone.text = phoneNum;
    
    CGSize addressSize = [UICommon getSizeFromString:address
                                            withSize:CGSizeMake(_orzAddress.width, MAXFLOAT)
                                            withFont:14];
    _orzAddress.height = addressSize.height;
    _orzAddress.text = address;
    
    _phoneAndAddressView.height = _orzAddress.bottom + 15;
}
//计算scrollview高度并动态改变
- (void)setHeightForScrollView:(NSString *)content{
    
    //contentview height
    CGSize size = [UICommon getSizeFromString:content
                                     withSize:CGSizeMake(_orzMark.width, MAXFLOAT)
                                     withFont:14];
    _orzMark.text = content;
    _orzMark.height = size.height;
    _contentView.height = 54 + size.height;
    
    //_phoneAndAddressView y
    _phoneAndAddressView.top = _contentView.bottom - 4;
    
    //mainview height
    _mainView.height = _phoneAndAddressView.bottom;
    
    RRLineView *lineview = WEAK_OBJECT(RRLineView, initWithFrame:CGRectMake(0, _mainView.height, SCREENWIDTH, 0.5));
    [_scrollView addSubview:lineview];
    
    //tableview y
    _tableview.top = _mainView.bottom + 10;
    [self setHeightForTableView];
    
    //mainview contentsize height
    _scrollView.contentSize = CGSizeMake(SCREENWIDTH, _tableview.bottom);
}
//计算表格高度
- (void)setHeightForTableView{
    _tableview.height = 0;
    
    if ([[[_dataDic wrapper] getArray:@"Adverts"] count]) {
        if ([[_dataDic wrapper] getBool:@"HasMoreAdvert"]) {
            _tableview.height += 60;
        } else {
            _tableview.height += 10;
        }
        
        _tableview.height += [[[_dataDic wrapper] getArray:@"Adverts"] count] * 145;//cell height
        _tableview.height += 30;//header height
    }
    
    if (_tableview.height) {
        RRLineView *lineview1 = WEAK_OBJECT(RRLineView, initWithFrame:CGRectMake(0, _mainView.height + 10, SCREENWIDTH, 0.5));
        [_scrollView addSubview:lineview1];
    }
    
    [self.tableview reloadData];
}
//列表
- (void)showAll:(UIButton *)button{
    PUSH_VIEWCONTROLLER(PsAdvertListViewController);
    model.orzId = _orzId;
}
//拨打电话
- (IBAction)makeCallClicked:(id)sender {
    [[UICommon shareInstance]makeCall:[self.dataDic getString:@"Tel"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)dealloc {
    [_comeFrom release];
    [_scrollView release];
    [_mainView release];
    [_orzId release];
    [_contentView release];
    [_phoneAndAddressView release];
    [_tableview release];
    [_orzAddress release];
    [_orzPhone release];
    [_orzMark release];
    [_orzName release];
    [_orzLogo release];
    [super dealloc];
}
@end
