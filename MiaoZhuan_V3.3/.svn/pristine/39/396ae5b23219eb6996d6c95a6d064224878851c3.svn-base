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
#import "GoldCommodity_Add.h"
#import "Preview_Commodity.h"

@interface Management_Index ()

@end

@implementation Management_Index

@synthesize tabView = _tabView;
@synthesize labView = _labView;
@synthesize slipBar = _slipBar;
@synthesize mjCon   = _mjCon;
@synthesize postDataWrapper = _postDataWrapper;
@synthesize searchTF = _searchTF;
@synthesize searchStrs = _searchStrs;

@synthesize onlineCount = _onlineCount;
@synthesize offlineCount = _offlineCount;
@synthesize onOfferCount = _onOfferCount;
@synthesize inTheReviewCount = _inTheReviewCount;
@synthesize auditFailureCount = _auditFailureCount;


-(void)dealloc
{
    [_tabView release];
    [_labView release];
    [_slipBar release];
    [_mjCon release];
    [_postDataWrapper release];
    [_searchTF release];
    [_searchStrs release];
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
    self.searchStrs = nil;
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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    InitNav(@"金币商城商品管理");
    [self setupMoveBackButton];
    [self setupMoveFowardButtonWithTitle:@"新增"];
    
    [self addDoneToKeyboard:_searchTF];
    
    [_tabView registerNib:[UINib nibWithNibName:@"Commodity_Cell" bundle:nil] forCellReuseIdentifier:@"Commodity_Cell"];
    
    //默认 - 出售中
    _statusTag = 4;
    
    //初始化5个对象, 用于存放5个选项卡类型的搜索框内容
    _searchStrs = [[NSMutableArray alloc] initWithObjects:@"", @"", @"", @"", @"", nil];
    
    //初始化
    _postDataWrapper = WEAK_OBJECT(WDictionaryWrapper, init);
    
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
    
    NSString *refreshName = @"api/GoldProductManagement/SearchProducts";
    
    self.mjCon = [MJRefreshController controllerFrom:_tabView name:refreshName];
    
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
            [HUDUtil showErrorWithStatus:netData.operationMessage];
        }
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
- (void)onMoveFoward:(UIButton *)sender
{
//    PUSH_VIEWCONTROLLER(GoldCommodity_Add);
    PUSH_VIEWCONTROLLER(Preview_Commodity);
}

//点击 --- 选项卡
- (IBAction)Action_Tab_Selected:(id)sender
{
    //切换前，存放搜索框内容
    [_searchStrs replaceObjectAtIndex:_statusTag - 1 withObject:_searchTF.text];
    
    UIButton *btn = (UIButton *)sender;
    
    //如果选择仍是当前项 不做处理
    
    if(btn.tag == _statusTag)
    
        return;
    
    _statusTag = btn.tag;
    
    _searchTF.text = [_searchStrs objectAtIndex:btn.tag - 1];
    
    //刷新数据
    
    [_mjCon refresh];
    
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
                lab.textColor = [UIColor blackColor];
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
    return _mjCon.refreshCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger  row = indexPath.row;
    
    Commodity_Cell *cell = [_tabView dequeueReusableCellWithIdentifier:@"Commodity_Cell" forIndexPath:indexPath];
    
    DictionaryWrapper *wrapper = [[_mjCon dataAtIndex:(int)indexPath.row] wrapper];
    
    NSLog(@"%@",wrapper);
    
    if (row >= _mjCon.refreshCount) {
        return cell;
    }
    
    //正常下架
    if([wrapper getInt:@"OfflineReason"] == 1)
    {
        //售完下架
        if([wrapper getInt:@"OfflineType"] == 1)
            cell.offlineImage.image = [UIImage imageNamed:@"gcm_status_0"];
        
        //到期下架
        else if([wrapper getInt:@"OfflineType"] == 2)
            cell.offlineImage.image = [UIImage imageNamed:@"gcm_status_1"];
    }
    //手动下架
    else if([wrapper getInt:@"OfflineReason"] == 2)
        cell.offlineImage.image = [UIImage imageNamed:@"gcm_status_2"];
    
    [cell.picture roundCornerBorder];
    [cell.picture requestPic:[wrapper getString:@"PictureUrl"] placeHolder:NO];
    cell.productName.text = [wrapper getString:@"ProductName"];
    cell.unitPrice.text = [NSString stringWithFormat:@"库存：%d",[wrapper getInt:@"OnhandQty"]];
    cell.onhandQty.text = [NSString stringWithFormat:@"单价：%.1f",[wrapper getFloat:@"UnitPrice"]];
    if([[wrapper getString:@"RemainingTime"] isEqualToString:@""] || [wrapper getString:@"RemainingTime"] == nil)
        cell.remainingTime.text = @"";
    else
    cell.remainingTime.text = [NSString stringWithFormat:@"距离下架：%@",[wrapper getString:@"RemainingTime"]];
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PUSH_VIEWCONTROLLER(Commodity_Detail);
    
    DictionaryWrapper *wrapper = [[_mjCon dataAtIndex:(int)indexPath.row] wrapper];
    
    model.productId = [wrapper getInt:@"ProductId"];
}

#pragma mark ------------------UITableView Delegate End------------------

@end
