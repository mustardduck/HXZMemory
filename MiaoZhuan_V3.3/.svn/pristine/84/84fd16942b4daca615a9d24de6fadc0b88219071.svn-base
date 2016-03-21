//
//  YinYuanAdvertBindingProdController.m
//  miaozhuan
//
//  Created by momo on 14-12-1.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "YinYuanAdvertBindingProdController.h"
#import "YinYuanProdBindingCell.h"
#import "YinYuanBindingHelpView.h"
#import "GetMoreGoldViewController.h"
#import "MyGoldMainController.h"

@interface YinYuanAdvertBindingProdController ()<UIAlertViewDelegate,UIScrollViewDelegate>
{
    double _goldMoney;
}
@property (nonatomic, retain) UITextField *curText;

@end

@implementation YinYuanAdvertBindingProdController

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setNavigateTitle:_titleName];
    
    [self setupMoveBackButton];
    
    _okBtn.enabled = NO;
    
    _okBtn.backgroundColor = AppColor(204);
    
    _listArr = STRONG_OBJECT(NSMutableArray, init);
    
    _selNumDic = STRONG_OBJECT(NSMutableDictionary, init);
    
    _selArr = STRONG_OBJECT(NSMutableArray, init);
    
    self.curText = STRONG_OBJECT(UITextField, init);
    
    if(_selProdArr.count)
    {
        [_selArr addObjectsFromArray:_selProdArr];
    }
    
    [self loadTableView];
    
    [self refreshTotalNumLab];
    
}

- (void) customerAccountSummary:(DelegatorArguments *)arg
{
    [arg logError];
    DictionaryWrapper *wrapper = arg.ret;
    if (wrapper.operationSucceed)
    {
        _goldMoney = [wrapper.data getDouble:@"GoldIntegral"];
        
        [self calcuGoldTotal];
    }
    else
    {
        [HUDUtil showErrorWithStatus:wrapper.operationMessage];
    }
}

- (void) calcuGoldTotal
{
    double goldTotal = [_jinbiTotalLbl.text doubleValue];
    
    if(goldTotal > _goldMoney)
    {
        UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:nil
                                                         message:[NSString stringWithFormat:@"发布广告所需金币：%0.2f金币  当前金币余额：%0.2f金币",goldTotal, _goldMoney]
                                                        delegate:self
                                               cancelButtonTitle:@"取消"
                                               otherButtonTitles:@"保存并去赚金币", nil] autorelease];
        [alert show];
        
        return;
    }
    if(_selArr.count)
    {
        [_delegate productBindingFinish:_selArr];
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void) appendSelItem:(DictionaryWrapper *)dic num:(NSInteger)total{
    
    NSString * wareId = [dic getString:@"Id"];
    
    NSMutableDictionary *wareDic = WEAK_OBJECT(NSMutableDictionary, init);
    
    float unitIntegral = 0;
    
    if(!_isZhiGou)
    {
        unitIntegral = [dic getInteger:@"UnitIntegral"];
        
        [wareDic setObject:wareId forKey:@"SilverProductId"];
        
        [wareDic setObject:[NSNumber numberWithInteger:unitIntegral] forKey:@"UnitIntegral"];
        
    }
    
    [wareDic setObject:[NSNumber numberWithInteger:total] forKey:@"Total"];
    
    [wareDic setObject:[dic getString:@"Name"] forKey:@"Name"];
    
    [_selArr addObject:wareDic];
}

- (void) removeSelItem:(DictionaryWrapper*)dic{
    
    NSString *wareId = [dic getString:@"Id"];
    
    for (NSInteger i = 0; i < [_selArr count]; i++) {
        
        NSDictionary *tempDic = [_selArr objectAtIndex:i];
        
        NSString *tempId = @"";
        
        if(!_isZhiGou)
        {
            tempId = [tempDic.wrapper getString:@"SilverProductId"];
        }
        
        if ([wareId isEqualToString:tempId]) {
            
            [_selArr removeObjectAtIndex:i];
            
            return;
        }
    }
}

- (void) calculateYinYuanTotal:(BOOL) isJian andEdit:(BOOL)isEdit
{
    DictionaryWrapper * dic = [_MJRefreshCon dataAtIndex:_selIndex];
    
    NSIndexPath *curPath = [NSIndexPath indexPathForRow:_selIndex inSection:0];
    
    YinYuanProdBindingCell *cell = (YinYuanProdBindingCell *)[_mainTableView cellForRowAtIndexPath:curPath];
    
    if(!_isZhiGou && !isEdit)
    {
        [self changeCount:cell.numField andJian:isJian];
    }
    
    if(cell.numField.text.length)
    {
        [_selNumDic setObject:cell.numField.text forKey:[NSString stringWithFormat:@"%ld", (long)_selIndex]];
    }
    
    if([cell.numField.text intValue] == 0 && isJian)
    {
        [self removeSelItem:dic];
    }
    else
    {
        [self removeSelItem:dic];
        
        if([cell.numField.text intValue])
        {
            [self appendSelItem:dic num:[[cell.numField text] integerValue]];
        }
    }
    
    [self refreshTotalNumLab];
}

- (void) refreshTotalNumLab{
    
    long long allNum = 0;
    
    for (NSInteger i = 0; i < [_selArr count]; i++) {
        
        NSInteger total = [[_selArr[i] valueForKey:@"Total"] integerValue];
        
        NSInteger UnitIntegral = [[_selArr[i] valueForKey:@"UnitIntegral"] integerValue];
        
        allNum += UnitIntegral*total;
        
        if(allNum < 0)
        {
            [HUDUtil showErrorWithStatus:@"绑定数量太多，请重新设置"];
            
            return;
        }
    }
    
    if(allNum == 0)
    {
        _okBtn.enabled = NO;
        
        _okBtn.backgroundColor = AppColor(204);

    }
    else
    {
        _okBtn.enabled = YES;
        
        _okBtn.backgroundColor = AppColorRed;

    }
    
    _yinyuanTotalLbl.text = [NSString stringWithFormat:@"%lli 银元", allNum];
    
    _jinbiTotalLbl.text = [NSString stringWithFormat:@"%.2f 金币",allNum/1000.0];
}

- (NSInteger) isSelWare:(DictionaryWrapper *)dic{
    
    NSString *wareId = [dic getString:@"Id"];
    
    for (NSDictionary * tempDic in _selArr)
    {
        NSString *tempId = @"";
        
        if(!_isZhiGou)
        {
            tempId = [tempDic.wrapper getString:@"SilverProductId"];
        }
        
        if ([wareId isEqualToString:tempId]) {
            
            return [tempDic.wrapper getInt:@"Total"];
        }
    }
    
    return -1;
}

- (void)loadTableView
{
    NSString * refreshName = @"SilverAdvert/EnterpriseGetProducts";
    
    _MJRefreshCon = [MJRefreshController controllerFrom:_mainTableView name:refreshName];
    
    __block YinYuanAdvertBindingProdController * weakself = self;
    
    [_MJRefreshCon setURLGenerator:MJREFRESH_URL_GENERATOR_BLOCK{
        
        NSDictionary * dic = @{@"service":[NSString stringWithFormat:@"%@%@", @"api/", refreshName ],
                               @"parameters":@{
                                               @"QueryType":[NSNumber numberWithInteger: 9],//能绑定广告的商品
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
                if([netData.data getInt:@"PageIndex"] == 0)
                {
                    _goldMoney = [netData.data getDouble:@"ExtraData"];
                }
                
                YinYuanBindingHelpView * hover = (YinYuanBindingHelpView *)[self.view viewWithTag:1111];
                
                if(hover)
                {
                    [self.view sendSubviewToBack:hover];
                }
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

- (void) refreshTableView
{
    [_MJRefreshCon refreshWithLoading];
}

- (void)createHoverViewWhenNoData{
    
    YinYuanBindingHelpView * hover = (YinYuanBindingHelpView *)[self.view viewWithTag:1111];
    
    if(!hover)
    {
        hover = WEAK_OBJECT(YinYuanBindingHelpView, initView);
        
        hover.tag = 1111;
        
        hover.frame = self.view.frame;
        
        if(hover.top > 0)
        {
            hover.height = hover.top + H(self.view);
            
            hover.top = 0;
        }
        
        hover.mainScrollView.contentSize = CGSizeMake(W(hover), hover.bottomImg.bottom + 44 + 64);
        
        [self.view addSubview:hover];
        
    }
    
    [self.view bringSubviewToFront:hover];
    
}

- (void) onMoveBack:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)changeCount:(UITextField *) textField andJian:(BOOL) isJian
{
    int count = [textField.text intValue];
    
    if(count >= 1)
    {
        count += isJian ? -1 : 1 ;
    }
    else if (count == 0)
    {
        count += isJian ? 0 : 1;
    }
    
    textField.text = [NSString stringWithFormat:@"%d", count];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 1)
    {
        [_delegate saveAdvert];
        
        DictionaryWrapper * dic =[APP_DELEGATE.runtimeConfig getDictionary:RUNTIME_USER_LOGIN_INFO].wrapper;
        
        int VipLevel = [dic getInt:@"VipLevel"];
        
        int enterStatus = [dic getInt:@"EnterpriseStatus"];
        
        if(VipLevel == 7 || enterStatus == 4){
            PUSH_VIEWCONTROLLER(GetMoreGoldViewController);
        } else {
            PUSH_VIEWCONTROLLER(MyGoldMainController);
        }
        
    }
}

- (IBAction)touchUpInsideOnBtn:(id)sender
{
    if(sender == _okBtn)
    {
//        ADAPI_adv3_Me_getCount([self genDelegatorID:@selector(customerAccountSummary:)]);
        [self calcuGoldTotal];
    }
    else{
        
        UIButton *btn = sender;
        
        NSInteger btnTab = btn.tag;
        
        NSInteger index = 0;
        
        BOOL isJian = NO;
        
        if (btnTab >= 1000&&btnTab < 5000) {
            
            index = btnTab - 1000;
            
            isJian = YES;
            
        }
        else if (btnTab >= 5000)
        {
            index = btnTab - 5000;
        }
        
        _selIndex = index;
        
        [self calculateYinYuanTotal:isJian andEdit:NO];
    }
}


#pragma mark UITableViewDelegate and UITableViewDatasource methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _MJRefreshCon.refreshCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"YinYuanProdBindingCell";
    
    YinYuanProdBindingCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YinYuanProdBindingCell" owner:self options:nil] firstObject];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    NSInteger row = [indexPath row];
    
    DictionaryWrapper * dic = [_MJRefreshCon dataAtIndex:row];
    
    [cell.imgview setBorderWithColor:AppColor(220)];
    
    NSString * str = [dic getString:@"PictureUrl"];
    
    if(str.length > 5)
    {
        [cell.imgview requestPic:str placeHolder: YES];
    }
    
    cell.titleName.text = [dic getString:@"Name"];
    
    cell.yinyuanCountLbl.text = [dic getString:@"UnitIntegral"];
    
    
    NSInteger allNum = [self isSelWare:dic];
    
    if (allNum < 0) {
        
        NSInteger num = [_selNumDic.wrapper getInteger:[NSString stringWithFormat:@"%ld", (long)row]];
        
        cell.numField.text = [NSString stringWithFormat:@"%ld", (long)num];
    }
    else
    {
        cell.numField.text = [NSString stringWithFormat:@"%ld", (long)allNum];
        
        [_selNumDic setObject:[NSNumber numberWithInteger:allNum] forKey:[NSString stringWithFormat:@"%ld", (long)row]];

    }
    
    [self addDoneToKeyboard:cell.numField];
    
    cell.numField.delegate = self;
    
    cell.numField.tag = 9000 + row;
    
    cell.jianBtn.tag = 1000 + row;
    
    cell.jiaBtn.tag = 5000 + row;
    
    [cell.jianBtn addTarget:self action:@selector(touchUpInsideOnBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell.jiaBtn addTarget:self action:@selector(touchUpInsideOnBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

- (void)hiddenKeyboard
{
    [self.view endEditing:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [_curText resignFirstResponder];
}

- (void) textFieldDidBeginEditing:(UITextField *)textField
{
    self.curText = textField;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
//    if([textField.text intValue] == 0)
//    {
//        return;
//    }
    
    _selIndex = textField.tag - 9000;
    
    [self calculateYinYuanTotal:NO andEdit:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    
    [_selArr release];
    _selArr = nil;
    
    [_listArr release];
    _listArr = nil;
    
    [_selNumDic release];
    _selNumDic = nil;
    
    [_mainTableView release];
    [_okBtn release];
    [_jinbiTotalLbl release];
    [_yinyuanTotalLbl release];
    [super dealloc];
}
@end
