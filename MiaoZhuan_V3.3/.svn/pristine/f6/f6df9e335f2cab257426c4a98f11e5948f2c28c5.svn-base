//
//  CircurateViewController.m
//  miaozhuan
//
//  Created by 孙向前 on 14-12-2.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "MyGoldCircurateViewController.h"
#import "CircurateNexViewController.h"
#import "ContactorListViewController.h"
#import "MyGoldListController.h"
#import "RRAttributedString.h"
#import "RRLineView.h"
#import "ZhiFuPwdEditController.h"
#import "ZhiFuPwdQueRenViewController.h"
#import "ZhiFuPwdYanZhengViewController.h"

@interface MyGoldCircurateViewController ()<UITextFieldDelegate, UIScrollViewDelegate, UITextViewDelegate, UIAlertViewDelegate>
{
    BOOL canNext;
}
//赠送
@property (retain, nonatomic) IBOutlet UITextField *txtAccount;
@property (retain, nonatomic) IBOutlet UITextField *txtIntegral;
@property (retain, nonatomic) IBOutlet UITextField *lblName;
@property (retain, nonatomic) IBOutlet UITextView *txtMessage;
@property (retain, nonatomic) IBOutlet UILabel *lblTip;
@property (retain, nonatomic) IBOutlet UILabel *lblBalance;

@property (retain, nonatomic) IBOutlet UIView *infoView;
@property (retain, nonatomic) IBOutlet UIView *nameView;
@property (retain, nonatomic) IBOutlet UIView *centerView;
@property (retain, nonatomic) IBOutlet UIView *integralView;

//求赠
@property (retain, nonatomic) IBOutlet UITextField *lblGetAccount;
@property (retain, nonatomic) IBOutlet UITextField *txtGetName;
@property (retain, nonatomic) IBOutlet UITextField *txtGetIntegral;
@property (retain, nonatomic) IBOutlet UILabel *lblGetBalance;
@property (retain, nonatomic) IBOutlet UITextView *txtGetMessage;
@property (retain, nonatomic) IBOutlet UILabel *lblGetTip;

@property (retain, nonatomic) IBOutlet UIView *getCenterView;
@property (retain, nonatomic) IBOutlet UIView *getNameView;
@property (retain, nonatomic) IBOutlet UIView *getIntegralView;
@property (retain, nonatomic) IBOutlet UIView *getInfoView;

@property (retain, nonatomic) IBOutlet UIScrollView *scrollview;
@property (retain, nonatomic) IBOutlet UIImageView *lineView;
@property (retain, nonatomic) IBOutlet UIButton *btnFirst;
@property (retain, nonatomic) IBOutlet UIButton *btnSecond;
@property (retain, nonatomic) IBOutlet RRLineView *line;
@property (retain, nonatomic) IBOutlet UIView *firstBottomView;
@property (retain, nonatomic) IBOutlet UIView *secondBottomView;

@end

@implementation MyGoldCircurateViewController

MTA_viewDidAppear()
MTA_viewDidDisappear()

-(void)viewWillAppear:(BOOL)animated
{
    ADAPI_CustomerGoldGetCustomerGoldSummary([self genDelegatorID:@selector(handleGetGoldSummary:)]);
}

- (void)handleGetGoldSummary:(DelegatorArguments*)arguments {
    
    DictionaryWrapper *wrapper = arguments.ret;
    
    if (wrapper.operationSucceed)
    {
        DictionaryWrapper * result = wrapper.data;
        
        double balance = [result getFloat:@"RemainingGold"];
        
        NSString *str = [NSString stringWithFormat:@"账户余额：%0.2f广告金币", balance];
        
        NSAttributedString *attStr = [RRAttributedString setText:str color:AppColorRed range:NSMakeRange(5, str.length - 5)];
        _lblBalance.attributedText = _lblGetBalance.attributedText = attStr;
        
//        _balanceGold = [NSString stringWithFormat:@"%.2f",[result getFloat:@"RemainingGold"]];
//        
//        _balanceMoneyLabel.text = _balanceGold;
//        
//        _bigbalanceMoneyLable.text = _balanceGold;
    }
    else if (wrapper.operationPromptCode || wrapper.operationErrorCode)
    {
//        [HUDUtil showErrorWithStatus:wrapper.operationMessage];
        
        NSString *str = [NSString stringWithFormat:@"账户余额：0广告金币"];
        
        NSAttributedString *attStr = [RRAttributedString setText:str color:AppColorRed range:NSMakeRange(5, str.length - 5)];
        _lblBalance.attributedText = _lblGetBalance.attributedText = attStr;
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigateTitle:@"广告金币流通"];
    [self setupMoveBackButton];
    [self setupMoveFowardButtonWithTitle:@"流通记录"];
    
    [self addDoneToKeyboard:_txtAccount];
    [self addDoneToKeyboard:_txtIntegral];
    [self addDoneToKeyboard:_lblName];
    [self addDoneToKeyboard:_txtMessage];
    [self addDoneToKeyboard:_lblGetAccount];
    [self addDoneToKeyboard:_txtGetName];
    [self addDoneToKeyboard:_txtGetIntegral];
    [self addDoneToKeyboard:_txtGetMessage];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(chooseContact:) name:@"Contactor" object:nil];
    _scrollview.contentSize = CGSizeMake(2 * SCREENWIDTH, [UICommon getIos4OffsetY] ? 400 : 300);
    
    
    
    _btnFirst.selected = YES;
    
    [self fixView];
    
    _txtAccount.text = [_userDic getString:@"UserAccount"];
    _txtIntegral.text = [_userDic getString:@"Number"];
    
    if(_userDic)
    {
        ADAPI_CustomerIntegral_GetNameByPhone([GLOBAL_DELEGATOR_MANAGER addDelegator:self selector:@selector(handleName:)], _txtAccount.text, 1);
    }
}

- (void) fixView
{
    _line.top = 39.5;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark -
//联系人列表
- (IBAction)contactListClicked:(id)sender {
    ContactorListViewController *list = WEAK_OBJECT(ContactorListViewController, init);
    if (_txtAccount.text.length > 3) {
        list.keyWord = [_txtAccount.text substringToIndex:3];
    } else {
        list.keyWord = @"";
    }
    list.value = Block_copy(^(DictionaryWrapper *value){
        NSString *name = [value getString:@"Name"];
        if (name.length) {
            name = [name stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:@"*"];
        }
        NSString *phone = [value getString:@"Phone"];
        BOOL flag = (_scrollview.contentOffset.x < 300);
        if (flag) {//赠送给好友
            _txtAccount.text = phone;
            canNext = YES;
            if (name.length) {
                _lblName.text = name;
                _integralView.top = _nameView.bottom;
                _infoView.height = _nameView.height + 150;
                _centerView.top = _infoView.bottom;
            }
            //0-默认 1-检查是否有金币账户(赠送)
            
            ADAPI_CustomerIntegral_GetNameByPhone([GLOBAL_DELEGATOR_MANAGER addDelegator:self selector:@selector(handleName:)], _txtAccount.text, 1);

        } else {//求赠
            _lblGetAccount.text = phone;
            
            if (name.length) {
                _txtGetName.text = name;
                _getIntegralView.top = _getNameView.bottom;
                _getInfoView.height = _getNameView.height + 100;
                _getCenterView.top = _getInfoView.bottom;
            }
            
            ADAPI_CustomerIntegral_GetNameByPhone([GLOBAL_DELEGATOR_MANAGER addDelegator:self selector:@selector(handleName:)], _lblGetAccount.text, 1);
        }

    });
    
    list.isGold = YES;
    
    [UI_MANAGER.mainNavigationController pushViewController:list animated:YES];
}

- (void) handlePhoneVerified:(DelegatorArguments *)arguments
{
    DictionaryWrapper* dic = arguments.ret;
    if (dic.operationSucceed) {

        NSString *notes = _txtMessage.text.length ? _txtMessage.text : @"";

//        CircurateNexViewController *next = WEAK_OBJECT(CircurateNexViewController, init);
//        next.name = _txtAccount.text;
//        next.dataDic = [NSMutableDictionary dictionaryWithObjects:@[_txtAccount.text, _txtIntegral.text, notes] forKeys:@[@"Phone", @"GoldNumber", @"Notes"]];
//        
//        next.isGold = YES;
//        
//        [UI_MANAGER.mainNavigationController pushViewController:next animated:YES];
        
        //3.3需求
        //先判断是否最新版本，随后判断是否设置支付密码
        
        NSString *OrVersion = [[NSUserDefaults standardUserDefaults] valueForKey:@"OrVersion"];
        
        NSString *Downurl = [[NSUserDefaults standardUserDefaults] valueForKey:@"Downurl"];
        
        DictionaryWrapper * dic =[APP_DELEGATE.runtimeConfig getDictionary:RUNTIME_USER_LOGIN_INFO].wrapper;
        
//        if ([OrVersion isEqualToString:@"1"])
//        {
            //不需要升级、判断是否设置支付密码
            if ([dic getInt:@"SetPayPwdStatus"] == 0)
            {
                //未设置
                ZhiFuPwdYanZhengViewController *model = [[[ZhiFuPwdYanZhengViewController alloc] init] autorelease];
                model.dataDic = [NSMutableDictionary dictionaryWithObjects:@[_txtAccount.text, _txtIntegral.text, notes] forKeys:@[@"Phone", @"GoldNumber", @"Notes"]];
                model.zhifuPwdFromType = ZhifuPWD_Gold;
                model.name = _txtAccount.text;
                model.isGold = YES;
                model.type = @"1";
                [self.navigationController pushViewController:model animated:YES];
                
                [[NSUserDefaults standardUserDefaults] setObject:@{
                                                                   @"name":_txtAccount.text,
                                                                   @"dataDic":[NSMutableDictionary dictionaryWithObjects:@[_txtAccount.text, _txtIntegral.text, notes] forKeys:@[@"Phone", @"GoldNumber", @"Notes"]],
                                                                   @"type":@"1",
                                                                   @"isGold":@(YES)
                                                                   }
                                                          forKey:@"ConfirmPayPasswordInfo"];
            }
            else
            {
                ZhiFuPwdQueRenViewController *next = [[[ZhiFuPwdQueRenViewController alloc] init] autorelease];
                next.name = _txtAccount.text;
                next.dataDic = [NSMutableDictionary dictionaryWithObjects:@[_txtAccount.text, _txtIntegral.text, notes] forKeys:@[@"Phone", @"GoldNumber", @"Notes"]];
                next.isGold = YES;
                next.type = @"1";
                [self.navigationController pushViewController:next animated:YES];
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
    }
    else
    {
        [HUDUtil showErrorWithStatus:dic.operationMessage];
    }
}

//下一步
- (IBAction)nextStepClicked:(id)sender {
    NSString *phone = _txtAccount.text;
    phone = phone.length ? phone : @"";
    if (!phone.length) {
        [HUDUtil showErrorWithStatus:@"请输入好友账户"];return;
    }
    NSString *integral = _txtIntegral.text;
    integral = integral.length ? integral : @"";
    if (!integral.length) {
        [HUDUtil showErrorWithStatus:@"请输入赠送的金币金额"];return;
    }
    int balance = [[[NSUserDefaults standardUserDefaults] valueForKey:@"RemainingGold"] intValue];
    if (balance < [integral intValue]) {//比较
        [HUDUtil showErrorWithStatus:@"账户余额不足"];return;
    }
    
    if (phone.length < 11 || !canNext) {
        [HUDUtil showErrorWithStatus:@"账户不存在请重新输入"];return;
    }
    
    ADAPI_CustomerGoldCheckPhoneVerified([GLOBAL_DELEGATOR_MANAGER addDelegator:self selector:@selector(handlePhoneVerified:)], phone);
    
}
- (void)chooseContact:(NSNotification *)noti{
    _txtAccount.text = [[noti.object wrapper] getString:@"Phone"];
}
- (void)onMoveFoward:(UIButton *)sender{
    MyGoldListController *silver = WEAK_OBJECT(MyGoldListController, init);
    silver.cellType = LiutongRecord;
    [UI_MANAGER.mainNavigationController pushViewController:silver animated:YES];
}
//切换页面
- (IBAction)itemClicked:(UIButton *)sender {
    
    BOOL flag = [sender isEqual:_btnSecond];
    [UIView animateWithDuration:.3 animations:^{
        _lineView.left = !flag ? 15 : 175;
    }];
    _btnFirst.selected = !flag;
    _btnFirst.titleLabel.font = (flag ? Font(14) : Font(17));
    _btnSecond.selected = flag;
    _btnSecond.titleLabel.font = (!flag ? Font(14) : Font(17));
    [_scrollview setContentOffset:CGPointMake(flag ? 320 : 0, 0)];

    _firstBottomView.hidden = flag;
    _secondBottomView.hidden = !flag;
}
//求证
- (IBAction)requestClicked:(UIButton *)sender {
    if (!_lblGetAccount.text.length) {
        [HUDUtil showErrorWithStatus:@"请输入您的账号"];
        return;
    }
    if (!_txtGetIntegral.text.length) {
        [HUDUtil showErrorWithStatus:@"请输入求赠金额"];
        return;
    }
    NSDictionary *dic = @{@"Phone":_lblGetAccount.text, @"GoldNumber":_txtGetIntegral.text, @"Notes":_txtGetMessage.text.length ? _txtGetMessage.text : @""};
    ADAPI_CustomerGoldAskGiftGold([GLOBAL_DELEGATOR_MANAGER addDelegator:self selector:@selector(handleAsk:)], dic);
}
- (void)handleAsk:(DelegatorArguments *)arguments{
    DictionaryWrapper* dic = arguments.ret;
    if (dic.operationSucceed) {
        
        NSString * strTitle = @"求赠成功";
        NSString * strMsg = [NSString stringWithFormat:@"您已成功向 %@ 求赠%0.2f 广告金币", _lblGetAccount.text, [_txtGetIntegral.text doubleValue]];
        
        UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:strTitle
                                                         message:strMsg
                                                        delegate:self
                                               cancelButtonTitle:nil
                                               otherButtonTitles:@"确定", nil] autorelease];
        [alert show];
        
    } else {
        
        [HUDUtil showErrorWithStatus:dic.operationMessage];
        return;
    }
    
}
- (void)handleName:(DelegatorArguments *)arguments
{
    DictionaryWrapper* dic = arguments.ret;
    if (dic.operationSucceed)
    {
        NSString *name = dic.data;
        if (name.length)
        {
            name = [name stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:@"*"];
        }
        BOOL flag = (_scrollview.contentOffset.x < 300);
        if (flag)
        {
            canNext = YES;
            if (name.length)
            {
                _lblName.text = name;
                _integralView.top = _nameView.bottom;
                _infoView.height = 150 + 50;
                _centerView.top = _infoView.bottom;
            }
        }
        else
        {
            if (name.length)
            {
                _txtGetName.text = name;
                _getIntegralView.top = _getNameView.bottom;
                _getInfoView.height = 150;
                _getCenterView.top = _getInfoView.bottom;
            }
        }
    }
    else
    {
        _lblGetAccount.text = @"";
        [HUDUtil showErrorWithStatus:dic.operationMessage];
        return;
    }
}

#pragma mark - uitextfield delegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NSString * aString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if ([textField isEqual:_txtIntegral] || [textField isEqual:_txtGetIntegral]) {
        if ([aString length] > 9) {
            textField.text = [aString substringToIndex:9];
            [HUDUtil showErrorWithStatus:@"最多可填9个字"];
            return NO;
        }
    } else if ([textField isEqual:_lblGetAccount] || [textField isEqual:_txtAccount]){
        if (aString.length >= 11) {
            textField.text = [aString substringToIndex:11];
            
//            int state = 0;
//            
//            if([textField isEqual:_txtAccount])//0-默认 1-检查是否有金币账户(赠送)
//            {
//                state = 1;
//            }
            
            ADAPI_CustomerIntegral_GetNameByPhone([GLOBAL_DELEGATOR_MANAGER addDelegator:self selector:@selector(handleName:)], textField.text, 1);

            return NO;
        }
        else {
            BOOL flag = (_scrollview.contentOffset.x < 300);
            if (flag) {
                
                _integralView.top = _nameView.top;
                _infoView.height = 150;
                _centerView.top = _infoView.bottom;
                
            } else {
                
                _getIntegralView.top = _getNameView.top;
                _getInfoView.height = 100;
                _getCenterView.top = _getInfoView.bottom;
                
            }
        }
    }
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.view endEditing:YES];
    return YES;
}

#pragma mark - uitextview delegate
- (void)textViewDidBeginEditing:(UITextView *)textView{
    [UIView animateWithDuration:.3 animations:^{
        _scrollview.top = -50;
    }];
    
}
- (void)textViewDidChange:(UITextView *)textView{
    
    _lblGetTip.hidden = _lblTip.hidden = textView.text.length;
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    NSString * aString = [textView.text stringByReplacingCharactersInRange:range withString:text];
    
    if ([aString length] > 20) {
        textView.text = [textView.text substringToIndex:20];
        [HUDUtil showErrorWithStatus:@"最多可输入20字"];
        return NO;
    }
    return YES;
}

#pragma mark - uiscrollviewdelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    BOOL flag = (scrollView.contentOffset.x < 300);
    [UIView animateWithDuration:.3 animations:^{
        _lineView.left = flag ? 15 : 175;
    }];
    _btnFirst.selected = flag;
    _btnFirst.titleLabel.font = (!flag ? Font(14) : Font(17));
    _btnSecond.selected = !flag;
    _btnSecond.titleLabel.font = (flag ? Font(14) : Font(17));
    
    _firstBottomView.hidden = !flag;
    _secondBottomView.hidden = flag;
}

- (void)hiddenKeyboard {
    [self.view endEditing:YES];
    [UIView animateWithDuration:.3 animations:^{
        _scrollview.top = 40;
    }];
    
}

#pragma mark - 内存管理
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc {
    [_userDic release];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [_txtAccount release];
    [_txtIntegral release];
    [_txtMessage release];
    [_lblTip release];
    [_lblBalance release];
    [_lblName release];
    [_lblGetAccount release];
    [_txtGetName release];
    [_txtGetIntegral release];
    [_lblGetBalance release];
    [_txtGetMessage release];
    [_lblGetTip release];
    [_scrollview release];
    [_infoView release];
    [_nameView release];
    [_centerView release];
    [_getCenterView release];
    [_getNameView release];
    [_getIntegralView release];
    [_integralView release];
    [_getInfoView release];
    [_lineView release];
    [_btnFirst release];
    [_btnSecond release];
    [_line release];
    [_firstBottomView release];
    [_secondBottomView release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setTxtAccount:nil];
    [self setTxtIntegral:nil];
    [self setTxtMessage:nil];
    [self setLblTip:nil];
    [self setLblBalance:nil];
    [self setLblName:nil];
    [self setLblGetAccount:nil];
    [self setTxtGetName:nil];
    [self setTxtGetIntegral:nil];
    [self setLblGetBalance:nil];
    [self setTxtGetMessage:nil];
    [self setLblGetTip:nil];
    [self setScrollview:nil];
    [self setInfoView:nil];
    [self setNameView:nil];
    [self setCenterView:nil];
    [self setGetCenterView:nil];
    [self setGetNameView:nil];
    [self setGetIntegralView:nil];
    [self setIntegralView:nil];
    [self setGetInfoView:nil];
    [self setLineView:nil];
    [self setBtnFirst:nil];
    [self setBtnSecond:nil];
    [self setLine:nil];
    [self setFirstBottomView:nil];
    [self setSecondBottomView:nil];
    [super viewDidUnload];
}
@end
