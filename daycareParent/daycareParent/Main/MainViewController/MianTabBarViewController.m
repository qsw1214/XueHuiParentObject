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
#import "XHChatViewController.h"
#import "XHEducationCloudViewController.h"
#import "XHEducationCloudViewController.h"
#import "XHPersonalCenterViewController.h"
#import "XHAddressBookViewController.h"
#import "TabBarItem.h"
#import "TabBarView.h"
#import <RongIMKit/RongIMKit.h>
#import <RongIMLib/RongIMLib.h>
#define kTabbarNormalTitle @[@"tab1-heartshow",@"tab1-heartshow",@"plus_Last",@"tab4-more",@"tab5-file"]
 #define kTabbarSelectedTitle @[@"tab1-heart",@"tab2-doctorshow",@"plus_Last",@"tab4-moreshow",@"tab5-fileshow"]
@interface MianTabBarViewController ()<TabBarViewDelegate>
@property(nonatomic,strong)TabBarView * customTabBarView;
@end

@implementation MianTabBarViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self addsubView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadIMBadge) name:@"noticeIM" object:nil];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)addsubView
{
    XHChatViewController *Notice = [[XHChatViewController alloc] init];
    [self addChildViewController:Notice];
    
    XHAddressBookViewController *book = [[XHAddressBookViewController alloc] init];
    [self addChildViewController:book];

    XHSmartCampusViewController *MiddleSmartCampus = [[XHSmartCampusViewController alloc] init];
    [self addChildViewController:MiddleSmartCampus];
    
    XHEducationCloudViewController *educationCloud = [[XHEducationCloudViewController alloc] init];
    [self addChildViewController:educationCloud];
    
    XHPersonalCenterViewController *personalCenter = [[XHPersonalCenterViewController alloc] init];
    [self addChildViewController:personalCenter];
    
    self.tabBar.hidden = YES;
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
    [self.view addSubview:self.customTabBarView];
    
    self.selectedIndex = 2;
}
#pragma mark  tabbarViewDelegate
-(void)setItemSelectIndex:(NSInteger)selectIndex
{
    self.selectedIndex=selectIndex;
}

-(TabBarView *)customTabBarView
{
    if (_customTabBarView==nil) {
        _customTabBarView = [[TabBarView alloc] initWithFrame:CGRectMake(0, [[UIScreen mainScreen] bounds].size.height - 54, [[UIScreen mainScreen] bounds].size.width, 54)];
        _customTabBarView.tag = 1000;
        _customTabBarView.delegate=self;
        [_customTabBarView setBackgroundColor:[UIColor clearColor]];
    }
    return _customTabBarView;
}
-(void)reloadIMBadge
{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSInteger aaa=(NSInteger)[RCIMClient sharedRCIMClient].getTotalUnreadCount+[XHUserInfo sharedUserInfo].sum;
        UILabel *smallLabel = [self.customTabBarView viewWithTag:1008611];
        UIButton *button = [self.customTabBarView viewWithTag: 1];
        smallLabel.hidden=NO;
        if ( aaa <= 0)
        {
            smallLabel.text = nil;
            smallLabel.hidden=YES;
            return;
        }
        smallLabel.text =  aaa >= 99?@"99+":[NSString stringWithFormat:@"%ld", (long)aaa];
        smallLabel.frame=CGRectMake(button.right-button.width*2/5, button.top+8, [self getCustomWidth:smallLabel.text], 15);
    });
}
-(CGFloat)getCustomWidth:(NSString *)str
{
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:14.0]};
    
    CGSize textSize = [str boundingRectWithSize:CGSizeMake(22, 22) options:NSStringDrawingTruncatesLastVisibleLine attributes:attributes context:nil].size;;
    if (str.length==0) {
        return 0;
    }
    if (str.length==1) {
        return 15;
    }
    else
    {
        return textSize.width+8;
    }
    
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
