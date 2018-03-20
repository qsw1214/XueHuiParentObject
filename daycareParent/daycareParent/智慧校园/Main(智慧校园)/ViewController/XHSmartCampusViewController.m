//
//  XHSmartCampusViewController.m
//  daycareParent
//
//  Created by Git on 2017/11/28.
//  Copyright © 2017年 XueHui. All rights reserved.
//


#import <AVFoundation/AVFoundation.h>


#import "XHSmartCampusViewController.h"
#import "XHSmartCampusContentView.h"
#import "XHSafeRegisterViewController.h" //!< 安全签到
#import "XHAskforLeaveViewController.h" //!< 请假
#import "XHCookBookViewController.h" //!<  食谱
#import "XHSyllabusViewController.h"  //!< 课程表
#import "XHAchievementViewController.h" //!< 成绩
#import "XHSafeLocationViewController.h" //!< 定位
#import "XHHomeWorkViewController.h"
#import "XHLoginViewController.h"
#import "SDCycleScrollView.h"
#import "XHTeacherAddressBookViewController.h"
#import "XHBindViewController.h"



@interface XHSmartCampusViewController () <XHFunctionMenuControlDeletage>


@property (nonatomic,strong) XHSmartCampusContentView *contentView;

@end

@implementation XHSmartCampusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavtionTitle:@"校园"];
    [self navtionItemHidden:NavigationItemLeftType];
    [self setItemContentType:NavigationIconype withItemType:NavigationItemRightype withIconName:@"ico_sao" withTitle:nil];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
#pragma mark
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
            if ([self refreshChild])
            {
                XHSafeRegisterViewController *regis = [[XHSafeRegisterViewController alloc]initHiddenWhenPushHidden];
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
#pragma mark case 3 食谱
        case 3:
        {
            if ([self refreshChild])
            {
                XHSyllabusViewController *cookBook = [[XHSyllabusViewController alloc]initHiddenWhenPushHidden];
                [self.navigationController pushViewController:cookBook animated:YES];
            }
            
        }
            break;
#pragma mark case 4 课程表
        case 4:
        {
            if ([self refreshChild])
            {
                XHAskforLeaveViewController *achievement = [[XHAskforLeaveViewController alloc]initHiddenWhenPushHidden];
                [self.navigationController pushViewController:achievement animated:YES];
               
            }
            
        }
            break;
#pragma mark case 5 成绩
        case 5:
        {
            if ([self refreshChild])
            {
                XHCookBookViewController *syllabus = [[XHCookBookViewController alloc]initHiddenWhenPushHidden];
                [self.navigationController pushViewController:syllabus animated:YES];
            }
           
        }
            break;
    }
}



#pragma mark XHScrollPreviewControlDeletage (广告轮播)
-(void)scrollPreviewDidSelectItemAtindexObject:(XHFunctionMenuFrame *)object
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
    if (![XHUserInfo sharedUserInfo].childListArry.count)
    {
        [XHShowHUD showNOHud:@"请先绑定孩子！"];
        return NO;
    }
    else
    {
        return YES;
    }
}

@end
