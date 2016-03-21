//
//  Commodity_Update.m
//  miaozhuan
//
//  Created by xm01 on 14-12-29.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "Commodity_Update.h"

#define textField_Space         10
#define nameSpace               9
#define Time  0.25

@interface Commodity_Update ()<UITextFieldDelegate>{

    int _theBottomTextField;
}
@end

@implementation Commodity_Update
@synthesize data = _data;
@synthesize scrollView = _scrollView;
@synthesize topView = _topView;
@synthesize bottomView = _bottomView;
@synthesize radio_1 = _radio_1;
@synthesize radio_2 = _radio_2;
@synthesize uploadList = _uploadList;
@synthesize updateModel = _updateModel;
@synthesize tf_deliveryPrice = _tf_deliveryPrice;
@synthesize lab_time = _lab_time;
//@synthesize dateView = _dateView;

-(void)dealloc
{
    [_uploadList release];
    [_data release];
    [_scrollView release];
    [_topView release];
    [_bottomView release];
    [_radio_1 release];
    [_radio_2 release];
    [_updateModel release];
    [_tf_deliveryPrice release];
    [_lab_time release];
    [_dateView release];
    [super dealloc];
}

-(void)viewDidUnload
{
    [super viewDidUnload];
    self.uploadList = nil;
    self.data = nil;
    self.scrollView = nil;
    self.topView = nil;
    self.bottomView = nil;
    self.radio_1 = nil;
    self.radio_2 = nil;
    self.updateModel = nil;
    self.tf_deliveryPrice = nil;
    self.lab_time = nil;
//    self.dateView = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    InitNav(@"商品修改");
    [self setupMoveBackButton];
    [self setupMoveFowardButtonWithTitle:@"保存"];
    
    _theBottomTextField = 0;
    
    _tf_deliveryPrice.layer.cornerRadius = 5.0f;
    _tf_deliveryPrice.layer.borderWidth = 0.4f;
    _tf_deliveryPrice.layer.borderColor = [[UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:0.5f] CGColor];
    
    _datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 30, 320, 176)];
    [_datePicker setDatePickerMode:UIDatePickerModeDate];
    _datePicker.minimumDate = [NSDate date];
    [_dateView addSubview:_datePicker];
    
    CGRect dateView_frame = _dateView.frame;
    dateView_frame.origin.y = [[UIScreen mainScreen] bounds].size.height;
    _dateView.frame = dateView_frame;
    [self.view addSubview:_dateView];
    
    StyleMode *test0 = [[StyleMode alloc] init];
    test0.productSpec = @"XDSA-大号";
    test0.onhandQty = 11111;
    test0.unitPrice = 4239.00f;
    
    StyleMode *test1 = [[StyleMode alloc] init];
    test1.productSpec = @"XLM-白色";
    test1.onhandQty = 22222;
    test1.unitPrice = 432.00f;
    
    StyleMode *test2 = [[StyleMode alloc] init];
    test2.productSpec = @"DSAKJ-蓝色-XL";
    test2.onhandQty = 33333;
    test2.unitPrice = 5932.00f;
    
    StyleMode *test3 = [[StyleMode alloc] init];
    test3.productSpec = @"DKLS-大众-甲壳虫";
    test3.onhandQty = 44444;
    test3.unitPrice = 66.00f;
    
    StyleMode *test4 = [[StyleMode alloc] init];
    test4.productSpec = @"MJ-Machel-GS";
    test4.onhandQty = 55555;
    test4.unitPrice = 5.00f;
    
    _data = [[NSMutableArray alloc] init];
    
    [_data addObject:test0]; [_data addObject:test1]; [_data addObject:test2]; [_data addObject:test3]; [_data addObject:test4];
    
    //增加监听，当键盘出现或改变时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    //增加监听，当键退出时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    
    [self createCtronls];
}

//当键盘出现或改变时调用
- (void)keyboardWillShow:(NSNotification *)aNotification {
    
    if (_theBottomTextField == 1) {
     
        NSDictionary *userInfo = [aNotification userInfo];
        NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
        CGRect keyboardRect = [aValue CGRectValue];
        int height = keyboardRect.size.height;
        
        [UIView animateWithDuration:0.25 animations:^{

            [self.scrollView setContentOffset:CGPointMake(0, height+457)];
            [self.scrollView setContentSize:CGSizeMake([[UIScreen mainScreen] bounds].size.width, 961+height)];
        }];
    }
}

//当键退出时调用
- (void)keyboardWillHide:(NSNotification *)aNotification {
    
    if (_theBottomTextField == 1) {
        
        [UIView animateWithDuration:0.25 animations:^{
            
            [self.scrollView setContentOffset:CGPointMake(0, 457)];
            [self.scrollView setContentSize:CGSizeMake([[UIScreen mainScreen] bounds].size.width, 961)];
        }];
    }
}

#pragma mark -UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    if (textField == _tf_deliveryPrice) {
        
        _theBottomTextField = 1;
    }
    
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    if (textField == _tf_deliveryPrice) {
        
        _theBottomTextField = 0;
    }
}










- (void) createCtronls
{
    CGRect frame = CGRectMake(15, 80, 200, 15);
    
//    int i = 0;
//
    //循环的时候 把 standardList 的值 保存进data;
//    for (NSDictionary *data in _updateModel.standardList) {
//        DictionaryWrapper *item = data.wrapper;
//        
////        testMode *mode = [_data objectAtIndex:i];
//        
//        //Title
//        UILabel *lab_title = [[UILabel alloc] initWithFrame:CGRectMake(15, frame.origin.y + 20, 200, 15)];
//        lab_title.font = [UIFont systemFontOfSize:14.0];
//        lab_title.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
//        lab_title.text = [item getString:@"ProductSpec"];
//        
//        //TextField -- 价格
//        frame = CGRectMake(15, lab_title.frame.origin.y + lab_title.frame.size.height + textField_Space, 290, 35);
//        UITextField *tf_price = [[UITextField alloc] initWithFrame:frame];
//        tf_price.layer.cornerRadius = 5.0f;
//        tf_price.layer.borderWidth = 0.3f;
//        tf_price.layer.borderColor = [[UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:0.5f] CGColor];
//        tf_price.textAlignment = NSTextAlignmentRight;
//        tf_price.text = [NSString stringWithFormat:@"%.1f", [item getFloat:@"UnitPrice"]];
//        tf_price.tag = i + 1;
//        
//        //Name -- 价格
//        frame = CGRectMake(25, tf_price.frame.origin.y + nameSpace, 40, 18);
//        UILabel *lab_price = [[UILabel alloc] initWithFrame:frame];
//        lab_price.font = [UIFont systemFontOfSize:15.0];
//        lab_price.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
//        lab_price.text = @"价格";
//        
//        //TextField -- 库存
//        frame = CGRectMake(15, tf_price.frame.origin.y + tf_price.frame.size.height + textField_Space, 290, 35);
//        UITextField *tf_onhandQty = [[UITextField alloc] initWithFrame:frame];
//        tf_onhandQty.layer.cornerRadius = 5.0f;
//        tf_onhandQty.layer.borderWidth = 0.3f;
//        tf_onhandQty.layer.borderColor = [[UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0f] CGColor];
//        tf_onhandQty.textAlignment = NSTextAlignmentRight;
//        tf_onhandQty.text = [NSString stringWithFormat:@"%d", [item getInt:@"OnhandQty"]];
//        tf_onhandQty.tag = i + 2;
//        
//        //Name -- 库存
//        frame = CGRectMake(25, tf_onhandQty.frame.origin.y + nameSpace, 40, 18);
//        UILabel *lab_onhandQty = [[UILabel alloc] initWithFrame:frame];
//        lab_onhandQty.font = [UIFont systemFontOfSize:15.0];
//        lab_onhandQty.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
//        lab_onhandQty.text = @"库存";
//        
//        frame = CGRectMake(frame.origin.x, frame.origin.y + frame.size.height, frame.size.width, frame.size.height);
//        
//        [_topView addSubview:lab_title];
//        [_topView addSubview:tf_price];
//        [_topView addSubview:lab_price];
//        [_topView addSubview:tf_onhandQty];
//        [_topView addSubview:lab_onhandQty];
//        
//        i++;
//
//    }
    
    int tf_tag = 0;             //用于标识两个tf的区分
    
    for (int i = 0; i < [_data count]; i++) {
        
        StyleMode *mode = [_data objectAtIndex:i];
        
        //Title
        UILabel *lab_title = [[UILabel alloc] initWithFrame:CGRectMake(15, frame.origin.y + 20, 200, 15)];
        lab_title.font = [UIFont systemFontOfSize:14.0];
        lab_title.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
        lab_title.text = mode.productSpec;
        lab_title.tag = i+1;
        
        //TextField -- 价格
        frame = CGRectMake(15, lab_title.frame.origin.y + lab_title.frame.size.height + textField_Space, 290, 35);
        UITextField *tf_price = [[UITextField alloc] initWithFrame:frame];
        tf_price.layer.cornerRadius = 5.0f;
        tf_price.layer.borderWidth = 0.4f;
        tf_price.layer.borderColor = [[UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:0.5f] CGColor];
        tf_price.textAlignment = NSTextAlignmentRight;
        tf_price.font = [UIFont systemFontOfSize:11.0f];
        tf_price.text = [NSString stringWithFormat:@"%.0f", mode.unitPrice];
        tf_price.keyboardType = UIKeyboardTypeNumberPad;
        tf_price.delegate = self;
        tf_tag++;
        tf_price.tag = tf_tag;
        
        //Name -- 价格
        frame = CGRectMake(25, tf_price.frame.origin.y + nameSpace, 40, 18);
        UILabel *lab_price = [[UILabel alloc] initWithFrame:frame];
        lab_price.font = [UIFont systemFontOfSize:15.0];
        lab_price.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
        lab_price.text = @"价格";
        
        //TextField -- 库存
        frame = CGRectMake(15, tf_price.frame.origin.y + tf_price.frame.size.height + textField_Space, 290, 35);
        UITextField *tf_onhandQty = [[UITextField alloc] initWithFrame:frame];
        tf_onhandQty.layer.cornerRadius = 5.0f;
        tf_onhandQty.layer.borderWidth = 0.4f;
        tf_onhandQty.layer.borderColor = [[UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:0.5f] CGColor];
        tf_onhandQty.textAlignment = NSTextAlignmentRight;
        tf_onhandQty.font = [UIFont systemFontOfSize:11.0f];
        tf_onhandQty.text = [NSString stringWithFormat:@"%d", mode.onhandQty];
        tf_onhandQty.delegate = self;
        tf_tag++;
        tf_onhandQty.tag = tf_tag;
        
        //Name -- 库存
        frame = CGRectMake(25, tf_onhandQty.frame.origin.y + nameSpace, 40, 18);
        UILabel *lab_onhandQty = [[UILabel alloc] initWithFrame:frame];
        lab_onhandQty.font = [UIFont systemFontOfSize:15.0];
        lab_onhandQty.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
        lab_onhandQty.text = @"库存";
        
        frame = CGRectMake(frame.origin.x, frame.origin.y + frame.size.height, frame.size.width, frame.size.height);
        
        [_topView addSubview:lab_title];
        [_topView addSubview:tf_price];
        [_topView addSubview:lab_price];
        [_topView addSubview:tf_onhandQty];
        [_topView addSubview:lab_onhandQty];
        
    }
    
    CGRect top_frame = _topView.frame;
    top_frame.size.height = frame.origin.y + frame.size.height + 25;
    _topView.frame = top_frame;
    [_scrollView addSubview:_topView];
    
    CGRect bottom_frame = _bottomView.frame;
    bottom_frame.origin.y = top_frame.origin.y + top_frame.size.height;
    _bottomView.frame = bottom_frame;
    [_scrollView addSubview:_bottomView];
    
    
    _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width, bottom_frame.origin.y + bottom_frame.size.height);

    [self refreshData];
}

//更新数据
- (void) refreshData
{
    if(_updateModel.offlineType == 1)
    {
        [_radio_1 setBackgroundImage:[UIImage imageNamed:@"rank-03"] forState:UIControlStateNormal];
        [_radio_2 setBackgroundImage:[UIImage imageNamed:@"rank-02"] forState:UIControlStateNormal];
    }
    else if(_updateModel.offlineType == 2)
    {
        [_radio_1 setBackgroundImage:[UIImage imageNamed:@"rank-02"] forState:UIControlStateNormal];
        [_radio_2 setBackgroundImage:[UIImage imageNamed:@"rank-03"] forState:UIControlStateNormal];
    }
}

//点击 --- 保存
- (void)onMoveFoward:(UIButton *)sender
{
    NSMutableArray *list = [[[NSMutableArray alloc] init] autorelease];
    for(id obj in [_topView subviews])
    {
        if([obj isKindOfClass:[UITextField class]])
        {
            UITextField *tf = (UITextField *)obj;
            //奇数 tf1
            if(tf.tag % 2 != 0){
                StyleMode *model = [_data objectAtIndex:(int)ceil((CGFloat)tf.tag/2) - 1];
                model.unitPrice = [tf.text floatValue];
            }
            
            //偶数 tf2
            else
            {
                StyleMode *model = [_data objectAtIndex:tf.tag/2 - 1];
                model.onhandQty = [tf.text intValue];
            }
        }
    }
    for (StyleMode *obj in _data) {
        
        WDictionaryWrapper *dic = WEAK_OBJECT(WDictionaryWrapper, init);
        [dic set:@"ProductSpec" string:obj.productSpec];
        [dic set:@"OnhandQty"   string:[NSString stringWithFormat:@"%d",obj.onhandQty]];
        [dic set:@"UnitPrice"   string:[NSString stringWithFormat:@"%.2f",obj.unitPrice]];
        
        [list addObject:dic.dictionary];
    }
    
//    ADAPI_UpdateCommodity([GLOBAL_DELEGATOR_MANAGER addDelegator:self selector:@selector(handleSucceed:)], _updateModel.productId, _updateModel.deliveryPrice, _OfflineType, _lab_time.text, list);
    NSLog(@"邮费：%@", _tf_deliveryPrice.text);
}

- (void)handleSucceed:(DelegatorArguments *)arguments
{
    DictionaryWrapper *Datas = arguments.ret;
    
    NSLog(@"Datas :%@", Datas);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//隐藏键盘
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self resignAllKeyBoard];
}

//关闭所有键盘
-(void)resignAllKeyBoard
{
    [_tf_deliveryPrice resignFirstResponder];
    
    for(id obj in [_topView subviews])
    {
        if([obj isKindOfClass:[UITextField class]])
        {
            UITextField *tf = (UITextField *)obj;
            [tf resignFirstResponder];
        }
    }
    
    if(keyBordIsShow)
    {
        NSTimeInterval animationDuration = 0.25f;
        [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
        [UIView setAnimationDuration:animationDuration];
        CGRect rect = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, [[UIScreen mainScreen] bounds].size.height);
        self.view.frame = rect;
        [UIView commitAnimations];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    keyBordIsShow = NO;
    // When the user presses return, take focus away from the text field so that the keyboard is dismissed.
    NSTimeInterval animationDuration = 0.25f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    CGRect rect = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, [[UIScreen mainScreen] bounds].size.height);
    self.view.frame = rect;
    [UIView commitAnimations];
    [textField resignFirstResponder];
    return YES;
}

//
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    keyBordIsShow = YES;
    CGRect frame = textField.frame;
    int offset = frame.origin.y - ([[UIScreen mainScreen] bounds].size.height - 246.0);//键盘高度216
    NSTimeInterval animationDuration = 0.25f;
    [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    float width = self.view.frame.size.width;
    float height = [[UIScreen mainScreen] bounds].size.height;
    if(offset > 0)
    {
        CGRect rect = CGRectMake(0.0f, -offset,width,height);
        self.view.frame = rect;
    }
    [UIView commitAnimations];
}


//按钮点击事件
-(IBAction)Action_Btn_Selected:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    
    //Radio1
    if(btn.tag == 1)
    {
        _OfflineType = btn.tag;
        [_radio_1 setBackgroundImage:[UIImage imageNamed:@"rank-03"] forState:UIControlStateNormal];
        [_radio_2 setBackgroundImage:[UIImage imageNamed:@"rank-02"] forState:UIControlStateNormal];
    }
    
    //Radio2
    else if(btn.tag == 2)
    {
        _OfflineType = btn.tag;
        [_radio_1 setBackgroundImage:[UIImage imageNamed:@"rank-02"] forState:UIControlStateNormal];
        [_radio_2 setBackgroundImage:[UIImage imageNamed:@"rank-03"] forState:UIControlStateNormal];
    }
    
    //选择时间
    else if(btn.tag == 3)
    {
        [self resignAllKeyBoard];
        
        if(![self hasDatePicker])           //未打开
        {
            [self fadeIn_dateView:[[UIScreen mainScreen] bounds].size.height - _dateView.frame.size.height];
        }
        else
        {
            [self fadeIn_dateView:[[UIScreen mainScreen] bounds].size.height];
        }
    }
    //确定
    else if(btn.tag == 4)
    {
        [self resignAllKeyBoard];
        
        if(![self hasDatePicker])           //未打开
        {
            [self fadeIn_dateView:[[UIScreen mainScreen] bounds].size.height - _dateView.frame.size.height];
        }
        else
        {
            [self fadeIn_dateView:[[UIScreen mainScreen] bounds].size.height];
        }
        
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        //设置时间格式
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        
        NSString *destDateString = [dateFormatter stringFromDate:[_datePicker date]];
        
        _lab_time.text = destDateString;
    }
}

//判断DatePicker 是打开还是关闭
-(BOOL)hasDatePicker
{
    if(_dateView.frame.origin.y == [[UIScreen mainScreen] bounds].size.height - _dateView.frame.size.height)
        return YES;
    else
        return NO;
}

//DatePicker 打开、关闭
-(void)fadeIn_dateView:(int)y
{
    [UIView animateWithDuration:Time animations:^{
        
        CGRect rect = _dateView.frame;
        rect.origin.x = _dateView.frame.origin.x;
        rect.origin.y = y;
        rect.size.width = _dateView.frame.size.width;
        rect.size.height = _dateView.frame.size.height;
        _dateView.frame = rect;
    } completion:^(BOOL finished){
    }];
}

@end
