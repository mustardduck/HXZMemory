//
//  SetConvertCenterViewController.m
//  miaozhuan
//
//  Created by Santiago on 14-11-17.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "SetConvertCenterViewController.h"
#import "SetConvertCenterCell.h"
#import "AddConvertCenterViewController.h"
#import "YinYuanProductEditController.h"
#import "CommonSection.h"

@interface SetConvertCenterViewController ()<UITableViewDelegate, UITableViewDataSource, EndEditingConvertCenter>

@property (retain, nonatomic) IBOutlet UIView *tableHead;
@property (retain, nonatomic) IBOutlet UITableView *mainTable;
@property (strong, nonatomic) MJRefreshController *mjCon;
@property (nonatomic, assign) int deleteId;

@end

@implementation SetConvertCenterViewController
@synthesize tableHead = _tableHead;
@synthesize mainTable = _mainTable;
@synthesize mjCon = _mjCon;

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupMoveBackButton];
    
    [_mainTable registerNib:[UINib nibWithNibName:@"SetConvertCenterCell" bundle:nil] forCellReuseIdentifier:@"SetConvertCenterCell"];
    [_mainTable setTableHeaderView:_tableHead];
    _mainTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    if(_isSelect)
    {
        [self setTitle:@"选择兑换点"];

        [self setupMoveFowardButtonWithTitle:@"保存"];
        
        self.selArr = WEAK_OBJECT(NSMutableArray, initWithArray:_selArr);
    }
    else
    {
        [self setTitle:@"设置兑换点"];
    }
    [self setUpRefreshItem];
}

- (void) onMoveFoward:(UIButton *)sender
{
    NSMutableArray *selExPointArr = WEAK_OBJECT(NSMutableArray, init);
    
    for (NSDictionary * sdic in _selArr) {
        
        DictionaryWrapper * dic = sdic.wrapper;
        
        NSMutableDictionary * selDic = WEAK_OBJECT(NSMutableDictionary, init);
        
        NSString * text = [dic getString:@"Name"];
        
        if(!text.length)
        {
            text = @"";
        }
        
        [selDic setObject:text forKey:@"Name"];
        
        text = [dic getString:@"DetailedAddress"];
        
        if(!text.length)
        {
            text = @"";
        }
        
        [selDic setObject:text forKey:@"DetailedAddress"];
        
        text = [dic getString:@"ContactNumber"];
        
        if(!text.length)
        {
            text = @"";
        }
        
        [selDic setObject:text forKey:@"ContactNumber"];
        
        text = [dic getString:@"Id"];
        
        if(!text.length)
        {
            text = @"";
        }
        
        [selDic setObject:text forKey:@"Id"];
        
        
        [selExPointArr addObject:selDic];
        
    }
    
    if(!_selArr.count)
    {
        [HUDUtil showErrorWithStatus:@"请选择兑换点"];
        
        return;
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(yinYuanSelectExPointFinish:)]) {
        
        [_delegate yinYuanSelectExPointFinish:selExPointArr];
    }
    
    if(_isYinYuanProdCreate)
    {
        for (UIViewController *vc in self.navigationController.viewControllers) {
            if ([vc isKindOfClass:[YinYuanProductEditController class]]) {
                [self.navigationController popToViewController:vc animated:YES];
                break;
            }
        }
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    

}

- (void)setUpRefreshItem {

    NSString *refreshName = @"api/SilverAdvert/GetExchangeAddress";
    
    self.mjCon = [MJRefreshController controllerFrom:_mainTable name:refreshName];
    
    
    __block SetConvertCenterViewController *weakSelf = self;
    [self.mjCon setURLGenerator:MJREFRESH_URL_GENERATOR_BLOCK {
        NSLog(@"%@", @{
                       @"service":refreshName,
                       @"parameters":@{
                               @"PageIndex":@(pageIndex),
                               @"PageSize":@(pageSize)
                               }
                       });
        return @{
                 @"service":refreshName,
                 @"parameters":@{
                         @"PageIndex":@(pageIndex),
                          @"PageSize":@(pageSize)
                         }
                 }.wrapper;
    }];
    
    MJRefreshOnRequestDone block = MJREFRESH_ON_REQUEST_DONE {
    
        if (netData.operationSucceed) {
            
        }else {
        
        }
        [_mainTable reloadData];
    };
    
    [_mjCon setOnRequestDone:block];
    [_mjCon setPageSize:30];
    [_mjCon refreshWithLoading];
    
}

- (IBAction)addConvertCenter:(id)sender {
    
    AddConvertCenterViewController *temp = WEAK_OBJECT(AddConvertCenterViewController, init);
    temp.delegate = self;
    [self.navigationController pushViewController:temp animated:YES];
}

#pragma mark - EndEditingConvertCenterDelegate
- (void)refreshListWithSelectId:(NSString *)selectId
{
    self.selectId = selectId;
    
    [_mjCon refreshWithLoading];

}

#pragma mark - UITableViewwDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    return [CommonSection initCommonSection];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return _mjCon.refreshCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    SetConvertCenterCell *cell = [_mainTable dequeueReusableCellWithIdentifier:@"SetConvertCenterCell" forIndexPath:indexPath];

    [cell.backgoundView setOrigin:CGPointMake(0, 0)];
    
    NSDictionary * srcDic = [_mjCon dataAtIndex:(int)indexPath.section];
    
    cell.companyName.text = [[[_mjCon dataAtIndex:(int)indexPath.section] wrapper] getString:@"Name"];
    cell.phoneNumber.text = [[[_mjCon dataAtIndex:(int)indexPath.section] wrapper] getString:@"ContactNumber"];
    cell.companyWholeName.text = [[[_mjCon dataAtIndex:(int)indexPath.section] wrapper] getString:@"DetailedAddress"];
    
    NSArray *array = [[[[_mjCon dataAtIndex:(int)indexPath.section] wrapper] getString:@"ExchangeTime"] componentsSeparatedByString:@"#"];
    NSMutableString *string = WEAK_OBJECT(NSMutableString, init);
    
    for (int i = 0; i<[array count]; i++) {
        
        [string appendString:array[i]];
    }
    cell.convertTime.text = [NSString stringWithFormat:@"兑换时间:%@",string];
    
//    NSArray *managers = [[[_mjCon dataAtIndex:(int)indexPath.section] wrapper] getArray:@"ExchangeManagers"];
//    NSMutableString *managerStr;
//    
//    managerStr = WEAK_OBJECT(NSMutableString, init);
//    for (int i = 0; i<[managers count];i++) {
//        NSDictionary *item = managers[i];
//        NSString * str = [item.wrapper getString:@"Phone"];
//        if(str)
//        {
//            [managerStr appendString:str];
//        }
//        if (i<[managers count]-1) {
//            
//            [managerStr appendString:@"、"];
//        }
//    }
//
//    if (managerStr.length == 0) {
//        
//        cell.convertManagers.text = [APP_DELEGATE.persistConfig getString:USER_INFO_NAME];
//    }else {
//    
//        cell.convertManagers.text = managerStr;
//    }
//    
    CGSize size = [cell.companyWholeName.text sizeWithFont:cell.companyWholeName.font constrainedToSize:CGSizeMake(cell.companyWholeName.frame.size.width, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
    
    if (size.height > 20) {
        
        size = CGSizeMake(size.width, 35);
        cell.companyWholeName.numberOfLines = 2;
        [cell.convertTime setFrame:CGRectMake(cell.convertTime.frame.origin.x,cell.companyWholeName.frame.origin.y+size.height, cell.convertTime.frame.size.width, 20)];
    }
    else
    {
        size.height = 14;
        cell.companyWholeName.numberOfLines = 1;
        [cell.convertTime setFrame:CGRectMake(cell.convertTime.frame.origin.x,cell.companyWholeName.frame.origin.y+size.height + 8, cell.convertTime.frame.size.width, 15)];
    }
    
    [cell.companyWholeName setSize:CGSizeMake(cell.companyWholeName.frame.size.width, size.height)];
    
    [cell.deleteView setSize:CGSizeMake(70, size.height+116)];
    [cell.deleteBtn setSize:CGSizeMake(70, size.height+116)];
    
    [cell.backgoundView setSize:CGSizeMake(cell.contentView.frame.size.width+70, size.height+129.5 - 14)];
    
    
    cell.deleteBtn.tag = [[[_mjCon dataAtIndex:(int)indexPath.section] wrapper] getInt:@"Id"];
    
    [cell.deleteBtn addTarget:self action:@selector(deleteCell:) forControlEvents:UIControlEventTouchUpInside];
    
    
    if(_isSelect)
    {
        cell.selectView.hidden = NO;
        
        cell.jianTouIcon.hidden = YES;
        
        [cell.selectBtn addTarget:self action:@selector(touchUpInsideOnBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        cell.selectBtn.tag = 6000 + indexPath.section;
        
        int exPointId = [srcDic.wrapper getInt:@"Id"];
        
        for (NSInteger i = 0; i < [_selArr count]; i++) {
            
            NSString *tempIdStr = @"";
            
            NSDictionary *dic = [_selArr objectAtIndex:i];
            
            tempIdStr = [dic.wrapper getString:@"Id"];
            
            int tempId = [tempIdStr intValue];
            
            if(exPointId == tempId)
            {
                cell.selectImgView.image = [UIImage imageNamed:@"findShopfilterSelectBtn"];
                
                break;
            }
            else
            {
                cell.selectImgView.image = [UIImage imageNamed:@"findShopfilterBtn"];
            }
        }
    }
    
    if (_selectId)
    {
        int index = (int)indexPath.section;
        
        if(_mjCon.refreshCount == 1)
        {
            DictionaryWrapper *wraDic = [_mjCon dataAtIndex:index];
            
            int selId = [wraDic getInt:@"Id"];
            
            if(selId == [_selectId intValue])
            {
                BOOL isSelect = [self isSelExPoint:wraDic.dictionary];
                
                if (isSelect == YES) {
                    
                    [self appendSelItem:wraDic.dictionary];
                    
                    cell.selectImgView.image = [UIImage imageNamed:@"findShopfilterSelectBtn"];
                }
                else if (isSelect == NO)
                {
                    [self removeSelItem:wraDic.dictionary];
                    
                    cell.selectImgView.image = [UIImage imageNamed:@"findShopfilterBtn"];
                }
            }
        }
    }
    
    [cell.buttomLineView setFrame:CGRectMake(0, 130 + size.height - 14 - 0.5, 320, 0.5)];
    
    if (indexPath.section == _mjCon.refreshCount - 1) {
        
        cell.buttomLineView.hidden = NO;
    }else {
    
        cell.buttomLineView.hidden = YES;
    }
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *string = [[[_mjCon dataAtIndex:(int)indexPath.section] wrapper] getString:@"DetailedAddress"];
    
    CGSize temp = [string sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(270, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
    
    if (temp.height > 25) {
        
        temp = CGSizeMake(temp.width, 35);
    }
    else
    {
        temp.height = 14;
    }
    return 130 - 15 + temp.height;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {

    UIView *temp = WEAK_OBJECT(UIView, init);
    [temp setBackgroundColor:RGBCOLOR(239, 239, 244)];
    return temp;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {

    return 0.00001;
}


- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    SetConvertCenterCell *cell = (SetConvertCenterCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.contentView.backgroundColor = AppColor(220);
    return YES;
}

- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    SetConvertCenterCell *cell = (SetConvertCenterCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor whiteColor];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(!_isSelect)
    {
        AddConvertCenterViewController *temp = WEAK_OBJECT(AddConvertCenterViewController, init);
        
        temp.convertCenterId = [[[_mjCon dataAtIndex:(int)indexPath.section] wrapper] getInt:@"Id"];
        
        temp.style = EDIT_CONVERT_CENTER_ALREDY_HAVE;
        
        temp.delegate = self;
        
        [self.navigationController pushViewController:temp animated:YES];
    }
}

- (void)deleteCell:(UIButton*)sender {
    
    self.deleteId = (int) sender.tag;

    [AlertUtil showAlert:@"确认删除"
                 message:@"一旦删除，则不可以恢复"
                 buttons:@[
                           @"取消",
                           @{
                               @"title":@"确定",
                               @"delegator":ALERT_VIEW_DELEGATOR_BLOCK({
        
                                    ADAPI_DeleteConvertCenter([self genDelegatorID:@selector(delConvertCenterSucceed:)], (int)sender.tag);
                                    })
     }]];
}

- (void)touchUpInsideOnBtn:(UIButton*)sender {
    
    UIButton * btn = (UIButton *) sender;
    
    if(btn.tag >= 6000)
    {
        NSInteger row = btn.tag - 6000;
        
        if (row < _mjCon.refreshCount) {
            
            DictionaryWrapper * wra = [_mjCon dataAtIndex:(int)row];
            
            NSDictionary *dic = wra.dictionary;
            
            NSIndexPath *curPath = [NSIndexPath indexPathForRow:0 inSection:row];
            
            SetConvertCenterCell *cell = (SetConvertCenterCell *)[_mainTable cellForRowAtIndexPath:curPath];
            
            BOOL isSelect = [self isSelExPoint:dic];
            
            if (isSelect == YES) {
                
                [self appendSelItem:dic];
                
                cell.selectImgView.image = [UIImage imageNamed:@"findShopfilterSelectBtn"];
            }
            else if (isSelect == NO)
            {
                [self removeSelItem:dic];
                
                cell.selectImgView.image = [UIImage imageNamed:@"findShopfilterBtn"];
            }
        }
    }
}

- (void)delConvertCenterSucceed:(DelegatorArguments*)arguments {

    DictionaryWrapper *wrapper = arguments.ret;
    if (wrapper.operationSucceed) {
     
        [_mjCon refresh];
        [_mjCon refreshData];
        [HUDUtil showSuccessWithStatus:@"删除成功!"];
        
        if(_isSelect)
        {
            for (NSInteger i = 0; i < [_selArr count]; i++)
            {
                int tempId = [[_selArr[i] objectForKey:@"Id"] intValue];
                
                if(tempId == _deleteId)
                {
                    [_selArr removeObjectAtIndex:i];
                }
            }
        }
    } else {
        
        [HUDUtil showErrorWithStatus:wrapper.operationMessage];
        NSLog(@"%@", wrapper.operationMessage);
        [_mjCon refresh];
    }
}

- (void) removeSelItem:(NSDictionary*)dic{
    
    NSInteger exPointId = [[dic objectForKey:@"Id"] integerValue];
    
    for (NSInteger i = 0; i < [_selArr count]; i++) {
        
        NSInteger tempId = [[[_selArr objectAtIndex:i] objectForKey:@"Id"]integerValue];
        
        if (exPointId == tempId) {
            
            [self.selArr removeObjectAtIndex:i];
            
            return;
        }
    }
}

- (void) appendSelItem:(NSDictionary*)dic{
    
    [self.selArr addObject:dic];
    
}

- (BOOL) isSelExPoint:(NSDictionary*)dic{
    
    NSInteger exPointId = [[dic objectForKey:@"Id"] integerValue];
    
    for (NSInteger i = 0; i < [_selArr count]; i++) {
        
        NSInteger tempId = [[[_selArr objectAtIndex:i] objectForKey:@"Id"]integerValue];
        
        if (exPointId == tempId) {
            
            return NO;
        }
    }
    return YES;
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    [_mjCon release];
    [_tableHead release];
    [_mainTable release];
    _selArr = nil;
    self.delegate = nil;
    [super dealloc];
}
- (void)viewDidUnload {
    [self setTableHead:nil];
    [self setMainTable:nil];
    [super viewDidUnload];
}
@end
