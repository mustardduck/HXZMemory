//
//  Management_Index.m
//  miaozhuan
//
//  Created by xm01 on 14-12-29.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "Management_Index.h"
#import "Commodity_Cell.h"
#import "MJRefreshController.h"
#import "Commodity_Detail.h"
#import "Preview_Commodity.h"
#import "WebhtmlViewController.h"
#import "AppUtils.h"

#import "Commodity_Details.h"

#define onelineMargin           7
#define twolineMargin           2

@interface Management_Index ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, retain) IBOutlet UITableView           *tabView;
@property(nonatomic, retain) IBOutlet UIView                *slipBar;                       //选项卡底部横向红色滑动条
@property(nonatomic, retain) IBOutlet UIView                *labView;
@property(nonatomic, retain) IBOutlet UITextField           *searchTF;
@property(nonatomic, retain) IBOutlet UILabel               *onOfferCount;                  //出售中总数
@property(nonatomic, retain) IBOutlet UILabel               *onlineCount;                   //等待上架总数
@property(nonatomic, retain) IBOutlet UILabel               *offlineCount;                  //已下架总数
@property(nonatomic, retain) IBOutlet UILabel               *inTheReviewCount;              //审核中总数
@property(nonatomic, retain) IBOutlet UILabel               *auditFailureCount;             //审核失败总数

@property(nonatomic, retain) MJRefreshController            *mjCon;
@property(nonatomic, retain) WDictionaryWrapper             *postDataWrapper;
//@property(nonatomic, retain) NSMutableArray                 *searchStrs;                    //5个状态下 搜索框的输入内容

@end

@implementation Management_Index

@synthesize statusTag = _statusTag;


-(void)dealloc
{
    [_tabView release];
    [_labView release];
    [_slipBar release];
    [_mjCon release];
    [_postDataWrapper release];
    [_searchTF release];
//    [_searchStrs release];
    [_onlineCount release];
    [_onOfferCount release];
    [_offlineCount release];
    [_inTheReviewCount release];
    [_auditFailureCount release];
    
    [super dealloc];
}

-(void)viewDidUnload
{
    [super viewDidUnload];
    
    self.tabView = nil;
    self.labView = nil;
    self.slipBar = nil;
    self.mjCon = nil;
    self.postDataWrapper = nil;
    self.searchTF = nil;
//    self.searchStrs = nil;
    self.onOfferCount = nil;
    self.onlineCount = nil;
    self.offlineCount = nil;
    self.inTheReviewCount = nil;
    self.auditFailureCount = nil;
}

- (void)hiddenKeyboard {
    [_searchTF resignFirstResponder];
    
    [_mjCon refresh];
}

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    InitNav(@"易货商城商品管理");
    [self setupMoveBackButton];
    [self setupMoveFowardButtonWithTitle:@"新增"];
    
    [self addDoneToKeyboard:_searchTF];
    _searchTF.text = @"";
    
    [_tabView registerNib:[UINib nibWithNibName:@"Commodity_Cell" bundle:nil] forCellReuseIdentifier:@"Commodity_Cell"];
    
    //默认 - 出售中
//    _statusTag = 4;
    
//    //初始化5个对象, 用于存放5个选项卡类型的搜索框内容
//    _searchStrs = [[NSMutableArray alloc] initWithObjects:@"", @"", @"", @"", @"", nil];
    
    //初始化
    _postDataWrapper = WEAK_OBJECT(WDictionaryWrapper, init);
    
    
    [self.view addSubview:[AppUtils LineView:60]];
    
    [self.view addSubview:[AppUtils LineView_Vertical:64 y:14 h:33]];
    [self.view addSubview:[AppUtils LineView_Vertical:128 y:14 h:33]];
    [self.view addSubview:[AppUtils LineView_Vertical:192 y:14 h:33]];
    [self.view addSubview:[AppUtils LineView_Vertical:256 y:14 h:33]];
    
    CGRect slipBar_Frame = _slipBar.frame;
    slipBar_Frame.origin.y += 0.5;
    _slipBar.frame = slipBar_Frame;
    
    [self.view addSubview:[AppUtils LineView:100]];
    
    [self default_tab_selected:_statusTag];
    
    NSString *refreshName = @"api/GoldProductManagement/SearchProducts";
    
    if(!self.mjCon)
    self.mjCon = [MJRefreshController controllerFrom:_tabView name:refreshName];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //查询数量
    ADAPI_GoldSearchProductCount([GLOBAL_DELEGATOR_MANAGER addDelegator:self selector:@selector(handleSucceed:)]);
    [self setRefreshItem];
    
}

//Call Back
- (void)handleSucceed:(DelegatorArguments *)arguments
{
    DictionaryWrapper *Datas = arguments.ret;
    DictionaryWrapper *wrapper = [Datas getDictionaryWrapper:@"Data"];
    
    _onOfferCount.text = [NSString stringWithFormat:@"%d", [wrapper getInt:@"OnOfferCount"]];
    _onlineCount.text = [NSString stringWithFormat:@"%d", [wrapper getInt:@"OnlineCount"]];
    _offlineCount.text = [NSString stringWithFormat:@"%d", [wrapper getInt:@"OfflineCount"]];
    _inTheReviewCount.text = [NSString stringWithFormat:@"%d", [wrapper getInt:@"InTheReviewCount"]];
    _auditFailureCount.text = [NSString stringWithFormat:@"%d", [wrapper getInt:@"AuditFailureCount"]];
    
}
- (void)setRefreshItem {
    
    _tabView.hidden = YES;
    
    [self.mjCon setURLGenerator:MJREFRESH_URL_GENERATOR_BLOCK {
        return @{
                 @"service":refreshName,
                 @"parameters":@{
                         @"PageIndex":@(pageIndex),
                         @"PageSize":@(pageSize),
                         @"ProductName":_searchTF.text,
                         @"StatusId":@(_statusTag),
                         }
                 }.wrapper;
    }];
    
    MJRefreshOnRequestDone block = MJREFRESH_ON_REQUEST_DONE {
        
        if (netData.operationSucceed) {
            
        }else {
//            [HUDUtil showErrorWithStatus:netData.operationMessage];
            return;
        }
        _tabView.hidden = NO;
        [_tabView reloadData];
        
    };
    [self.mjCon setOnRequestDone:block];
    [self.mjCon setPageSize:10];
    [self.mjCon refresh];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//点击 --- 新增
- (void)onMoveFoward:(id)sender
{
    PUSH_VIEWCONTROLLER(WebhtmlViewController);
    model.navTitle = @"新增易货商品";
    model.ContentCode = @"f61febed625e52e85a90a51f37321481";
}

//点击 --- 选项卡
- (IBAction)Action_Tab_Selected:(id)sender
{
//    //切换前，存放搜索框内容
//    [_searchStrs replaceObjectAtIndex:_statusTag - 1 withObject:_searchTF.text];
    
    _searchTF.text = @"";
    
    UIButton *btn = (UIButton *)sender;
    
    //如果选择仍是当前项 不做处理
    
//    if(btn.tag == _statusTag)
//    
//        return;
    
    _statusTag = btn.tag;
    
//    _searchTF.text = [_searchStrs objectAtIndex:btn.tag - 1];
    
    //刷新数据
    [_mjCon refreshWithLoading];
    
    //slipBar 滑动效果
    
    CGRect slipBarFrame = _slipBar.frame;
    
    slipBarFrame.origin.x = btn.frame.origin.x;
    
    [UIView animateWithDuration:0.3   animations:^{
        
        _slipBar.frame = slipBarFrame;
        
    }];
    
    //循环设置sub下UILabel的颜色
    
    for(UILabel *lab in [self.labView subviews])
    {
        if([lab isKindOfClass:[UILabel class]])
        {
            if(lab.tag == btn.tag)
                lab.textColor = [UIColor redColor];
            else
                lab.textColor = [UIColor colorWithRed:85/255.0 green:85/255.0 blue:85/255.0 alpha:1.0f];
        }
    }
}

//默认选中项
-(void)default_tab_selected:(NSInteger)tag
{
    for(UILabel *lab in [self.labView subviews])
    {
        if([lab isKindOfClass:[UILabel class]])
        {
            if(lab.tag == tag)
                lab.textColor = [UIColor redColor];
            else
                lab.textColor = [UIColor colorWithRed:85/255.0 green:85/255.0 blue:85/255.0 alpha:1.0f];
        }
    }
    
    for (UIButton *btn in [self.labView subviews]) {
        if([btn isKindOfClass:[UIButton class]])
        {
            if(btn.tag == tag)
            {
                CGRect slipBarFrame = _slipBar.frame;
                
                slipBarFrame.origin.x = btn.frame.origin.x;
                
                _slipBar.frame = slipBarFrame;
            }
        }
    }
}

#pragma mark ------------------UITableView Delegate Start------------------

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(_mjCon.refreshCount == 0)
        _tabView.hidden = YES;
    else
        _tabView.hidden = NO;
    return _mjCon.refreshCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger  row = indexPath.row;
    
    Commodity_Cell *cell = [_tabView dequeueReusableCellWithIdentifier:@"Commodity_Cell" forIndexPath:indexPath];
    
    DictionaryWrapper *wrapper = [[_mjCon dataAtIndex:(int)indexPath.row] wrapper];
    
    if (row >= _mjCon.refreshCount) {
        return cell;
    }
    
    //已下架
    if(_statusTag == 5)
    {
        cell.offlineImage.hidden = NO;
        
        
//        //手动下架
//        if([wrapper getInt:@"OfflineReason"] == 2)
//        {
//            cell.offlineImage.image = [UIImage imageNamed:@"gcm_status_2"];
//        }
//        //额度过期下架
//        else if ([wrapper getInt:@""] == 3)
//        {
//            cell.offlineImage.image = [UIImage imageNamed:@"preview_edu"];
//            cell.offlineImage.width = 35;
//        }
//        else
//        {
//            //售完下架
//            if([wrapper getInt:@"OfflineType"] == 1)
//                cell.offlineImage.image = [UIImage imageNamed:@"gcm_status_0"];
//            
//            //到期下架
//            else if([wrapper getInt:@"OfflineType"] == 2)
//                cell.offlineImage.image = [UIImage imageNamed:@"gcm_status_1"];
//            
//            else
//                cell.offlineImage.image = [UIImage imageNamed:@""];
//        }
        
        
        switch ([wrapper getInt:@"OfflineReason"]) {
                
                //售完下架
            case 1:
                
                cell.offlineImage.image = [UIImage imageNamed:@"gcm_status_0"];
                
                break;
                
                //到期下架
            case 2:
                
                cell.offlineImage.image = [UIImage imageNamed:@"gcm_status_1"];
                
                break;
                
                //手动下架
            case 3:
                
                cell.offlineImage.image = [UIImage imageNamed:@"gcm_status_2"];
                
                break;
                
                //额度过期下架
            case 4:
                
                cell.offlineImage.image = [UIImage imageNamed:@"preview_edu"];
                cell.offlineImage.width = 35;
                
                break;
                
            default:
                break;
        }
    }
    else
        cell.offlineImage.hidden = YES;
    
    [cell.picture roundCornerBorder];
    [cell.picture requestPic:[wrapper getString:@"PictureUrl"] placeHolder:NO];
    cell.picture.layer.cornerRadius = 0.0f;
    
    cell.productName.text = [wrapper getString:@"ProductName"];
    
    
    cell.unitPrice.text = [NSString stringWithFormat:@"单价：%@",[UICommon getStringToTwoDigitsAfterDecimalPlacesPoint:[wrapper getString:@"UnitPrice"] withAppendStr:@""]];
    cell.onhandQty.text = [NSString stringWithFormat:@"库存：%d",[wrapper getInt:@"OnhandQty"]];
    
    CGRect frame = cell.onhandQty.frame;
    frame.size.width = [AppUtils textWidthByChar:cell.onhandQty.text height:frame.size.height fontSize:cell.onhandQty.font]+5;
    cell.onhandQty.frame = frame;
    
    frame.origin.x += frame.size.width + 15;
    frame.size.width = cell.unitPrice.frame.size.width;
    cell.unitPrice.frame = frame;
    
    
    
    CGRect pframe = cell.productName.frame;
    
    CGRect oframe = cell.onhandQty.frame;
    
    CGRect uframe = cell.unitPrice.frame;
    
    if([AppUtils textHeightByChar:cell.productName.text width:cell.productName.frame.size.width fontSize:cell.productName.font] > 15)
    {
        pframe.size.height = 30;
        pframe.origin.y = cell.picture.frame.origin.y + twolineMargin;
        
        oframe.origin.y = 50 - twolineMargin;
        
    }else
    {
        pframe.size.height = 15;
        pframe.origin.y = cell.picture.frame.origin.y + onelineMargin;
        
        oframe.origin.y = 50 - onelineMargin;
    }
    
    uframe.origin.y = oframe.origin.y;
    
    cell.productName.frame = pframe;
    
    cell.onhandQty.frame = oframe;
    cell.unitPrice.frame = uframe;
    
    NSString *remainingTime = @"";
    
    //等待上架
    if(_statusTag == 3)
    {
        if([[wrapper getString:@"RemainingTime"] isEqualToString:@""] || [wrapper getString:@"RemainingTime"] == nil || [[wrapper getString:@"RemainingTime"] isEqualToString:@"<null>"])
            remainingTime = @"";
        else
            remainingTime = [NSString stringWithFormat:@"距离上架：%@",[wrapper getString:@"RemainingTime"]];
        
        cell.remainingTime.hidden = NO;
    }
    
    //出售中
    else if(_statusTag == 4)
    {
        if([[wrapper getString:@"RemainingTime"] isEqualToString:@""] || [wrapper getString:@"RemainingTime"] == nil || [[wrapper getString:@"RemainingTime"] isEqualToString:@"<null>"])
            remainingTime = @"";
        else
            remainingTime = [NSString stringWithFormat:@"距离下架：%@",[wrapper getString:@"RemainingTime"]];
        
        cell.remainingTime.hidden = NO;
        
    }
    
    //已下架
    else if(_statusTag == 1 || _statusTag == 2 || _statusTag == 5)
    {
        cell.remainingTime.hidden = YES;
    }
    
    cell.remainingTime.text = remainingTime;
    
    CGRect lineFrame = cell.lineView.frame;
    
    if(![remainingTime isEqualToString:@""])
    {
        lineFrame.origin.y = 99;
    }
    else
        lineFrame.origin.y = 79;
    
    cell.lineView.frame = lineFrame;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int height = 100;
    
    DictionaryWrapper *wrapper = [[_mjCon dataAtIndex:(int)indexPath.row] wrapper];
    
    NSString *str = @"";
    //等待上架
    if(_statusTag == 3)
    {
        if([[wrapper getString:@"RemainingTime"] isEqualToString:@""] || [wrapper getString:@"RemainingTime"] == nil || [[wrapper getString:@"RemainingTime"] isEqualToString:@"<null>"])
            str = @"";
        else
            str = [NSString stringWithFormat:@"距离上架：%@",[wrapper getString:@"RemainingTime"]];
    }
    
    //出售中
    else if(_statusTag == 4)
    {
        if([[wrapper getString:@"RemainingTime"] isEqualToString:@""] || [wrapper getString:@"RemainingTime"] == nil || [[wrapper getString:@"RemainingTime"] isEqualToString:@"<null>"])
            str = @"";
        else
            str = [NSString stringWithFormat:@"距离下架：%@",[wrapper getString:@"RemainingTime"]];
    }
    
    if([str isEqualToString:@""] || str == nil)
        height -= 20;
    
    return height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    PUSH_VIEWCONTROLLER(Commodity_Detail);
    PUSH_VIEWCONTROLLER(Commodity_Details);
    
    DictionaryWrapper *wrapper = [[_mjCon dataAtIndex:(int)indexPath.row] wrapper];
    
    model.productId = [wrapper getInt:@"ProductId"];
    
    model.whereFrom = (int)_statusTag;
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    Commodity_Cell *cell = (Commodity_Cell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.contentView.backgroundColor = AppColor(220);
    return YES;
}

- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    Commodity_Cell *cell = (Commodity_Cell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor whiteColor];
}

#pragma mark ------------------UITableView Delegate End------------------

@end
