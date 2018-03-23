//
//  XHBindViewController.h
//  daycareParent
//
//  Created by 钧泰科技 on 2017/12/1.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "BaseViewController.h"


#pragma mark 绑定孩子


typedef NS_ENUM(NSInteger,XHBindViewControllerEnterType)
{
    XHRegisterEnterType=1, //!< 注册界面进入

    XHBindEnterType=2, //!< 绑定孩子界面进入

};




@interface XHBindViewController : BaseViewController
@property(nonatomic,assign)XHBindViewControllerEnterType enterType;

@end
