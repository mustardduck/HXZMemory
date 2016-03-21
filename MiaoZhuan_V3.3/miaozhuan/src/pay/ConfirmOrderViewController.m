//
//  ConfirmOrderViewController.m
//  miaozhuan
//
//  Created by 孙向前 on 14-12-29.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "ConfirmOrderViewController.h"
#import "NetImageView.h"
#import "PayTypeCell.h"
#import "PayMethod.h"
#import "BankChangeViewController.h"
#import "CheckAddressViewController.h"
#import "AddShippingAddressViewController.h"
#import "PayStateViewController.h"
#import "GetMoreGoldViewController.h"
#import "Redbutton.h"
#import "RRLineView.h"
#import "UICommon.h"
#import "ZhiFuPwdQueRenViewController.h"
#import "ZhiFuPwdEditController.h"
#import "CROrderDefine.h"
#import "ZhiFuPwdYanZhengViewController.h"

@interface ConfirmOrderViewController ()<UITableViewDataSource, UITableViewDelegate>{
    int _currentRow;
    int _addressId;
    int ptype;
    
    BOOL _isPos;
    DictionaryWrapper * result;
}

@property (retain, nonatomic) IBOutlet UIView *orderView;
@property (retain, nonatomic) IBOutlet NetImageView *imgGoodsPic;
@property (retain, nonatomic) IBOutlet UILabel *lblName;
@property (retain, nonatomic) IBOutlet UILabel *lblDetail;
@property (retain, nonatomic) IBOutlet UILabel *lblNum;
@property (retain, nonatomic) IBOutlet UILabel *lblPrice;
@property (retain, nonatomic) IBOutlet UILabel *lblGoodsNum;
@property (retain, nonatomic) IBOutlet UILabel *lblPeiSong;
@property (retain, nonatomic) IBOutlet UILabel *lblOrderPrice;

@property (retain, nonatomic) IBOutlet UITableView *tableview;
@property (retain, nonatomic) IBOutlet UIView *addressInfoView;
@property (retain, nonatomic) IBOutlet UIView *persongView;
@property (retain, nonatomic) IBOutlet UIView *dingdanView;
@property (retain, nonatomic) IBOutlet UIScrollView *scrollview;

@property (nonatomic, retain) NSMutableArray *dataArray;

@property (retain, nonatomic) IBOutlet UIView *personInfoView;
@property (retain, nonatomic) IBOutlet UILabel *lblPerson;
@property (retain, nonatomic) IBOutlet UILabel *lblAddress;
@property (retain, nonatomic) IBOutlet UILabel *lblPhone;
@property (retain, nonatomic) IBOutlet UIButton *btnAddress;
@property (retain, nonatomic) IBOutlet UILabel *lblCompany;
@property (retain, nonatomic) IBOutlet UIButton *btnReduce;
@property (retain, nonatomic) IBOutlet UIButton *btnAdd;
@property (retain, nonatomic) IBOutlet UILabel *lblTotal;
@property (retain, nonatomic) IBOutlet Redbutton *btnPay;

@property (nonatomic, retain) DictionaryWrapper *userInfo;

//3.3添加
@property (retain, nonatomic) IBOutlet UIView *goumaiView;

@end

@implementation ConfirmOrderViewController

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad {
    [super viewDidLoad];
    
    result =[APP_DELEGATE.runtimeConfig getDictionary:RUNTIME_USER_LOGIN_INFO].wrapper;
    
    [result retain];
    
    ptype = -1;
    [self setNavigateTitle:@"订单结算"];
    [self setupMoveBackButton];
    
    NSLog(@"-----%d",[_orderInfoDic.wrapper getInt:@"OrderType"]);
    
    [self viewHight];
    
    [self _initDataArray];
    [self refreshPage:_orderInfoDic];
    
}

//3.3
-(void) viewHight
{
    //不显示购买数量的来源：【购买精准广告条数】【购买广告金币】【购买用户VIP】【购买感恩果】【购买商家VIP】【购买易货额度】
    
    //1：直购商城 2：用户感恩果 3：商家VIP（年）4：金币 5：用户VI 6：直投广告 7：易货商城 8：兑换商城
    
    if ([_orderInfoDic.wrapper getInt:@"OrderType"] == 6 || [_orderInfoDic.wrapper getInt:@"OrderType"] == 4 || [_orderInfoDic.wrapper getInt:@"OrderType"] == 5 || [_orderInfoDic.wrapper getInt:@"OrderType"] == 2 || [_orderInfoDic.wrapper getInt:@"OrderType"] == 3 || [_orderInfoDic.wrapper getInt:@"OrderType"] == 9 )
    {
        _persongView.frame = CGRectMake(0, 118, 320, 50);
        _dingdanView.frame = CGRectMake(0, 168, 320, 50);
        _orderView.frame = CGRectMake(0, 110, 320, 219);
        _tableview.frame = CGRectMake(0, 347, 320, 420);
        _btnPay.frame = CGRectMake(15, 773, 290, 40);
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //获取用户信息
    ADAPI_adv3_Me_getCount([GLOBAL_DELEGATOR_MANAGER addDelegator:self selector:@selector(handleGetCount:)]);
}

- (void)handleGetCount:(DelegatorArguments *)arguments{
    DictionaryWrapper *dic = arguments.ret;
    if (dic.operationSucceed) {
        self.userInfo = dic.data;
    } else {
        [HUDUtil showErrorWithStatus:dic.operationMessage];
    }
}

- (void)refreshPage:(NSDictionary *) dic{
    NSDictionary *addresses = [dic.wrapper getDictionary:@"DeliveryAddress"];
    if (addresses.count) {
        _btnAddress.hidden = YES;
        _personInfoView.hidden = NO;
        _addressId = [[addresses wrapper] getInt:@"AddressId"];
        _addressInfoView.height = _personInfoView.top + 90;
        _lblPerson.text = [[addresses wrapper] getString:@"Name"];
        _lblPhone.text = [[addresses wrapper] getString:@"Phone"];
        _lblAddress.text = [[addresses wrapper] getString:@"FullAddress"];
    }
    
    _lblDetail.hidden = (_type != 2);
    
    
    if (_type == 3) {
        //3.订单信息位置改变
        _lblName.font = Font(15);
        _lblName.top = 75;
        _lblName.width = 200;
        _lblName.left = 15;
        
        //4.禁用加减
        _btnReduce.enabled = _btnAdd.enabled = NO;
        
        _imgGoodsPic.hidden = YES;
    }
    
    if (_type == 3 || [[dic wrapper] getInt:@"ExchangeType"])
    {
        //1.隐藏地址
        _addressInfoView.hidden = YES;
        _orderView.top = _addressInfoView.top;
        
        //2.隐藏配送方式
        _persongView.hidden = YES;
        _dingdanView.top = _persongView.top;
        _orderView.height = _orderView.height - _persongView.height;
        
    } else {
        
        _orderView.top = _addressInfoView.bottom + 10;
    }
    
    if (_type == 2) {
        _lblPeiSong.text = @"快递 包邮";
    } else {
        _lblPeiSong.text = [[dic wrapper] getInt:@"ExchangeType"] ? @"现场兑换" : @"邮费到付，用户自理";
    }
    
    [_imgGoodsPic setBorderWithColor:AppColor(197)];
    [_imgGoodsPic requestIcon:[[dic wrapper] getString:@"PictureUrl"]];
    _lblCompany.text = [[dic wrapper] getString:@"EnterpriseName"];
    
    NSString *str = [[dic wrapper] getString:@"ProductName"];
    CGSize size = [UICommon getSizeFromString:str withSize:CGSizeMake(168, MAXFLOAT) withFont:12];
    _lblName.height = size.height > 20 ? 30 : size.height;
    if (size.height < 20) {
        _lblName.top = 65;
        _lblDetail.top = _lblName.bottom;
    }
    _lblName.text = str;
    
    _lblDetail.text = [NSString stringWithFormat:@"颜色/规格：%@",[[dic wrapper] getString:@"Specification"]];
    _lblNum.text = [NSString stringWithFormat:@"x%@", [[dic wrapper] getString:@"ShowCount"]];
    _lblGoodsNum.text = [[dic wrapper] getString:@"ShowCount"];
    
    double singlePrice = [[dic wrapper] getDouble:@"UnitPrice"];
    double total = [[dic wrapper] getDouble:@"UnitPrice"] * [[dic wrapper] getDouble:@"ShowCount"];
    
    NSString *tempSingle = [NSString stringWithFormat:@"%f",singlePrice];
    NSString *tempTotal = [NSString stringWithFormat:@"%f", total];
    
    if (_type == 1) {
        //兑换商城
        _lblPrice.text = [UICommon getStringToTwoDigitsAfterDecimalPlacesPoint:tempSingle withAppendStr:@"银元"];
        _lblTotal.text = _lblOrderPrice.text = [UICommon getStringToTwoDigitsAfterDecimalPlacesPoint:tempTotal withAppendStr:@"银元"];
    } else if (_type == 2) {
        //易货商城
        _lblPrice.text = [UICommon getStringToTwoDigitsAfterDecimalPlacesPoint:tempSingle withAppendStr:@"易货码"];
        _lblTotal.text = _lblOrderPrice.text = [UICommon getStringToTwoDigitsAfterDecimalPlacesPoint:tempTotal withAppendStr:@"易货码"];;
    } else {
        _lblPrice.text = [NSString stringWithFormat:@"￥%@", [UICommon getStringToTwoDigitsAfterDecimalPlacesPoint:tempSingle withAppendStr:nil]];
        _lblTotal.text = _lblOrderPrice.text = [NSString stringWithFormat:@"￥%@", [UICommon getStringToTwoDigitsAfterDecimalPlacesPoint:tempTotal withAppendStr:nil]];
    }
    
    _tableview.top = _orderView.bottom + 10;
    
    RRLineView *lineview = WEAK_OBJECT(RRLineView, initWithFrame:CGRectMake(0, _tableview.bottom, SCREENWIDTH, 0.5));
    [_scrollview addSubview:lineview];
    
    _btnPay.top = _tableview.bottom + 10;
    
    if (!_addressInfoView.hidden) {
        RRLineView *line = WEAK_OBJECT(RRLineView, initWithFrame:CGRectMake(0, _addressInfoView.bottom, SCREENWIDTH, 0.5));
        line.tag = 998;
        [_scrollview addSubview:line];
    }
    
    [_scrollview setContentSize:CGSizeMake(SCREENWIDTH, _btnPay.bottom + 20)];
    
}

- (void)_initDataArray
{
    self.dataArray = [NSMutableArray array];
    NSArray *pics = @[@"mall_silver.png",@"mall_gold.png",@"mall_zhifubao.png",@"mall_weixin.png",@"mall_yinlian.png",@"mall_zhuanzhang.png",@"POS.png"];
    NSArray *types = @[@"银元账户",@"易货码账户",@"支付宝",@"微信支付",@"银联支付",@"银行转账",@"快钱POS机转账"];
    NSArray *details = @[@"使用您的银元账户余额",@"使用您的易货码账户余额",@"采用支付宝快捷支付，便捷又安全",@"推荐安装微信5.0或以上版本使用",@"无需安装，快捷支付",@"传统方式，需人工线下先转账",@"传统方式，需人工线下刷POS机转账"];
    for (int i = 0; i < pics.count; i++)
    {
        if (_type == 1)
        {
            if (i == 0)
            {
                NSMutableDictionary *dic = [NSMutableDictionary dictionary];
                [dic setValue:pics[i] forKey:@"Icon"];
                [dic setValue:types[i] forKey:@"Type"];
                [dic setValue:details[i] forKey:@"Detail"];
                [_dataArray addObject:dic];
            }
        }
        else if (_type == 2)
        {
            if (i == 1)
            {
                NSMutableDictionary *dic = [NSMutableDictionary dictionary];
                [dic setValue:pics[i] forKey:@"Icon"];
                [dic setValue:types[i] forKey:@"Type"];
                [dic setValue:details[i] forKey:@"Detail"];
                [_dataArray addObject:dic];
            }
        }
        else if (_type == 3)
        {
            if (i != 1 && i != 0)
            {
                double total = [[_orderInfoDic wrapper] getDouble:@"UnitPrice"] * [[_orderInfoDic wrapper] getDouble:@"ShowCount"];
                
                int EnterpriseStatus = [result getInt:@"EnterpriseStatus"];
                
                int IdentityStatus = [result getInt:@"IdentityStatus"];
                
//                if (total > 50000)
//                {
//                    if (i == 5 || i== 6)
//                    {
//                        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
//                        [dic setValue:pics[i] forKey:@"Icon"];
//                        [dic setValue:types[i] forKey:@"Type"];
//                        [dic setValue:details[i] forKey:@"Detail"];
//                        [_dataArray addObject:dic];
//                    }
//                }
                //修改 屏蔽条件判断
                if (total >= 10000)
                {
//                    if (i == 5 || i== 6)
//                    {
                        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
                        [dic setValue:pics[i] forKey:@"Icon"];
                        [dic setValue:types[i] forKey:@"Type"];
                        [dic setValue:details[i] forKey:@"Detail"];
                        [_dataArray addObject:dic];
//                    }
                }
                else if (EnterpriseStatus == 4 || IdentityStatus == 1)
                {
//                    if (i != 4)
//                    {
                        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
                        [dic setValue:pics[i] forKey:@"Icon"];
                        [dic setValue:types[i] forKey:@"Type"];
                        [dic setValue:details[i] forKey:@"Detail"];
                        [_dataArray addObject:dic];
//                    }
                }
                else
                {
                    if (i != 5 && i != 6)
                    {
                        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
                        [dic setValue:pics[i] forKey:@"Icon"];
                        [dic setValue:types[i] forKey:@"Type"];
                        [dic setValue:details[i] forKey:@"Detail"];
                        [_dataArray addObject:dic];
                    }
                }
            }
        }
    }
    _tableview.height = _dataArray.count * 70;
}

#pragma mark - UITableViewDelegate/UITableViewDatasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"Cell";
    PayTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"PayTypeCell" owner:self options:nil] firstObject];
    }
    cell.btnSelection.selected = (_currentRow == indexPath.row);
    
    NSDictionary * dic = _dataArray[indexPath.row];
    cell.dataDic = dic;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    _currentRow = (int)indexPath.row;
    NSDictionary * dic = _dataArray[indexPath.row];
    if([[dic.wrapper getString:@"Type"] isEqualToString:@"快钱POS机转账"])
    {
        _isPos = YES;
    }
    else
    {
        _isPos = NO;
    }
    [tableView reloadData];
}

#pragma mark - 事件
//新增收货人信息
- (IBAction)addNewAddressClicked:(id)sender {
    PUSH_VIEWCONTROLLER(AddShippingAddressViewController);
    model.block = ^(DictionaryWrapper *addressInfo) {
        
        if (addressInfo.dictionary.count) {
            _btnAddress.hidden = YES;
            _personInfoView.hidden = NO;
            _personInfoView.top = 41;
            _addressInfoView.height = _personInfoView.top + 90;
            _addressId = [addressInfo getInt:@"Id"];
            _lblPerson.text = [addressInfo getString:@"Name"];
            _lblPhone.text = [addressInfo getString:@"Phone"];
            _lblAddress.text = [addressInfo getString:@"FullAddress"];
            UIView *view = [_scrollview viewWithTag:998];
            if (view) {
                view.top = _addressInfoView.bottom;
            }
        }
    };
    model.type = @"1";
}
//减
- (IBAction)reduceClicked:(id)sender {
    int num = [_lblGoodsNum.text intValue];
    if (num <= 1) {
        return;
    }
    
    _lblGoodsNum.text = [NSString stringWithFormat:@"%d", --num];
    _lblNum.text = [NSString stringWithFormat:@"x%d", num];
    
    double total = [[_orderInfoDic wrapper] getDouble:@"UnitPrice"] * num;
    NSString *tempTotal = [NSString stringWithFormat:@"%f", total];
    if (_type == 1) {
        //兑换商城
        _lblTotal.text = _lblOrderPrice.text = [UICommon getStringToTwoDigitsAfterDecimalPlacesPoint:tempTotal withAppendStr:@"银元"];
    } else if (_type == 2) {
        //易货商城
        _lblTotal.text = _lblOrderPrice.text = [UICommon getStringToTwoDigitsAfterDecimalPlacesPoint:tempTotal withAppendStr:@"易货码"];
    } else {
        _lblTotal.text = _lblOrderPrice.text = [NSString stringWithFormat:@"￥%@", [UICommon getStringToTwoDigitsAfterDecimalPlacesPoint:tempTotal withAppendStr:nil]];
    }
}
//加
- (IBAction)addClicked:(id)sender {
    int num = [_lblGoodsNum.text intValue];
    if (num >= [[_orderInfoDic wrapper] getInt:@"RemainStock"]) {
        [HUDUtil showErrorWithStatus:@"库存不足"];return;
    }
    _lblGoodsNum.text = [NSString stringWithFormat:@"%d", ++num];
    _lblNum.text = [NSString stringWithFormat:@"x%d", num];
    
    double total = [[_orderInfoDic wrapper] getDouble:@"UnitPrice"] * num;
    NSString *tempTotal = [NSString stringWithFormat:@"%f", total];
    if (_type == 1) {
        //兑换商城
        _lblTotal.text = _lblOrderPrice.text = [UICommon getStringToTwoDigitsAfterDecimalPlacesPoint:tempTotal withAppendStr:@"银元"];
    } else if (_type == 2) {
        //易货商城
        _lblTotal.text = _lblOrderPrice.text = [UICommon getStringToTwoDigitsAfterDecimalPlacesPoint:tempTotal withAppendStr:@"易货码"];
    } else {
        _lblTotal.text = _lblOrderPrice.text = [NSString stringWithFormat:@"￥%@", [UICommon getStringToTwoDigitsAfterDecimalPlacesPoint:tempTotal withAppendStr:nil]];
    }
}

- (void)turntobanck{
    //银行转帐
    PUSH_VIEWCONTROLLER(BankChangeViewController);
    model.isPos = _isPos;
    model.orderId = @"";
    if ([_orderInfoDic.wrapper getInt:@"OrderType"] == CRENUM_OrderTypeGold || [_orderInfoDic.wrapper getInt:@"OrderType"] == CRENUM_OrderTypeDirectAdvert) {
        int tempItemCount = [_orderInfoDic.wrapper getInt:@"ItemCount"];
        NSString *count = [NSString stringWithFormat:@"%d", tempItemCount * [_lblGoodsNum.text intValue]];
        model.itemCount = count;
    }
    else if([_orderInfoDic.wrapper getInteger:@"OrderType"] == CRENUM_OrderTypeBuy_DEJB)
    {
        model.itemCount = [_orderInfoDic.wrapper getString:@"ItemCount"];
    }
    else {
        model.itemCount = _lblGoodsNum.text;
    }
    int num = [_lblGoodsNum.text intValue];
    double total = [[_orderInfoDic wrapper] getDouble:@"UnitPrice"] * num;
    model.totalPay = [NSString stringWithFormat:@"%f",total];
    model.orderType = [[_payDic wrapper] getInt:@"OrderType"];
    model.goodsinfo = _goodsInfo;

}

//确认支付
- (IBAction)goPaymentClicked:(id)sender {
    int num = [_lblGoodsNum.text intValue];
    if (num > [[_orderInfoDic wrapper] getInt:@"RemainStock"] && _type != 3) {
        [HUDUtil showErrorWithStatus:@"库存不足"];return;
    }
    if (_type == 1) {
        //银元账户
        if (!_addressId && ![[_orderInfoDic wrapper] getInt:@"ExchangeType"]) {
            [HUDUtil showErrorWithStatus:@"请先添加收货地址"];return;
        }
        double total = [[_orderInfoDic wrapper] getDouble:@"UnitPrice"] * num;
        if ([_userInfo getDouble:@"SilverIntegral"] < total) {
            [AlertUtil showAlert:@"" message:@"抱歉，银元账户余额不足" buttons:@[@"确定"]];return;
        }
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:_payDic];
        [dic setValue:[NSString stringWithFormat:@"%d", _addressId] forKey:@"AddressId"];
        [dic setValue:_lblGoodsNum.text forKey:@"ItemCount"];
        ADAPI_Payment_GoSilverPayment([GLOBAL_DELEGATOR_MANAGER addDelegator:self selector:@selector(handleSilverPayment:)], dic);

        return;
    }
    if (_type == 2)
    {
        //金币商户
//        BOOL GoldIntegral = YES;
        
        int num = [_lblGoodsNum.text intValue];
        if (!_addressId && ![[_orderInfoDic wrapper] getInt:@"ExchangeType"]) {
            [HUDUtil showErrorWithStatus:@"请先添加收货地址"];return;
        }
         double total = [[_orderInfoDic wrapper] getDouble:@"UnitPrice"] * num;
        
        //取消本地余额不足判断，此代码已注释
//        if ([_userInfo getDouble:@"GoldIntegral"] < total)
//        {
//            GoldIntegral = NO;
            
//            [HUDUtil showErrorWithStatus:@"抱歉，易货码账户余额不足"];
        
//            return;
        
//            __block typeof(self) weakself = self;
//            [AlertUtil showAlert:@"" message:@"抱歉，易货码账户余额不足" buttons:@[@"确定",@{
//                                                                            @"title":@"去赚金币",
//                                                                            @"delegator":ALERT_VIEW_DELEGATOR_BLOCK
//                                                                            ({
//                [weakself.navigationController pushViewController:WEAK_OBJECT(GetMoreGoldViewController, init) animated:YES];
//            })
//                                                                          }]];return;
//        }

        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:_payDic];
        [dic setValue:[NSString stringWithFormat:@"%d", _addressId] forKey:@"AddressId"];
        [dic setValue:_lblGoodsNum.text forKey:@"ItemCount"];
        
        
        //3.3需求
        
        NSString *OrVersion = [[NSUserDefaults standardUserDefaults] valueForKey:@"OrVersion"];
        
        NSString *Downurl = [[NSUserDefaults standardUserDefaults] valueForKey:@"Downurl"];
        
        DictionaryWrapper * resulttwo =[APP_DELEGATE.runtimeConfig getDictionary:RUNTIME_USER_LOGIN_INFO].wrapper;
//        if ([OrVersion isEqualToString:@"1"])
//        {
            //不需要升级、判断是否设置支付密码
            if ([resulttwo getInt:@"SetPayPwdStatus"] == 0)
            {
                //未设置
                PUSH_VIEWCONTROLLER(ZhiFuPwdYanZhengViewController);
                model.zhifuPwdFromType = ZhifuPWD_YiHuoMallBuy;
                model.dataDic = dic;
//                model.isJinBiNum = GoldIntegral;
                model.type = @"2";
                
                [[NSUserDefaults standardUserDefaults] setObject:@{
                                                                   @"dataDic":dic,
                                                                   @"type":@"2",
                                                                   }
                                                          forKey:@"ConfirmPayPasswordInfo"];
            }
            else
            {
                ZhiFuPwdQueRenViewController *next = WEAK_OBJECT(ZhiFuPwdQueRenViewController, init);
                next.dataDic = dic;
                next.type = @"2";
//                next.isJinBiNum = GoldIntegral;
                [UI_MANAGER.mainNavigationController pushViewController:next animated:YES];
            }
//        }
//        if ([OrVersion isEqualToString:@"2"])
//        {
//            [AlertUtil showAlert:@""
//                         message:@"为确保你的账户安全，我们加入了支付密码。请升级到最新版本后继续使用！"
//                         buttons:@[@"暂不升级",@{ @"title":@"马上升级",
//                                              @"delegator":ALERT_VIEW_DELEGATOR_BLOCK({
//                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:Downurl]];
//            })}]];
//        }
//        else if ([OrVersion isEqualToString:@"3"])
//        {
//            [AlertUtil showAlert:@""
//                         message:@"为确保你的账户安全，我们加入了支付密码。请升级到最新版本后继续使用！"
//                         buttons:@[@{ @"title":@"确定",
//                                      @"delegator":ALERT_VIEW_DELEGATOR_BLOCK({
//                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:Downurl]];
//            })}]];
//        }

        
//        ADAPI_Payment_GoGoldPayment([GLOBAL_DELEGATOR_MANAGER addDelegator:self selector:@selector(handleGoldPayment:)], dic);
        return;
    }
    
    double total = [[_orderInfoDic wrapper] getDouble:@"UnitPrice"] * num;
    
    int EnterpriseStatus = [result getInt:@"EnterpriseStatus"];
    
    int IdentityStatus = [result getInt:@"IdentityStatus"];
    
    
    if (total > 50000) {
        
        [self turntobanck];
        
    }
    
    //已激活，已认证
    else if (EnterpriseStatus == 4 || IdentityStatus == 1)
    {
        
//        wxPay = 4,
//        upompPay = 1,
//        aliPay = 2,
        
        switch (_currentRow) {
                //第一条，支付宝
            case 0:
                ptype = 2;
                break;
                //第二条, 微信支付
            case 1:
                ptype = 4;
                break;
                //第三条，银联支付
            case 2:
                ptype = 1;
                break;
            default:
                ptype = 3;
                break;
        }
        
//        ptype = !_currentRow ? 2 : (_currentRow == 1 ? 4 : 3);
        if (ptype == 3) {
            
            [self turntobanck];
            
        } else {
            NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:_payDic];
//            NSString *str = [NSString stringWithFormat:@"%@",@(!_currentRow ? 2 : (_currentRow == 1 ? 4 : 3))];
            NSString *str = [NSString stringWithFormat:@"%d", ptype];
            [dic setValue:str forKey:@"PaymentType"];
            
            
            
            if ([_orderInfoDic.wrapper getInt:@"OrderType"] == 4 || [_orderInfoDic.wrapper getInt:@"OrderType"] == 6 ||[_orderInfoDic.wrapper getInt:@"OrderType"] == 9) {
                
                int tempItemCount = [_orderInfoDic.wrapper getInt:@"ItemCount"];
                NSString *count = [NSString stringWithFormat:@"%d", tempItemCount * [_lblGoodsNum.text intValue]];
                [dic setValue:count forKey:@"ItemCount"];
            } else {
                [dic setValue:_lblGoodsNum.text forKey:@"ItemCount"];
            }
            
            ADAPI_Payment_GoCashPayment([GLOBAL_DELEGATOR_MANAGER addDelegator:self selector:@selector(handleGoCashPayment:)], dic);
        }
        
    } else {
        
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:_payDic];
        NSString *str = [NSString stringWithFormat:@"%@",@(!_currentRow ? 2 : (_currentRow == 1 ? 4 : 1))];
        [dic setValue:str forKey:@"PaymentType"];
        
        if ([_orderInfoDic.wrapper getInt:@"OrderType"] == 4 || [_orderInfoDic.wrapper getInt:@"OrderType"] == 6 || [_orderInfoDic.wrapper getInt:@"OrderType"] == 9) {
            int tempItemCount = [_orderInfoDic.wrapper getInt:@"ItemCount"];
            NSString *count = [NSString stringWithFormat:@"%d", tempItemCount * [_lblGoodsNum.text intValue]];
            [dic setValue:count forKey:@"ItemCount"];
        } else {
            [dic setValue:_lblGoodsNum.text forKey:@"ItemCount"];
        }
        
        ptype = !_currentRow ? 2 : (_currentRow == 1 ? 4 : 1);
        
        ADAPI_Payment_GoCashPayment([GLOBAL_DELEGATOR_MANAGER addDelegator:self selector:@selector(handleGoCashPayment:)], dic);
        
    }
    
    //统计点击
    if ([_orderInfoDic.wrapper getInt:@"OrderType"] == 2) {
        [APP_MTA MTA_touch_From:MTAEVENT_user_vip_fruit_confirm];//感恩过
    } else if ([_orderInfoDic.wrapper getInt:@"OrderType"] == 3) {
        [APP_MTA MTA_touch_From:MTAEVENT_business_vip_confirm];//商家vip
    } else if ([_orderInfoDic.wrapper getInt:@"OrderType"] == 5){
        [APP_MTA MTA_touch_From:MTAEVENT_user_vip_confirm];//用户vip
    }
    
}

//现金支付
- (void)handleGoCashPayment:(DelegatorArguments *)arguments{
    __block DictionaryWrapper* dic = [arguments.ret retain];
    if (dic.operationSucceed) {
        __block typeof(self) weakSelf = self;
        __block BOOL flag = NO;
        switch (ptype) {
            case 1://银联
                [PayMethod payWithPayType:ptype payInfo:@{@"payData":[dic.data getString:@"Token"], @"viewController":weakSelf} resultback:^(id result, payType type) {
                    if ([result isEqualToString:@"0000"] && !flag) {
                        [weakSelf turnToPayStatus:dic];
                        flag = YES;
                    }
                }];
                break;
            case 2://支付宝
                [PayMethod payWithPayType:ptype payInfo:[dic.data getString:@"Token"] resultback:^(id result, payType type) {
                    if (type == aliPay && !flag) {
                        [weakSelf turnToPayStatus:dic];
                        flag = YES;
                    }
                    
                }];
                break;
            case 4://微信
                NSLog(@"%@",[dic.data getDictionary:@"WeixinPayload"]);
                [PayMethod payWithPayType:ptype payInfo:[dic.data getDictionary:@"WeixinPayload"] resultback:^(id result, payType type) {
                    if (type == wxPay && !flag) {
                        [weakSelf turnToPayStatus:dic];
                        flag = YES;
                    }
                }];
                break;
            default:
                break;
        }
        
    } else {
        [HUDUtil showErrorWithStatus:dic.operationMessage];return;
    }
}

- (void)turnToPayStatus:(DictionaryWrapper *)dic{
    PayStateViewController *pay = WEAK_OBJECT(PayStateViewController, init);
    pay.orderNum = [dic.data getString:@"OrderSerialNo"];;
    pay.payType = ptype;
    pay.orderType = [[_payDic wrapper] getString:@"OrderType"];
    pay.goodsInfo = _goodsInfo;
    pay.isPost = ![[_payDic wrapper] getBool:@"ExchangeType"];
    int num = [_lblGoodsNum.text intValue];
    double total = [[_orderInfoDic wrapper] getDouble:@"UnitPrice"] * num;
    pay.totalPay = [NSString stringWithFormat:@"%f",total];
    [self.navigationController pushViewController:pay animated:YES];
}

//金币支付
- (void)handleGoldPayment:(DelegatorArguments *)arguments{
    DictionaryWrapper* dic = arguments.ret;
    if (dic.operationSucceed)
    {
        //先跳转到支付密码确认页面,再跳转下面页面
        
        PayStateViewController *pay = WEAK_OBJECT(PayStateViewController, init);
        pay.orderNum = [dic.data getString:@"OrderSerialNo"];
        pay.payType = ptype;
        pay.orderType = [[_payDic wrapper] getString:@"OrderType"];
        pay.isPost = ![[_payDic wrapper] getBool:@"ExchangeType"];
        pay.goodsInfo = _goodsInfo;
        pay.productId = [[_payDic wrapper] getString:@"ProductId"];
        pay.payBonusLink = [dic.data getString:@"PayBonusLink"];
        
        [self.navigationController pushViewController:pay animated:YES];
    }
    else
    {
        [HUDUtil showErrorWithStatus:dic.operationMessage];return;
    }
}
//银元支付
- (void)handleSilverPayment:(DelegatorArguments *)arguments{
    DictionaryWrapper* dic = arguments.ret;
    if (dic.operationSucceed) {
        PayStateViewController *pay = WEAK_OBJECT(PayStateViewController, init);
        pay.orderNum = [dic.data getString:@"OrderSerialNo"];
        pay.payType = ptype;
        pay.isPost = ![[_payDic wrapper] getBool:@"ExchangeType"];
        pay.orderType = [[_payDic wrapper] getString:@"OrderType"];
        pay.goodsInfo = _goodsInfo;
        pay.productId = [[_payDic wrapper] getString:@"ProductId"];
        pay.advertId = [[_payDic wrapper] getString:@"AdvertId"];
        [self.navigationController pushViewController:pay animated:YES];
    } else {
        [HUDUtil showErrorWithStatus:dic.operationMessage];return;
    }
}
- (IBAction)tapAddress:(UITapGestureRecognizer *)sender {
    PUSH_VIEWCONTROLLER(CheckAddressViewController);
    model.addressId = [NSString stringWithFormat:@"%d",_addressId];
    model.block = ^(DictionaryWrapper *addressInfo){
        
        _btnAddress.hidden = YES;
        _personInfoView.hidden = NO;
        _personInfoView.top = 41;
        _addressInfoView.height = _personInfoView.top + 90;
        _addressId = [addressInfo getInt:@"Id"];
        _lblPerson.text = [addressInfo getString:@"Name"];
        _lblPhone.text = [addressInfo getString:@"Phone"];
        _lblAddress.text = [NSString stringWithFormat:@"%@%@%@%@",[addressInfo getString:@"ProvinceName"], [addressInfo getString:@"CityName"], [addressInfo getString:@"DistrictName"], [addressInfo getString:@"Address"]];
    };
}

#pragma mark - 内存管理
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc {
    [_userInfo release];
    [_payDic release];
    [_orderInfoDic release];
    [_orderView release];
    [_tableview release];
    [_imgGoodsPic release];
    [_lblName release];
    [_lblDetail release];
    [_lblNum release];
    [_lblPrice release];
    [_lblGoodsNum release];
    [_lblPeiSong release];
    [_lblOrderPrice release];
    [_addressInfoView release];
    [_personInfoView release];
    [_lblPerson release];
    [_lblAddress release];
    [_lblPhone release];
    [_persongView release];
    [_dingdanView release];
    [_scrollview release];
    [_btnAddress release];
    [_lblCompany release];
    [_btnReduce release];
    [_btnAdd release];
    [_lblTotal release];
    [_btnPay release];
    [_goumaiView release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setOrderView:nil];
    [self setTableview:nil];
    [self setImgGoodsPic:nil];
    [self setLblName:nil];
    [self setLblDetail:nil];
    [self setLblNum:nil];
    [self setLblPrice:nil];
    [self setLblGoodsNum:nil];
    [self setLblPeiSong:nil];
    [self setLblOrderPrice:nil];
    [self setAddressInfoView:nil];
    [self setPersonInfoView:nil];
    [self setLblPerson:nil];
    [self setLblAddress:nil];
    [self setLblPhone:nil];
    [self setPersongView:nil];
    [self setDingdanView:nil];
    [self setScrollview:nil];
    [self setBtnAddress:nil];
    [self setLblCompany:nil];
    [self setBtnReduce:nil];
    [self setBtnAdd:nil];
    [self setLblTotal:nil];
    [self setBtnPay:nil];
    [super viewDidUnload];
}
@end
