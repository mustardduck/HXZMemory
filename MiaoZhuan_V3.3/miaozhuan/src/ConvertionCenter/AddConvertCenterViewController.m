//
//  AddConvertCenterViewController.m
//  miaozhuan
//
//  Created by Santiago on 14-11-15.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "AddConvertCenterViewController.h"
#import "GaoDeMapViewController.h"
#import "OwnManagerListViewController.h"
#import "SetConvertCenterViewController.h"
#import "AppUtils.h"

@interface AddConvertCenterViewController ()<UITextFieldDelegate, GetMapInformation, /*GetManagerIds, */YinYuanSelectExPointDelegate> {
    
    double _lng;
    double _lat;
    //选择日期BOOL
    BOOL _mondaySeleted;
    BOOL _tuesdaySeleted;
    BOOL _wednesdaySeleted;
    BOOL _thursdaySeleted;
    BOOL _fridaySeleted;
    BOOL _saturdaySeleted;
    BOOL _sundaySeleted;
}

@property (retain, nonatomic) IBOutlet UITextField *convertLocationField;
@property (retain, nonatomic) IBOutlet UITextField *mapLocationField;
@property (retain, nonatomic) IBOutlet UITextField *phoneNumberField;
@property (retain, nonatomic) IBOutlet UITextField *convertDateField;
@property (retain, nonatomic) IBOutlet UITextField *convertTimeField;
@property (retain, nonatomic) IBOutlet UITextField *convertManagers;

@property (strong, nonatomic) NSString* convertLocationName;
@property (strong, nonatomic) NSString* mapLocation;
@property (strong, nonatomic) NSString* phoneNumber;
@property (strong, nonatomic) NSMutableString *convertDate;
@property (strong, nonatomic) NSString* convertTime;

@property (retain, nonatomic) IBOutlet UIView *chooseConvertTimeView;

@property (retain, nonatomic) IBOutlet UIImageView *mondayCheckIcon;
@property (retain, nonatomic) IBOutlet UIImageView *tusedayCheckIcon;
@property (retain, nonatomic) IBOutlet UIImageView *wednesdayCheckIcon;
@property (retain, nonatomic) IBOutlet UIImageView *thursdayCheckIcon;
@property (retain, nonatomic) IBOutlet UIImageView *fridayCheckIcon;
@property (retain, nonatomic) IBOutlet UIImageView *saturdayCheckIcon;
@property (retain, nonatomic) IBOutlet UIImageView *sundayCheckIcon;
@property (strong, nonatomic) NSMutableArray *managersArray;
@property (strong, nonatomic) NSArray *oldManagersArray;

@property (nonatomic, retain) IBOutlet UIView   *view0;
@property (nonatomic, retain) IBOutlet UIView   *view1;

@property (retain, nonatomic) IBOutlet UIScrollView *mainScrollerView;
- (IBAction)mapBtn:(id)sender;
- (IBAction)timeBtn:(id)sender;
- (IBAction)mangerBtn:(id)sender;
@property (retain, nonatomic) IBOutlet UIView *blackVIew;

@end

@implementation AddConvertCenterViewController
@synthesize convertLocationField = _convertLocationField;
@synthesize mapLocationField = _mapLocationField;
@synthesize phoneNumberField = _phoneNumberField;
@synthesize convertDateField = _convertDateField;
@synthesize convertTimeField = _convertTimeField;
@synthesize chooseConvertTimeView = _chooseConvertTimeView;
@synthesize mondayCheckIcon = _mondayCheckIcon;
@synthesize tusedayCheckIcon = _tusedayCheckIcon;
@synthesize wednesdayCheckIcon = _wednesdayCheckIcon;
@synthesize thursdayCheckIcon = _thursdayCheckIcon;
@synthesize fridayCheckIcon = _fridayCheckIcon;
@synthesize saturdayCheckIcon = _saturdayCheckIcon;
@synthesize sundayCheckIcon = _sundayCheckIcon;
@synthesize convertManagers = _convertManagers;
@synthesize managersArray = _managersArray;
@synthesize convertDate = _convertDate;
@synthesize convertLocationName = _convertLocationName;
@synthesize mapLocation = _mapLocation;
@synthesize phoneNumber = _phoneNumber;
@synthesize convertTime = _convertTime;
@synthesize oldManagersArray = _oldManagersArray;
@synthesize mainScrollerView = _mainScrollerView;
MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setupMoveBackButton];
    [self setupMoveFowardButtonWithTitle:@"保存"];
    
    [self addDoneToKeyboard:_convertLocationField];
    [self addDoneToKeyboard:_phoneNumberField];
    [self addDoneToKeyboard:_convertTimeField];
    self.managersArray = WEAK_OBJECT(NSMutableArray, init);
    self.convertDate = WEAK_OBJECT(NSMutableString, init);
    if (self.style == EDIT_CONVERT_CENTER_ALREDY_HAVE) {
        //编辑模式
        ADAPI_GetConvertCenterInfo([self genDelegatorID:@selector(getConvertCenterInfo:)], self.convertCenterId);
        NSLog(@"%d",self.convertCenterId);
        [self setTitle:@"编辑兑换点"];
    }else {
        [self setTitle:@"增加兑换点"];
        self.convertCenterId = 0;
    }
    
    self.convertManagers.text = @"";
    
    [_view0 addSubview:[AppUtils LineView:0.f y:10.f]];
    [_view0 addSubview:[AppUtils LineView:85.0f y:62.0f]];
    [_view0 addSubview:[AppUtils LineView:85.0f y:112.f]];
    [_view0 addSubview:[AppUtils LineView:85.0f y:163.0f]];
    [_view0 addSubview:[AppUtils LineView:85.0f y:213.5f]];
    [_view0 addSubview:[AppUtils LineView:85.0f y:262.f]];
    [_view0 addSubview:[AppUtils LineView:0.f y:312.0f]];
    
    [_view1 addSubview:[AppUtils LineView:15.0f y:90.f]];
    [_view1 addSubview:[AppUtils LineView:15.0f y:136.f]];
    [_view1 addSubview:[AppUtils LineView:15.0f y:182.f]];
    [_view1 addSubview:[AppUtils LineView:15.0f y:228.f]];
    [_view1 addSubview:[AppUtils LineView:15.0f y:274.f]];
    [_view1 addSubview:[AppUtils LineView:15.0f y:320.f]];
}

- (void)getConvertCenterInfo:(DelegatorArguments*)arguments {
    
    DictionaryWrapper *wrapper = arguments.ret;
    
    if (wrapper.operationSucceed) {
        
        DictionaryWrapper *dataSource = wrapper.data;
        
        self.convertLocationField.text = [dataSource getString:@"Name"];
        self.convertLocationName = _convertLocationField.text;
        
        self.mapLocationField.text = [dataSource getString:@"DetailedAddress"];
        self.mapLocation = _mapLocationField.text;
        
        self.phoneNumberField.text = [dataSource getString:@"ContactNumber"];
        self.phoneNumber = _phoneNumberField.text;
        
        NSString *nstring = [dataSource getString:@"ExchangeTime"];
        NSArray *array = [nstring componentsSeparatedByString:@"#"];
        
        if ([array count] >= 2) {
            
            self.convertDateField.text = array[0];
            NSString *weekDayStr = array[0];
            
            if ([weekDayStr containsString:@"周一"]) {
                
                [_mondayCheckIcon setImage:[UIImage imageNamed:@"address_single_boxhover.png"]];
                _mondaySeleted = YES;
            }else {
            
                [_mondayCheckIcon setImage:[UIImage imageNamed:@"address_single_box.png"]];
                _mondaySeleted = NO;
            }
            
            if ([weekDayStr containsString:@"周二"]) {
                
                [_tusedayCheckIcon setImage:[UIImage imageNamed:@"address_single_boxhover.png"]];
                _tuesdaySeleted = YES;
            }else {
            
                [_tusedayCheckIcon setImage:[UIImage imageNamed:@"address_single_box.png"]];
                _tuesdaySeleted = NO;
            }
            
            if ([weekDayStr containsString:@"周三"]) {
                
                [_wednesdayCheckIcon setImage:[UIImage imageNamed:@"address_single_boxhover.png"]];
                _wednesdaySeleted = YES;
            }else {
            
                [_wednesdayCheckIcon setImage:[UIImage imageNamed:@"address_single_box.png"]];
                _wednesdaySeleted = NO;
            }
            
            if ([weekDayStr containsString:@"周四"]) {
                
                [_thursdayCheckIcon setImage:[UIImage imageNamed:@"address_single_boxhover.png"]];
                _thursdaySeleted = YES;
            }else {
            
                [_thursdayCheckIcon setImage:[UIImage imageNamed:@"address_single_box.png"]];
                _thursdaySeleted = NO;
            }
            
            if ([weekDayStr containsString:@"周五"]) {
                
                [_fridayCheckIcon setImage:[UIImage imageNamed:@"address_single_boxhover.png"]];
                _fridaySeleted = YES;
            }else {
            
                [_fridayCheckIcon setImage:[UIImage imageNamed:@"address_single_box.png"]];
                _fridaySeleted = NO;
            }
            
            if ([weekDayStr containsString:@"周六"]) {
                
                [_saturdayCheckIcon setImage:[UIImage imageNamed:@"address_single_boxhover.png"]];
                _saturdaySeleted = YES;
            }else {
            
                [_saturdayCheckIcon setImage:[UIImage imageNamed:@"address_single_box.png"]];
                _saturdaySeleted = NO;
            }
            
            if ([weekDayStr containsString:@"周日"]) {
                
                [_sundayCheckIcon setImage:[UIImage imageNamed:@"address_single_boxhover.png"]];
                _sundaySeleted = YES;
            }else {
            
                [_sundayCheckIcon setImage:[UIImage imageNamed:@"address_single_box.png"]];
                _sundaySeleted = YES;
            }
            
            self.convertTimeField.text = array[1];
            self.convertTime = array[1];
            self.convertDate = [NSMutableString stringWithString:array[0]];
        }
        
//        for (NSDictionary *dic in [dataSource getArray:@"ExchangeManagers"]) {
//            
//            if ([[dic wrapper] getString:@"Name"]) {
//                
//                self.convertManagers.text = @"已添加";
//            }
//        }
        
        self.managersArray = [NSMutableArray arrayWithArray:[dataSource getArray:@"ExchangeManagers"]];
        self.oldManagersArray = [NSMutableArray arrayWithArray:[dataSource getArray:@"ExchangeManagers"]];
        
        _lng = [dataSource getDouble:@"Lng"];
        _lat = [dataSource getDouble:@"Lat"];
        
    }else {
        
        [HUDUtil showErrorWithStatus:@"请求数据失败"];
    }
}

- (BOOL)canBecomeFirstResponder {
    
    return YES;
}

- (void)hiddenKeyboard {
    
    [_convertLocationField resignFirstResponder];
    [_phoneNumberField resignFirstResponder];
    [_convertTimeField resignFirstResponder];
}

- (void)viewWillAppear:(BOOL)animated {
    
    _chooseConvertTimeView.frame= CGRectMake(0, self.view.frame.size.height, _chooseConvertTimeView.frame.size.width, _chooseConvertTimeView.frame.size.height);
}

//检测号码是否合法
- (BOOL)checkPhoneNumber:(NSString*)string {
    
    NSString * regex        = @"(^[0-9]{7,8}$)";
    NSString * regex2       = @"(^[0-9]{10,12}$)";
    NSPredicate * pred      = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    NSPredicate * pred2     = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex2];
    BOOL isMatch            = [pred2 evaluateWithObject:string];
    BOOL isMatch2            = [pred evaluateWithObject:string];
    return isMatch||isMatch2;
}

//检测时间不包含#特殊字符
- (BOOL)checkConvertTime:(NSString*)string {
    
    if ([string rangeOfString:@"#"].location == NSNotFound) {
        
        return YES;
    }else {
        
        return NO;
    }
}

//检查数据是否完整
- (BOOL)checkInformationDataCompeleted {
    
    if (!_convertLocationName||[_convertLocationName isEqualToString:@""]) {
        
        [HUDUtil showErrorWithStatus:@"请填写兑换点名称"];
        return NO;
    }else if (!_mapLocation||[_mapLocation isEqualToString:@""]) {
        
        [HUDUtil showErrorWithStatus:@"请标记兑换点位置"];
        return NO;
    }else if (!_phoneNumber||[_phoneNumber isEqualToString:@""]) {
        
        [HUDUtil showErrorWithStatus:@"请填写联系电话"];
        return NO;
    }else if (![self checkPhoneNumber:_phoneNumberField.text]){
        
        [HUDUtil showErrorWithStatus:@"请填写正确的电话"];
        return NO;
    }else if (!_convertDate||[_convertDate isEqualToString:@""]) {
        
        [HUDUtil showErrorWithStatus:@"请设置兑换日期"];
        return NO;
    }else if (!_convertTime||[_convertTime isEqualToString:@""]) {
        
        [HUDUtil showErrorWithStatus:@"请设置详细兑换时间"];
        return NO;
    }else if(![self checkConvertTime:_convertTime]){
        
        [HUDUtil showErrorWithStatus:@"请勿兑换时间处填写'#'字符"];
        return NO;
    }else{
        
        return YES;
    }
}

//保存本兑换点并提交数据
- (IBAction)onMoveFoward:(UIButton *)sender {
    
    if ([self checkInformationDataCompeleted]) {
        
        WDictionaryWrapper* postDataDic = [WDictionaryWrapper wrapperFromDictionary:@{}];
        [self.convertDate appendString:[NSString stringWithFormat:@"#%@",_convertTime]];
        [postDataDic set:@"Id" string:[NSString stringWithFormat:@"%d",_convertCenterId]];
        [postDataDic set:@"EnterpriseId" string:[NSString stringWithFormat:@"%d",[EnterpriseInfo ID]]];
        [postDataDic set:@"Name" string:_convertLocationField.text];
        [postDataDic set:@"Lng" double:_lng];
        [postDataDic set:@"Lat" double:_lat];
        [postDataDic set:@"LocationType" string:@"2"];//坐标类型1 gps,2 baidu,3 google
        [postDataDic set:@"ContactNumber" string:_phoneNumberField.text];
        [postDataDic set:@"CompanyName" string:[EnterpriseInfo name]];
        [postDataDic set:@"DetailedAddress" string:_mapLocationField.text];
        [postDataDic set:@"ExchangeTime" string:_convertDate];
        //获取ID数组
        NSMutableArray *idsArray = WEAK_OBJECT(NSMutableArray, init);
        NSMutableArray *oldIdsArray = WEAK_OBJECT(NSMutableArray, init);
        
        //如果提交的号码相同，服务端未做处理，所以要加上这些判断
        for (NSDictionary *dic in _oldManagersArray) {
            
            DictionaryWrapper *wrapper = dic.wrapper;
            NSString *oldId = [wrapper getString:@"Id"];
            [oldIdsArray addObject:oldId];
        }
        
        for (int i = 0; i < [_managersArray count]; i++) {
            
            NSString *itemId = [[_managersArray[i] wrapper] getString:@"BusinessCardId"];
            if (itemId) {
                
                if (![oldIdsArray containsObject:itemId]) {
                    
                    [idsArray addObject:itemId];
                }
            }
        }
        
        [postDataDic set:@"ExchangeManagerCardIds" value:idsArray];
        ADAPI_AddAndEditConvertCenter([self genDelegatorID:@selector(addConvertCenterRequest:)],postDataDic.dictionary);
    }
}

- (void)addConvertCenterRequest:(DelegatorArguments*)arguments {
    
    DictionaryWrapper *wrapper = arguments.ret;
    
    if (wrapper.operationSucceed) {
        
        if(_isYinYuanProduct)
        {
            SetConvertCenterViewController * view = WEAK_OBJECT(SetConvertCenterViewController, init);
            
            view.delegate = self.yinYuanDelegate;
            
            view.isSelect = YES;
            
            view.isYinYuanProdCreate = YES;
            
            view.selectId = wrapper.data;
            
            [self.navigationController pushViewController:view animated:YES];
        }
        else
        {
            [self.delegate refreshListWithSelectId:wrapper.data];
            
            [self.navigationController popViewControllerAnimated:YES];
        }
        [HUDUtil showSuccessWithStatus:@"保存成功"];
    }else {
        
    }
}

#pragma -mark GetManagersIdsDelegate
- (void)getManagerIds:(NSArray*)array {
    
    self.managersArray = [NSMutableArray arrayWithArray:array];
    if ([_managersArray count] > 0) {
        
        self.convertManagers.text = @"已添加";
    }
}

#pragma -mark GaoDeMapDelegate
- (void)getLocation:(NSString*)string {
    
    _mapLocationField.text = string;
    self.mapLocation = _mapLocationField.text;
}

- (void)getLongitude:(double)longitude andLatitude:(double)latitude {
    
    _lng = longitude;
    _lat = latitude;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [_convertLocationField resignFirstResponder];;
    [_mapLocationField resignFirstResponder];
    [_phoneNumberField resignFirstResponder];
    [_convertDateField resignFirstResponder];
    [_convertTimeField resignFirstResponder];
    
    [UIView animateWithDuration:0.3 animations:^{
        _blackVIew.hidden = YES;
        _chooseConvertTimeView.frame = CGRectMake(0, self.view.frame.size.height, _chooseConvertTimeView.frame.size.width, _chooseConvertTimeView.frame.size.height);
    }];
    
    [self configDate];
    _convertDateField.text = _convertDate;
    
    [super touchesBegan:touches withEvent:event];
}

//取消
- (IBAction)cancelOfChooseConvertTimeView:(id)sender {
    
    [UIView animateWithDuration:0.3 animations:^{
        _blackVIew.hidden = YES;
        _chooseConvertTimeView.frame = CGRectMake(0, self.view.frame.size.height, _chooseConvertTimeView.frame.size.width, _chooseConvertTimeView.frame.size.height);
    }];
    [_chooseConvertTimeView resignFirstResponder];
}
//保存
- (IBAction)saveOfChooseConvertTimeVIew:(id)sender {
    
    [UIView animateWithDuration:0.3 animations:^{
        
        _blackVIew.hidden = YES;
        _chooseConvertTimeView.frame = CGRectMake(0, self.view.frame.size.height, _chooseConvertTimeView.frame.size.width, _chooseConvertTimeView.frame.size.height);
    }];
    [self configDate];
    _convertDateField.text = _convertDate;
    
    [_chooseConvertTimeView resignFirstResponder];
}

- (void)configDate {
    [self.convertDate setString:@""];
    
    if(_mondaySeleted){
        
        [self.convertDate appendString:@" 周一"];
    }
    if(_tuesdaySeleted){
        
        [self.convertDate appendString:@" 周二"];
    }
    if(_wednesdaySeleted){
        
        [self.convertDate appendString:@" 周三"];
    }
    if(_thursdaySeleted){
        
        [self.convertDate appendString:@" 周四"];
    }
    if(_fridaySeleted){
        
        [self.convertDate appendString:@" 周五"];
    }
    if(_saturdaySeleted){
        
        [self.convertDate appendString:@" 周六"];
    }
    if(_sundaySeleted){
        
        [self.convertDate appendString:@" 周日"];
    }
}

- (IBAction)weekDayClicked:(UIButton *)sender {
    
    switch (sender.tag) {
        case 1:
            if (_mondaySeleted) {
                
                [_mondayCheckIcon setImage:[UIImage imageNamed:@"address_single_box.png"]];
            }else {
                
                [_mondayCheckIcon setImage:[UIImage imageNamed:@"address_single_boxhover.png"]];
            }
            _mondaySeleted = !_mondaySeleted;
            break;
        case 2:
            if (_tuesdaySeleted) {
                
                [_tusedayCheckIcon setImage:[UIImage imageNamed:@"address_single_box.png"]];
            }else {
                
                [_tusedayCheckIcon setImage:[UIImage imageNamed:@"address_single_boxhover.png"]];
            }
            _tuesdaySeleted = !_tuesdaySeleted;
            break;
        case 3:
            if (_wednesdaySeleted) {
                
                [_wednesdayCheckIcon setImage:[UIImage imageNamed:@"address_single_box.png"]];
            }else {
                
                [_wednesdayCheckIcon setImage:[UIImage imageNamed:@"address_single_boxhover.png"]];
            }
            _wednesdaySeleted = !_wednesdaySeleted;
            break;
        case 4:
            if (_thursdaySeleted) {
                
                [_thursdayCheckIcon setImage:[UIImage imageNamed:@"address_single_box.png"]];
            }else {
                
                [_thursdayCheckIcon setImage:[UIImage imageNamed:@"address_single_boxhover.png"]];
            }
            _thursdaySeleted = !_thursdaySeleted;
            break;
        case 5:
            if (_fridaySeleted) {
                
                [_fridayCheckIcon setImage:[UIImage imageNamed:@"address_single_box.png"]];
            }else {
                
                [_fridayCheckIcon setImage:[UIImage imageNamed:@"address_single_boxhover.png"]];
            }
            _fridaySeleted = !_fridaySeleted;
            break;
        case 6:
            if (_saturdaySeleted) {
                
                [_saturdayCheckIcon setImage:[UIImage imageNamed:@"address_single_box.png"]];
            }else {
                
                [_saturdayCheckIcon setImage:[UIImage imageNamed:@"address_single_boxhover.png"]];
            }
            _saturdaySeleted = !_saturdaySeleted;
            break;
        case 7:
            if (_sundaySeleted) {
                
                [_sundayCheckIcon setImage:[UIImage imageNamed:@"address_single_box.png"]];
            }else {
                
                [_sundayCheckIcon setImage:[UIImage imageNamed:@"address_single_boxhover.png"]];
            }
            _sundaySeleted = !_sundaySeleted;
            break;
        default:
            break;
    }
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    switch (textField.tag) {
        case 1:
            
            return YES;
            
        case 3:
            return YES;
       
        case 5:
            
            [UIView animateWithDuration:0.25 animations:^{
                [self.mainScrollerView setContentOffset:CGPointMake(0,150)];
            }];
            return YES;
            
        default:
            break;
    }
    return NO;
}


- (IBAction)mapBtn:(id)sender
{
    GaoDeMapViewController* mapViewController = WEAK_OBJECT(GaoDeMapViewController, init);
    mapViewController.delegate = self;
    mapViewController.typeName = @"ConvertCenterMap";
    [mapViewController bd_decrypt:_lat andLon:_lng];
    [self.navigationController pushViewController:mapViewController animated:YES];
}

- (IBAction)timeBtn:(id)sender
{
    //选择接受兑换时间
    [UIView animateWithDuration:0.3 animations:^{
        _blackVIew.hidden = NO;
        _chooseConvertTimeView.frame = CGRectMake(0, self.view.frame.size.height - _chooseConvertTimeView.frame.size.height, _chooseConvertTimeView.frame.size.width, _chooseConvertTimeView.frame.size.height);
    }];
    
    [_convertLocationField resignFirstResponder];;
    [_mapLocationField resignFirstResponder];
    [_phoneNumberField resignFirstResponder];
    [_convertDateField resignFirstResponder];
    [_convertTimeField resignFirstResponder];
    [_chooseConvertTimeView becomeFirstResponder];
}

- (IBAction)mangerBtn:(id)sender
{
    PUSH_VIEWCONTROLLER(OwnManagerListViewController);
//    model.delegate = self;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    switch (textField.tag) {
            
        case 1:
            
            self.convertLocationName = _convertLocationField.text;
            break;
            
        case 2:
            
            self.mapLocation = _mapLocationField.text;
            break;
            
        case 3:
            
            self.phoneNumber = _phoneNumberField.text;
            break;
            
        case 4:
            break;
            
        case 5:
            
            self.convertTime = _convertTimeField.text;
            [UIView animateWithDuration:0.25 animations:^{
                [self.mainScrollerView setContentOffset:CGPointMake(0,0)];
            }];
            break;
            
        case 6:
            break;
        default:
            break;
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NSString * aString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    switch (textField.tag) {
            
        case 1:{
            if ([aString length] > 20) {
                textField.text = [aString substringToIndex:20];
                [HUDUtil showErrorWithStatus:@"最多可填20个字符"];
                return NO;
            }
            break;
        }
        case 2:
            
            break;
        case 3:{
            if ([aString length] > 11) {
                textField.text = [aString substringToIndex:12];
                if ([aString length] > 12) {
                    
                    [HUDUtil showErrorWithStatus:@"最多可输入12位"];
                }
                return NO;
            }
        }
            break;
        case 4:
            break;
        case 5:
            
            break;
        case 6:
            
            break;
            
        default:
            break;
    }
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)dealloc {
    
    [_oldManagersArray release];
    [_managersArray release];
    [_convertTime release];
    [_phoneNumber release];
    [_mapLocation release];
    [_convertLocationName release];
    [_convertDate release];
    [_convertLocationField release];
    [_mapLocationField release];
    [_phoneNumberField release];
    [_convertDateField release];
    [_convertTimeField release];
    [_chooseConvertTimeView release];
    [_mondayCheckIcon release];
    [_tusedayCheckIcon release];
    [_wednesdayCheckIcon release];
    [_thursdayCheckIcon release];
    [_fridayCheckIcon release];
    [_saturdayCheckIcon release];
    [_sundayCheckIcon release];
    [_convertManagers release];
    [_view0 release];
    [_view1 release];
    self.delegate = nil;
    [_mainScrollerView release];
    [_blackVIew release];
    [super dealloc];
}

@end
