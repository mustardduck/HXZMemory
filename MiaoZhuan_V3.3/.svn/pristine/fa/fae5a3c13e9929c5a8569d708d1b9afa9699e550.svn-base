//
//  RecommendMerchantViewController.m
//  guanggaoban
//
//  Created by Santiago on 14-10-21.
//  Copyright (c) 2014年 Arvin. All rights reserved.
//

#import "RecommendMerchantViewController.h"
#import "RecommendMerchantCell.h"
#import "NSTimer+Addition.h"
#import "ScrollerViewWithTime.h"
#import "MerchantDetailViewController.h"
#import "CRSliverDetailViewController.h"
#import "Preview_Commodity.h"
#import "CRScrollController.h"
#import "WebhtmlViewController.h"
#import "RecommandMerchantDetailViewController.h"
#import "AppUtils.h"
const float AUTO_SCROLL_INTERVAL = 2.0f;

@interface RecommendMerchantViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate> {
    
    NSArray *_imageSource;
    NSArray * _merchantAdvantageArray;
    
    NSArray *_bannerArray;
    ScrollerViewWithTime*       _recommandBanner;
    
    NSArray * arrImage;
    
    CRScrollController *_scrollCon;
}

@property (nonatomic, strong)NSArray *recommandDataSourceList;
@property (nonatomic, strong)MJRefreshController *mjCon;
@property (retain, nonatomic) IBOutlet UIView *UILineView;
@end

@implementation RecommendMerchantViewController
@synthesize myTable = _myTable;
@synthesize headerView = _headerView;
@synthesize myScrollerView = _myScrollerView;
@synthesize recommandDataSourceList = _recommandDataSourceList;
@synthesize mjCon = _mjCon;

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    InitNav(@"推荐商家");
    [self setupRefreshCon];
    [self.UILineView setFrame:CGRectMake(0, 9.5, 320, 0.5)];
    
    [_myTable registerNib:[UINib nibWithNibName:@"RecommendMerchantCell" bundle:nil] forCellReuseIdentifier:@"RecommendMerchantCell"];
    _myTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //获取广告banner
    ADAPI_adv3_1_Operator_GetBanne([self genDelegatorID:@selector(handleNotification:)], @"d16b8aa350f49010736f3ed28e1521a5");
}

//配置banner数据
- (void)handleNotification:(DelegatorArguments *)arguments {

    DictionaryWrapper *wrapper = arguments.ret;
    
    if(!wrapper.operationSucceed)
    {
        return ;
    }
    
    
    _recommandBanner = [ScrollerViewWithTime controllerFromView:_myScrollerView];
    [_recommandBanner retain];
    
    NSMutableArray *urlArray = WEAK_OBJECT(NSMutableArray, init);
    for(NSDictionary* v in wrapper.data)
    {
        DictionaryWrapper* advItem = v.wrapper;
        [_recommandBanner addImageItems:@[[advItem getString:@"Image"]]];
        //详情URL跳转
        if ([advItem getString:@"Code"]) {

            [urlArray addObject:[advItem getString:@"Code"]];
        }
    }
    //点击事件
    _recommandBanner.TapActionBlock = ^(NSInteger pageIndex){
        NSLog(@"点击了第%ld个",(long)pageIndex);
        
        if ([urlArray count] > pageIndex) {
            
            PUSH_VIEWCONTROLLER(WebhtmlViewController)
            model.ContentCode = urlArray[pageIndex];
        }
    };
}

//设置下拉刷新控件
- (void) setupRefreshCon {
    
    NSString *refreshName = @"api/Enterprise/GetRecommendList";
    
    self.mjCon = [MJRefreshController controllerFrom:_myTable name:refreshName];
    
    [_mjCon setURLGenerator:MJREFRESH_URL_GENERATOR_BLOCK{
        
        return @{
                 @"service":refreshName,
                 @"parameters":@{
                         @"PageIndex":@(pageIndex),
                         @"PageSize":@(pageSize)}
                 }.wrapper;
    }];
    
    MJRefreshOnRequestDone block = MJREFRESH_ON_REQUEST_DONE {

        if (netData.operationSucceed) {
            
            [_myTable reloadData];
        }else {
        
            [HUDUtil showErrorWithStatus:netData.operationMessage];
            NSLog(@"请求数据失败");
        }
        
    };
    [_mjCon setOnRequestDone:block];
    [_mjCon setPageSize:10];
    [_mjCon refreshWithLoading];
}

#pragma mark - TableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _mjCon.refreshCount;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DictionaryWrapper *wrapper = [_mjCon dataAtIndex:(int)indexPath.row];
    
    NSArray *silverProductArray = [wrapper getArray:@"SilverProducts"];
    NSArray *goldProductArray = [wrapper getArray:@"GoldProducts"];
    int height = 0;
    NSString *string = [NSString stringWithFormat:@"商家优势:%@",[wrapper getString:@"Feature"]];
    CGSize size = [string sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(290, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
    if (height <= 17) {
        
        height = 14;
    }else {
    
        height = size.height-14+1;
    }
    
    int buttomGrayCutLineHeight = 0;
    
    if (indexPath.row == _mjCon.refreshCount - 1) {
        
        buttomGrayCutLineHeight = 0;
    }else {
        
        buttomGrayCutLineHeight = 10;
    }
    
    if ([silverProductArray count]== 0&&[goldProductArray count] == 0) {
        
        return 210.5 + height + buttomGrayCutLineHeight;
    }else {
        
        if (indexPath.row == _mjCon.refreshCount - 1) {
            
            return 289 + height + buttomGrayCutLineHeight + 15;
        }else {
        
            return 289 + height + buttomGrayCutLineHeight;
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    
    RecommendMerchantCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"RecommendMerchantCell" owner:self options:nil] firstObject];
    
    [cell.UILineView1 setFrame:CGRectMake(0, 0, 320, 0.5)];
    [cell.UILineView2 setFrame:CGRectMake(0, 0, 320, 0.5)];
    [cell.UILineView3 setFrame:CGRectMake(0, 127, 320, 1)];
    
    [cell.UILineView31 setFrame:CGRectMake(0, 9.5, 320, 0.5)];
    
    [cell.UILineView4 setFrame:CGRectMake(0, 9.5, 320, 0.5)];
    
    if (_mjCon.refreshCount - 1 == indexPath.row) {
        
        [cell.UILineView4 setBackgroundColor:RGBCOLOR(239, 239, 244)];
    }else {
    
        [cell.UILineView4 setBackgroundColor:RGBCOLOR(204, 204, 204)];
    }
    
    DictionaryWrapper *wrapper = [_mjCon dataAtIndex:(int)indexPath.row];
    
    cell.merchantLabel.text = [wrapper getString:@"Name"];
    [cell.merchantLogo requestPicture:[wrapper getString:@"LogoUrl"]];
    
    cell.merchantLogo.layer.borderWidth = 0.5;
    cell.merchantLogo.layer.borderColor = [RGBCOLOR(204, 204, 204) CGColor];
    cell.merchantLogo.layer.masksToBounds = YES;
    
    [cell.grayCutOffLine setFrame:CGRectMake(15, 6.5, 305, 1)];
    [cell.grayCutOffLine2 setFrame:CGRectMake(15, 15.5, 305, 1)];
    
    if ([wrapper getBool:@"IsVip"]) {
        
        [cell.vipImage setImage:[UIImage imageNamed:@"vip_selected.png"]];
    }else {
    
        [cell.vipImage setImage:[UIImage imageNamed:@"vip_normal.png"]];
    }
    
    if ([wrapper getBool:@"IsGold"]) {
        
        [cell.goldImage setImage:[UIImage imageNamed:@"gold_selected.png"]];
    }else {
    
        [cell.goldImage setImage:[UIImage imageNamed:@"gold_normal.png"]];
    }
    
    if ([wrapper getBool:@"IsSilver"]) {
        
        [cell.silverImage setImage:[UIImage imageNamed:@"sliver_selected.png"]];
    }else {
    
        [cell.silverImage setImage:[UIImage imageNamed:@"sliver_normal.png"]];
    }
    
    int height = 0;
    
    NSString *string = [NSString stringWithFormat:@"商家优势:%@",[wrapper getString:@"Feature"]];
    
    if (![wrapper getString:@"Feature"]) {
        
        cell.merchantAdvantageLabel.text = @"商家优势:无";
    }else {
        
        cell.merchantAdvantageLabel.text = string;
    }

    CGSize size = [string sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(290, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
    
    if (size.height < 16) {
        
        height = 0;
    }else {
    
        height = size.height-14;
    }
    [cell.merchantAdvantageLabel setFrame:CGRectMake(15, 74, 290, height+14+1)];
    
    NSArray *silverProductArray = [wrapper getArray:@"SilverProducts"];
    NSArray *goldProductArray = [wrapper getArray:@"GoldProducts"];
    
    if ([silverProductArray count]== 0&&[goldProductArray count] == 0) {
        
        cell.noProductsView.hidden = NO;
        cell.havaProductsView.hidden = YES;
        [cell.noProductsView setOrigin:CGPointMake(0, 95 + height)];
    }else {
        
        [cell.havaProductsView setFrame:CGRectMake(0,104+height, 320, 198)];
        cell.noProductsView.hidden = YES;
        cell.havaProductsView.hidden = NO;
    }
    
    if ([goldProductArray count] > 0) {
    
        if ([silverProductArray count] == 0) {
            DictionaryWrapper *gold1 = [goldProductArray[0] wrapper];
            [cell.product1View setImage:[gold1 getString:@"PictureUrl"] andPrice:[NSString stringWithFormat:@"%.f金币",[gold1 getFloat:@"UnitPrice"]] andName:[gold1 getString:@"Name"]];
            cell.product1View.hidden = NO;
            cell.product2View.hidden = YES;
            cell.product3View.hidden = YES;
            [cell.productBtn1 addTarget:self action:@selector(goldProductDetail:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        if ([silverProductArray count] == 1) {
            DictionaryWrapper *silver1 = [silverProductArray[0] wrapper];
            DictionaryWrapper *gold1 = [goldProductArray[0] wrapper];
            [cell.product1View setImage:[silver1 getString:@"PictureUrl"] andPrice:[NSString stringWithFormat:@"%.f银元",[silver1 getFloat:@"UnitPrice"]] andName:[silver1 getString:@"Name"]];
            [cell.product2View setImage:[gold1 getString:@"PictureUrl"] andPrice:[NSString stringWithFormat:@"%.f金币",[gold1 getFloat:@"UnitPrice"]] andName:[gold1 getString:@"Name"]];
            cell.product1View.hidden = NO;
            cell.product2View.hidden = NO;
            cell.product3View.hidden = YES;
            [cell.productBtn1 addTarget:self action:@selector(sliverProductDetail:) forControlEvents:UIControlEventTouchUpInside];
            [cell.productBtn2 addTarget:self action:@selector(goldProductDetail:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        if ([silverProductArray count] >= 2) {
            
            DictionaryWrapper *silver1 = [silverProductArray[0] wrapper];
            DictionaryWrapper *silver2 = [silverProductArray[1] wrapper];
            DictionaryWrapper *gold1 = [goldProductArray[0]wrapper];
            [cell.product1View setImage:[silver1 getString:@"PictureUrl"] andPrice:[NSString stringWithFormat:@"%.f银元",[silver1 getFloat:@"UnitPrice"]] andName:[silver1 getString:@"Name"]];
            [cell.product2View setImage:[silver2 getString:@"PictureUrl"] andPrice:[NSString stringWithFormat:@"%.f银元",[silver2 getFloat:@"UnitPrice"]] andName:[silver2 getString:@"Name"]];
            [cell.product3View setImage:[gold1 getString:@"PictureUrl"] andPrice:[NSString stringWithFormat:@"%.f金币",[gold1 getFloat:@"UnitPrice"]] andName:[gold1 getString:@"Name"]];
            cell.product1View.hidden = NO;
            cell.product2View.hidden = NO;
            cell.product3View.hidden = NO;
            [cell.productBtn1 addTarget:self action:@selector(sliverProductDetail:) forControlEvents:UIControlEventTouchUpInside];
            [cell.productBtn2 addTarget:self action:@selector(sliverProductDetail:) forControlEvents:UIControlEventTouchUpInside];
            [cell.productBtn3 addTarget:self action:@selector(goldProductDetail:) forControlEvents:UIControlEventTouchUpInside];
        }
    }else {
        
        if ([silverProductArray count] == 1) {
            DictionaryWrapper *silver1 = [silverProductArray[0] wrapper];
            [cell.product1View setImage:[silver1 getString:@"PictureUrl"] andPrice:[NSString stringWithFormat:@"%.f银元",[silver1 getFloat:@"UnitPrice"]] andName:[silver1 getString:@"Name"]];
            cell.product1View.hidden = NO;
            cell.product2View.hidden = YES;
            cell.product3View.hidden = YES;
            [cell.productBtn1 addTarget:self action:@selector(sliverProductDetail:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        if ([silverProductArray count] >= 2) {
            
            DictionaryWrapper *silver1 = [silverProductArray[0] wrapper];
            DictionaryWrapper *silver2 = [silverProductArray[1] wrapper];
            [cell.product1View setImage:[silver1 getString:@"PictureUrl"] andPrice:[NSString stringWithFormat:@"%.f银元",[silver1 getFloat:@"UnitPrice"]] andName:[silver1 getString:@"Name"]];
            [cell.product2View setImage:[silver2 getString:@"PictureUrl"] andPrice:[NSString stringWithFormat:@"%.f银元",[silver2 getFloat:@"UnitPrice"]] andName:[silver2 getString:@"Name"]];
            cell.product1View.hidden = NO;
            cell.product2View.hidden = NO;
            cell.product3View.hidden = YES;
            [cell.productBtn1 addTarget:self action:@selector(sliverProductDetail:) forControlEvents:UIControlEventTouchUpInside];
            [cell.productBtn2 addTarget:self action:@selector(sliverProductDetail:) forControlEvents:UIControlEventTouchUpInside];

        }
    }
    
    cell.productBtn1.tag = indexPath.row + 1000;
    cell.productBtn2.tag = indexPath.row + 2000;
    cell.productBtn3.tag = indexPath.row + 3000;
    
    if (indexPath.row == _mjCon.refreshCount - 1) {
        
        cell.buttomGrayCutLine.hidden = YES;
        cell.buttomGrayCutLine2.hidden = YES;
    }else {
    
        cell.buttomGrayCutLine.hidden = NO;
        cell.buttomGrayCutLine2.hidden = NO;
    }
    

    
    return cell;
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UIView * footer = WEAK_OBJECT(UIView, init);
    [footer setBackgroundColor:RGBCOLOR(239, 239, 244)];
    return footer;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.00001;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DictionaryWrapper *wrapper = [_mjCon dataAtIndex:(int)indexPath.row];
    MerchantDetailViewController *temp = WEAK_OBJECT(MerchantDetailViewController, init);
    temp.comefrom = @"0";
    temp.enId = [NSString stringWithFormat:@"%d",[wrapper getInt:@"EnterpriseId"]];
    [self.navigationController pushViewController:temp animated:YES];
}


- (void)sliverProductDetail:(UIButton*)sender{
    
    int btnNumber = (int)sender.tag/1000;
    int theIndexPath = (int)sender.tag - btnNumber*1000;
    DictionaryWrapper *wrapper = [_mjCon dataAtIndex:theIndexPath];
    NSArray *silverProductArray = [wrapper getArray:@"SilverProducts"];
    switch (btnNumber) {
        case 1:{
        
            DictionaryWrapper *silverWrapper1 = [silverProductArray[0] wrapper];
            CRSliverDetailViewController *temp = WEAK_OBJECT(CRSliverDetailViewController, init);
            temp.advertId = [silverWrapper1 getInt:@"AdvertId"];
            temp.productId = [silverWrapper1 getInt:@"ProductId"];
            [self.navigationController pushViewController:temp animated:YES];
            break;
        }
        case 2:{
            
            DictionaryWrapper *silverWrapper2 = [silverProductArray[1] wrapper];
            CRSliverDetailViewController *temp = WEAK_OBJECT(CRSliverDetailViewController, init);
            temp.advertId = [silverWrapper2 getInt:@"AdvertId"];
            temp.productId = [silverWrapper2 getInt:@"ProductId"];
            [self.navigationController pushViewController:temp animated:YES];
            break;
        }
        default:
            break;
    }
}

- (void)goldProductDetail:(UIButton*)sender {
    
    int btnNumber = (int)sender.tag/1000;
    int theIndexPath = (int)sender.tag - btnNumber*1000;
    DictionaryWrapper *wrapper = [_mjCon dataAtIndex:theIndexPath];
    NSArray *goldProductArray = [wrapper getArray:@"GoldProducts"];
    DictionaryWrapper *goldWrapper = [goldProductArray[0] wrapper];
    
    Preview_Commodity *temp = WEAK_OBJECT(Preview_Commodity, init);
    temp.whereFrom = 1;
    temp.productId = [goldWrapper getInt:@"ProductId"];
    [self.navigationController pushViewController:temp animated:YES];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    [_mjCon release];
    [_recommandDataSourceList release];
    [_myTable release];
    [_headerView release];
    [_myScrollerView release];
    [_recommandBanner release];
    [_UILineView release];
    [super dealloc];
}

- (void)viewDidUnload {
    [self setMyTable:nil];
    [self setHeaderView:nil];
    [self setMyScrollerView:nil];
    [super viewDidUnload];
}
@end
