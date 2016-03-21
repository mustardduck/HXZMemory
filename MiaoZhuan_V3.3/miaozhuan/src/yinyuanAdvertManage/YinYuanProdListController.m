//
//  YinYuanProdListController.m
//  miaozhuan
//
//  Created by momo on 14-11-18.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "YinYuanProdListController.h"
#import "MJRefreshController.h"
#import "BaserHoverView.h"
#import "YinYuanProdCell.h"
#import "YinYuanProductEditController.h"
#import "CRSliverDetailViewController.h"

@interface YinYuanProdListController ()

@end

@implementation YinYuanProdListController
{
    MJRefreshController *_MJRefreshCon;
}

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self showNaviTitle];
    
    [self setupMoveBackButton];
    
    DictionaryWrapper* dic =[APP_DELEGATE.runtimeConfig getDictionary:RUNTIME_USER_LOGIN_INFO].wrapper;
    
    _enterpId = [dic getString:@"EnterpriseId"];
    
    [self initTableView];
}

- (void) showNaviTitle
{
    NSString * titleName = @"";
    
    switch (_queryType) {
        case 1:
            titleName = @"草稿箱";
            break;
        case 2:
            titleName = @"审核中的兑换商品";
            break;
        case 3:
            titleName = @"审核失败的兑换商品";
            break;
        case 4:
            titleName = @"审核成功的兑换商品";
            break;
        default:
            break;
    }
    
    [self setNavigateTitle: titleName];
    
}

- (void)initTableView
{
    NSString * refreshName = @"SilverAdvert/EnterpriseGetProducts";
        
    _MJRefreshCon = [MJRefreshController controllerFrom:_mainTableView name:refreshName];
    
    __block YinYuanProdListController * weakself = self;
    
    [_MJRefreshCon setURLGenerator:MJREFRESH_URL_GENERATOR_BLOCK{

        NSDictionary * dic = @{@"service":[NSString stringWithFormat:@"%@%@", @"api/", refreshName ],
                               @"parameters":@{@"QueryType":[NSNumber numberWithInteger: weakself.queryType],
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
                _mainTableView.hidden = NO;
            }
            else
            {
                [self createHoverViewWhenNoData];
            }
        };
        
        [_MJRefreshCon setOnRequestDone:block];
        [_MJRefreshCon setPageSize:30];
        [_MJRefreshCon retain];
    }
    
    [self refreshTableView];
    
}

- (void)createHoverViewWhenNoData{
    
    BaserHoverView * hover = (BaserHoverView *)[self.view viewWithTag:1111];
    
    if(!hover)
    {
        
        NSString * text = @"";
        
        switch (_queryType) {
            case 1:
                text = @"暂无保存的草稿";
                break;
            case 2:
                text = @"暂无审核中的兑换商品";
                break;
            case 3:
                text = @"暂无审核失败的兑换商品";
                break;
            case 4:
                text = @"暂无已绑定的兑换商品";
                break;
            default:
                break;
        }
        
        hover = WEAK_OBJECT(BaserHoverView, initWithTitle:@"抱歉" message:text);
        
        hover.frame = _mainTableView.frame;
        
        hover.tag = 1111;
        
        [self.view addSubview:hover];
        
        [self.view sendSubviewToBack:hover];
        
    }
    
    _mainTableView.hidden = YES;
    
}

- (void) refreshTableView
{
    [_MJRefreshCon refreshWithLoading];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)handleDeleteProduct:(DelegatorArguments *)arguments{
   
    DictionaryWrapper* dic = arguments.ret;
    
    if (dic.operationSucceed) {
        
        [self initTableView];
    } else {
        
        [HUDUtil showErrorWithStatus:dic.operationMessage];
        return;
    }
    
}

- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 1)
    {
        
        DictionaryWrapper *dic = [_MJRefreshCon dataAtIndex: (int)_curIndex];
        
        ADAPI_SilverAdvertDeleteProduct([self genDelegatorID:@selector(handleDeleteProduct:)], [dic getString:@"Id"]);

    }
}

#pragma mark UITableViewDelegate and UITableViewDatasource methods

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(_queryType == 1 || _queryType == 3)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"确认删除"
                                                         message:@"一旦删除，则不可以恢复"
                                                        delegate:self
                                               cancelButtonTitle:@"取消"
                                               otherButtonTitles:@"确定", nil] autorelease];
        [alert show];
        
        _curIndex = [indexPath row];
        
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return _MJRefreshCon.refreshCount;
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    YinYuanProdCell *cell = (YinYuanProdCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.contentView.backgroundColor = AppColor(220);
    
    return YES;
}
- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    YinYuanProdCell *cell = (YinYuanProdCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor whiteColor];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"YinYuanProdCell";
    
    YinYuanProdCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YinYuanProdCell" owner:self options:nil] firstObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

    }
    
    DictionaryWrapper * dic = [_MJRefreshCon dataAtIndex:indexPath.row];
    
    [cell.imgView setBorderWithColor:[UIColor borderPicGreyColor]];
    
    NSString * str = [dic getString:@"PictureUrl"];

    [cell.imgView requestPic:str placeHolder: YES];
    
    cell.titleLbl.text = [dic getString:@"Name"];
    
    if(cell.titleLbl.text.length == 0)
    {
        cell.titleLbl.text = @"未填写商品名称";
        
        cell.titleLbl.textColor = [UIColor titleRedColor];
    }
    else
    {
        cell.titleLbl.textColor = [UIColor titleBlackColor];
    }
    
    NSString * time = @"";

    switch (_queryType) {
        case 1:
            
            time = [dic getString:@"UpdatedTime"];
            
            time = [UICommon formatDate:time withRange:NSMakeRange(0, 16)];
            
            time = [NSString stringWithFormat:@"保存于%@", time];
            
            break;
        case 2:
            
            time = [dic getString:@"SubmitVerifyTime"];
            
            time = [UICommon formatDate:time withRange:NSMakeRange(0, 16)];
            
            time = [NSString stringWithFormat:@"于%@ 提交审核", time];
            
            break;
        case 3:
            
            time = [dic getString:@"VerifyTime"];
            
            time = [UICommon formatDate:time withRange:NSMakeRange(0, 16)];
            
            time = [NSString stringWithFormat:@"于%@ 审核失败", time];
            
            break;
        case 4:
            
            time = @"价值银元";
            
            cell.yinyuanLbl.hidden = NO;
            
            cell.yinyuanLbl.text = [dic getString:@"UnitIntegral"];
            
            break;

        default:
            break;
    }

    cell.desLbl.text = time;

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DictionaryWrapper * dic = [_MJRefreshCon dataAtIndex:indexPath.row];

    if(_queryType == 1 || _queryType == 3)
    {
        YinYuanProductEditController * view = WEAK_OBJECT(YinYuanProductEditController, init);
        
        view.productId = [dic getString:@"Id"];
        
        view.isEdit = YES;
        
        if(_queryType == 3)
        {
            view.isFail = YES;
        }
        
        [self.navigationController pushViewController:view animated:YES];

    }
    else//预览
    {
        CRSliverDetailViewController * view = WEAK_OBJECT(CRSliverDetailViewController, init);
        view.productId = [dic getInteger:@"Id"];
        view.advertId = 0;
        view.isPreview = YES;
        [self.navigationController pushViewController:view animated:YES];
    }
}

- (void)dealloc {
    
    [_MJRefreshCon release];

    [_mainTableView release];
        
    [super dealloc];
}
- (void)viewDidUnload {
    [self setMainTableView:nil];
    [super viewDidUnload];
}
@end
