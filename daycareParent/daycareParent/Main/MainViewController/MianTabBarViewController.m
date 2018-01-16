//
//  MianTabBarViewController.m
//  ZhongBangShop
//
//  Created by Git on 2017/10/12.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "MianTabBarViewController.h"
#import "XHSmartCampusViewController.h"
#import "XHIMNoticeViewController.h"
#import "XHEducationCloudViewController.h"
#import "XHEducationCloudViewController.h"
#import "XHPersonalCenterViewController.h"
#import "TabBarItem.h"
#import <RongIMKit/RongIMKit.h>
#import <RongIMLib/RongIMLib.h>
@interface MianTabBarViewController ()

@end

@implementation MianTabBarViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self addsubView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadIMBadge) name:@"noticeIM" object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)addsubView
{
    XHSmartCampusViewController *smartCampus = [[XHSmartCampusViewController alloc] init];
    //创建tabBarItem
    TabBarItem *smartCampusTabBarItem = [[TabBarItem alloc]initWithTitle:@"智慧校园" imageName:@"ico_shouyehui" selectedImageName:@"ico_shouyese"];
    [smartCampus setTabBarItem:smartCampusTabBarItem];
    UINavigationController *smartCampusNavigation = [[UINavigationController alloc] initWithRootViewController:smartCampus];
    [self addChildViewController:smartCampusNavigation];

    XHIMNoticeViewController *imNotice = [[XHIMNoticeViewController alloc] init];
   // [imNotice navtionItemHidden:NavigationItemLeftType];
    //创建tabBarItem
    TabBarItem *imNoticeTabBarItem = [[TabBarItem alloc]initWithTitle:@"消息" imageName:@"ico_xiaoxihui" selectedImageName:@"ico_xiaoxise"];
    [imNotice setTabBarItem:imNoticeTabBarItem];
    UINavigationController *imNoticeNavigation = [[UINavigationController alloc] initWithRootViewController:imNotice];
    [self addChildViewController:imNoticeNavigation];

    XHEducationCloudViewController *educationCloud = [[XHEducationCloudViewController alloc] init];
    [educationCloud navtionItemHidden:NavigationItemLeftType];
    //创建tabBarItem
    TabBarItem *educationCloudTabBarItem = [[TabBarItem alloc]initWithTitle:@"浩学云" imageName:@"ico_haoxueyunhui" selectedImageName:@"ico_haoxueyunse"];
    [educationCloud setTabBarItem:educationCloudTabBarItem];
    UINavigationController *educationCloudNavigation = [[UINavigationController alloc] initWithRootViewController:educationCloud];
    [self addChildViewController:educationCloudNavigation];
    
    XHPersonalCenterViewController *personalCenter = [[XHPersonalCenterViewController alloc] init];
    [personalCenter navtionItemHidden:NavigationItemLeftType];
    //创建tabBarItem
    TabBarItem *personalCenterTabBarItem = [[TabBarItem alloc]initWithTitle:@"我的" imageName:@"ico_wohui" selectedImageName:@"ico_wose"];
    [personalCenter setTabBarItem:personalCenterTabBarItem];
    UINavigationController *personalCenterNavigation = [[UINavigationController alloc] initWithRootViewController:personalCenter];
    [self addChildViewController:personalCenterNavigation];
}
-(void)reloadIMBadge
{
    dispatch_async(dispatch_get_main_queue(), ^{
         NSInteger aaa=(NSInteger)[RCIMClient sharedRCIMClient].getTotalUnreadCount;
        UITabBarItem *IBarItem = [self.tabBar.items objectAtIndex:1];
        if (  aaa <= 0)
        {
            IBarItem.badgeValue = nil;
            return;
        }
        IBarItem.badgeValue =  aaa >= 99?@"99+":[NSString stringWithFormat:@"%ld", (long)aaa];
    });
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
