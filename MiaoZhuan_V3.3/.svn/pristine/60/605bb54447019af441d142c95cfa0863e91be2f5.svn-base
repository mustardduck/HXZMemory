//
//  YinYuanAdvertListController.m
//  miaozhuan
//
//  Created by momo on 14-11-20.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "YinYuanAdvertListController.h"
#import "MJRefreshController.h"
#import "BaserHoverView.h"
#import "YinYuanAdvertCell.h"
#import "YinYuanAdvertEditController.h"
#import "YinYuanADsDetailController.h"
#import "YinYuanAdvertDisplayCell.h"


@interface YinYuanAdvertListController ()<UITableViewDataSource, UITableViewDelegate>
{
    MJRefreshController * _MJRefreshCon;
}

@end

@implementation YinYuanAdvertListController

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    DictionaryWrapper* dic =[APP_DELEGATE.runtimeConfig getDictionary:RUNTIME_USER_LOGIN_INFO].wrapper;
    
    _enterpId = [dic getString:@"EnterpriseId"];
    
    [self showNaviTitle];
    [self setupMoveBackButton];
    
    if(_queryType == PlayingADType || _queryType == ReadToPlayADType)
    {
        [self ShowTopView];
    }

    [self initTableView];
    
}

- (void) onMoveBack:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) showNaviTitle
{
    NSString * titleName = @"";
    
    switch (_queryType) {
        case DraftADType:
            titleName = @"草稿箱";
            break;
        case PlayingADType://播放中
            titleName = @"审核成功的银元广告";
            break;
        case ProceedingADType:
            titleName = @"审核中的银元广告";
            break;
        case AuditFailedADType:
            titleName = @"审核失败的银元广告";
            break;
        case PlayedADType:
            titleName = @"已播完的银元广告";
            break;
        default:
            break;
    }
    
    [self setNavigateTitle: titleName];
    
}

- (void)initTableView
{
    NSString * refreshName = @"SilverAdvert/EnterpriseGetAdverts";
    
    _MJRefreshCon = [MJRefreshController controllerFrom:_mainTableView name:refreshName];
    
    __block YinYuanAdvertListController * weakself = self;
    
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
    
    NSString * titleName = @"";
    
    switch (_queryType) {
        case DraftADType:
            titleName = @"暂无保存的草稿";
            break;
        case PlayingADType:
            titleName = @"暂无播放中的银元广告";
            break;
        case ReadToPlayADType:
            titleName = @"暂无即将播放的银元广告";
            break;
        case ProceedingADType:
            titleName = @"暂无审核中的银元广告";
            break;
        case AuditFailedADType:
            titleName = @"暂无审核失败的银元广告";
            break;
        case PlayedADType:
            titleName = @"暂无已播完的银元广告";
            break;
        default:
            break;
    }
    
    if(!hover)
    {
        hover = WEAK_OBJECT(BaserHoverView, initWithTitle:@"抱歉" message:titleName);
        
        hover.frame = _mainTableView.frame;
        
        hover.tag = 1111;
        
        [self.view addSubview:hover];
        
        [self.view sendSubviewToBack:hover];
        
    }
    else
    {
        hover.lblTitle.text = @"抱歉";
        hover.lblMessage.text = titleName;
    }
    
    _mainTableView.hidden = YES;
    
}

- (void) refreshTableView
{
    [_MJRefreshCon refreshWithLoading];
}

- (IBAction)touchUpInsideOnBtn:(id)sender
{
    if(sender == _playingBtn)
    {
        [UIView animateWithDuration:0.3 animations:^{
            _lineView.left = 15;
        }];
        
        _playingBtn.titleLabel.font = [UIFont systemFontOfSize:17];
        _readyToBtn.titleLabel.font = [UIFont systemFontOfSize:14];

        [_playingBtn setTitleColor:[UIColor titleRedColor] forState:UIControlStateNormal];
        [_readyToBtn setTitleColor:[UIColor titleBlackColor] forState:UIControlStateNormal];
        
        self.queryType = PlayingADType;
        
        [self refreshTableView];

    }
    else if(sender == _readyToBtn)
    {
        [UIView animateWithDuration:0.3 animations:^{
            _lineView.left = 175;
        }];
        
        _readyToBtn.titleLabel.font = [UIFont systemFontOfSize:17];
        _playingBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        
        [_readyToBtn setTitleColor:[UIColor titleRedColor] forState:UIControlStateNormal];
        [_playingBtn setTitleColor:[UIColor titleBlackColor] forState:UIControlStateNormal];
        
        self.queryType = ReadToPlayADType;
        
        [self refreshTableView];
    }
}

- (void) ShowTopView
{
    _topView.hidden = NO;
    
    CGRect rect = _mainTableView.frame;
    
    rect.origin.y = H(_topView);
    
    rect.size.height = H(self.view) - H(_topView);
    
    _mainTableView.frame = rect;
}

- (void)handleDeleteAdvert:(DelegatorArguments *)arguments{
    
    DictionaryWrapper* dic = arguments.ret;
    
    if (dic.operationSucceed) {
        
        [self refreshTableView];
    } else {
        
        [HUDUtil showErrorWithStatus:dic.operationMessage];
        return;
    }
    
}

#pragma mark UITableViewDelegate and UITableViewDatasource methods

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(_queryType == DraftADType || _queryType == AuditFailedADType || _queryType == PlayedADType)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 1)
    {
        DictionaryWrapper *dic = [_MJRefreshCon dataAtIndex: (int)_curIndex];
        
        ADAPI_SilverAdvertDeleteAdvert([self genDelegatorID:@selector(handleDeleteAdvert:)], [dic getString:@"Id"]);
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
    int height = 102;
    
    if(_queryType == PlayingADType || _queryType == PlayedADType)
    {
        DictionaryWrapper * dic = [_MJRefreshCon dataAtIndex:indexPath.row];
        
        NSString * titleText = [dic getString:@"Title"];
        
//        NSString * titleText = @"文字是两行时文字是两行时文字是两行时文字是两行时文字是两行时文字是两行时";
        
        CGSize size = [UICommon getSizeFromString:titleText
                                         withSize:CGSizeMake(226, 36)
                                         withFont:15];
        
        if(size.height > 20)
        {
            height += 15;
        }
    }
    
    return height;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _MJRefreshCon.refreshCount;
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    YinYuanAdvertCell *cell = (YinYuanAdvertCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.contentView.backgroundColor = AppColor(220);
    
    return YES;
}
- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    YinYuanAdvertCell *cell = (YinYuanAdvertCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor whiteColor];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(_queryType == PlayingADType || _queryType == PlayedADType)
    {
        static NSString *identifier = @"YinYuanAdvertDisplayCell";

        YinYuanAdvertDisplayCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
        if (!cell) {
            
            cell = [[[NSBundle mainBundle] loadNibNamed:@"YinYuanAdvertDisplayCell" owner:self options:nil] firstObject];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        
        DictionaryWrapper * dic = [_MJRefreshCon dataAtIndex:indexPath.row];
        
        [cell.imgview setBorderWithColor:AppColor(220)];
        
        NSString * str = [dic getString:@"PictureUrl"];
        
        [cell.imgview requestPic:str placeHolder:YES];
        
        NSString * titleText = [dic getString:@"Title"];
        
        cell.titleLbl.text = titleText;
        
        CGSize size = [UICommon getSizeFromString:titleText
                                         withSize:CGSizeMake(226, 36)
                                         withFont:15];
        
        if(size.height > 20)
        {
            cell.titleLbl.top = 13;
            cell.countView.top = 55;
            cell.line.top = 116.5;
        }
        else
        {
            cell.titleLbl.top = 5;
            cell.countView.top = 40;
            cell.line.top = 101.5;
        }
        
        if(cell.titleLbl.text.length == 0)
        {
            cell.titleLbl.text = @"未填写广告名称";
            
            cell.titleLbl.textColor = [UIColor titleRedColor];
        }
        else
        {
            cell.titleLbl.textColor = [UIColor titleBlackColor];
        }
        
        NSString * time = @"";
        
        NSString * startTime = [dic getString:@"StartTime"];
        
        NSString * endTime = [dic getString:@"EndTime"];
        
        switch (_queryType) {
            case PlayingADType:
                
                time = [UICommon countWithFromDate:startTime toDate:endTime];
                
                time = [NSString stringWithFormat:@"剩余有效期%@", time];
                
                break;
            case PlayedADType:
                
                endTime = [dic getString:@"FinishTime"];
                
                time = [UICommon formatDate:endTime withRange:NSMakeRange(0, 16)];
                
                time = [NSString stringWithFormat:@"于%@ 广告下架", time];
                break;
            default:
                break;
        }
        
        cell.dateLbl.text = time;
        
        cell.displayedCountLbl.text = [NSString stringWithFormat:@"已播放次数  %d", [dic getInt:@"PlayCount"]];
        
        cell.reviewedCountLbl.text = [NSString stringWithFormat:@"已收看人数  %d", [dic getInt:@"ReadCount"]];
        
        [cell displayView];
        
        return cell;
    }
    else
    {
        static NSString *identifier = @"YinYuanAdvertCell";
       
        YinYuanAdvertCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
        if (!cell) {
            
            cell = [[[NSBundle mainBundle] loadNibNamed:@"YinYuanAdvertCell" owner:self options:nil] firstObject];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        
        DictionaryWrapper * dic = [_MJRefreshCon dataAtIndex:indexPath.row];
        
        [cell.imgview setBorderWithColor:AppColor(220)];
        
        NSString * str = [dic getString:@"PictureUrl"];
        
        [cell.imgview requestPic:str placeHolder:YES];
        
        cell.titleLbl.text = [dic getString:@"Title"];
        
        if(cell.titleLbl.text.length == 0)
        {
            cell.titleLbl.text = @"未填写广告名称";
            
            cell.titleLbl.textColor = [UIColor titleRedColor];
        }
        else
        {
            cell.titleLbl.textColor = [UIColor titleBlackColor];
        }
        
        NSString * time = @"";
        
        NSString * startTime = [dic getString:@"StartTime"];
        
        NSString * endTime = [dic getString:@"EndTime"];
        
        switch (_queryType) {
            case DraftADType:
                
                time = [dic getString:@"UpdatedTime"];
                
                time = [UICommon formatDate:time withRange:NSMakeRange(0, 16)];
                
                time = [NSString stringWithFormat:@"保存于%@", time];
                
                break;
            case PlayingADType:
                
                time = [UICommon countWithFromDate:startTime toDate:endTime];
                
                time = [NSString stringWithFormat:@"剩余有效期%@", time];
                
                break;
            case ReadToPlayADType:
                
                time = [UICommon formatDate:startTime];
                
                time = [NSString stringWithFormat:@"播放时间: %@", time];
                
                break;
            case ProceedingADType:
                
                time = [dic getString:@"SubmitVerifyTime"];
                
                time = [UICommon formatDate:time withRange:NSMakeRange(0, 16)];
                
                time = [NSString stringWithFormat:@"于%@ 提交审核", time];
                
                break;
            case AuditFailedADType:
                
                time = [dic getString:@"VerifyTime"];
                
                time = [UICommon formatDate:time withRange:NSMakeRange(0, 16)];
                
                time = [NSString stringWithFormat:@"于%@ 审核失败", time];
                
                break;
            case PlayedADType:
                
                time = [UICommon formatDate:endTime withRange:NSMakeRange(0, 16)];
                
                time = [NSString stringWithFormat:@"于%@ 广告下架", time];
                
                break;
            default:
                break;
        }
        
        cell.dateLbl.text = time;
        
        return cell;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(_queryType == DraftADType || _queryType == AuditFailedADType )
    {
        YinYuanAdvertEditController * view = WEAK_OBJECT(YinYuanAdvertEditController, init);
        
        DictionaryWrapper * dic = [_MJRefreshCon dataAtIndex:indexPath.row];
        
        view.advertId = [dic getString:@"Id"];
        
        view.isEdit = YES;
        
        if (_queryType == AuditFailedADType) {
            
            view.isFail = YES;
        }
        
        [self.navigationController pushViewController:view animated:YES];
        
    }
    else//预览
    {
        YinYuanADsDetailController * view = WEAK_OBJECT(YinYuanADsDetailController, init);
        
        DictionaryWrapper * dic = [_MJRefreshCon dataAtIndex:indexPath.row];

        view.advertId = [dic getString:@"Id"];
        
        view.state = _queryType;
        
        [self.navigationController pushViewController:view animated:YES];

    }
}

- (void)dealloc {
    [_topView release];
    [_playingBtn release];
    [_readyToBtn release];
    [_lineView release];
    [_mainTableView release];
    
    [_MJRefreshCon release];
    
    [super dealloc];
}
- (void)viewDidUnload {
    [self setTopView:nil];
    [self setPlayingBtn:nil];
    [self setReadyToBtn:nil];
    [self setLineView:nil];
    [self setMainTableView:nil];
    [super viewDidUnload];
}
@end
