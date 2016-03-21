//
//  MyCollectionViewController.m
//  miaozhuan
//
//  Created by apple on 14/12/19.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "MyCollectionViewController.h"
#import "MyCollectionTableViewCell.h"
#import "MJRefreshController.h"
#import "YFJLeftSwipeDeleteTableView.h"
#import "SelectionButton.h"
#import "AppPopView.h"
#import "Redbutton.h"
#import "otherButton.h"
#import "CRSliverDetailViewController.h"
#import "Preview_Commodity.h"
#import "MallScanAdvertMain.h"
#import "UIView+expanded.h"

@interface MyCollectionViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    MJRefreshController *_MJRefreshCon;
    
    NSString * _ProductType;
    
    AppPopView *_appPopView;
}
@property (retain, nonatomic) IBOutlet YFJLeftSwipeDeleteTableView *myCollectionTableView;
@property (retain) UIViewController*    father;
@property (retain, nonatomic) IBOutlet NSString * ProductType;
@property (retain, nonatomic) IBOutlet SelectionButton *buxianBtn;
@property (retain, nonatomic) IBOutlet SelectionButton *goldBtn;
@property (retain, nonatomic) IBOutlet SelectionButton *yinyuanBtn;
@property (retain, nonatomic) IBOutlet UIView *shaixuanView;

@property (retain, nonatomic) IBOutlet UIView *aginShaiXuanVIew;
@property (retain, nonatomic) IBOutlet UIButton *aginShaiXuanBtn;
@property (retain, nonatomic) IBOutlet UIView *showView;
@property (retain, nonatomic) IBOutlet Redbutton *gotoMallBtn;

@property (retain, nonatomic) IBOutlet UIButton *shaiXuanBtn;

- (IBAction)shaixuanBtn:(id)sender;

- (IBAction)touchUpInsideBtn:(id)sender;
@end

@implementation MyCollectionViewController

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    InitNav(@"我的收藏");
    
    _ProductType = @"0";
    
    [_aginShaiXuanBtn roundCornerBorder];
    
    if ([[UIScreen mainScreen] bounds].size.height < 568)
    {
        _shaiXuanBtn.frame = CGRectMake(268, 364, 44, 44);
    }
    else
    {
        _shaiXuanBtn.frame = CGRectMake(268, 452, 44, 44);
    }
    
    [_myCollectionTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];

    [self setTableviewLoad];
}

- (IBAction)shaixuanBtn:(id)sender
{
    [self setConsult];
}

#pragma mark Consult

- (IBAction) onMoveFoward:(UIButton*) sender
{
    [self setConsult];
}

-(void) setConsult
{
    if (!_appPopView)
    {
        __block MyCollectionViewController *weakSelf = self;
        
        _appPopView = [[AppPopView alloc] initWithAnimateUpOn:self frame:CGRectMake(0, 0, _shaixuanView.width, _shaixuanView.height) left:^{} right:^{
            [weakSelf rightButtonTouched];
        }];
        [_appPopView.contentView addSubview:_shaixuanView];
        _buxianBtn.selected = YES;
        _appPopView.titleName = @"筛选";
        
    }
    [_appPopView show:YES];
}

- (void)rightButtonTouched
{
    [_appPopView show:NO];
    
    [self refreshTableView];
}

#pragma mark - tableView delegate

- (void) setTableviewLoad
{
    NSString * refreshName = @"Favorite/ProductList";
    
    _MJRefreshCon = [MJRefreshController controllerFrom:_myCollectionTableView name:refreshName];
    
    __block MyCollectionViewController * weakself = self;
    
    [_MJRefreshCon setURLGenerator:MJREFRESH_URL_GENERATOR_BLOCK
     {
         NSLog(@"----%@",@{
                           @"service":[NSString stringWithFormat:@"api/%@",refreshName],
                           @"parameters":
                               @{@"ProductType":weakself.ProductType,@"PageIndex":@(pageIndex),
                                 @"PageSize":@(pageSize)}});
         
         return @{
                  @"service":[NSString stringWithFormat:@"api/%@",refreshName],
                  @"parameters":
                      @{@"ProductType":weakself.ProductType,@"PageIndex":@(pageIndex),
                        @"PageSize":@(pageSize)}}.wrapper;
     }];
    
    {
        MJRefreshOnRequestDone block = MJREFRESH_ON_REQUEST_DONE
        {
            NSLog(@"%@",netData);
            if (netData.operationSucceed)
            {
                _myCollectionTableView.delegate = self;
                _myCollectionTableView.dataSource = self;
                
                if ([_ProductType isEqualToString:@"0"])
                {
                    if (controller.refreshCount == 0)
                    {
                        [self.view addSubview:_showView];
                        [self setupMoveFowardButtonWithTitle:@"筛选"];
                    }
                    else
                    {
                        [_aginShaiXuanVIew removeFromSuperview];
                        [self setupMoveFowardButtonWithTitle:@""];
                    }
                }
                else
                {
                    if (controller.refreshCount == 0)
                    {
                        [self.view addSubview:_aginShaiXuanVIew];
                        [self setupMoveFowardButtonWithTitle:@"筛选"];
                    }
                    else
                    {
                        [_aginShaiXuanVIew removeFromSuperview];
                        [self setupMoveFowardButtonWithTitle:@""];
                    }
                }
            }
            else
            {
                [HUDUtil showErrorWithStatus:netData.operationMessage];
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

#pragma mark - tableView delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _MJRefreshCon.refreshCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MyCollectionTableViewCell";
    
    MyCollectionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[NSBundle mainBundle] loadNibNamed:@"MyCollectionTableViewCell" owner:nil options:nil].lastObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.layer.masksToBounds = YES;
    }
    if ([[_MJRefreshCon dataAtIndex:(int)indexPath.row]getInt:@"ProductType"] == 1)
    {
        cell.cellTypeImage.image = [UIImage imageNamed:@"goodsForYinyuan"];
        cell.cellneedLable.text = @"所需银元";
        cell.cellNeedMoney.text = [NSString stringWithFormat:@"%d",[[_MJRefreshCon dataAtIndex:(int)indexPath.row]getInt:@"UnitPrice"]];
    }
    else
    {
        cell.cellTypeImage.image = [UIImage imageNamed:@"goodsForGold"];
        cell.cellneedLable.text = @"所需易货码";
        cell.cellNeedMoney.text = [NSString stringWithFormat:@"%.2f",[[_MJRefreshCon dataAtIndex:(int)indexPath.row]getDouble:@"UnitPrice"]];
    }
    
    [cell.cellImages requestCustom:[[_MJRefreshCon dataAtIndex:(int)indexPath.row]getString:@"PictureUrl"] width:cell.cellImages.width height:cell.cellImages.height];
    
    cell.cellTitle.text = [[_MJRefreshCon dataAtIndex:(int)indexPath.row]getString:@"ProductName"];
    
    if (cell.cellTitle.text.length <= 13)
    {
        cell.cellTitle.frame = CGRectMake(105, 25, 200, 36);
        cell.cellneedLable.frame = CGRectMake(105, 62, 47, 21);
        cell.cellNeedMoney.frame = CGRectMake(155, 62, 150, 21);
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[_MJRefreshCon dataAtIndex:(int)indexPath.row]getInt:@"ProductType"] == 1)
    {
        PUSH_VIEWCONTROLLER(CRSliverDetailViewController);
        model.productId = [[_MJRefreshCon dataAtIndex:(int)indexPath.row]getInt:@"ProductId"];
        model.advertId = [[_MJRefreshCon dataAtIndex:(int)indexPath.row]getInt:@"AdvertId"];
    }
    else
    {
        PUSH_VIEWCONTROLLER(Preview_Commodity);
        model.productId = [[_MJRefreshCon dataAtIndex:(int)indexPath.row]getInt:@"ProductId"];
        model.whereFrom = 1;
    }
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyCollectionTableViewCell *cell = (MyCollectionTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.contentView.backgroundColor = AppColor(220);
    return YES;
}

- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyCollectionTableViewCell *cell = (MyCollectionTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor whiteColor];
}

#pragma mark TableViewDelete

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        int ProductId = [[_MJRefreshCon dataAtIndex:(int)indexPath.row]getInt:@"ProductId"];
        
        int AdvertId = [[_MJRefreshCon dataAtIndex:(int)indexPath.row]getInt:@"AdvertId"];
        
        int ProductType = [[_MJRefreshCon dataAtIndex:(int)indexPath.row]getInt:@"ProductType"];
        
        if ( ProductType == 1)
        {
            ADAPI_UnFavoriteCommodity_new([self genDelegatorID:@selector(collectReponse:)],ProductId,AdvertId,ProductType);
        }
        else
        {
            ADAPI_UnFavoriteCommodity_new([self genDelegatorID:@selector(collectReponse:)],ProductId,AdvertId,ProductType);
        }
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert)
    {
        
    }
}

- (void)collectReponse:(DelegatorArguments *)arg
{
    if (arg.ret.operationSucceed)
    {
        [HUDUtil showSuccessWithStatus:arg.ret.operationMessage];
        
        [self refreshTableView];
    }
    else
    {
        [HUDUtil showErrorWithStatus:arg.ret.operationMessage];
    }
}


- (IBAction)touchUpInsideBtn:(id)sender
{
    if (sender == _buxianBtn)
    {
        _buxianBtn.selected = YES;
        _goldBtn.selected = NO;
        _yinyuanBtn.selected = NO;
        _ProductType = @"0";
    }
    else if (sender == _goldBtn)
    {
        _buxianBtn.selected = NO;
        _goldBtn.selected = YES;
        _yinyuanBtn.selected = NO;
        _ProductType = @"2";
    }
    else if (sender == _yinyuanBtn)
    {
        _buxianBtn.selected = NO;
        _goldBtn.selected = NO;
        _yinyuanBtn.selected = YES;
        _ProductType = @"1";
    }
    else if (sender == _gotoMallBtn)
    {
        for (UIViewController *vc in [DotCUIManager instance].mainNavigationController.viewControllers)
        {
            if ([vc isKindOfClass:[MallScanAdvertMain class]])
            {
                UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                button.tag = 1;
                
                [((MallScanAdvertMain *)vc) swapPage:button];
                [self.navigationController popViewControllerAnimated:YES];
            }
        }
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    
    [_MJRefreshCon release];
    [_appPopView release];
    [_myCollectionTableView release];
    [_buxianBtn release];
    [_goldBtn release];
    [_yinyuanBtn release];
    [_shaixuanView release];
    [_aginShaiXuanVIew release];
    [_aginShaiXuanBtn release];
    [_showView release];
    [_gotoMallBtn release];
    [_shaiXuanBtn release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setMyCollectionTableView:nil];
    [super viewDidUnload];
}
@end
