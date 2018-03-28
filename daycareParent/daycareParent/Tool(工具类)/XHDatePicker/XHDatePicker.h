//
//  XHDatePicker.h
//  daycareParent
//
//  Created by mac on 2018/3/13.
//  Copyright © 2018年 XueHui. All rights reserved.
//




#import "BaseControl.h"

@protocol XHDatePickerDelegate <NSObject>

-(void)datePickerAction:(NSString*)date;


@end

@interface XHDatePicker : BaseControl


@property (nonatomic,weak) id <XHDatePickerDelegate> delegate;

#pragma mark - 显示当前日期的选择
/**
 显示当前日期选择器
 */
-(void)show;


#pragma mark - 隐藏当前日期的选择器
/**
 隐藏当前日期选择器
 */
-(void)dismiss;





#pragma mark - 设置日期的显示模式
/**
 设置日期显示的模式

 @param type 日期模式枚举类型
 */
-(void)setPickerType:(UIDatePickerMode)type;


-(void)setMaximumDate:(NSDate *)maximumDate;



@end
