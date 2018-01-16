//
//  XHShowHUD.m
//  daycareParent
//
//  Created by Git on 2017/11/27.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHShowHUD.h"

@implementation XHShowHUD

static MBProgressHUD *HUD;

+ (void)removeTopHUD
{
    if (HUD)
    {
        [HUD hide:YES];
        [HUD removeFromSuperview];
        HUD = nil;
    }
}
+ (void)showTextHud
{
    [self showTextHud:hudLOAD_DEFAULT_TITLE];
}
+ (void)showTextHud:(NSString *)text
{
    [self removeTopHUD];
    
    UIWindow *window = [[UIApplication sharedApplication].delegate window];
    
    HUD = [[MBProgressHUD alloc] initWithWindow:window];
    HUD.mode = MBProgressHUDModeIndeterminate;
    HUD.animationType = MBProgressHUDAnimationZoom;
    HUD.labelText = text;
    
    [window addSubview:HUD];
    
    [HUD show:YES];
}
+ (void)showOKHud:(NSString *)text delay:(NSTimeInterval)dalay
{
    [self removeTopHUD];
    
    UIWindow *window = [[UIApplication sharedApplication].delegate window];
    
    HUD = [[MBProgressHUD alloc] initWithWindow:window];
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.labelText = text;
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
    
    [window addSubview:HUD];
    
    [HUD show:YES];
    [HUD hide:YES afterDelay:dalay == 0?hudDEFAULT_HIDE_DELAY:dalay];
}

+ (void)showNOHud:(NSString *)text delay:(NSTimeInterval)dalay
{
    [self removeTopHUD];
    
    UIWindow *window = [[UIApplication sharedApplication].delegate window];
    
    HUD = [[MBProgressHUD alloc] initWithWindow:window];
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.labelText = text;
    HUD.customView = [[UIImageView alloc] initWithImage:
                      [UIImage imageNamed:@"37x-Wrong.png"]];
    
    [window addSubview:HUD];
    
    [HUD show:YES];
    [HUD hide:YES afterDelay:dalay == 0?hudDEFAULT_HIDE_DELAY:dalay];
}
+ (void)showOKHud:(NSString *)text
{
    [self showOKHud:text delay:hudDEFAULT_HIDE_DELAY];
}
+ (void)showNOHud:(NSString *)text
{
    [self showNOHud:text delay:hudDEFAULT_HIDE_DELAY];
}

+ (void)hideHud
{
    [self removeTopHUD];
}

+ (MBProgressHUD *)showProgressHUD:(NSString *)text
{
    [self removeTopHUD];
    
    UIWindow *window = [[UIApplication sharedApplication].delegate window];
    
    HUD = [[MBProgressHUD alloc] initWithWindow:window];
    HUD.mode =MBProgressHUDModeAnnularDeterminate;
    HUD.labelText = text;
    
    [window addSubview:HUD];
    [HUD show:YES];
    
    return HUD;
}
@end
