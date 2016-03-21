//
//  ApplyToBeMerchantStep1.m
//  miaozhuan
//
//  Created by Santiago on 14-11-4.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "ApplyToBeMerchantStep1.h"
#import "ApplyToBeMerchantStep2.h"
#import "PickerViewSelfDefined.h"
#import "GaoDeMapViewController.h"
#import "CRInfoNotify.h"
#import "RRLineView.h"

@interface ApplyToBeMerchantStep1 ()<PickerViewSelfDefineDelegate, UITextFieldDelegate, GetMapInformation> {
    
    int _provinceRegion;
    int _cityRegion;
    int _areaRegion;
    
    double _longitude;
    double _latitude;
    
    int _numberOfPickerView;
}

@property (strong, nonatomic) NSArray *locationDataSource;
@property (strong, nonatomic) PickerViewSelfDefined *locatePicker;

@property (strong, nonatomic) NSString *merchantName;
@property (strong, nonatomic) NSString *merchantPhoneNumber;
@property (strong, nonatomic) NSString *merchantLocationSum;
@property (strong, nonatomic) NSString *merchantLocationDetail;
@property (strong, nonatomic) NSString *merchantLocationOnTheMap;
@property (strong, nonatomic) NSString *enterpriseId;

@property (retain, nonatomic) IBOutlet UITextField *merchantNameField;
@property (retain, nonatomic) IBOutlet UITextField *merchantPhoneNumberField;
@property (retain, nonatomic) IBOutlet UITextField *merchantLocationField;
@property (retain, nonatomic) IBOutlet UITextField *merchantLocationDetailField;
@property (retain, nonatomic) IBOutlet UITextField *mapLocationField;
@property (retain, nonatomic) IBOutlet UIView *frontView;

@property (strong, nonatomic) ApplyToBeMerchantStep2 *step2;

@property (strong, nonatomic) CRInfoNotify *nameErrorBubble;
@property (strong, nonatomic) CRInfoNotify *telErrorBubble;
@property (strong, nonatomic) CRInfoNotify *addressErrorBubble;

@property (retain, nonatomic) IBOutlet UIScrollView *mainScrollerView;
@property (retain, nonatomic) IBOutlet UIView *topReasonView;
@property (retain, nonatomic) IBOutlet UILabel *reasonLbl;
@property (retain, nonatomic) IBOutlet UIView *firstMainView;
@property (retain, nonatomic) IBOutlet RRLineView *topReasonLine;

@end

@implementation ApplyToBeMerchantStep1

@synthesize merchantNameField = _merchantNameField;
@synthesize merchantPhoneNumberField = _merchantPhoneNumberField;
@synthesize merchantLocationField = _merchantLocationField;
@synthesize merchantLocationDetailField = _merchantLocationDetailField;
@synthesize mapLocationField = _mapLocationField;
@synthesize frontView = _frontView;
@synthesize merchantName = _merchantName;
@synthesize merchantPhoneNumber = _merchantPhoneNumber;
@synthesize merchantLocationSum = _merchantLocationSum;
@synthesize merchantLocationDetail = _merchantLocationDetail;
@synthesize merchantLocationOnTheMap = _merchantLocationOnTheMap;
@synthesize locatePicker = _locatePicker;
@synthesize editStatement = _editStatement;
@synthesize step2 = _step2;
@synthesize nameErrorBubble = _nameErrorBubble;
@synthesize telErrorBubble = _telErrorBubble;
@synthesize addressErrorBubble = _addressErrorBubble;
@synthesize enterpriseId = _enterpriseId;
@synthesize locationDataSource = _locationDataSource;
@synthesize mainScrollerView = _mainScrollerView;

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad {

    [super viewDidLoad];
    
    [self setupMoveBackButton];
    [self setTitle:@"申请商家(1/2)"];
    [self setupMoveFowardButtonWithTitle:@"下一步"];
    
    [self addDoneToKeyboard:_merchantNameField];
    [self addDoneToKeyboard:_merchantPhoneNumberField];
    [self addDoneToKeyboard:_merchantLocationDetailField];
    
    self.step2 = WEAK_OBJECT(ApplyToBeMerchantStep2, init);
    self.step2.postData = WEAK_OBJECT(WDictionaryWrapper, init);
    self.enterpriseId = @"0";
    if (_editStatement == 1) {
        
        ADAPI_GetMerchantBasicInfoToRepost([self genDelegatorID:@selector(oldMerchantInfo:)]);
    }
    _numberOfPickerView = 0;
}

- (void)oldMerchantInfo:(DelegatorArguments*)arguments {

    DictionaryWrapper *wrapper = arguments.ret;

    if (wrapper.operationSucceed) {
        
        DictionaryWrapper *dataSource = wrapper.data;
        
        [APP_DELEGATE.runtimeConfig set:RUNTIME_USER_LOGIN_INFO".IFEDITED" int:0];
        
        self.step2.oldData = [WDictionaryWrapper wrapperFromDictionary:dataSource.dictionary];
        self.step2.editStatement = _editStatement;
        
        self.enterpriseId = [dataSource getString:@"EnterpriseId"];
        
        self.merchantNameField.text = [dataSource getString:@"Name"];
        self.merchantName = _merchantNameField.text;
        
        self.merchantPhoneNumberField.text = [dataSource getString:@"Tel"];
        self.merchantPhoneNumber = _merchantPhoneNumberField.text;
        
        self.merchantLocationField.text = [NSString stringWithFormat:@"%@%@%@",[dataSource getString:@"Province"],[dataSource getString:@"City"],[dataSource getString:@"District"]];
        self.merchantLocationSum = _merchantLocationField.text;
        
        self.merchantLocationDetailField.text = [dataSource getString:@"Address"];
        self.merchantLocationDetail = _merchantLocationDetailField.text;
        
        _provinceRegion = [dataSource getInt:@"ProvinceId"];
        _cityRegion = [dataSource getInt:@"CityId"];
        _areaRegion = [dataSource getInt:@"DistrictId"];
        
        _longitude = [dataSource getDouble:@"Lng"];
        _latitude = [dataSource getDouble:@"Lat"];
        
        self.mapLocationField.text = @"已定位";
        
        DictionaryWrapper *errors = [dataSource getDictionaryWrapper:@"AuditMessages"];
        
        if ([errors getString:@"NameErrmsg"]) {
            
            self.nameErrorBubble = WEAK_OBJECT(CRInfoNotify, initWith:[errors getString:@"NameErrmsg"] at:CGPointMake(298, 20));
            [self.frontView addSubview:_nameErrorBubble];
            self.merchantNameField.textColor = [UIColor redColor];
            [APP_DELEGATE.runtimeConfig set:RUNTIME_USER_LOGIN_INFO".CREATMERCHANTNAMEERROR" int:1];
        }
        
        if ([errors getString:@"TelErrmsg"]) {

            self.telErrorBubble = WEAK_OBJECT(CRInfoNotify, initWith:[errors getString:@"TelErrmsg"] at:CGPointMake(298, 71));
            [self.frontView addSubview:_telErrorBubble];
            self.merchantPhoneNumberField.textColor = [UIColor redColor];
            [APP_DELEGATE.runtimeConfig set:RUNTIME_USER_LOGIN_INFO".CREATMERCHANTTELERROR" int:1];
        }
        
        if ([errors getString:@"AddressErrmsg"]) {
            
            self.addressErrorBubble = WEAK_OBJECT(CRInfoNotify, initWith:[errors getString:@"AddressErrmsg"] at:CGPointMake(298, 168));
            [self.frontView addSubview:_addressErrorBubble];
            self.merchantLocationDetailField.textColor = [UIColor redColor];
            [APP_DELEGATE.runtimeConfig set:RUNTIME_USER_LOGIN_INFO".CREATMERCHANTADDRESSERROR" int:1];
        }
        
        NSString * topReason = [errors getString:@"OtherErrmsg"];
        
//         NSString * topReason = @"测试测试测试测试";
        
        if(topReason.length > 0)
        {
            _topReasonView.hidden = NO;
            
            _reasonLbl.text = topReason;
            
            CGSize textSize = [UICommon getSizeFromString:topReason
                                                 withSize:CGSizeMake(_reasonLbl.width, MAXFLOAT)
                                                 withFont:14];
            _reasonLbl.height = textSize.height < 30 ? 30 : textSize.height;
            
            _topReasonView.height = _reasonLbl.bottom + 15;
            
            _topReasonLine.top = _topReasonView.height - 0.5;
            
            _firstMainView.top = _topReasonView.bottom + 10;
        }
  
    }else {
    
        [HUDUtil showWithStatus:wrapper.operationMessage];
    }
}

- (void)allTextResign {
    
    [_merchantNameField resignFirstResponder];
    [_merchantPhoneNumberField resignFirstResponder];
    [_merchantLocationField resignFirstResponder];
    [_merchantLocationDetailField resignFirstResponder];
    [_mapLocationField resignFirstResponder];
}

- (void)hiddenKeyboard {

    [_merchantNameField resignFirstResponder];
    [_merchantPhoneNumberField resignFirstResponder];
    [_merchantLocationDetailField resignFirstResponder];
}

- (void)handleRegionList:(DelegatorArguments*)arguments {

    DictionaryWrapper *wrapper = arguments.ret;
    if (wrapper.operationSucceed) {

        self.locationDataSource = wrapper.data;
        
        [APP_DELEGATE.runtimeConfig set:RUNTIME_USER_LOGIN_INFO".LocationArray" value:_locationDataSource];
        
        if (_numberOfPickerView == 0) {
            
            _numberOfPickerView++;
            self.locatePicker = STRONG_OBJECT(PickerViewSelfDefined, initPickerWithDelegate:self name:THREELEVEL userData:_merchantLocationField.text array:_locationDataSource);
            [self allTextResign];
            [_locatePicker showInView:self.view];
            [_locatePicker release];
            self.locatePicker = nil;
        }
    }else{
        
        [HUDUtil showErrorWithStatus:wrapper.operationMessage];
    }
}

#pragma mark - GaodeMapDelegate
- (void)getLocation:(NSString*)string {
    
    if (string) {
        
        [_mapLocationField setText:@"已定位"];
    }
    self.merchantLocationOnTheMap = _mapLocationField.text;
}

- (void)getLongitude:(double)longitude andLatitude:(double)latitude {

    _longitude = longitude;
    _latitude = latitude;
    
    NSLog(@"%f", _longitude);
    NSLog(@"%f", _latitude);
    
}

#pragma mark - pickerdelegate
- (void)pickerDidChangeContent:(PickerViewSelfDefined *)picker {
    
    _merchantLocationField.text = [NSString stringWithFormat:@"%@ %@ %@", picker.locate.state, picker.locate.city, picker.locate.district];
    self.merchantLocationSum = _merchantLocationField.text;
    
    _provinceRegion = [picker.locate.stateData getInt:@"RegionId"];
    _cityRegion = [picker.locate.cityData getInt:@"RegionId"];
    _areaRegion = [picker.locate.districtData getInt:@"RegionId"];
}

- (void)pickerClearContent:(PickerViewSelfDefined *)picker {

    _merchantLocationField.text = picker.userData;
}

- (void)endOperating {

    _numberOfPickerView--;
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {

    switch (textField.tag) {
        case 1:
            
            self.nameErrorBubble.hidden = YES;
            self.merchantNameField.textColor = [UIColor blackColor];
            return YES;
        case 2:
            
            self.telErrorBubble.hidden = YES;
            self.merchantPhoneNumberField.textColor = [UIColor blackColor];
            return YES;
        case 3:{
            
            if ([[APP_DELEGATE.runtimeConfig getArray:RUNTIME_USER_LOGIN_INFO".LocationArray"] count] > 0) {
                
                self.locationDataSource = [APP_DELEGATE.runtimeConfig getArray:RUNTIME_USER_LOGIN_INFO".LocationArray"];
                
                NSLog(@"the number of picker view is%d", _numberOfPickerView);
                if (_numberOfPickerView == 0) {
                    
                    _numberOfPickerView++;
                    self.locatePicker = STRONG_OBJECT(PickerViewSelfDefined, initPickerWithDelegate:self name:THREELEVEL userData:_merchantLocationField.text array:_locationDataSource);
                    [self allTextResign];
                    [_locatePicker showInView:self.view];
                    [_locatePicker release];
                    self.locatePicker = nil;
                }
            }else {
            
                ADAPI_RegionGetAllBaiduRegionList([self genDelegatorID:@selector(handleRegionList:)]);
            }
            return NO;
        }
        case 4:
            
            self.addressErrorBubble.hidden = YES;
            self.merchantLocationDetailField.textColor = [UIColor blackColor];
            [UIView animateWithDuration:0.3 animations:^{
                
                [self.mainScrollerView setContentOffset:CGPointMake(0, 30)];
            }];

            return YES;
        case 5:{
            
            GaoDeMapViewController* mapViewController = WEAK_OBJECT(GaoDeMapViewController, init);
            mapViewController.delegate = self;
            if (_latitude||_longitude) {
            
                [mapViewController bd_decrypt:_latitude andLon:_longitude];
            }
            [self.navigationController pushViewController:mapViewController animated:YES];
            return NO;
        }
            
        default:
            break;
    }
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {

    switch (textField.tag) {
            
        case 1:
            self.merchantName = textField.text;
            [APP_DELEGATE.runtimeConfig set:RUNTIME_USER_LOGIN_INFO".CREATMERCHANTNAMEERROR" int:0];
            [APP_DELEGATE.runtimeConfig set:RUNTIME_USER_LOGIN_INFO".EnterpriseName" string:textField.text];
            break;
        
        case 2:
            self.merchantPhoneNumber = textField.text;
            [APP_DELEGATE.runtimeConfig set:RUNTIME_USER_LOGIN_INFO".CREATMERCHANTTELERROR" int:0];
            break;
        
        case 3:
            self.merchantLocationSum = textField.text;
            break;
        
        case 4:
            self.merchantLocationDetail = textField.text;
            [APP_DELEGATE.runtimeConfig set:RUNTIME_USER_LOGIN_INFO".CREATMERCHANTADDRESSERROR" int:0];
            
            [UIView animateWithDuration:0.3 animations:^{
                
                [self.mainScrollerView setContentOffset:CGPointMake(0, 0)];
            }];
            
            break;
        
        case 5:
            self.merchantLocationOnTheMap = textField.text;
            break;
        default:
            break;
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {

    NSString * aString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    switch (textField.tag) {
        case 1:{
            if ([aString length] > 40) {
                textField.text = [aString substringToIndex:40];
                [HUDUtil showErrorWithStatus:@"最多可填40个字符"];
                return NO;
            }
            break;
        }
        case 2:{
            if ([aString length] > 11) {
                textField.text = [aString substringToIndex:12];
                [HUDUtil showErrorWithStatus:@"最多可输入12位"];
                return NO;
            }
            break;
        }
        case 3:
            
            break;
        case 4:{
            if ([aString length] > 30) {
                textField.text = [aString substringToIndex:30];
                [HUDUtil showErrorWithStatus:@"最多可输入30个字"];
                return NO;
            }
            break;
        }
        case 5:
            
            break;
            
        default:
            break;
    }
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self allTextResign];
    [super touchesBegan:touches withEvent:event];
}

- (WDictionaryWrapper*)configDicForNextStep {

    WDictionaryWrapper *wrapper = WEAK_OBJECT(WDictionaryWrapper, init);
    
    [wrapper set:@"EnterpriseId" string:_enterpriseId];
    [wrapper set:@"Name" string:_merchantName];
    [wrapper set:@"Tel" string:_merchantPhoneNumber];
    [wrapper set:@"ProvinceId" string:[NSString stringWithFormat:@"%d",_provinceRegion]];
    [wrapper set:@"CityId" string:[NSString stringWithFormat:@"%d",_cityRegion]];
    [wrapper set:@"DistrictId" string:[NSString stringWithFormat:@"%d",_areaRegion]];
    [wrapper set:@"Address" string:_merchantLocationDetail];
    [wrapper set:@"Lng" string:[NSString stringWithFormat:@"%f",_longitude]];
    [wrapper set:@"Lat" string:[NSString stringWithFormat:@"%f",_latitude]];
    return wrapper;
}

//下一步
- (void)onMoveFoward:(UIButton *)sender {

    if ([self checkInformationCompeleted]) {
    
        [self.step2.postData setDictionary:[self configDicForNextStep].dictionary];
        [self.navigationController pushViewController:_step2 animated:YES];
    }
}

//判断用户信息是否完整
- (BOOL)checkInformationCompeleted {
    
    if ([_merchantName isEqualToString:@""]||!_merchantName) {
        
        [HUDUtil showErrorWithStatus:@"请填写商家名称"];
        return NO;
    }else if (_merchantPhoneNumber.length > 40){
        
        [HUDUtil showErrorWithStatus:@"商家名称最多可填40个字"];
        return NO;
    }
    else if ([_merchantPhoneNumber isEqualToString:@""]||!_merchantPhoneNumber){
        
        [HUDUtil showErrorWithStatus:@"请填写联系电话"];
        return NO;
    }else if (_merchantPhoneNumber.length > 12){
        
        [HUDUtil showErrorWithStatus:@"联系电话最多输入12位"];
        return NO;
    }
    else if(![self checkPhoneNumberCorrect:_merchantPhoneNumber]){
        
        [HUDUtil showErrorWithStatus:@"请填写正确的联系电话"];
        return NO;
    }else if ([_merchantLocationSum isEqualToString:@""]||!_merchantLocationSum){
        
        [HUDUtil showErrorWithStatus:@"请选择省市区"];
        return NO;
    }else if ([_merchantLocationDetail isEqualToString:@""]||!_merchantLocationDetail){
        
        [HUDUtil showErrorWithStatus:@"请填写详细街道地址"];
        return NO;
    }
    else if (_merchantLocationDetail.length > 30){
        
        [HUDUtil showErrorWithStatus:@"街道地址最多可填30个字"];
        return NO;
    }else if (!_longitude||!_latitude){
        
        [HUDUtil showErrorWithStatus:@"请在地图上标记商家位置"];
        return NO;
    }
//    else
//    {
//        
//        if ([APP_DELEGATE.runtimeConfig getInt:RUNTIME_USER_LOGIN_INFO".CREATMERCHANTNAMEERROR"] == 1) {
//            
//            [HUDUtil showErrorWithStatus:@"请修改商家名称！"];
//            return NO;
//        }
//        
//        if ([APP_DELEGATE.runtimeConfig getInt:RUNTIME_USER_LOGIN_INFO".CREATMERCHANTTELERROR"] == 1) {
//            
//            [HUDUtil showErrorWithStatus:@"请修改商家电话！"];
//            return NO;
//        }
//        
//        if ([APP_DELEGATE.runtimeConfig getInt:RUNTIME_USER_LOGIN_INFO".CREATMERCHANTADDRESSERROR"] == 1) {
//            
//            [HUDUtil showErrorWithStatus:@"请修改商家地址！"];
//            return NO;
//        }
        return YES;
//    }
}

//使用正则表达式判断电话号码是否为7/8/10/11位的数字
- (BOOL)checkPhoneNumberCorrect:(NSString*)string {
    
    NSString * regex        = @"(^[0-9]{7,8}$)";
    NSString * regex1       = @"(^[0-9]{10,12}$)";
    NSPredicate * pred      = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    NSPredicate * pred1     = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex1];
    BOOL isMatch            = [pred evaluateWithObject:string];
    BOOL isMatch1           = [pred1 evaluateWithObject:string];
    return isMatch||isMatch1;
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    
    _merchantLocationField.delegate = nil;
    _mapLocationField.delegate = nil;
    [_enterpriseId release];
    [_nameErrorBubble release];
    [_telErrorBubble release];
    [_addressErrorBubble release];
    [_step2 release];
    [_merchantLocationOnTheMap release];
    [_merchantLocationSum release];
    [_merchantLocationDetail release];
    [_merchantLocationField release];
    [_mapLocationField release];
    [_merchantPhoneNumber release];
    [_merchantMapLocation release];
    [_merchantName release];
    [_merchantNameField release];
    [_merchantPhoneNumberField release];
    [_merchantLocationDetailField release];
    [_frontView release];
    [_locationDataSource release];
    [_mainScrollerView release];
    [_topReasonView release];
    [_reasonLbl release];
    [_firstMainView release];
    [_topReasonLine release];
    [super dealloc];
}
@end
