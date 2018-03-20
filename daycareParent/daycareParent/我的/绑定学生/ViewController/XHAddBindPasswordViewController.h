//
//  XHAddBindPasswordViewController.h
//  daycareParent
//
//  Created by mac on 2018/3/16.
//  Copyright © 2018年 XueHui. All rights reserved.
//




#pragma mark 设置绑定密码

typedef NS_ENUM(NSInteger,XHAddBindPasswordViewControllerEnterType)
{
    XHRegisterAddEnterType=1,//!< 注册界面进入
    
    XHBindAddEnterType=2,//!< 绑定孩子界面进入
    
};


typedef NS_ENUM(NSInteger,XHAddBindPasswordType)
{
    XHAddBindEnterPasswordType = 1, //!< 输入新密码
    XHAddBindSettingPasswordType = 2, //!<设置密码
};






#import "BaseViewController.h"

@interface XHAddBindPasswordViewController : BaseViewController


@property (nonatomic,assign) XHAddBindPasswordType type;

@property (nonatomic,assign) XHAddBindPasswordViewControllerEnterType enterType;

@end



