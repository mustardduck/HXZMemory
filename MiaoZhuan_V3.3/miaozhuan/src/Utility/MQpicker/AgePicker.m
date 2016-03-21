//
//  AgePicker.m
//  miaozhuan
//
//  Created by momo on 14-12-3.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "AgePicker.h"

@implementation AgePicker

- (id)initWithStyle:(id<AgePickerDelegate>)delegate
{
    
    self = [[[[NSBundle mainBundle] loadNibNamed:@"AgePicker" owner:self options:nil] objectAtIndex:0] retain];
    
    if (self) {
        
        self.delegate = delegate;
        self.agePicker.dataSource = self;
        self.agePicker.delegate = self;
        
        _ageSecondArr = STRONG_OBJECT(NSMutableArray, init);
        
        _ageFirstArr = STRONG_OBJECT(NSMutableArray, init);
        
        [_ageFirstArr addObject:@"不限"];

        [_ageSecondArr addObject:@"不限"];
        
        for (int i = 0; i < 101 ; i ++) {
            
            if(i >= 0 && i <= 99)
            {
                [_ageFirstArr addObject:[NSString stringWithFormat:@"%d", i] ];
            }
            if(i >= 1 && i <= 100)
            {
                [_ageSecondArr addObject:[NSString stringWithFormat:@"%d", i]];
            }
        }
        
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0f){
            
            self.agePicker.backgroundColor = [UIColor whiteColor];
        }
    }
    
    return self;
}

- (void) displayAgeView
{
    if(_isAll || ([_firstText intValue] == 0 && [_secondText intValue] == 100) )//不限
    {
        self.curText = _ageFirstArr[0];
        
        self.firstText = _ageFirstArr[0];
        
        self.secondText = _ageSecondArr[0];
        
        [_agePicker selectRow:0 inComponent:0 animated:NO];
        
        [_agePicker selectRow:0 inComponent:2 animated:NO];
    }
    else
    {
        if([_secondText isEqualToString:@"不限"])
        {
            [_agePicker selectRow:0 inComponent:2 animated:NO];
        }
        else
        {
            self.curText = [_firstText stringByAppendingString:[NSString stringWithFormat:@" - %@ 岁", _secondText]];
            
            [_agePicker selectRow:[_firstText intValue] + 1 inComponent:0 animated:NO];
            
            [_agePicker selectRow:[_secondText intValue] inComponent:2 animated:NO];
        }
    }
}

#pragma mark -
#pragma mark Picker Datasource Protocol

//返回显示的列数
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 3;
}

//返回当前列显示的行数
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if(component==0){
        return [_ageFirstArr count];
    }
    else if (component == 1)
    {
        return 1;
    }
    else{
        return [_ageSecondArr count];
    }
}

#pragma mark -
#pragma mark Picker Delegate Protocol

//设置当前行的内容
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if(component==0){
        
        return [_ageFirstArr objectAtIndex:row];
    }
    else if (component == 1)
    {
        return @"至";
    }
    else if(component == 2){
        return [_ageSecondArr objectAtIndex:row];
    }
    return nil;
}

- (BOOL) validSelctNum
{
    if ([_firstText intValue] >= [_secondText intValue]) {
        
        [HUDUtil showErrorWithStatus:@"最小年龄不能大于等于最大年龄"];
        
        return NO;
    }
    return YES;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if(component == 0)
    {
        if(row == 0)//不限
        {
            _isAll = YES;
            
            self.firstText = _ageFirstArr[0];
            
            [_agePicker selectRow:0 inComponent:2 animated:YES];
            
            self.secondText = _ageSecondArr[0];

            return;
        }
        else
        {
            self.firstText = _ageFirstArr[row];
            
            if([_secondText isEqualToString:@"不限"])
            {
                self.secondText = @"100";
                
                _isAll = NO;
                
                self.curText = [_firstText stringByAppendingString:[NSString stringWithFormat:@" - %@ 岁", _secondText]];
            }
            else
            {
                if([self validSelctNum])
                {
                    _isAll = NO;
                    
                    self.curText = [_firstText stringByAppendingString:[NSString stringWithFormat:@" - %@ 岁", _secondText]];
                    
                    self.firstText = _ageFirstArr[row];
                    
                }
                else
                {
                    [_agePicker selectRow:0 inComponent:0 animated:YES];
                    
                    self.firstText = _ageFirstArr[0];
                    
                    _isAll = YES;
                }
            }
        }
    }
    else if(component == 2)
    {
        if(_isAll || [_firstText isEqualToString:@"不限"])
        {
            [_agePicker selectRow:0 inComponent:2 animated:YES];
            
            return;
        }
        else
        {
            if(!_isAll)
            {
                if(row == 0)
                {
                    self.secondText = @"100";
                }
                else
                {
                    self.secondText = _ageSecondArr[row];
                }
                
                if([self validSelctNum])
                {
                    self.curText = [_firstText stringByAppendingString:[NSString stringWithFormat:@" - %@ 岁", _secondText]];
                    
                    self.secondText = _ageSecondArr[row];
                }
                else
                {
                    [_agePicker selectRow:0 inComponent:2 animated:YES];
                    
                    self.secondText = _ageSecondArr[0];
                }
            }
        }

    }
    
    if([self.delegate respondsToSelector:@selector(pickerAgeDidChaneStatus:)]) {
        
        [self.delegate pickerAgeDidChaneStatus:self];
    }

}

- (IBAction) touchUpInsideOnBtn:(id)sender{
    
    if (sender == _okItem) {
        
        if (_delegate&&[_delegate respondsToSelector:@selector(pickerAgeOk:)]) {
            
            if(_isAll || ( [_firstText intValue] == 0 && [_secondText intValue] == 100 ))
            {
                self.curText = _ageFirstArr[0];
            }
            
            [_delegate pickerAgeOk:self];
        }
    }
    else if (sender == _cancelItem||sender == _fullBtn){
        
        if (_delegate&&[_delegate respondsToSelector:@selector(pickerAgeCancel:)]) {
            
            [_delegate pickerAgeCancel:self];
        }
    }
}

- (void)dealloc {
    [_fullBtn release];
    [_agePicker release];
    [_cancelItem release];
    [_okItem release];
    
    [_ageSecondArr release];
    _ageSecondArr = nil;
    
    [_ageFirstArr release];
    _ageFirstArr = nil;
    
    [super dealloc];
}
@end
