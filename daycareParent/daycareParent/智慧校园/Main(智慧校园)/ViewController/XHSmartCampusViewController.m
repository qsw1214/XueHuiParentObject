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
#import "XHLoginViewController.h"
#import "SDCycleScrollView.h"



@interface XHSmartCampusViewController () <XHFunctionMenuControlDeletage>

@property (nonatomic,strong) NSMutableArray *itemArray;
@property (nonatomic,strong) XHFunctionMenuControl *functionMenuControl;
@property (nonatomic,strong) SDCycleScrollView *cycleScrollView; //!< 滚动视图


@property (nonatomic,strong) XHSmartCampusContentView *contentView;

@end

@implementation XHSmartCampusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavtionTitle:@"智慧校园"];
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
        
        
//        //添加轮播图
//        NSArray *imagesURLStrings = @[@"placeholderImage",@"placeholderImage",@"placeholderImage"];
//        self.cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200.0) shouldInfiniteLoop:YES imageNamesGroup:imagesURLStrings withCurrentPageDotImage:@"pageControlCurrentDot" withPageControlDot:@"pageControlDot"];
//        [self.cycleScrollView setDelegate:self];
//        [self.cycleScrollView setPageControlStyle:SDCycleScrollViewPageContolStyleAnimated];
//        [self.cycleScrollView setScrollDirection:UICollectionViewScrollDirectionHorizontal];
//        [self.view addSubview:self.cycleScrollView];
//
//
//        //!< 添加六宫格菜单
//        [self.functionMenuControl resetFrame:CGRectMake(0, (self.cycleScrollView.bottom+20.0), SCREEN_WIDTH, (SCREEN_HEIGHT-(self.cycleScrollView.bottom+20.0)))];
//        [self.view addSubview:self.functionMenuControl];
//        [self.functionMenuControl setItemArray:self.itemArray];
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
#pragma mark case 3 食谱
        case 3:
        {
            if ([self refreshChild])
            {
                XHCookBookViewController *cookBook = [[XHCookBookViewController alloc]initHiddenWhenPushHidden];
                [self.navigationController pushViewController:cookBook animated:YES];
            }
            
        }
            break;
#pragma mark case 4 课程表
        case 4:
        {
            if ([self refreshChild])
            {
                XHSyllabusViewController *syllabus = [[XHSyllabusViewController alloc]initHiddenWhenPushHidden];
                [self.navigationController pushViewController:syllabus animated:YES];
            }
            
        }
            break;
#pragma mark case 5 成绩
        case 5:
        {
            if ([self refreshChild])
            {
                XHAchievementViewController *achievement = [[XHAchievementViewController alloc]initHiddenWhenPushHidden];
                [self.navigationController pushViewController:achievement animated:YES];
            }
           
        }
            break;
#pragma mark case 6 请假
        case 6:
        {
            if ([self refreshChild])
            {
                XHAskforLeaveViewController *leave = [[XHAskforLeaveViewController alloc]initHiddenWhenPushHidden];
                [self.navigationController pushViewController:leave animated:YES];
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

-(NSMutableArray *)itemArray
{
    if (_itemArray == nil)
    {
        NSArray *array = @[@"考勤记录",@"安全定位",@"成绩",@"食谱",@"课程表",@"请假",@"安全定位",@"成绩",@"食谱"];
        _itemArray = [NSMutableArray array];
        [array enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL *stop)
         {
             NSString *iconName = [array objectAtIndex:idx];
             XHFunctionMenuFrame *frame = [[XHFunctionMenuFrame alloc]init];
             XHFunctionMenuModel *model = [[XHFunctionMenuModel alloc]init];
             [model setTitle:obj];
             [model setTage:idx];
             [model setIconName:[NSString safeString:iconName]];
             [frame setModel:model];
             [_itemArray addObject:frame];
         }];
    }
    return _itemArray;
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


#pragma mark 九宫格功能视图
-(XHFunctionMenuControl *)functionMenuControl
{
    if (_functionMenuControl == nil)
    {
        _functionMenuControl = [[XHFunctionMenuControl alloc]init];
    }
    return _functionMenuControl;
}




@end
