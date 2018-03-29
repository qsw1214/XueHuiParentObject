//
//  XHChageTelephoneTableViewCell.h
//  daycareParent
//
//  Created by 钧泰科技 on 2018/3/15.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "ParentTableViewCell.h"
#define kPlaceTitle @[@"请输入手机号",@"请输入验证码",@"请输入新密码(6-20位英文、数字组合)"]
typedef NS_ENUM(NSInteger,XHChageTelephoneModelType)
{
    XHChageTelephoneRegistType=1,
    XHChageTelephoneForgetType=2,
    XHChageTelephoneyFoundType=3,
};

@interface XHChageTelephoneTableViewCell : ParentTableViewCell
@property(nonatomic,assign)XHChageTelephoneModelType modelType;
@end
