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
@property(nonatomic,strong)UIView * customTabBarView;
@end

@implementation MianTabBarViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self addsubView];
    [self resetTabbarController];
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
    XHIMNoticeViewController *Notice = [[XHIMNoticeViewController alloc] init];
    [self addChildViewController:Notice];
    
    XHIMNoticeViewController *imNotice = [[XHIMNoticeViewController alloc] init];
    [self addChildViewController:imNotice];

    XHSmartCampusViewController *MiddleSmartCampus = [[XHSmartCampusViewController alloc] init];
    [self addChildViewController:MiddleSmartCampus];
    
    XHEducationCloudViewController *educationCloud = [[XHEducationCloudViewController alloc] init];
    [self addChildViewController:educationCloud];
    
    XHPersonalCenterViewController *personalCenter = [[XHPersonalCenterViewController alloc] init];
    [self addChildViewController:personalCenter];
}
-(void)hidTabbarView:(BOOL)hidden
{
    self.customTabBarView.hidden=hidden;
}
-(void)resetTabbarController
{
    self.tabBar.hidden = YES;
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
    NSMutableArray  *imageArray = [NSMutableArray arrayWithCapacity:0];
    [imageArray addObjectsFromArray:@[[UIImage imageNamed:@"tab1-heartshow"],
                                      [UIImage imageNamed:@"tab2-doctor"],
                                      [UIImage imageNamed:@"plus_Last"],
                                      [UIImage imageNamed:@"tab4-more"],
                                      [UIImage imageNamed:@"tab5-file"]
                                      ]];
    NSArray *selectedImageArray = @[[UIImage imageNamed:@"tab1-heart"],
                                    [UIImage imageNamed:@"tab2-doctorshow"],
                                    [UIImage imageNamed:@"plus_Last"],
                                    [UIImage imageNamed:@"tab4-moreshow"],
                                    [UIImage imageNamed:@"tab5-fileshow"]
                                    ];
    
    NSMutableArray  *titleArray = [NSMutableArray arrayWithCapacity:0];
    [titleArray addObjectsFromArray:@[@"消息", @"通讯录", @"", @"学汇", @"我的"]];

    UIImageView *lineImageView = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2 - 40, - 17,80, 80)];
    lineImageView.backgroundColor = [UIColor blueColor];
    [lineImageView setBackgroundColor:[UIColor colorWithRed:250.0/255 green:250.0/255 blue:250.0/255 alpha:1]];
    lineImageView.layer.masksToBounds = YES;
    lineImageView.layer.cornerRadius = 40;
    lineImageView.layer.borderColor = [UIColor lightGrayColor].CGColor;//边框颜色
    lineImageView.layer.borderWidth = 1;//边框宽度
    [self.customTabBarView addSubview:lineImageView];
    [self.customTabBarView sendSubviewToBack:lineImageView];
    
    
    UIImageView *backImageView = [[UIImageView alloc] init];
    [backImageView setFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 54)];
    [backImageView setBackgroundColor:[UIColor colorWithRed:250.0/255 green:250.0/255 blue:250.0/255 alpha:1]];
    [self.customTabBarView addSubview:backImageView];
    
    UIImageView *leftLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width/2 - 32, 1)];
    leftLine.backgroundColor =[UIColor lightGrayColor]; //LINECOLOR;
    [self.customTabBarView addSubview:leftLine];
    
    UIImageView *rightLine = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2 + 32, 0,[UIScreen mainScreen].bounds.size.width/2 - 30, 1)];
    rightLine.backgroundColor = [UIColor lightGrayColor];//LINECOLOR;
    [self.customTabBarView addSubview:rightLine];
    
    for (int i = 0; i < 5; i ++)
    {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setFrame:CGRectMake(([[UIScreen mainScreen] bounds].size.width/5)*i, 0, ([[UIScreen mainScreen] bounds].size.width/5), 54)];
        [button setTag:i + 1];
        [button setImage:[imageArray objectAtIndex:i] forState:UIControlStateNormal];
        [button setImage:[selectedImageArray objectAtIndex:i] forState:UIControlStateSelected];
        [button setTitle:[titleArray objectAtIndex:i] forState:UIControlStateNormal];
        [button setTitle:[titleArray objectAtIndex:i] forState:UIControlStateSelected];
        [button setTitleColor:[UIColor colorWithRed:142/255.0 green:142/255.0 blue:142/255.0 alpha:1] forState:UIControlStateNormal];//WHOLE_TONE
        [button setTitleColor:[UIColor colorWithRed:142/255.0 green:142/255.0 blue:142/255.0 alpha:1] forState:UIControlStateSelected];
        [button.titleLabel setFont:[UIFont systemFontOfSize:12.0]];
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        
        [self initButton:button];
        if (i == 2) {
            [button setFrame:CGRectMake(([[UIScreen mainScreen] bounds].size.width/5)*i, -10, ([[UIScreen mainScreen] bounds].size.width/5), 60)];
        }
        if(i == 2)
        {
            [button setSelected:YES];
        }
        [button addTarget:self action:@selector(tabBarButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.customTabBarView addSubview:button];
    }
    [self.view addSubview:self.customTabBarView];
    
    self.selectedIndex = 2;
}

- (void)tabBarButtonClick:(id)sender
{
    UIButton *button = (UIButton *)sender;
    if (button.tag == self.selectedIndex + 1)
    {
        return;
    }
    UIView *customTabBarView = [self.view viewWithTag:1000];
    for (UIView *view in customTabBarView.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *btn = (UIButton *)view;
            [btn setSelected:NO];
        }
    }
    [button setSelected:YES];
    self.selectedIndex = button.tag - 1;
    
}

- (void)setTabBar:(NSInteger)select{
    UIView *customTabBarView = [self.view viewWithTag:1000];
    for (UIView *view in customTabBarView.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *btn = (UIButton *)view;
            [btn setSelected:NO];
        }
    }
    UIButton *button = [customTabBarView viewWithTag:select + 1];
    [button setSelected:YES];
    //[self setNavTitle:self.selectedIndex];
}
-(void)initButton:(UIButton*)btn{
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;//使图片和文字水平居中显示
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(btn.imageView.frame.size.height+10 ,-btn.imageView.frame.size.width, 0.0,0.0)];//文字距离上边框的距离增加imageView的高度，距离左边框减少imageView的宽度，距离下边框和右边框距离不变
    [btn setImageEdgeInsets:UIEdgeInsetsMake(-10, 0.0,0.0, -btn.titleLabel.bounds.size.width)];//图片距离右边框距离减少图片的宽度，其它不边
  
}
  /*
-(void)setHidesBottomBarWhenPushed:(BOOL)hidesBottomBarWhenPushed
{
//    _hidesBottomBarWhenPushed = hidesBottomBarWhenPushed;
    [super setHidesBottomBarWhenPushed:hidesBottomBarWhenPushed];
    self.tabBar.hidden=YES;
    if (hidesBottomBarWhenPushed)
    {
        [self.customTabBarView removeFromSuperview];
    }
    else
    {
        [self.view addSubview:self.customTabBarView];
    }

}
   */
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
-(UIView *)customTabBarView
{
    if (_customTabBarView==nil) {
        _customTabBarView = [[UIView alloc] initWithFrame:CGRectMake(0, [[UIScreen mainScreen] bounds].size.height - 54, [[UIScreen mainScreen] bounds].size.width, 54)];
        _customTabBarView.tag = 1000;
        [_customTabBarView setBackgroundColor:[UIColor clearColor]];
    }
    return _customTabBarView;
}
@end
