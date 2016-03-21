//
//  AdvertCollectionViewController.m
//  miaozhuan
//
//  Created by abyss on 14/10/21.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "AdvertCollectionViewController.h"
#import "AdvertCollectionTableViewCell.h"
#import "MJRefreshController.h"
#import "OpenRedPacketViewController.h"
#import "PSAsDetailController.h"
#import "AdsDetailViewController.h"

#import "AppPopView.h"

typedef NS_ENUM(int64_t, AdvertCollectionType)
{
    AdvertCollectionTypeAll = 0,
    AdvertCollectionTypeYin = 1,
    AdvertCollectionTypeHong = 2,
    AdvertCollectionTypePs = 3
};

typedef NS_ENUM(int64_t, AdvertCollectionRefreshReason)
{
    AdvertCollectionRefreshReasonFirst = 0,
    AdvertCollectionRefreshReasonFilter = 1,
    AdvertCollectionRefreshReasonSelector = 1 << 1,
};

@interface AdvertCollectionViewController () <UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
{
    MJRefreshController *_MJRefreshCon;
    NSString *_key;
    
    AdvertCollectionType _type;
    AdvertCollectionRefreshReason _reason;
    
    AppPopView *_appPopView;
    
    NSIndexPath *_deletePath;
}
@property (retain, nonatomic) MJRefreshController *MJRefreshCon;
@property (assign, nonatomic) AdvertCollectionType type;
@property (assign, nonatomic) AdvertCollectionRefreshReason reason;
@property (retain, nonatomic) AppPopView *appPopView;
@property (retain, nonatomic) NSMutableArray *objectDic;
@property (retain, nonatomic) NSString *key;
@end

@implementation AdvertCollectionViewController
@synthesize tableView = _tableView;
@synthesize popView   = _popView;
@synthesize bt1 = _bt1,bt2 = _bt2,bt3 = _bt3;
@synthesize textF = _textF;
@synthesize noCollectionView = _noCollectionView;
@synthesize noSelectionView  = _noSelectionView;
@synthesize reSelectBt = _reSelectBt;

- (void)dealloc
{
    [_popView release];
    [_appPopView release];
    
    [_deletePath release];
    [_key release];
    [_reSelectBt release];
//    [_deletePath release];
    [_MJRefreshCon release];
    [_tableView release];
    [_noCollectionView release];
    [_noSelectionView release];
    [_selectionButton release];
    [_bt1 release];
    [_bt2 release];
    [_bt3 release];
    [_textF release];
    CRDEBUG_DEALLOC();
    
    [_btn4 release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setTableView:nil];
    [self setNoCollectionView:nil];
    [self setNoSelectionView:nil];
    [self setSelectionButton:nil];
    [super viewDidUnload];
}

#pragma mark - main

MTA_viewDidAppear()
MTA_viewDidDisappear()

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    InitNav(@"广告收藏");
    
    [self setupMoveFowardButtonWithTitle:@"筛选"];
    
    [self loadTableView];
    [self.view addSubview:_noSelectionView];
    _noSelectionView.hidden = YES;
    [self.view addSubview:_noCollectionView];
    _noCollectionView.hidden = YES;
    _reSelectBt.b_color = AppColorLightGray204;
    _reSelectBt.h_color = AppColorBackground;
    _selectionButton.top = SCREENHEIGHT - 64 - 48;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    _tableView.tableFooterView = WEAK_OBJECT(UIView, init);
    
    [self addDoneToKeyboard:_textF];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadTableView
{
    _type = AdvertCollectionTypeAll;
    _key = @"";
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    NSString * refreshName = @"Favorite/List/";
    
    _MJRefreshCon = [MJRefreshController controllerFrom:_tableView name:refreshName];
    
    __block AdvertCollectionViewController *weakself = self;

    [_MJRefreshCon setURLGenerator:MJREFRESH_URL_GENERATOR_BLOCK
    {
        NSLog(@"%@",  @{@"service":[NSString stringWithFormat:@"api/%@",refreshName],
                        @"parameters":@{
                                @"AdvertType":@(weakself.type),
                                @"KeyWord":weakself.key,
                                @"PageIndex":@(pageIndex),
                                @"PageSize":@(pageSize)}
                        });
       return
  @{@"service":[NSString stringWithFormat:@"api/%@",refreshName],
    @"parameters":@{
                    @"AdvertType":@(weakself.type),
                    @"KeyWord":weakself.key,
                    @"PageIndex":@(pageIndex),
                    @"PageSize":@(pageSize)}
    }.wrapper;
    }];
    
    {
        MJRefreshOnRequestDone block = MJREFRESH_ON_REQUEST_DONE
        {
            NSLog(@"%@",netData);
            weakself.noCollectionView.hidden = YES;
            weakself.noSelectionView.hidden = YES;
            if (controller.refreshCount == 0)
            {
                if (weakself.reason == AdvertCollectionRefreshReasonFilter)
                {
                    weakself.noCollectionView.hidden = NO;
                }
                else if (weakself.reason == AdvertCollectionRefreshReasonSelector)
                {
                    weakself.noSelectionView.hidden = NO;
                }
                else
                {
                    weakself.noCollectionView.hidden = NO;
                }
            }
            if (weakself.appPopView)
            {
                [weakself.appPopView show:NO];
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

#pragma mark - event

//重新筛选
- (IBAction)reSelect:(id)sender
{
    [self onMoveFoward:nil];
}

//红色选择效果，key
- (IBAction)selectBt:(UIButton *)sender
{
    _bt1.selected = NO;
    _bt2.selected = NO;
    _bt3.selected = NO;
    _btn4.selected = NO;
    
    sender.selected = YES;
    
    if (sender == _bt1)
    {
        _type = AdvertCollectionTypeAll;
    }
    else if (sender == _bt2)
    {
        _type = AdvertCollectionTypeYin;
    }
    else if (sender == _bt3)
    {
        _type = AdvertCollectionTypeHong;
    } else if (sender == _btn4) {
        _type = AdvertCollectionTypePs;
    }
}

//过滤
- (IBAction)selection:(id)sender
{
    UIAlertView* view = [[UIAlertView alloc] initWithTitle:@"过滤失效广告" message:@"确定要过滤失效广告吗" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [view show];
    [view autorelease];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        ADAPI_adv3_Filter([self genDelegatorID:@selector(isDone:)]);
        _reason = AdvertCollectionRefreshReasonFilter;
        [self refreshTableView];
    }
}

- (void)isDone:(DelegatorArguments *)arg
{
    [arg logError];
    if (arg.ret.operationSucceed)
    {
        [_MJRefreshCon refreshWithLoading];
    }
}

- (void)hiddenKeyboard{
    [APP_DELEGATE.window endEditing:YES];
}

//筛选结束执行
- (void)hiddenKB
{
    [APP_DELEGATE.window endEditing:YES];
    _key = _textF.text;
    [_key retain];
    if (_key == nil) _key = @"";
    NSLog(@"%@",_key);
    [_appPopView show:NO];
}

//返回
- (void)onMoveBack:(UIButton *)sender
{
    [APP_DELEGATE.window endEditing:YES];
    [_appPopView show:NO];
    [self.navigationController popViewControllerAnimated:YES];
}

//筛选
- (void)onMoveFoward:(UIButton *)sender
{
    if (!_appPopView)
    {    __block UIWindow *weakWindow = APP_DELEGATE.window;
        [_textF setShouldReturnBlock:CommonTextFieldBlockBOOL{
            [weakWindow endEditing:YES];
            return YES;
        }];
        __block AdvertCollectionViewController *weakSelf = self;
        _appPopView = [[AppPopView alloc] initWithAnimateUpOn:self frame:CGRectMake(0, 0, 320, _popView.height) left:^{} right:^{
            weakSelf.reason = AdvertCollectionRefreshReasonSelector;
            [weakSelf hiddenKB];
            [weakSelf.MJRefreshCon refreshWithLoading];
        }];
        _appPopView.titleName = @"筛选";
        [_appPopView.contentView addSubview:_popView];
    }
    [_appPopView show:YES];
    [self selectBt:_bt1];
}

#pragma mark - TableView Delegate

//- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    AdvertCollectionTableViewCell *cell = (AdvertCollectionTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
//    cell.contentView.backgroundColor = AppColor(220);
//    return YES;
//}
//- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    AdvertCollectionTableViewCell *cell = (AdvertCollectionTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
//    cell.contentView.backgroundColor = [UIColor whiteColor];
//}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AdvertCollectionTableViewCell *cell = (AdvertCollectionTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    
    DictionaryWrapper *data = [[_MJRefreshCon dataAtIndex:(int)indexPath.row] wrapper];
    int type = [data getInt:@"AdvertType"];
    
    switch (type) {
        case 1:{
            
            PUSH_VIEWCONTROLLER(AdsDetailViewController);
            model.adId          = cell.adsId;
            model.isMerchant    = YES;
            break;
            
        case 2:{
            
            PUSH_VIEWCONTROLLER(OpenRedPacketViewController);
            model.adsId = cell.adsId.intValue;
            break;}
            
        case 3:{
            
            
            PUSH_VIEWCONTROLLER(PSAsDetailController);
            model.adId = cell.adsId;
            model.notShow = YES;
            break;}
            
        default:
            break;
    }
  }
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        // Delete the row from the data source
        _deletePath = indexPath;
        [_deletePath retain];
        ADAPI_adv3_Remove([self genDelegatorID:@selector(remove:)], [[_MJRefreshCon.refreshData[indexPath.row] wrapper] getInteger:@"AdvertId"], [[_MJRefreshCon.refreshData[indexPath.row] wrapper] getInteger:@"AdvertType"]);
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert)
    {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 145;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    if (_MJRefreshCon.refreshCount == 0)
//    {
//        [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
//    }
//    else [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
//    return _objectDic.count;
    return _MJRefreshCon.refreshCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"AdvertCollectionTableViewCell";
    AdvertCollectionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[NSBundle mainBundle] loadNibNamed:@"AdvertCollectionTableViewCell" owner:nil options:nil].lastObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.highlighted = YES;
        [cell.img setBorderWithColor:AppColor(197)];
    }
    
    DictionaryWrapper *data = [[_MJRefreshCon dataAtIndex:(int)indexPath.row] wrapper];
    cell.icon.image = [UIImage imageNamed:([data getInt:@"AdvertType"] == 1 ? @"016.png" : ([data getInt:@"AdvertType"] == 2 ? @"015.png" : @"ps_adsiconbg.png"))];
//    [cell.img requestCustom:[data getString:@"PictureUrl"] width:cell.img.width height:cell.img.height];
    [cell.img requestMiddle:[data getString:@"PictureUrl"]];
    cell.titleL.text = [data getString:@"AdvertDescription"];
    cell.textL.text = [data getString:@"EnterpriseName"];
//    cell.titleL.text = @"kagsdjkasgcfkjasgbdcjgaskljcghlaSGKUadkuAGQLC";
    cell.textL.top = AppGetTextHeight(cell.titleL);
    
    cell.isYin = [data getInt:@"AdvertType"] == 1? YES:NO;
    cell.adsId = [data getString:@"AdvertId"];
    
//    cell.separatorInset = UIEdgeInsetsMake(0, 15, 0, 0);
    
    return cell;
}

- (void)remove:(DelegatorArguments *)arg
{
    [arg logError];
    if (arg.ret.operationSucceed)
    {
        if (!_deletePath) return;
        [_MJRefreshCon removeDataAtIndex:(int)_deletePath.row andView:UITableViewRowAnimationFade];
        [self refreshTableView];
    }
}

@end
