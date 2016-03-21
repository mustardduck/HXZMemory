//
//  Commodity_Info_Update.m
//  miaozhuan
//
//  Created by Nick on 15/5/11.
//  Copyright (c) 2015年 zdit. All rights reserved.
//

#import "Commodity_Info_Update.h"

@interface Commodity_Info_Update ()<UITextFieldDelegate>
{
    UITextField             *_chooseTF;
    BOOL                    _KeyBoardIsShow;            //邮费的键盘 是否显示
}
@property(nonatomic, retain) IBOutlet UIScrollView          * scrollView;
@property(nonatomic, retain) IBOutlet UIView                * topView;

@property(nonatomic, retain) IBOutlet UIView                * v_productName;
@property(nonatomic, retain) IBOutlet UITextField           * tf_productName;

@property(nonatomic, retain) IBOutlet UIView                * v_categoryName;
@property(nonatomic, retain) IBOutlet UILabel               * lab_categoryName;

@property(nonatomic, retain) IBOutlet UIView                * bottomView;
@property(nonatomic, retain) NSMutableArray                     *data;

@end

@implementation Commodity_Info_Update

- (void)viewDidLoad {
    [super viewDidLoad];
    
    InitNav(@"商品详情");
    [self setupMoveBackButton];
    [self setupMoveFowardButtonWithTitle:@"保存"];
    
    _data = [[NSMutableArray alloc] init];
    
    //添加InfoView
    CGRect infoFrame = _topView.frame;
    
    _topView.frame = infoFrame;
    
    [_scrollView addSubview:_topView];
    
    
    
    //添加BottomView
    CGRect bottomFrame = _bottomView.frame;
    
    bottomFrame.origin.y = _topView.frame.origin.y + _topView.frame.size.height;
    
    _bottomView.frame = bottomFrame;
    
    [_scrollView addSubview:_bottomView];
    
    
    
    _v_productName.layer.cornerRadius = 5.0f;
    _v_productName.layer.borderWidth = 1.0f;
    _v_productName.layer.borderColor = [[UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:0.5f] CGColor];
    
    _v_categoryName.layer.cornerRadius = 5.0f;
    _v_categoryName.layer.borderWidth = 1.0f;
    _v_categoryName.layer.borderColor = [[UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:0.5f] CGColor];
    
    //添加键盘
    [self addDoneToKeyboard:_tf_productName];
    
    _tf_productName.text = _updateModel.productName;
    _lab_categoryName.text = _updateModel.categoryName;
    
    [self loadColorSize];
}

//点击事件 保存
- (void)onMoveFoward:(UIButton *)sender
{
    BOOL specIsWrite = YES;
    
    NSMutableArray *list = [[[NSMutableArray alloc] init] autorelease];
    for(id obj in [_bottomView subviews])
    {
        if([obj isKindOfClass:[UITextField class]])
        {
            UITextField *tf = (UITextField *)obj;
            StyleMode *model = [_data objectAtIndex:tf.tag];
                
            model.unitPrice = [tf.text floatValue];
                
            //判断单价 库存是否有未填写
               if([tf.text isEqualToString:@""])
                specIsWrite = NO;
        }
    }
    
    if([_tf_productName.text isEqualToString:@""])
    {
        [HUDUtil showErrorWithStatus:@"请填写商品名称"];
        return;
    }
    
    else if(!specIsWrite)
    {
        [HUDUtil showErrorWithStatus:@"请填写颜色规格"];
        return;
    }
    
    for (StyleMode *obj in _data) {
        
        WDictionaryWrapper *dic = WEAK_OBJECT(WDictionaryWrapper, init);
        
        [dic set:@"ProductSpecId"   string:obj.specId];
        
        [dic set:@"ProductSpec" string:obj.productSpec];
        
        [list addObject:dic.dictionary];
    }
    
    ADAPI_UpdateCommodityProductName([GLOBAL_DELEGATOR_MANAGER addDelegator:self selector:@selector(handleSucceed:)], _updateModel.productId, _updateModel.productName, list);
}

- (void)handleSucceed:(DelegatorArguments *)arguments
{
    DictionaryWrapper *dic = arguments.ret;
    
    if([dic getInt:@"Code"] == 100)
    {
        [HUDUtil showSuccessWithStatus:[dic getString:@"Desc"]];
        
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
        [HUDUtil showErrorWithStatus:[dic getString:@"Desc"]];
}
-(void)loadColorSize
{
    int tf_tag = 0;
    CGRect frame = CGRectMake(15, 28, 290, 35);
    
    for (NSDictionary *data in _updateModel.standardList) {
        DictionaryWrapper *item = data.wrapper;
        
        StyleMode *obj = [[StyleMode alloc] init];
        obj.productSpec = [item getString:@"ProductSpec"];
        obj.unitPrice = [[UICommon getStringToTwoDigitsAfterDecimalPlacesPoint:[item getString:@"UnitPrice"] withAppendStr:@""] floatValue];
        obj.onhandQty = [item getInt:@"OnhandQty"];
        obj.specId = [item getString:@"ProductSpecId"];
        
        [_data addObject:obj];
        
        
        UIView *p_view = [[UIView alloc] initWithFrame:frame];
        p_view.layer.cornerRadius = 5.0f;
        p_view.layer.borderWidth = 1.0f;
        p_view.layer.borderColor = [[UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:0.5f] CGColor];
        
        [_bottomView addSubview:p_view];
        
        CGRect p_frame = frame;
        p_frame.size.width -= 13;
        p_frame.origin.x += 13;
        
        UITextField *tf_price = [[UITextField alloc] initWithFrame:p_frame];
        tf_price.textAlignment = NSTextAlignmentLeft;
        tf_price.font = [UIFont systemFontOfSize:16.0f];
        tf_price.text = [item getString:@"ProductSpec"];
        tf_price.textColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0];
        [self addDoneToKeyboard:tf_price];
        tf_price.delegate = self;
        tf_price.tag = tf_tag;
        tf_tag ++;
        [_bottomView addSubview:tf_price];
        
        frame.origin.y = frame.origin.y + frame.size.height + 10;
    }
    
    
    
    
    
//    for(int i = 0; i < [list count]; i ++)
//    {
//        UIView *p_view = [[UIView alloc] initWithFrame:frame];
//        p_view.layer.cornerRadius = 5.0f;
//        p_view.layer.borderWidth = 1.0f;
//        p_view.layer.borderColor = [[UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:0.5f] CGColor];
//        
//        [_bottomView addSubview:p_view];
//        
//        CGRect p_frame = frame;
//        p_frame.size.width -= 13;
//        p_frame.origin.x += 13;
//        
//        UITextField *tf_price = [[UITextField alloc] initWithFrame:p_frame];
//        tf_price.textAlignment = NSTextAlignmentLeft;
//        tf_price.font = [UIFont systemFontOfSize:16.0f];
////        tf_price.text = [NSString stringWithFormat:@"%@", [UICommon getStringToTwoDigitsAfterDecimalPlacesPoint:[item getString:@"UnitPrice"] withAppendStr:@""]];
//        tf_price.text = [list objectAtIndex:i];
//        tf_price.textColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0];
////        tf_price.inputView = _customkeyboard;
//        [self addDoneToKeyboard:tf_price];
//        tf_price.delegate = self;
////        tf_tag++;
////        tf_price.tag = tf_tag;
//        [_bottomView addSubview:tf_price];
//        
//        frame.origin.y = frame.origin.y + frame.size.height + 10;
//    }
    
    int bottomHeight = frame.origin.y + frame.size.height + 20;
    
    CGRect bottomFrame = _bottomView.frame;
    bottomFrame.size.height = bottomHeight;
    _bottomView.frame = bottomFrame;
    
    
    _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width, _topView.frame.size.height + bottomHeight);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    _chooseTF = textField;
    
//    if(textField == _tf_deliveryPrice)
//    {
//        _KeyBoardIsShow = YES;
//    }
//    else
//    {
        _KeyBoardIsShow = NO;
//    }
    
    return YES;
}

- (void)hiddenKeyboard {
    [_tf_productName resignFirstResponder];
    
    for(id obj in [_bottomView subviews])
    {
        if([obj isKindOfClass:[UITextField class]])
        {
            UITextField *tf = (UITextField *)obj;
            [tf resignFirstResponder];
        }
    }
}

@end
