//
//  MainRootControllerHelper.h
//  ZhongBangShop
//
//  Created by Git on 2017/11/1.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MianTabBarViewController.h"
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,RootHelperType)
{
    RootHelperMianTabBarType = 1,        //!< 登录状态跳转到首页
    RootHelperLoginType = 2,      //!< 登录成功的
    RootHelperLogoutMianTabBarType = 3, //!< 清除登录状态跳转到首页
    RootHelperPresentLoginType = 4, //!< 从下往上模态的推出登录界面
};

@interface MainRootControllerHelper : NSObject<UIAlertViewDelegate>

/**
 单例初始化方法
 
 @return 单例初始化方法
 */
+ (instancetype)sharedRootHelperHelper;

/**
 判断是否是第一次启动，用来显示是否要显示启动页

 @param window 当前窗口的Window对象
 */
+(void)isFirstStartWithWindow:(UIWindow*)window;

/**
 用户点击引导页上的“立即体验”按钮时把当前版本号设置进去，
 下次启动时根据的版本是否一致来判断是否显示引导页
 */
+(void)setAppVersion;



/**
 设置当前根视图的模式及当前视图控制器
 @param type 设置跳转root类型
 @param object 当前视图控制器
 */
+(void)rootHelperWith:(RootHelperType)type withController:(UIViewController*)object;


/**
 设置自动登录
 */
-(void)autoLoginWithWindow:(UIWindow*)window;


@end
