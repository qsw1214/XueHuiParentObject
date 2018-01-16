//
//  XHDatePickerView.h
//  Object
//
//  Created by Git on 2017/12/7.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseButtonControl.h"


@protocol XHDatePickerViewDelegate <NSObject>

/**
 保存按钮代理方法
 
 @param timer 选择的数据
 */
- (void)datePickerViewSaveBtnClickDelegate:(NSString *)timer;

/**
 取消按钮代理方法
 */
- (void)datePickerViewCancelBtnClickDelegate;

@end

@interface XHDatePickerView : UIView

@property (copy, nonatomic) NSString *title;
@property (weak, nonatomic) id <XHDatePickerViewDelegate> delegate;

/// 显示
- (void)show;

@end
