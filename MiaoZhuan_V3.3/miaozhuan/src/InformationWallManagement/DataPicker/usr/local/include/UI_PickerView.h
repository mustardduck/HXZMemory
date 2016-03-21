//
//  UI_PickerView.h
//  Demo
//
//  Created by Nick on 15-4-27.
//  Copyright (c) 2015年 Nick. All rights reserved.
//

#import <UIKit/UIKit.h>
@class UI_PickerView;

@protocol UI_PickViewDelegate <NSObject>

@optional
-(void)toobarDonBtnHaveClick:(UI_PickerView *)pickView resultString:(NSString *)resultString;

@end

@interface UI_PickerView : UIView

@property(nonatomic,weak) id<UI_PickViewDelegate> delegate;

/**
 *  通过plistName添加一个pickView
 *
 *  @param plistName          plist文件的名字
 
 *  @param isHaveNavControler 是否在NavControler之内
 *
 *  @return 带有toolbar的pickview
 */
-(instancetype)initPickviewWithPlistName:(NSString *)plistName isHaveNavControler:(BOOL)isHaveNavControler;
/**
 *  通过plistName添加一个pickView
 *
 *  @param array              需要显示的数组
 *  @param isHaveNavControler 是否在NavControler之内
 *
 *  @return 带有toolbar的pickview
 */
-(instancetype)initPickviewWithArray:(NSArray *)array isHaveNavControler:(BOOL)isHaveNavControler;

/**
 *  通过时间创建一个DatePicker
 *
 *  @param date               默认选中时间
 *  @param maxDate            可选最大时间
 *  @param minDate            可选最小时间
 *  @param isHaveNavControler是否在NavControler之内
 *
 *  @return 带有toolbar的datePicker
 */
//-(instancetype)initDatePickWithDate:(NSDate *)defaulDate datePickerMode:(UIDatePickerMode)datePickerMode isHaveNavControler:(BOOL)isHaveNavControler;
-(instancetype)initDatePickWithDate:(NSDate *)defaulDate maxDate:(NSDate *)maxDate minDate:(NSDate *)minDate datePickerMode:(UIDatePickerMode)datePickerMode isHaveNavControler:(BOOL)isHaveNavControler;

/**
 *   移除本控件
 */
-(void)remove;
/**
 *  显示本控件
 */
-(void)show;
/**
 *  设置PickView的颜色
 */
-(void)setPickViewColer:(UIColor *)color;
/**
 *  设置toobar的文字颜色
 */
-(void)setTintColor:(UIColor *)color;
/**
 *  设置toobar的背景颜色
 */
-(void)setToolbarTintColor:(UIColor *)color;

@end