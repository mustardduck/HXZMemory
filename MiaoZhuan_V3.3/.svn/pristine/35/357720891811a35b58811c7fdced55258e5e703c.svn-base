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

@interface Commodity_Update ()
{
    UserKeyboard            *_customkeyboard;
    
    UITextField             *_chooseTF;
    
    CGFloat offsetY;
    
    BOOL                    _KeyBoardIsShow;            //邮费的键盘 是否显示
    
    CGSize                  _orignailSize;              //ScrollView 原始 ContentSize;
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
@synthesize btn_Time = _btn_Time;

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
    [_btn_Time release];
//    [_dateView release];
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
    self.btn_Time = nil;
//    self.dateView = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    offsetY = [UICommon getIos4OffsetY];
    
    InitNav(@"商品修改");
    [self setupMoveBackButton];
    [self setupMoveFowardButtonWithTitle:@"保存"];
    
    _data = [[NSMutableArray alloc] init];
    
    _tf_deliveryPrice.layer.cornerRadius = 5.0f;
    _tf_deliveryPrice.layer.borderWidth = 0.4f;
    _tf_deliveryPrice.layer.borderColor = [[UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:0.5f] CGColor];
    
    _btn_Time.layer.cornerRadius = 5.0f;
    _btn_Time.layer.borderWidth = 0.4f;
    _btn_Time.layer.borderColor = [[UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:0.5f] CGColor];
    
    
    //初始化自定义数字键盘
    
    _customkeyboard = [[UserKeyboard alloc] initWithFrame:CGRectMake(0, 200, 320, 216)];
    _customkeyboard.delegate = self;
    
    
    //ScrollView 添加点击事件
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Action_Scroll_Clicked:)];
    
    [_scrollView addGestureRecognizer:singleTap];
    
    [singleTap release];
    
    
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
    CGRect frame = CGRectMake(15, 80, 200, 15);
    
    int tf_tag = 0;             //用于标识两个tf的区分
    int i = 0;
    
    _tf_deliveryPrice.text = [NSString stringWithFormat:@"%.2f", _updateModel.deliveryPrice];
    
    for (NSDictionary *data in _updateModel.standardList) {
        DictionaryWrapper *item = data.wrapper;
        
        StyleMode *obj = [[StyleMode alloc] init];
        obj.productSpec = [item getString:@"ProductSpec"];
        obj.unitPrice = [item getFloat:@"UnitPrice"];
        obj.onhandQty = [item getInt:@"OnhandQty"];
        
        [_data addObject:obj];
        
        //Title
        UILabel *lab_title = [[UILabel alloc] initWithFrame:CGRectMake(15, frame.origin.y + 20, 200, 15)];
        lab_title.font = [UIFont systemFontOfSize:14.0];
        lab_title.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
        lab_title.text = [item getString:@"ProductSpec"];
        lab_title.tag = i+1;
        
        //TextField -- 价格
        frame = CGRectMake(15, lab_title.frame.origin.y + lab_title.frame.size.height + textField_Space, 290, 35);
        UITextField *tf_price = [[UITextField alloc] initWithFrame:frame];
        tf_price.layer.cornerRadius = 5.0f;
        tf_price.layer.borderWidth = 0.4f;
        tf_price.layer.borderColor = [[UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:0.5f] CGColor];
        tf_price.textAlignment = NSTextAlignmentRight;
        tf_price.font = [UIFont systemFontOfSize:11.0f];
        tf_price.text = [NSString stringWithFormat:@"%.2f", [item getFloat:@"UnitPrice"]];
        tf_price.inputView = _customkeyboard;
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
        tf_onhandQty.text = [NSString stringWithFormat:@"%d", [item getInt:@"OnhandQty"]];
        tf_onhandQty.inputView = _customkeyboard;
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
        
        i++;
        
    }
    
    
    _tf_deliveryPrice.inputView = _customkeyboard;
    
    CGRect top_frame = _topView.frame;
    top_frame.size.height = frame.origin.y + frame.size.height + 25;
    _topView.frame = top_frame;
    [_scrollView addSubview:_topView];
    
    CGRect bottom_frame = _bottomView.frame;
    bottom_frame.origin.y = top_frame.origin.y + top_frame.size.height;
    _bottomView.frame = bottom_frame;
    [_scrollView addSubview:_bottomView];
    
    
    _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width, bottom_frame.origin.y + bottom_frame.size.height);
    
    _orignailSize = _scrollView.contentSize;

    [self refreshData];
}

//更新数据
- (void) refreshData
{
    if(_updateModel.offlineType == 2)
    {
        [_radio_1 setBackgroundImage:[UIImage imageNamed:@"rank-02"] forState:UIControlStateNormal];
        [_radio_2 setBackgroundImage:[UIImage imageNamed:@"rank-03"] forState:UIControlStateNormal];
    }
    else
    {
        [_radio_1 setBackgroundImage:[UIImage imageNamed:@"rank-03"] forState:UIControlStateNormal];
        [_radio_2 setBackgroundImage:[UIImage imageNamed:@"rank-02"] forState:UIControlStateNormal];
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
        [dic set:@"OnhandQty" string:[NSString stringWithFormat:@"%d", obj.onhandQty]];
        [dic set:@"UnitPrice" string:[NSString stringWithFormat:@"%.2f", obj.unitPrice]];
        
        [list addObject:dic.dictionary];
    }
    
    ADAPI_UpdateCommodity([GLOBAL_DELEGATOR_MANAGER addDelegator:self selector:@selector(handleSucceed:)], _updateModel.productId, _updateModel.deliveryPrice, _OfflineType, _lab_time.text, list);
}

- (void)handleSucceed:(DelegatorArguments *)arguments
{
    DictionaryWrapper *dic = arguments.ret;
    
    if([dic getInt:@"Code"] == 100)
        [HUDUtil showSuccessWithStatus:[dic getString:@"Desc"]];
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
        [self setDatePickerView];
        
        datePickerView.picker.date = [NSDate date];
        
        datePickerView.view.tag = 100;
        
        [datePickerView initwithtitles:0];
        
        [self.view addSubview:datePickerView.view];
    }
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
}

-(void)numberKeyboardInput:(NSInteger)number
{
    _chooseTF.text = [_chooseTF.text stringByAppendingString:[NSString stringWithFormat:@"%ld",number]];
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
