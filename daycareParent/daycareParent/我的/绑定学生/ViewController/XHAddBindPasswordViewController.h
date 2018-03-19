//
//  XHAddBindPasswordViewController.h
//  daycareParent
//
//  Created by mac on 2018/3/16.
//  Copyright © 2018年 XueHui. All rights reserved.
//




#pragma mark 设置绑定密码

typedef NS_ENUM(NSInteger,XHAddBindPasswordType)
{
    XHAddBindEnterPasswordType = 1, //!< 输入新密码
    XHAddBindSettingPasswordType = 2, //!<设置密码
};






#import "BaseViewController.h"

@interface XHAddBindPasswordViewController : BaseViewController


@property (nonatomic,assign) XHAddBindPasswordType type;


@end



