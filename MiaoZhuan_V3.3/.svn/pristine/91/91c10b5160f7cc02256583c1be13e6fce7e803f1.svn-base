//
//  DraftBoxViewController.m
//  miaozhuan
//
//  Created by 孙向前 on 14-11-19.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "DraftBoxViewController.h"
#import "DraftBoxCell.h"
#import "MJRefreshController.h"
#import "BaserHoverView.h"
#import "AddAccurateAdsViewController.h"
#import "AdsDetailViewController.h"
#import "AccurateService.h"
#import "AccAdsDetailViewController.h"
#import "RRLineView.h"

@interface DraftBoxViewController ()<UITableViewDataSource, UITableViewDelegate>{
    int _currentState;
    BaserHoverView *_hover;
}

@property (nonatomic, retain) MJRefreshController *MJRefreshCon;

@property (retain, nonatomic) IBOutlet UITableView *tableView;
@property (retain, nonatomic) IBOutlet UIView *selectItemView;
@property (retain, nonatomic) IBOutlet UIButton *btnPlay;
@property (retain, nonatomic) IBOutlet UIButton *btnWillPlay;
@property (retain, nonatomic) IBOutlet UIImageView *ImgRedLine;
@property (nonatomic, assign) BOOL isBack;
@property (retain, nonatomic) IBOutlet RRLineView *topline;

@end

@implementation DraftBoxViewController

- (void)viewWillAppear:(BOOL)animated{
    if (_isBack) {
        [self refreshTableView];
    }
}

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _topline.top = 39.5;
    
    [self setupMoveBackButton];
    NSArray *titles = @[@"草稿箱", @"审核成功的红包广告", @"审核成功的红包广告", @"审核成功的红包广告", @"审核中的红包广告", @"审核失败的红包广告", @"已播放完的红包广告"];
    [self setNavigateTitle:titles[_state]];
    
    if (_state != 1) {
        _selectItemView.hidden = YES;
        _tableView.top = 0;
        _tableView.height = self.view.height;
    }
    _btnPlay.selected = YES;
    _btnPlay.titleLabel.font = Font(17);
    _currentState = (_state == 1 ? 2 : _state);
    
    [_MJRefreshCon release];
    _MJRefreshCon = nil;
    NSString *refreshName = @"DirectAdvert/List";
    self.MJRefreshCon = [MJRefreshController controllerFrom:_tableView name:refreshName];
    
    [self _initTableView];
}

-(void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = WEAK_OBJECT(UIView, initWithFrame:CGRectZero);
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}
- (void)_initTableView{
    
    __block typeof(self) weakSelf = self;
    
    [_MJRefreshCon setURLGenerator:MJREFRESH_URL_GENERATOR_BLOCK{
        NSDictionary * dic =@{@"State":@(_currentState), @"PageIndex":@(pageIndex), @"PageSize":@(pageSize)};
        NSDictionary *pramaDic= @{@"service":[NSString stringWithFormat:@"api/%@",refreshName],@"parameters":dic};
        return pramaDic.wrapper;
    }];
    MJRefreshOnRequestDone block = MJREFRESH_ON_REQUEST_DONE
    {
        NSLog(@"%@___%d ___",netData.dictionary, netData.operationSucceed);;
        if(controller.refreshCount > 0)
        {
            [_hover removeFromSuperview];
        }
        else
        {
            [weakSelf createHoverViewWhenNoData];
        }
    };
    
    [_MJRefreshCon setOnRequestDone:block];
    [_MJRefreshCon setPageSize:50];
    
    [self refreshTableView];
    
    [self setExtraCellLineHidden:_tableView];
}

//无数据hoverview
- (void)createHoverViewWhenNoData{
    _hover = nil;
    NSArray *words = @[@"暂无保存的草稿", @"", @"暂无播放中的红包广告", @"暂无即将播放的红包广告", @"暂无审核中的红包广告", @"暂无审核失败的红包广告", @"暂无已播完的红包广告", ];
    _hover = STRONG_OBJECT(BaserHoverView, initWithTitle:@"抱歉" message:words[_currentState]);
    _hover.lblMessage.width = 200;
    _hover.lblMessage.left = 60;
    _hover.frame = (_state == 1 ? CGRectMake(self.view.bounds.origin.x, 40, SCREENWIDTH, self.view.bounds.size.height - 40) : self.view.bounds);
    [self.view addSubview:_hover];
}

- (void) refreshTableView
{
    [_MJRefreshCon refreshWithLoading];
}

#pragma mark - UITableViewDelegate/UITableViewDatasource
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return !_state || _state == 5 || _state == 6;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        __block typeof(self) weakself = self;
        [AlertUtil showAlert:@"确认删除" message:@"一旦删除，则不可以恢复" buttons:@[
                                                        
                                                                        @"取消"
                                                                        ,@{
                                                                          @"title":@"确定",
                                                                          @"delegator":ALERT_VIEW_DELEGATOR_BLOCK
                                                                          ({
            DictionaryWrapper *dic = [_MJRefreshCon dataAtIndex:(int)indexPath.row];
            ADAPI_DirectAdvert_DeleteAdvert([GLOBAL_DELEGATOR_MANAGER addDelegator:weakself selector:@selector(handleDeleteAds:)], @{@"DirectAdvertId":[dic getString:@"DirectAdvertId"]});
        })
                                                                          }
                                                                      ]];
        
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (_state == 2 || _state == 6) {
        DraftBoxCell *cell = (DraftBoxCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
        return cell.height;
//    }
//    return 100;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _MJRefreshCon.refreshCount;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier;
    identifier = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    DraftBoxCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"DraftBoxCell" owner:self options:nil] firstObject];
    }
    cell.state = _currentState;
    cell.dataDic = [_MJRefreshCon dataAtIndex:(int)indexPath.row];
   
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (!_state || _state == 5) {
        //草稿箱
        [AccurateService clearData];
        self.isBack = YES;
        DictionaryWrapper *dic = [_MJRefreshCon dataAtIndex:(int)indexPath.row];
        AddAccurateAdsViewController *add = WEAK_OBJECT(AddAccurateAdsViewController, init);
        add.state = _state;
        add.directAdvertId = [dic getString:@"DirectAdvertId"];
        [UI_MANAGER.mainNavigationController pushViewController:add animated:YES];
    } else {
        AccAdsDetailViewController *ads = WEAK_OBJECT(AccAdsDetailViewController, init);
        ads.state = _state;
        DictionaryWrapper *dic = [_MJRefreshCon dataAtIndex:(int)indexPath.row];;
        ads.directAdvertId = [dic getString:@"DirectAdvertId"];
        [UI_MANAGER.mainNavigationController pushViewController:ads animated:YES];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - 删除广告
- (void)handleDeleteAds:(DelegatorArguments *)arguments{
    DictionaryWrapper* dic = arguments.ret;
    if (dic.operationSucceed) {
        NSLog(@"%@", [dic getDictionary:@"Data"]);
        [self _initTableView];
    } else {
        
        [HUDUtil showErrorWithStatus:dic.operationMessage];
        return;
    }

}

#pragma mark - 事件
- (IBAction)playingCilcied:(UIButton *)sender {
    _btnPlay.selected = NO;
    _btnWillPlay.selected = NO;
    _btnPlay.titleLabel.font = Font(14);
    _btnWillPlay.titleLabel.font = Font(14);
    sender.selected = YES;
    sender.titleLabel.font = Font(17);
    
    [UIView animateWithDuration:.3 animations:^{
        _ImgRedLine.left = (sender.tag == 2) ? 15 : 175;
    }];
    
    _currentState = (int)sender.tag;
    [self _initTableView];
}


#pragma mark - 内存管理
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc {
    [_hover release];
    [_MJRefreshCon release];
    [_tableView release];
    [_selectItemView release];
    [_btnPlay release];
    [_btnWillPlay release];
    [_ImgRedLine release];
    [_topline release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setTableView:nil];
    [self setSelectItemView:nil];
    [self setBtnPlay:nil];
    [self setBtnWillPlay:nil];
    [self setImgRedLine:nil];
    [self setTopline:nil];
    [super viewDidUnload];
}
@end
