//
//  PickerViewSelfDefined.m
//  miaozhuan
//
//  Created by Santiago on 14-11-5.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "PickerViewSelfDefined.h"
#import <QuartzCore/QuartzCore.h>

@class ApplyToBeMerchantStep1;
@interface PickerViewSelfDefined(){

    NSMutableArray * _provinces;
    NSArray *_cities, *_areas;
}
@property (strong, nonatomic)NSArray *selfDefinedArray;
@property (strong, nonatomic)NSArray *normalStyleArray;
@property (strong, nonatomic)UIView *backgroundView;
@end

@implementation PickerViewSelfDefined

@synthesize locate = _locate;
@synthesize locatePicker = _locatePicker;
@synthesize delegate = _delegate;
@synthesize selfDefinedArray = _selfDefinedArray;
@synthesize backgroundView = _backgroundView;
@synthesize normalStyleArray = _normalStyleArray;

//一次遍历配置数组元素中的子数组
- (void)configArray:(NSArray*)array {
    
    _provinces = [[NSMutableArray alloc] init];
    
    NSMutableSet*             provincesSet = WEAK_OBJECT(NSMutableSet, init);
    NSMutableArray*       regionDatasArray = WEAK_OBJECT(NSMutableArray, initWithArray:@[@""]);
    WDictionaryWrapper*             id2idx = WEAK_OBJECT(WDictionaryWrapper, init);
    
    for(NSDictionary* item in array) {
        
        DictionaryWrapper* dic = item.wrapper;
        
        // 1 Check self data
        NSString* selfID = [dic getString:@"RegionId"];
        int selfIdx = 0;
        
        WDictionaryWrapper* selfData = nil;
        selfData = WEAK_OBJECT(WDictionaryWrapper, init);
        
        [selfData set:@"data" value:item];
        [selfData set:@"subRegins" value:WEAK_OBJECT(NSMutableArray, init)];
        
        selfIdx = (int)regionDatasArray.count;
        [regionDatasArray addObject:selfData];
        
        [id2idx set:selfID int:selfIdx];
        
        // 2 Check parent data
        NSString* parentID  = [dic getString:@"ParentId"];
        if(parentID.length == 0 || [parentID isEqualToString:@"0"]) {
            
            [provincesSet addObject:@(selfIdx)];
            continue;
        }
        
        int parentIdx = [id2idx getInt:parentID];
        
        WDictionaryWrapper* parentData = nil;
        
        if(parentIdx == 0) {
            
            parentData = WEAK_OBJECT(WDictionaryWrapper, init);
            
            [parentData set:@"subRegins" value:WEAK_OBJECT(NSMutableArray, init)];
            
            parentIdx = (int)regionDatasArray.count;
            
            [regionDatasArray addObject:parentData];
            
            [id2idx set:parentID int:parentIdx];
            
        }else {
            
            parentData = regionDatasArray[parentIdx];
        }
        
        // 3 Link with parent data
        [(NSMutableArray*)[parentData getArray:@"subRegins"] addObject:selfData];
    }
    
    for(NSNumber* idx in provincesSet) {
        
        [_provinces addObject:regionDatasArray[idx.intValue]];
    }
}

//省市区样式
- (id)initPickerWithDelegate:(id<PickerViewSelfDefineDelegate>)delegate DataSource:(NSArray *)array {
    
    self = [[[NSBundle mainBundle] loadNibNamed:@"PickerViewSelfDefined" owner:self options:nil][0] retain];
    
    if (self) {
        
        self.delegate = delegate;
        [self configArray:array];
        
        if ([_provinces count]>0) {
            
        _cities = [_provinces[0]getArray:@"subRegins"];
        _areas = [_cities[0]getArray:@"subRegins"];
        
        self.locate.state = [_provinces[0] getString:@"data.Name"];
        self.locate.city = [_cities[0] getString:@"data.Name"];
        self.locate.district = [_areas[0] getString:@"data.Name"];
                        
        self.locate.stateData = [[_provinces[0] getDictionary:@"data"] wrapper];
        self.locate.cityData = [[_cities[0] getDictionary:@"data"] wrapper];
        self.locate.districtData = [[_areas[0] getDictionary:@"data"] wrapper];

            if([self.delegate respondsToSelector:@selector(pickerDidChangeContent:)]) {
                [self.delegate pickerDidChangeContent:self];
            }
            
        }else {
        
            [HUDUtil showErrorWithStatus:@"获取地址列表失败，请检查网络!"];
        }
    }
    return self;
}

//自定义样式
- (id)initSelfDefinedPickerWithDelegate:(id<PickerViewSelfDefineDelegate>)delegate DataSource:(NSArray*)array {
    
    self = [[[NSBundle mainBundle] loadNibNamed:@"PickerViewSelfDefined" owner:self options:nil][0] retain];
    if (self) {
        self.delegate = delegate;
        self.selfDefinedArray = array;
        
        self.locate.state = [_provinces[0] getString:@"data.Name"];
        self.locate.city = [_cities[0] getString:@"data.Name"];
        self.locate.district = [_areas[0] getString:@"data.Name"];
        
        self.locate.stateData = [[_provinces[0] getDictionary:@"data"] wrapper];
        self.locate.cityData = [[_cities[0] getDictionary:@"data"] wrapper];
        self.locate.districtData = [[_areas[0] getDictionary:@"data"] wrapper];
        
        self.selfDefinedArray = @[@"全国榜",@"省级榜",@"市级榜",@"区级榜"];
    }
    return self;
}

//普通样式
- (id)initNormalStylePickerWithDelegate:(id<PickerViewSelfDefineDelegate>)delegate dataSource:(NSArray*)array {

    self = [[[NSBundle mainBundle] loadNibNamed:@"PickerViewSelfDefined" owner:self options:nil][0] retain];
    if (self) {

        self.delegate = delegate;
        self.normalStyleArray = array;
    }
    return self;
}

- (id)initPickerWithDelegate:(id <PickerViewSelfDefineDelegate>)delegate name:(PickerIdentify)name userData:(id)userData array:(NSArray *)array {
    
    if (name == 1||name == 2||name == 3) {
        
        self = [self initPickerWithDelegate:delegate DataSource:array];
    }else if(name == 4){
        
        self = [self initSelfDefinedPickerWithDelegate:delegate DataSource:array];
    }else {
    
        self = [self initNormalStylePickerWithDelegate:delegate dataSource:array];
    }
    self.name = name;
    self.userData = userData;
    return self;
}

-(MerchantLocation *)locate {
    
    if (_locate == nil) {
        _locate = [[MerchantLocation alloc] init];
    }
    return _locate;
}

#pragma mark - PickerView lifeCycle

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    switch (self.name) {
        case 1:
            return 1;
        case 2:
            return 2;
        case 3:
            return 3;
        case 4:
            return 1;
        case 5:
            return 1;
        default:
            break;
    }
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {

    if (self.name == 3) {
        
        switch (component) {
                
            case 0:
                return [_provinces count];
                
            case 1:
                return [_cities count];
                
            case 2:
                return [_areas count];
                
            default:
                return 0;
        }
    }else if(self.name == 2) {
        
        switch (component) {
                
            case 0:
                return [_provinces count];
                
            case 1:
                return [_cities count];
                
            default:
                return 0;
        }
    }else if(self.name == 1){
    
        switch (component) {
                
            case 0:
                return [_provinces count];
                
            default:
                return 0;
        }
    }else if(self.name == 4){
        switch (component) {
                
            case 0:
                return [_selfDefinedArray count];
                
            default:
                return 0;
        }
    }else {
    
        switch (component) {
                
            case 0:
                return [_normalStyleArray count];
                
            default:
                return 0;
        }
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {

    if (self.name == 3) {
        
        switch (component) {
            case 0:
                
                return [_provinces[row] getString:@"data.Name"];
                
            case 1:
                return [_cities[row] getString:@"data.Name"];
                
            case 2:

                return [_areas[row] getString:@"data.Name"];
                
            default:
                return @"";
        }
        
    }else if(self.name == 2){
        
        switch (component) {
            case 0:
                
                return [_provinces[row] getString:@"data.Name"];
                
            case 1:
                return [_cities[row] getString:@"data.Name"];
                
            default:
                return @"";
        }

    }else if(self.name == 1){
    
        switch (component) {
            case 0:
                
                return [_provinces[row] getString:@"data.Name"];
                
            default:
                return @"";
        }
    }else if(self.name == 4){
    
        switch (component) {
            case 0:
                
                return _selfDefinedArray[row];
                
            default:
                return @"";
        }
    }else {
    
        switch (component) {
            case 0:{
                
                DictionaryWrapper *wrapper = [_normalStyleArray[row] wrapper];
                return [wrapper getString:@"CompanyName"];
            }
            default:
                return @"";
        }
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {

    if (self.name == 3) {
        
        switch (component) {
                
            case 0:
                _cities = (NSMutableArray*)[_provinces[row] getArray:@"subRegins"];
                [self.locatePicker selectRow:0 inComponent:1 animated:YES];
                [self.locatePicker reloadComponent:1];
                
                _areas = (NSMutableArray*)[_cities [0] getArray:@"subRegins"];
                [self.locatePicker selectRow:0 inComponent:2 animated:YES];
                [self.locatePicker reloadComponent:2];
                
                self.locate.state = [_provinces[row] getString:@"data.Name"];
                self.locate.stateData = [[_provinces[row] getDictionary:@"data"] wrapper];
                
                self.locate.city = [_cities[0] getString:@"data.Name"];
                self.locate.cityData = [[_cities[0] getDictionary:@"data"] wrapper];
                
                self.locate.district = [_areas[0] getString:@"data.Name"];
                self.locate.districtData = [[_areas[0] getDictionary:@"data"] wrapper];
        
                break;
                
            case 1:
                _areas = (NSMutableArray*)[_cities[row] getArray:@"subRegins"];
                [self.locatePicker selectRow:0 inComponent:2 animated:YES];
                [self.locatePicker reloadComponent:2];
                
                self.locate.city = [_cities[row] getString:@"data.Name"];
                self.locate.cityData = [[_cities[row] getDictionary:@"data"] wrapper];
                
                self.locate.district = [_areas[0] getString:@"data.Name"];
                self.locate.districtData = [[_areas [0] getDictionary:@"data"] wrapper];
                break;
                
            case 2:

                self.locate.district = [_areas [row] getString:@"data.Name"];
                self.locate.districtData = [[_areas [row] getDictionary:@"data"] wrapper];
                    
                break;
            default:
                break;
        }
        
    }else if(self.name == 2){
        
        switch (component) {
                
            case 0:
                _cities = (NSMutableArray*)[_provinces[row] getArray:@"subRegins"];
                [self.locatePicker selectRow:0 inComponent:1 animated:YES];
                [self.locatePicker reloadComponent:1];
                
                self.locate.state = [_provinces[row] getString:@"data.Name"];
                self.locate.stateData = [[_provinces[row] getDictionary:@"data"] wrapper];
                
                self.locate.city = [_cities[0] getString:@"data.Name"];
                self.locate.cityData = [[_cities[0] getDictionary:@"data"] wrapper];
                
                break;
                
            case 1:
                
                self.locate.city = [_cities[row] getString:@"data.Name"];
                self.locate.cityData = [[_cities[row] getDictionary:@"data"] wrapper];
                
                break;
                
            default:
                break;
        }
        
    }else if(self.name == 1){
    
        switch (component) {
                
            case 0:
                
                self.locate.state = [_provinces[row] getString:@"data.Name"];
                self.locate.stateData = [[_provinces[row] getDictionary:@"data"] wrapper];
                
                break;
            default:
                break;
        }
    }else if(self.name == 4){
    
        switch (component) {
                
            case 0:
                
                self.locate.locationType = _selfDefinedArray[row];
                break;
                
            default:
                break;
        }
    }else {
    
        switch (component) {
                
            case 0:
                
                self.locate.normalData = _normalStyleArray[row];
                break;
                
            default:
                break;
        }
    }
    
    if([self.delegate respondsToSelector:@selector(pickerDidChangeContent:)]) {
        [self.delegate pickerDidChangeContent:self];
    }
}

- (void)dealloc {
    [_locate release];
    [_locatePicker release];
    [_provinces release];
    [_userData release];
    [_selfDefinedArray release];
    self.delegate = nil;
    [super dealloc];
}

#pragma mark - animations

- (void)showInView:(UIView *)view {

    self.frame = CGRectMake(0, view.frame.size.height, self.frame.size.width, self.frame.size.height);
    
    if (!_backgroundView) {
        
        self.backgroundView = WEAK_OBJECT(UIView, initWithFrame:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height));
        [self.backgroundView setBackgroundColor:[UIColor blackColor]];
        self.backgroundView.alpha = 0.5;
        [view addSubview:_backgroundView];
    }
    self.backgroundView.hidden = NO;
    [view addSubview:self];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.frame = CGRectMake(0, view.frame.size.height - self.frame.size.height, self.frame.size.width, self.frame.size.height);
    }];
    
    
}

- (IBAction)btnCancel:(id)sender {
    
    if ([self.delegate respondsToSelector:@selector(endOperating)]) {
        
        [self.delegate endOperating];
    }
    
    if([self.delegate respondsToSelector:@selector(pickerClearContent:)]) {
        [self.delegate pickerClearContent:self];
    }
    
    self.backgroundView.hidden = YES;
    
    [self removePicker];
}

- (IBAction)btnConfirm:(id)sender {
    
    if([self.delegate respondsToSelector:@selector(pickerDidChangeContent:)]) {
        [self.delegate pickerDidChangeContent:self];
    }
    
    if ([self.delegate respondsToSelector:@selector(endOperating)]) {
        
        [self.delegate endOperating];
    }
    
    if ([self.locate.locationType isEqualToString:@"全国榜"]||!self.locate.locationType||[self.locate.locationType isEqualToString:@""]) {
        [self removePicker];
        
        if ([self.delegate respondsToSelector:@selector(refreshData:)]) {
            [self.delegate refreshData:self];
        }
        
    }else {
        [self.delegate pushAnotherPicker:self.locate.locationType];
        [self removePicker];
    }

    
    self.backgroundView.hidden = YES;
}

- (void)removePicker {
    
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.frame = CGRectMake(0, self.frame.origin.y+self.frame.size.height, self.frame.size.width, self.frame.size.height);
                     }
                     completion:^(BOOL finished){
                         [self removeFromSuperview];
                     }];
}

@end
