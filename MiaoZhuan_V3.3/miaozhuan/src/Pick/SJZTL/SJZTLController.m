//
//  SJZTLController.m
//  miaozhuan
//
//  Created by momo on 15/6/8.
//  Copyright (c) 2015年 zdit. All rights reserved.
//

#import "SJZTLController.h"
#import "Definition.h"
#import "SJYHCell.h"
#import "NetImageView.h"
#import "IWMainDetail.h"
#import "IWRecruitDetailViewController.h"
#import "IWAttractBusinessDetailViewController.h"
#import "IWCompanyIntroViewController.h"
#import "SellerDiscountDetail.h"

@interface SJZTLController ()<UITableViewDataSource,UITableViewDelegate>

@property (retain, nonatomic) NSString * enterpId;
@property (assign, nonatomic) int queryType;
@property (nonatomic, retain) UIButton *buttonClick;
@property (retain, nonatomic) IBOutlet UIButton *firstBtn;
@property (retain, nonatomic) IBOutlet UIButton *secondBtn;
@property (retain, nonatomic) IBOutlet UIButton *thirdBtn;
@property (retain, nonatomic) IBOutlet UITableView *mainTableView;
@property (retain, nonatomic) IBOutlet NSLayoutConstraint *constraintLine;
@property (retain, nonatomic) IBOutlet UIView *viewNoResult;
@property (retain, nonatomic) IBOutlet UILabel *lableNoResulttip;

@end

@implementation SJZTLController
{
    MJRefreshController * _MJRefreshCon;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setNavigateTitle:@"优惠、招聘、招商信息"];
    [self setupMoveBackButton];
        
    self.enterpId = _enteId;
    self.queryType = kPostBoardDiscount;
    
    [self initTableView];

}

- (void)initTableView
{
    NSString * refreshName = @"Enterprise/PostBoardList";
    
    _MJRefreshCon = [MJRefreshController controllerFrom:_mainTableView name:refreshName];
    
    __block SJZTLController * weakself = self;
    
    [_MJRefreshCon setURLGenerator:MJREFRESH_URL_GENERATOR_BLOCK{
        
        NSDictionary * dic = @{@"service":[NSString stringWithFormat:@"%@%@", @"api/", refreshName ],
                               @"parameters":@{@"EnterpriseId":weakself.enterpId,
                                               @"Type":[NSNumber numberWithInteger: weakself.queryType],
                                               @"pageIndex":@(pageIndex),
                                               @"pageSize":@(pageSize)}
                               };
        return dic.wrapper;
    }];
    
    {
        MJRefreshOnRequestDone block = MJREFRESH_ON_REQUEST_DONE
        {
            if(controller.refreshCount > 0 && netData.operationSucceed)
            {
                _viewNoResult.hidden = YES;
                _mainTableView.hidden = NO;
            }
            else
            {
                _viewNoResult.hidden = NO;
                switch (self.queryType) {
                    case kPostBoardDiscount:
                    {
                        _lableNoResulttip.text = @"该商家没有任何优惠信息";
                    }
                        break;
                    case kPostBoardAttractBusiness:
                    {
                         _lableNoResulttip.text = @"该商家没有任何招商信息";
                    }
                        break;
                    case kPostBoardRecruit:
                    {
                        _lableNoResulttip.text = @"该商家没有任何招聘信息";
                    }
                        break;
                        
                    default:
                        break;
                }
            }
        };
        
        [_MJRefreshCon setOnRequestDone:block];
        [_MJRefreshCon setPageSize:30];
        [_MJRefreshCon retain];
    }
    
    [self refreshTableView];
    
}

- (void) refreshTableView
{
    [_MJRefreshCon refreshWithLoading];
}


- (IBAction)touchUpInsideOn:(UIButton *)sender {
    
    UIButton * btn = (UIButton *)sender;
    
    [UIView animateWithDuration:0.3f animations:^{
        self.constraintLine.constant = sender.frame.origin.x;
    }];
    
    if(sender.tag == 0 && (self.buttonClick == nil)) {
        self.buttonClick = sender; return;
    }else if ( (self.buttonClick == nil ) && sender.tag != 0){
        [self.firstBtn setTitleColor:[UIColor titleBlackColor] forState:UIControlStateNormal];
        self.firstBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        
    }
    if (sender == self.buttonClick) return;
    
    [self.buttonClick setTitleColor:[UIColor titleBlackColor] forState:UIControlStateNormal];
    self.buttonClick.titleLabel.font = [UIFont systemFontOfSize:14];
    
    self.buttonClick = sender;
    
    [self.buttonClick setTitleColor:[UIColor titleRedColor] forState:UIControlStateNormal];
    self.buttonClick.titleLabel.font = [UIFont systemFontOfSize:17];
    
    switch (btn.tag) {
        case 0:
            self.queryType = kPostBoardDiscount;
            break;
        case 1:
            self.queryType = kPostBoardRecruit;
            break;
        case 2:
            self.queryType = kPostBoardAttractBusiness;
            break;
        default:
            break;
    }
    
    [self refreshTableView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableViewDelegate and UITableViewDatasource methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _MJRefreshCon.refreshCount;
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    SJYHCell *cell = (SJYHCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.contentView.backgroundColor = AppColor(220);
    
    return YES;
}

- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    SJYHCell *cell = (SJYHCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor whiteColor];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"SJYHCell";
    
    SJYHCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"SJYHCell" owner:self options:nil] firstObject];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    cell.queryType = _queryType;
    
    [cell setDataDic:[_MJRefreshCon dataAtIndex:indexPath.row]];
    
    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic =  [_MJRefreshCon dataAtIndex:indexPath.row];
    
    NSLog(@"dic:%@",dic);
    
    NSInteger type = [[dic wrapper] getInt:@"Type"];

    NSString *detailId = [[dic wrapper] getString:@"Id"];
    switch (type) {
        case 1:
        {//招聘详情
            IWMainDetail *vc = [[IWMainDetail alloc] init];
            IWRecruitDetailViewController *vc0 = [[IWRecruitDetailViewController alloc] initWithNibName:NSStringFromClass([IWRecruitDetailViewController class]) bundle:nil];
            IWCompanyIntroViewController *vc1 = [[IWCompanyIntroViewController alloc] initWithNibName:NSStringFromClass([IWCompanyIntroViewController class]) bundle:nil];
            vc0.detailsId = detailId;
            vc0.detailType = IWRecruitDetailType_Browse;
            vc1.postBoardType = kPostBoardRecruit;
            vc.navTitle = @"招聘信息";
            vc.viewControllers = @[vc0,vc1];
            vc.viewControllersTitle = @[@"详情展示",@"企业简介"];
            
            [UI_MANAGER.mainNavigationController pushViewController:vc animated:YES];
            
        }
            break;
        case 2:
        {//招商详情
            IWMainDetail *vc = [[IWMainDetail alloc] init];
            IWAttractBusinessDetailViewController *vc0 = [[IWAttractBusinessDetailViewController alloc] initWithNibName:NSStringFromClass([IWAttractBusinessDetailViewController class]) bundle:nil];
            IWCompanyIntroViewController *vc1 = [[IWCompanyIntroViewController alloc] initWithNibName:NSStringFromClass([IWCompanyIntroViewController class]) bundle:nil];
            vc0.detailsId = detailId;
            vc0.detailType = IWAttractBusinessDetailType_Browse;
            vc1.postBoardType = kPostBoardAttractBusiness;
            vc.navTitle = @"招商信息";
            vc.viewControllers = @[vc0,vc1];
            vc.viewControllersTitle = @[@"详情展示",@"企业简介"];
            
            [UI_MANAGER.mainNavigationController pushViewController:vc animated:YES];
        }
            break;
        case 3:
        {//优惠详情
            IWMainDetail *vc = [[IWMainDetail alloc] init];
            SellerDiscountDetail *vc0 = [[SellerDiscountDetail alloc] initWithNibName:NSStringFromClass([SellerDiscountDetail class]) bundle:nil];
            IWCompanyIntroViewController *vc1 = [[IWCompanyIntroViewController alloc] initWithNibName:NSStringFromClass([IWCompanyIntroViewController class]) bundle:nil];
            vc1.postBoardType =kPostBoardDiscount;
            vc0.discountId = detailId;
            vc.navTitle = @"优惠信息";
            vc.viewControllers = @[vc0,vc1];
            vc.viewControllersTitle = @[@"详情展示",@"企业简介"];
            
            [UI_MANAGER.mainNavigationController pushViewController:vc animated:YES];
        }
            break;
        default:
            break;
    }

}

- (void)dealloc {
    [_firstBtn release];
    [_secondBtn release];
    [_thirdBtn release];
    [_mainTableView release];
    [_constraintLine release];
    [_viewNoResult release];
    [_lableNoResulttip release];
    [super dealloc];
}
@end
