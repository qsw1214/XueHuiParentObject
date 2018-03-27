//
//  XHCommonAlertBoardControl.h
//  daycareParent
//
//  Created by mac on 2018/3/26.
//  Copyright © 2018年 XueHui. All rights reserved.
//





#import "BaseControl.h"

@interface XHCommonAlertBoardControl : BaseControl

@property (nonatomic,strong) BaseButtonControl *confirmControl; //!< 确定
@property (nonatomic,strong) BaseButtonControl *cancelControl; //!< 取消


-(void)setWithTitle:(nullable NSString *)title message:(nullable NSString *)message delegate:(nullable id)delegate cancelButtonTitle:(nullable NSString *)cancelButtonTitle otherButtonTitle:(nullable NSString *)otherButtonTitle;


@end
