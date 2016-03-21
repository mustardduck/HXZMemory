//
//  AlreadyPublishManagementTableViewCell.m
//  miaozhuan
//
//  Created by luo on 15/4/23.
//  Copyright (c) 2015年 zdit. All rights reserved.
//

#import "IWAlreadyPublishManagementTableViewCell.h"
#include <sys/types.h>
#include <sys/sysctl.h>

@implementation IWAlreadyPublishManagementTableViewCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)awakeFromNib{
//    _constraint_Top.constant = 13.f;
//    _constraint_Middle.constant = 6.f;
//    _constraint_Bottom.constant = 13.f;
    _view_Content.layer.masksToBounds = YES;
}

- (NSString*)getDeviceVersion
{
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = (char*)malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
    free(machine);
    return platform;
}

static NSString *platform  = nil;
static int  devicePlatform = 0;
- (IBAction)buttonSelected:(UIButton *)sender {
    _isSelected = !_isSelected;
    if (_isSelected) {
        [self.buttonSelect setBackgroundImage:[UIImage imageNamed:@"ads_consult_004"] forState:UIControlStateNormal];
    }else{
        [self.buttonSelect setBackgroundImage:[UIImage imageNamed:@"ads_consult_005"] forState:UIControlStateNormal];
    }
    if (self.choiceItem) {
        self.choiceItem(_isSelected);
    }
}


//if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone 5";
//if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone 5C";
//if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone 5C";
//if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone 5S";
//if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone 5S";
//if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone 6";
//if ([platformisEqualToString:@"iPhone7,2"]) return @"iPhone 6 Plus";

-(void) updateContent:(BOOL) isEdit seleted:(BOOL) isSelected
{
    _isEdit = isEdit;
    _isSelected = isSelected;
    
    if (_isEdit) {
//        _viewConstraint.constant = 0;
        
        _constraint_horizontal_CheckBox.constant = 15.f;
        _constraint_horizontal_Title.constant = 55.f;
        _constraint_horzontal_SubTitle.constant = 55.f;
        _imageViewArrow.hidden = YES;
    }else{
//        if (platform == nil) {
//            platform = [self getDeviceVersion];
//            if ([platform hasPrefix:@"iPhone"]) {
//                NSString *sub = [platform substringFromIndex:6];
//                NSString *subsub = [sub substringToIndex:1];
//                devicePlatform = [subsub intValue];
//            }
//        }
//        if (devicePlatform < 6) { //iphone 5s以下版本
//            _viewConstraint.constant = - 42;
//        }else{  //iPhone5s以上版本
//            _viewConstraint.constant = - 50;
//        }
        
        _constraint_horizontal_CheckBox.constant = -45.f;
        _constraint_horizontal_Title.constant = 15.f;
        _constraint_horzontal_SubTitle.constant = 15.f;
        _imageViewArrow.hidden = NO;

    }
    [self updateConstraints];
    
    if (_isSelected) {
        [self.buttonSelect setBackgroundImage:[UIImage imageNamed:@"ads_consult_004"] forState:UIControlStateNormal];
    }else{
        [self.buttonSelect setBackgroundImage:[UIImage imageNamed:@"ads_consult_005"] forState:UIControlStateNormal];
    }
}

- (void)dealloc {
    [_viewConstraint release];
    [_buttonSelect release];
    [_imageViewArrow release];
    [_lableTitle release];
    [_lableContent release];
    [_constraint_Top release];
    [_constraint_Middle release];
    [_constraint_Bottom release];
    [_label_AlreadyRefresh release];
    [_view_Content release];
    [_constraint_horizontal_CheckBox release];
    [_constraint_horizontal_Title release];
    [_constraint_horzontal_SubTitle release];
    [super dealloc];
}
@end
