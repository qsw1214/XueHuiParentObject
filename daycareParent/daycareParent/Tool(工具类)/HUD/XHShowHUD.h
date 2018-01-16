//
//  XHShowHUD.h
//  daycareParent
//
//  Created by Git on 2017/11/27.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"

#define hudDEFAULT_HIDE_DELAY 2.0
#define hudLOAD_DEFAULT_TITLE @"请稍后..."
#define hudLOAD_NOTWEB @"请检查您的网络!"
#define hudLOAD_UNKNOWN @"未知错误!"

@interface XHShowHUD : NSObject


+ (void)showTextHud;
+ (void)showTextHud:(NSString *)text;
+ (void)showOKHud:(NSString *)text delay:(NSTimeInterval)dalay;
+ (void)showNOHud:(NSString *)text delay:(NSTimeInterval)dalay;
+ (void)showOKHud:(NSString *)text;
+ (void)showNOHud:(NSString *)text;

+ (void)hideHud;

+ (MBProgressHUD *)showProgressHUD:(NSString *)text;

@end
