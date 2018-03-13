//
//  XHDatePickerBoard.h
//  daycareParent
//
//  Created by mac on 2018/3/13.
//  Copyright © 2018年 XueHui. All rights reserved.
//


#pragma mark 日期选择面板


#import "BaseControl.h"

@interface XHDatePickerBoard : BaseControl

@property (nonatomic,strong) BaseButtonControl *cancleControl; //!< 取消
@property (nonatomic,strong) BaseButtonControl *confirmControl; //!< 确定


-(void)setPickerType:(UIDatePickerMode)type;

@end
