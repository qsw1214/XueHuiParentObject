//
//  XHSmartCampusViewController.m
//  daycareParent
//
//  Created by Git on 2017/11/28.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHSmartCampusViewController.h"
#import "XHSmartCampusContentView.h"
#import "XHSafeRegisterViewController.h" //!< 安全签到
#import "XHHomeWorkViewController.h" //!< 家庭作业
#import "XHAskforLeaveViewController.h" //!< 请假
#import "XHCookBookViewController.h" //!<  食谱
#import "XHSyllabusViewController.h"  //!< 课程表
#import "XHAchievementViewController.h" //!< 成绩
#import "XHAddressBookViewController.h" //!< 班级通讯录
#import "MainRootControllerHelper.h"
#import "XHSafeLocationViewController.h" //!< 定位
#import "XHDynamicsViewController.h" //!< 班级动态
#import "XHLoginViewController.h"
#import "AppDelegate.h"
#import <AVFoundation/AVFoundation.h>
#import "XHBindCardViewController.h"//!<扫一扫
#import "XHCommonAlertControl.h"
#import "XHUpdateHelper.h"

@interface XHSmartCampusViewController () <XHFunctionMenuControlDeletage,XHCommonAlertControlDelegate>

@property (nonatomic,strong) XHSmartCampusContentView *contentView;

@end

@implementation XHSmartCampusViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //!< 判断是否强制更新
    [[XHUpdateHelper alloc] updateVersionWithViewController:self];
    [self setNavtionTitle:@"智慧校园"];
    [self navtionItemHidden:NavigationItemLeftType];
    [self setItemContentType:NavigationIconype withItemType:NavigationItemRightype withIconName:@"ico_sao" withTitle:nil];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
}




-(void)addSubViews:(BOOL)subview
{
    if (subview)
    {
         [self.view addSubview:self.contentView];
        
    }
}

#pragma mark - Deletage Method
#pragma mark XHFunctionMenuControlDeletage (功能点击)
-(void)functionDidSelectItemAtindexObject:(XHFunctionMenuFrame *)object
{
    switch (object.model.tage)
    {
#pragma mark case 0 平安记录
        case 0:
        {
            if ([self refreshChild]) {
                XHSafeRegisterViewController *regis = [[XHSafeRegisterViewController alloc]initHiddenWhenPushHidden];
                [regis setHidesBottomBarWhenPushed:YES];
                [self.navigationController pushViewController:regis animated:YES];
            }
          
        }
            break;
#pragma mark case 1实时定位
        case 1:
        {
            XHSafeLocationViewController *location = [[XHSafeLocationViewController alloc]initHiddenWhenPushHidden];
            [self.navigationController pushViewController:location animated:YES];
        }
            break;
#pragma mark case 2: 家庭作业
        case 2:
        {
            if ([self refreshChild]) {
                XHHomeWorkViewController *homeWork = [[XHHomeWorkViewController alloc]initHiddenWhenPushHidden];
                [self.navigationController pushViewController:homeWork animated:YES];
            }
            
        }
            break;
#pragma mark case 3 食谱
        case 3:
        {
            if ([self refreshChild]) {
                XHCookBookViewController *cookBook = [[XHCookBookViewController alloc]initHiddenWhenPushHidden];
                [self.navigationController pushViewController:cookBook animated:YES];
            }
            
        }
            break;
#pragma mark case 4 课程表
        case 4:
        {
            if ([self refreshChild]) {
                XHSyllabusViewController *syllabus = [[XHSyllabusViewController alloc]initHiddenWhenPushHidden];
                [self.navigationController pushViewController:syllabus animated:YES];
            }
            
        }
            break;
#pragma mark case 5 成绩
        case 5:
        {
            if ([self refreshChild]) {
                XHAchievementViewController *achievement = [[XHAchievementViewController alloc]initHiddenWhenPushHidden];
                [self.navigationController pushViewController:achievement animated:YES];
            }
           
        }
            break;
#pragma mark case 6 请假
        case 6:
        {
            if ([self refreshChild]) {
                XHAskforLeaveViewController *leave = [[XHAskforLeaveViewController alloc]initHiddenWhenPushHidden];
                [self.navigationController pushViewController:leave animated:YES];
            }
            
        }
            break;
#pragma mark case 7 班级通讯录
        case 7:
        {
            if ([self refreshChild]) {
                XHAddressBookViewController *addressBook = [[XHAddressBookViewController alloc]initHiddenWhenPushHidden];
                [addressBook setNavtionTitle:@"班级通讯录"];
                [self.navigationController pushViewController:addressBook animated:YES];
            }
           
        }
            break;
#pragma mark case 8 班级动态
        case 8:
        {
            if ([self refreshChild]) {
                XHDynamicsViewController *dynamics = [[XHDynamicsViewController alloc]initHiddenWhenPushHidden];
                [self.navigationController pushViewController:dynamics animated:YES];
            }
            
        }
            break;
    }
}
-(void)rightItemAction:(BaseNavigationControlItem *)sender
{
    // 1、 获取摄像设备
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (device) {
        AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (status == AVAuthorizationStatusNotDetermined) {
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                if (granted) {
                    dispatch_sync(dispatch_get_main_queue(), ^{
                        
                        XHBindCardViewController *bindCard = [[XHBindCardViewController alloc] initHiddenWhenPushHidden];
                        [self.navigationController pushViewController:bindCard animated:YES];
                    });
                    // 用户第一次同意了访问相机权限
                    NSLog(@"用户第一次同意了访问相机权限 - - %@", [NSThread currentThread]);
                    
                } else {
                    // 用户第一次拒绝了访问相机权限
                    NSLog(@"用户第一次拒绝了访问相机权限 - - %@", [NSThread currentThread]);
                }
            }];
        } else if (status == AVAuthorizationStatusAuthorized) { // 用户允许当前应用访问相机
            XHBindCardViewController *bindCard = [[XHBindCardViewController alloc] initHiddenWhenPushHidden];
            [self.navigationController pushViewController:bindCard animated:YES];
        } else if (status == AVAuthorizationStatusDenied) { // 用户拒绝当前应用访问相机
            UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请去-> [设置 - 隐私 - 相机 - 学汇家长] 打开访问开关" preferredStyle:(UIAlertControllerStyleAlert)];
            UIAlertAction *alertA = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            
            [alertC addAction:alertA];
            [self presentViewController:alertC animated:YES completion:nil];
            
        } else if (status == AVAuthorizationStatusRestricted) {
            NSLog(@"因为系统原因, 无法访问相册");
        }
    } else {
        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"未检测到您的摄像头" preferredStyle:(UIAlertControllerStyleAlert)];
        UIAlertAction *alertA = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [alertC addAction:alertA];
        [self presentViewController:alertC animated:YES completion:nil];
    }
}
#pragma mark XHScrollPreviewControlDeletage (广告轮播)
-(void)scrollPreviewDidSelectItemAtindexObject:(XHFunctionMenuFrame *)object
{
    
}



#pragma mark  XHCommonAlertControlDelegate
-(void)alertBoardAction:(BaseButtonControl*)sender
{
    
}




#pragma mark - Getter / Setter
-(XHSmartCampusContentView *)contentView
{
    if (_contentView == nil)
    {
        _contentView = [[XHSmartCampusContentView alloc]initWithDeletage:self];
        [_contentView resetFrame:CGRectMake(0, self.navigationView.bottom, SCREEN_WIDTH, SCREEN_HEIGHT-(self.navigationView.height+50.0))];
    }
    return _contentView;
}
-(BOOL)refreshChild
{
    if (![XHUserInfo sharedUserInfo].childListArry.count) {
        [XHShowHUD showNOHud:@"请先绑定孩子！"];
        return NO;
    }
    else
    {
        return YES;
    }
}

@end
