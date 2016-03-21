//
//  SearchShopResultController.m
//  miaozhuan
//
//  Created by momo on 14-11-6.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "SearchShopResultController.h"
#import "RecommendMerchantCell.h"
#import "FindShopCell.h"
#import "NetImageView.h"
#import "BaserHoverView.h"
#import "CRSliverDetailViewController.h"
#import "Preview_Commodity.h"
#import "MerchantDetailViewController.h"

@interface SearchShopResultController ()

@property (retain, nonatomic) IBOutlet UITableView *mainTableView;
@property (retain, nonatomic) IBOutlet UITableView *recommendTableView;

@end

@implementation SearchShopResultController

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
//    NSString *result = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,(CFStringRef)_keyword ,NULL ,CFSTR("!*'();:@&=+$,/?%#[]-") ,kCFStringEncodingUTF8));
//    
//    self.keyword = result;
    
    [self initTableView];
    
    [self setNavigateTitle:@"搜索结果"];
    
    [self setupMoveBackButton];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) onMoveBack:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)dealloc {
    [_mainTableView release];
    [_searchCountView release];
    [_searchNothingView release];
    [_keywordLbl release];
    [_searchCountLbl release];

    [_recommendTableView release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setMainTableView:nil];
    [self setSearchCountView:nil];
    [self setSearchNothingView:nil];
    [self setKeywordLbl:nil];
    [self setSearchCountLbl:nil];
    [super viewDidUnload];
}

- (void)initTableView
{
    _mainTableView.hidden = NO;
    
    _recommendTableView.hidden = YES;
    
    NSString * refreshName = @"Enterprise/SearchNearbyEnterpriseList";
    
    _MJRefreshCon = [MJRefreshController controllerFrom:_mainTableView name:refreshName];
    
    __block SearchShopResultController * weakself = self;
    
    [_MJRefreshCon setURLGenerator:MJREFRESH_URL_GENERATOR_BLOCK{
        
        
        NSDictionary * dic = @{@"service":[NSString stringWithFormat:@"%@%@", @"api/", refreshName ],
                    @"parameters":@{@"SearchWord": weakself.keyword,
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
                _searchCountView.hidden = NO;
                
                _searchNothingView.hidden = YES;
                
                _keywordLbl.text = [NSString stringWithFormat:@"当前搜索 : %@", _keyword];
                
                _searchCountLbl.text = [NSString stringWithFormat:@"%d个相关结果", [netData.data getInt:@"ExtraData"]];

            }
            else
            {
                _searchCountView.hidden = YES;
                
                _searchNothingView.hidden = NO;
                
                _recommendTableView.top = _searchNothingView.bottom;
                
                [self recommenTableViewRefresh];
                
            }
        };
        
        [_MJRefreshCon setOnRequestDone:block];
        [_MJRefreshCon setPageSize:30];
        [_MJRefreshCon retain];
    }
    
    [self refreshTableView];
}

- (void) recommenTableViewRefresh
{
    _mainTableView.hidden = YES;
    
    _recommendTableView.hidden = NO;
    
    NSString * refreshName = @"Enterprise/GetRecommendList";
    
    _MJRefreshCon = [MJRefreshController controllerFrom:_recommendTableView name:refreshName];
    
    [_MJRefreshCon setURLGenerator:MJREFRESH_URL_GENERATOR_BLOCK{
        return    @{@"service":[NSString stringWithFormat:@"%@%@", @"api/", refreshName ],
                    @"parameters":@{@"pageIndex":@(pageIndex),
                                    @"pageSize":@(pageSize)}
                    }.wrapper;
    }];
    
    {
        MJRefreshOnRequestDone block = MJREFRESH_ON_REQUEST_DONE
        {
            if(controller.refreshCount > 0 && netData.operationSucceed)
            {
            }
            else
            {
                [self createHoverViewWhenNoData];
            }
        };
        
        [_MJRefreshCon setOnRequestDone:block];
        [_MJRefreshCon setPageSize:10];
        [_MJRefreshCon retain];
    }
    
    [self refreshTableView];
}

- (void)createHoverViewWhenNoData{
    
    BaserHoverView * hover = (BaserHoverView *)[self.view viewWithTag:1111];
    
    if(!hover)
    {
        hover = WEAK_OBJECT(BaserHoverView, initWithTitle:@"抱歉" message:@"没有推荐商家");
        
        hover.frame = _recommendTableView.frame;
        
        hover.tag = 1111;
        
        [self.view addSubview:hover];
        
        [self.view sendSubviewToBack:hover];
        
    }
    
    _recommendTableView.hidden = YES;
    
}

- (void) refreshTableView
{
    [_MJRefreshCon refreshWithLoading];
}

#pragma mark UITableViewDelegate and UITableViewDatasource methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(_searchNothingView.hidden)
    {
        return 110;
    }
    else
    {
        DictionaryWrapper *wrapper = [_MJRefreshCon dataAtIndex:(int)indexPath.row];
        
        NSArray *silverProductArray = [wrapper getArray:@"SilverProducts"];
        NSArray *goldProductArray = [wrapper getArray:@"GoldProducts"];
        int height = 0;
        NSString *string = [NSString stringWithFormat:@"商家优势:%@",[wrapper getString:@"Feature"]];
        CGSize size = [string sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(290, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
        height = size.height-14+1;
        
        if ([silverProductArray count]== 0&&[goldProductArray count] == 0) {
            
            return 238 + height;
        }else {
            
            return 328 + height;
        }
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UIView * footer = WEAK_OBJECT(UIView, init);
    [footer setBackgroundColor:[UIColor clearColor]];
    return footer;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _MJRefreshCon.refreshCount;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(_searchNothingView.hidden)
    {
        static NSString *identifier = @"FindShopCell";
        
        FindShopCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
        if (!cell) {
            
            cell = [[[NSBundle mainBundle] loadNibNamed:@"FindShopCell" owner:self options:nil] firstObject];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        DictionaryWrapper * dic = [_MJRefreshCon dataAtIndex:indexPath.row];
        
        [cell.imgView setRoundCorner:11.0];
        
        NSString * str = [dic getString:@"LogoUrl"];
        
        if(str.length > 5)
        {

            [cell.imgView requestPic:str placeHolder:NO];
        }
        
        cell.titleLbl.text = [dic getString:@"Name"];
        
        cell.vipIcon.image = [dic getBool:@"IsVip"] ? [UIImage imageNamed:@"fatopviphover"] : [UIImage imageNamed:@"fatopvip"];
        cell.yinyuanIcon.image = [dic getBool:@"IsSilver"] ? [UIImage imageNamed:@"fatopyinhover"] : [UIImage imageNamed:@"fatopyin"];
        cell.jinbiIcon.image = [dic getBool:@"IsGold"] ? [UIImage imageNamed:@"fatopjinhover"] : [UIImage imageNamed:@"fatopjin"];
        cell.zhigouIcon.image = [dic getBool:@"IsDirect"] ? [UIImage imageNamed:@"fatopzhihover"] : [UIImage imageNamed:@"fatopzhi"];
        
        cell.distanceLbl.text = [dic getString:@"DistanceRange"];
        
        UIView *view = WEAK_OBJECT(UIView, initWithFrame:CGRectMake(15 , H(cell.contentView) - 0.5, 320, 0.5));
        view.backgroundColor = AppColor(204);
        [cell.contentView addSubview:view];
        
        return cell;
    }
    else
    {
        static NSString *identifier = @"RecommendMerchantCell";
        
        RecommendMerchantCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
        if (!cell) {
            
            cell = [[[NSBundle mainBundle] loadNibNamed:@"RecommendMerchantCell" owner:self options:nil] firstObject];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        DictionaryWrapper * wrapper = [_MJRefreshCon dataAtIndex:indexPath.row];
        
        cell.merchantLabel.text = [wrapper getString:@"Name"];
        
        [cell.merchantLogo requestPicture:[wrapper getString:@"LogoUrl"]];
        
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
        
        NSString * string = [wrapper getString:@"Feature"];
        
        if(string.length)
        {
            string = [NSString stringWithFormat:@"商家优势：%@", string];
        }
        else
        {
            string = @"商家优势:";
        }
        
        cell.merchantAdvantageLabel.text = string;
        
        CGSize size = [string sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(290, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
        height = size.height-14;
        [cell.merchantAdvantageLabel setFrame:CGRectMake(15, 85, 290, height+14+1)];
        
        NSArray *silverProductArray = [wrapper getArray:@"SilverProducts"];
        NSArray *goldProductArray = [wrapper getArray:@"GoldProducts"];
        
        if ([silverProductArray count]== 0&&[goldProductArray count] == 0) {
            
            cell.noProductsView.hidden = NO;
            cell.havaProductsView.hidden = YES;
            [cell.noProductsView setFrame:CGRectMake(0, 105+height, 320, 133)];
        }else {
            
            [cell.havaProductsView setFrame:CGRectMake(0,114+height, 320, 216)];
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
        
        return cell;
    }
}

- (void)sliverProductDetail:(UIButton*)sender{
    
    int btnNumber = (int)sender.tag/1000;
    int theIndexPath = (int)sender.tag - btnNumber*1000;
    DictionaryWrapper *wrapper = [_MJRefreshCon dataAtIndex:theIndexPath];
    NSArray *silverProductArray = [wrapper getArray:@"SilverProducts"];
    switch (btnNumber) {
        case 1:{
            
            DictionaryWrapper *silverWrapper1 = [silverProductArray[0] wrapper];
            CRSliverDetailViewController *temp = WEAK_OBJECT(CRSliverDetailViewController, init);
            temp.advertId = [silverWrapper1 getInt:@"AdvertId"];
            temp.productId = [silverWrapper1 getInt:@"ProductId"];
            temp.isPreview = YES;
            [self.navigationController pushViewController:temp animated:YES];
            break;
        }
        case 2:{
            
            DictionaryWrapper *silverWrapper2 = [silverProductArray[1] wrapper];
            CRSliverDetailViewController *temp = WEAK_OBJECT(CRSliverDetailViewController, init);
            temp.advertId = [silverWrapper2 getInt:@"AdvertId"];
            temp.productId = [silverWrapper2 getInt:@"ProductId"];
            temp.isPreview = YES;
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
    DictionaryWrapper *wrapper = [_MJRefreshCon dataAtIndex:theIndexPath];
    NSArray *goldProductArray = [wrapper getArray:@"GoldProducts"];
    DictionaryWrapper *goldWrapper = [goldProductArray[0] wrapper];
    Preview_Commodity *temp = WEAK_OBJECT(Preview_Commodity, init);
    temp.whereFrom = 1;
    temp.productId = [goldWrapper getInt:@"ProductId"];
    [self.navigationController pushViewController:temp animated:YES];
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(_searchNothingView.hidden)
    {
        FindShopCell *cell = (FindShopCell *)[tableView cellForRowAtIndexPath:indexPath];
        cell.contentView.backgroundColor = AppColor(220);
    }
    return YES;
}
- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(_searchNothingView.hidden)
    {
        FindShopCell *cell = (FindShopCell *)[tableView cellForRowAtIndexPath:indexPath];
        cell.contentView.backgroundColor = [UIColor whiteColor];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DictionaryWrapper *wrapper = [_MJRefreshCon dataAtIndex:(int)indexPath.row];
    MerchantDetailViewController *temp = WEAK_OBJECT(MerchantDetailViewController, init);
    temp.enId = [NSString stringWithFormat:@"%d",[wrapper getInt:@"EnterpriseId"]];
    temp.comefrom = @"0";
    [self.navigationController pushViewController:temp animated:YES];
}

@end
