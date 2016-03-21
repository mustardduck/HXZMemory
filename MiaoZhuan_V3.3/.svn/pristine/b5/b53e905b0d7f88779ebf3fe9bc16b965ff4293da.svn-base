//
//  Commodity_Update.m
//  miaozhuan
//
//  Created by xm01 on 14-12-29.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "Commodity_Update.h"
#import "AppUtils.h"

#define textField_Space         10
#define nameSpace               9
#define Time  0.25

@interface Commodity_Update ()<UITextFieldDelegate, DatePickerDelegate, UIScrollViewDelegate, UserKeyboardDelegate>
{
    UserKeyboard            *_customkeyboard;
    
    UITextField             *_chooseTF;
    
    CGFloat offsetY;
    
    BOOL                    _KeyBoardIsShow;            //邮费的键盘 是否显示
    
    CGSize                  _orignailSize;              //ScrollView 原始 ContentSize;
    
    CGSize                  _bottomSize;                //bottomView 原始 Frame;
    
    int                     _OfflineType;
    
    DatePickerViewController *datePickerView;
    
    BOOL                    _isEqual;                   //是否修改过
    
    int                     _allOnhandQty;              //修改过后的库存总数
}

@property(nonatomic, retain) IBOutlet UIButton                  *btn_Time;
@property(nonatomic, retain) NSArray                            *uploadList;

@property(nonatomic, retain) NSMutableArray                     *price_array;              //存放代码生成的 textField
@property(nonatomic, retain) NSMutableArray                     *onhandQty_array;          //存放代码生成的 textField

@property(nonatomic, retain) IBOutlet UIScrollView              *scrollView;
@property(nonatomic, retain) IBOutlet UIView                    *topView;
@property(nonatomic, retain) IBOutlet UIView                    *bottomView;

@property(nonatomic, retain) IBOutlet UIButton                  *radio_1;
@property(nonatomic, retain) IBOutlet UIButton                  *radio_2;

@property(nonatomic, retain) IBOutlet UIView                    *view_deliveryPrice;
@property(nonatomic, retain) IBOutlet UITextField               *tf_deliveryPrice;
@property(nonatomic, retain) IBOutlet UILabel                   *lab_time;

@property(nonatomic, retain) IBOutlet UIView                    *timeView;

@property(nonatomic, retain) IBOutlet UIView                    *bottomLine;



@property(nonatomic, retain) NSMutableArray                     *data;

@end

@implementation Commodity_Update

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
    [_view_deliveryPrice release];
    [_tf_deliveryPrice release];
    [_lab_time release];
    [_btn_Time release];
    [_timeView release];
    [_bottomLine release];
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
    self.view_deliveryPrice = nil;
    self.tf_deliveryPrice = nil;
    self.lab_time = nil;
    self.btn_Time = nil;
    self.timeView = nil;
    self.bottomLine = nil;
}

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad {
    [super viewDidLoad];
    
    offsetY = [UICommon getIos4OffsetY];
    
    InitNav(@"商品修改");
    [self setupMoveBackButton];
    [self setupMoveFowardButtonWithTitle:@"保存"];
    
    _data = [[NSMutableArray alloc] init];
    
    _view_deliveryPrice.layer.cornerRadius = 5.0f;
    _view_deliveryPrice.layer.borderWidth = 1.0f;
    _view_deliveryPrice.layer.borderColor = [[UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:0.5f] CGColor];
    
    _btn_Time.layer.cornerRadius = 5.0f;
    _btn_Time.layer.borderWidth = 1.0f;
    _btn_Time.layer.borderColor = [[UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:0.5f] CGColor];
    
    
    //初始化自定义数字键盘
    
    _customkeyboard = [[UserKeyboard alloc] initWithFrame:CGRectMake(0, 200, 320, 216)];
    _customkeyboard.delegate = self;
    
    
    //ScrollView 添加点击事件
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Action_Scroll_Clicked:)];
    
    [_scrollView addGestureRecognizer:singleTap];
    
    [singleTap release];
    
    
    _bottomSize = _bottomView.size;
    
    //更新UI
    [self createCtronls];
}

//ScrollView 点击事件
-(void)Action_Scroll_Clicked:(id)sender
{
    [self resignAllKeyBoard];
}

- (void) createCtronls
{
    CGRect frame = CGRectMake(15, 70, 200, 15);
    
    //用于标识两个tf的区分
    int tf_tag = 0;
    
    int i = 0;
    
    if(_updateModel.deliveryPrice == 0)
    {
        _tf_deliveryPrice.text = @"0";
        _tf_deliveryPrice.enabled = NO;
        _tf_deliveryPrice.alpha = 0.5f;
    }
    else
    _tf_deliveryPrice.text = [NSString stringWithFormat:@"%.2f", _updateModel.deliveryPrice];
    
    [_topView addSubview:[AppUtils LineView:10.0f]];
    
    _bottomLine = [AppUtils LineView:243.0f];
    [_bottomView addSubview:_bottomLine];
    
    for (NSDictionary *data in _updateModel.standardList) {
        DictionaryWrapper *item = data.wrapper;
        
        StyleMode *obj = [[StyleMode alloc] init];
//        obj.productSpec = [item getString:@"ProductSpec"];
//        obj.unitPrice = [[UICommon getStringToTwoDigitsAfterDecimalPlacesPoint:[item getString:@"UnitPrice"] withAppendStr:@""] floatValue];
        obj.specId = [item getString:@"ProductSpecId"];
        obj.onhandQty = [item getInt:@"OnhandQty"];
        
        [_data addObject:obj];
        
        //Title
        UILabel *lab_title = [[UILabel alloc] initWithFrame:CGRectMake(15, frame.origin.y + 26, 200, 14.0f)];
        lab_title.font = [UIFont systemFontOfSize:14.0];
        lab_title.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
        lab_title.text = [item getString:@"ProductSpec"];
        lab_title.tag = i+1;
        
        //TextField -- 价格
        frame = CGRectMake(15, lab_title.frame.origin.y + lab_title.frame.size.height + textField_Space, 290, 35);
        
        UIView *p_view = [[UIView alloc] initWithFrame:frame];
        p_view.layer.cornerRadius = 5.0f;
        p_view.layer.borderWidth = 1.0f;
        p_view.layer.borderColor = [[UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:0.5f] CGColor];
        CGRect p_frame = frame;
        p_frame.size.width -= 10;
        
        UITextField *tf_price = [[UITextField alloc] initWithFrame:p_frame];
        tf_price.textAlignment = NSTextAlignmentRight;
        tf_price.font = [UIFont systemFontOfSize:16.0f];
        tf_price.text = [NSString stringWithFormat:@"%@", [UICommon getStringToTwoDigitsAfterDecimalPlacesPoint:[item getString:@"UnitPrice"] withAppendStr:@""]];
        tf_price.textColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0];
        tf_price.inputView = _customkeyboard;
        tf_price.delegate = self;
        tf_tag++;
        tf_price.tag = tf_tag;
        
        //Name -- 价格
        frame = CGRectMake(25, tf_price.frame.origin.y + nameSpace, 40, 18);
        UILabel *lab_price = [[UILabel alloc] initWithFrame:frame];
        lab_price.font = [UIFont systemFontOfSize:16.0f];
        lab_price.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
        lab_price.text = @"价格";
        
        //TextField -- 库存
        frame = CGRectMake(15, tf_price.frame.origin.y + tf_price.frame.size.height + textField_Space, 290, 35);
        
        UIView *o_view = [[UIView alloc] initWithFrame:frame];
        o_view.layer.cornerRadius = 5.0f;
        o_view.layer.borderWidth = 1.0f;
        o_view.layer.borderColor = [[UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:0.5f] CGColor];
        
        CGRect o_frame = frame;
        o_frame.size.width -= 10;
        
        UITextField *tf_onhandQty = [[UITextField alloc] initWithFrame:o_frame];
        tf_onhandQty.textAlignment = NSTextAlignmentRight;
        tf_onhandQty.font = [UIFont systemFontOfSize:16.0f];
        tf_onhandQty.text = [NSString stringWithFormat:@"%d", [item getInt:@"OnhandQty"]];
        tf_onhandQty.textColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0];
        tf_onhandQty.inputView = _customkeyboard;
        tf_onhandQty.delegate = self;
        tf_tag++;
        tf_onhandQty.tag = tf_tag;
        
        //Name -- 库存
        frame = CGRectMake(25, tf_onhandQty.frame.origin.y + nameSpace, 40, 18);
        UILabel *lab_onhandQty = [[UILabel alloc] initWithFrame:frame];
        lab_onhandQty.font = [UIFont systemFontOfSize:16.0f];
        lab_onhandQty.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
        lab_onhandQty.text = @"库存";
        
        frame = CGRectMake(frame.origin.x, frame.origin.y + frame.size.height, frame.size.width, frame.size.height);
        
        [_topView addSubview:lab_title];
        [_topView addSubview:p_view];
        [_topView addSubview:tf_price];
        [_topView addSubview:lab_price];
        [_topView addSubview:o_view];
        [_topView addSubview:tf_onhandQty];
        [_topView addSubview:lab_onhandQty];
        
        
        [lab_title release];
        [p_view release];
        [tf_price release];
        [lab_price release];
        [o_view release];
        [tf_onhandQty release];
        [lab_onhandQty release];
        
        i++;
        
    }
    
    
    _tf_deliveryPrice.inputView = _customkeyboard;
    
    CGRect top_frame = _topView.frame;
    top_frame.size.height = frame.origin.y + frame.size.height + 10;
    _topView.frame = top_frame;
    [_scrollView addSubview:_topView];
    
    CGRect bottom_frame = _bottomView.frame;
    bottom_frame.origin.y = top_frame.origin.y + top_frame.size.height;
    _bottomView.frame = bottom_frame;
    [_scrollView addSubview:_bottomView];
    
    
    _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width, bottom_frame.origin.y + bottom_frame.size.height);
    
    _orignailSize = _scrollView.contentSize;

    _OfflineType = _updateModel.offlineType;
    

    _lab_time.text = _updateModel.offlineDate;
    if([_updateModel.offlineDate isEqualToString:@""] || _updateModel.offlineDate == nil)
        _lab_time.text = @"请选择下架时间";
    else
    {
        if(_lab_time.text.length >= 10)
            _lab_time.text = [AppUtils theMaxTimeStamp:[_lab_time.text substringToIndex:10]];
    }
    [self refreshData:_updateModel.offlineType];
}

//更新数据
- (void) refreshData:(NSInteger) tag
{
    //售完下架
    if(tag == 1)
    {
        _OfflineType = 1;
        
        _timeView.hidden = YES;
        
        CGRect frame = _bottomView.frame;
        
        int offset_height = _timeView.frame.size.height + 18;
        
        frame.size.height = _bottomSize.height - offset_height;
        
        _bottomView.frame = frame;
        
        
        CGRect lineFrame = _bottomLine.frame;
        lineFrame.origin.y = frame.size.height - 9.5;
        _bottomLine.frame = lineFrame;
        
        _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width, _orignailSize.height - offset_height);
        
        [_radio_1 setBackgroundImage:[UIImage imageNamed:@"rank-03"] forState:UIControlStateNormal];
        [_radio_2 setBackgroundImage:[UIImage imageNamed:@"rank-02"] forState:UIControlStateNormal];
    }
    //指定日期下架
    else if(tag == 2)
    {
        _OfflineType = 2;
        
        _timeView.hidden = NO;
        
        CGRect frame = _bottomView.frame;
        
        int offset_height = _timeView.frame.size.height + 18;
        
        frame.size.height = _bottomSize.height;
        
        _bottomView.frame = frame;
        
        CGRect lineFrame = _bottomLine.frame;
        lineFrame.origin.y = frame.size.height - 9.5;
        _bottomLine.frame = lineFrame;
        
        _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width, _orignailSize.height);
        
        [_radio_1 setBackgroundImage:[UIImage imageNamed:@"rank-02"] forState:UIControlStateNormal];
        [_radio_2 setBackgroundImage:[UIImage imageNamed:@"rank-03"] forState:UIControlStateNormal];
        
        [_scrollView setContentOffset:CGPointMake(0, _scrollView.contentOffset.y + offset_height) animated:NO];
    }
}

//点击 --- 保存
- (void)onMoveFoward:(UIButton *)sender
{
    BOOL priceIsWrite = YES;
    BOOL onhandQtyIsWrite = YES;
    
    _isEqual = NO;
    
    if(_OfflineType != _updateModel.offlineType)
        _isEqual = YES;
    else
    {
        if(_OfflineType == 2)
        {
            if(![_lab_time.text isEqualToString:@"请选择下架时间"] && ![[_lab_time.text stringByAppendingString:@"T00:00:00"] isEqualToString:_updateModel.offlineDate])
                _isEqual = YES;
        }
    }
    
//    if(_updateModel.deliveryPrice == 0)
//    {
//        if(![_tf_deliveryPrice.text isEqualToString:[NSString stringWithFormat:@"%.0f", _updateModel.deliveryPrice]])
//            _isEqual = YES;
//    }
//    else
//    {
//        if(![_tf_deliveryPrice.text isEqualToString:[NSString stringWithFormat:@"%.2f", _updateModel.deliveryPrice]])
//            _isEqual = YES;
//    }
    
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
                
//                //判断单价 库存是否有未填写
//                if([tf.text isEqualToString:@""])
//                    priceIsWrite = NO;
            }
            
            //偶数 tf2
            else
            {
                StyleMode *model = [_data objectAtIndex:tf.tag/2 - 1];
                
                model.onhandQty = [tf.text intValue];
                
                //判断 库存是否有未填写
                if([tf.text isEqualToString:@""])
                    onhandQtyIsWrite = NO;
                else
                    _allOnhandQty += [tf.text intValue];
            }
        }
    }
    
//    if(!priceIsWrite)
//    {
//        [HUDUtil showErrorWithStatus:@"请填写单价"];
//        return;
//    }
    
    if(!onhandQtyIsWrite)
    {
        [HUDUtil showErrorWithStatus:@"请填写库存数量"];
        return;
    }
    
    else if([_tf_deliveryPrice.text isEqualToString:@""])
    {
        [HUDUtil showErrorWithStatus:@"请填写邮费"];
        return;
    }
    
    else if(_OfflineType == 2)
        if([_lab_time.text isEqualToString:@"请选择下架时间"])
        {
            [HUDUtil showErrorWithStatus:@"请选择下架时间"];
            
            return;
        }
    
    for (StyleMode *obj in _data) {
        
        WDictionaryWrapper *dic = WEAK_OBJECT(WDictionaryWrapper, init);
        
        [dic set:@"ProductSpecId"   string:obj.specId];
        
        [dic set:@"OnhandQty"   string:[NSString stringWithFormat:@"%d", obj.onhandQty]];
        
        [list addObject:dic.dictionary];
    }
    
    ADAPI_UpdateCommodity([GLOBAL_DELEGATOR_MANAGER addDelegator:self selector:@selector(handleSucceed:)], _updateModel.productId, [_tf_deliveryPrice.text floatValue], _OfflineType, _lab_time.text, list);
}

- (void)handleSucceed:(DelegatorArguments *)arguments
{
    DictionaryWrapper *dic = arguments.ret;
    
    if([dic getInt:@"Code"] == 100)
    {
        [HUDUtil showSuccessWithStatus:[dic getString:@"Desc"]];
        
        [self.navigationController popViewControllerAnimated:YES];
        
        NSMutableArray *resendList = [[AppUtils getInstance] getResendList];
        
        for(resendObject *obj in resendList)
        {
            if(obj.productId == _updateModel.productId)
                return;
        }
        
        resendObject *obj = [[resendObject alloc] init];
        obj.productId = _updateModel.productId;
        [resendList addObject:obj];
        
        [_delegate resendPutaway:_isEqual allOnhandQty:_allOnhandQty];
    }
    else
        [HUDUtil showErrorWithStatus:[dic getString:@"Desc"]];
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
    if(_KeyBoardIsShow)
        _scrollView.contentSize = _orignailSize;
    _KeyBoardIsShow = NO;
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    _chooseTF = textField;
    
    if(textField == _tf_deliveryPrice)
    {
        _KeyBoardIsShow = YES;
        
        _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width, _orignailSize.height + 50);
    }
    else
    {
        _KeyBoardIsShow = NO;
        
        _scrollView.contentSize = _orignailSize;
    }
    
    return YES;
}


//按钮点击事件
-(IBAction)Action_Btn_Selected:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    
    //RadioButton
    if(btn.tag == 1 || btn.tag == 2)
    {
        [self refreshData:btn.tag];
    }
    
    //选择时间
    else if(btn.tag == 3)
    {   
        [self setDatePickerView];
        
        NSDate* date = [[NSDate alloc] init];
        date = [date dateByAddingTimeInterval:+60*60*24];//当前系统时间+1天
        
        datePickerView.picker.date = date;
        
        datePickerView.picker.minimumDate = date;
        datePickerView.view.tag = 100;
        
        [datePickerView initwithtitles:0];
        
        [self.view addSubview:datePickerView.view];
    }
}

// 文本框输入限制
-(BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    BOOL result = NO;
    
//    if(textField.tag == 0)
//    {
        NSMutableString *text0 = [[textField.text mutableCopy] autorelease];
        [text0 replaceCharactersInRange:range withString:string];
        if(text0.length <= 10)
        {
            result = YES;
        }else {
            result = NO;
        }
//    }
     
    return result;
}

#pragma mark - CustomNumberKeyboard

-(void)changeKeyboardType
{
    [self resignAllKeyBoard];
}

-(void)numberKeyboardBackspace
{
    if (_chooseTF.text.length != 0)
    {
        _chooseTF.text = [_chooseTF.text substringToIndex:_chooseTF.text.length -1];
    }
//    else
//        _chooseTF.text = @"0";
}

-(void)numberKeyboardInput:(NSInteger)number
{
    //控制输出长度
    if(_chooseTF.text.length <= 15)
    {
        _chooseTF.text = [_chooseTF.text stringByAppendingString:[NSString stringWithFormat:@"%ld",number]];
    }
    
}


#pragma mark UIPickerView

-(void) setDatePickerView
{
    datePickerView = [[DatePickerViewController alloc]initWithNibName:@"DatePickerViewController" bundle:nil];
    
    datePickerView.view.frame = CGRectMake(0, 0, 320, 460 + offsetY);
    
    datePickerView.delegate = self;
}

- (void) selectDateCallBack:(NSDate*)date
{
    [datePickerView.view removeFromSuperview];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    
    NSString* text = [dateFormatter stringFromDate:date];
    
    if (datePickerView.view.tag == 100)
    {
        _lab_time.text = text;
    }
    
    [dateFormatter release];
    
    dateFormatter = nil;
}

- (void) cancelDateCallBack:(NSDate*)date
{
    [datePickerView.view removeFromSuperview];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    [self resignAllKeyBoard];
}

-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
//    [self resignAllKeyBoard];
}

@end
