//
//  BaseViewController.m
//  liaotian
//
//  Created by Git on 17/7/10.
//  Copyright © 2017年 XueHui. All rights reserved.
//


#import "BaseViewController.h"

@interface BaseViewController ()




@end

@implementation BaseViewController

-(instancetype)initHiddenWhenPushHidden
{
    self = [super init];
    if (self)
    {
        [self setHidesBottomBarWhenPushed:YES];
    }
   return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    [self.view setBackgroundColor:RGB(245, 245, 245)];
    [self.navigationController.navigationBar setHidden:YES];
    [self.view addSubview:self.navigationView];
    [self.navigationView setNavtionTitleColor:RGB(44.0, 44.0, 44.0)];
    [self.navigationView resetFrame:CGRectMake(0, 0, SCREEN_WIDTH, [[XHHelper sharedHelper] isIphoneX] == 1 ? 64+30 :64)];
    [self setNavtionColor:[UIColor whiteColor]];
    [self setItemContentItemHiddenWithType:NavigationRightType withHidden:YES];
    [self setItemContentType:NavigationIconAndTitle withItemType:NavigationItemLeftType withIconName:@"arr_back" withTitle:@"返回"];
    [self addSubViews:YES];
    //去掉留白方法
    if (@available(iOS 11.0, *))
    {
        
    }
    else
    {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setHidden:YES];
   
}

-(BaseNavigationView *)navigationView
{
    if (_navigationView == nil)
    {
        _navigationView = [[BaseNavigationView alloc]init];
        [_navigationView.letfItem addTarget:self action:@selector(letfItemAction:) forControlEvents:UIControlEventTouchUpInside];
        [_navigationView.rightItem addTarget:self action:@selector(rightItemAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _navigationView;
}







#pragma mark 设置按钮的样式
-(void)setItemContentType:(BaseNavigationControlItemContentType)contentType withItemType:(BaseNavigationControlItemType)itemType withIconName:(NSString*)iconName withTitle:(NSString*)title
{
    [self.navigationView setItemContentType:contentType withItemType:itemType withIconName:iconName withTitle:title];
}

#pragma mark 设置按钮的隐藏类型
-(void)setItemContentItemHiddenWithType:(BaseNavigationControlItemHiddenType)hiddenType withHidden:(BOOL)hidden
{
    [self.navigationView setItemContentItemHiddenWithType:hiddenType withHidden:hidden];
}

#pragma mark 设置标题
-(void)setNavtionTitle:(NSString*)title
{
    [self.navigationView setNavtionTitle:title];
}

#pragma mark 设置标题颜色
-(void)setNavtionTitleColor:(UIColor*)color
{
    [self.navigationView setNavtionTitleColor:color];
}

-(void)setNavtionColor:(UIColor*)color
{
    [self.navigationView setBackgroundColor:color];
}



#pragma mark 设置左右标题的颜色
-(void)setItemTextColor:(UIColor*)color withItemType:(BaseNavigationControlItemType)type
{
    [self.navigationView setItemTextColor:color withItemType:type];
}




#pragma mark 设置左标题
-(void)setLeftItemTitle:(NSString*)title
{
    [self.navigationView setLeftItemTitle:title];
}
#pragma mark 设置右标题
-(void)setRightItemTitle:(NSString*)title
{
    [self.navigationView setRightItemTitle:title];
}



#pragma mark 设置左图标
-(void)setLeftImageName:(NSString*)imageName
{
    [self.navigationView setLeftImageName:imageName];
}



#pragma mark 设置右图标
-(void)setRightImageName:(NSString*)imageName
{
    [self.navigationView setRightImageName:imageName];
}

#pragma mark 左侧按钮相应的方法
-(void)letfItemAction:(BaseNavigationControlItem*)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark 右侧按钮相应的方法
-(void)rightItemAction:(BaseNavigationControlItem*)sender
{
    
}


#pragma mark 隐藏导航栏
-(void)navtionHidden:(BOOL)hidden
{
    [self.navigationView setHidden:hidden];
}

#pragma mark 隐藏导航看左右按钮
-(void)navtionItemHidden:(BaseNavigationControlItemType)item
{
    switch (item)
    {
        case NavigationItemLeftType:
        {
            [self.navigationView.letfItem setHidden:YES];
        }
            break;
        case NavigationItemRightype:
        {
            [self.navigationView.rightItem setHidden:YES];
        }
            break;
        case NavigationItemLeftAndRightype:
        {
            [self.navigationView.letfItem setHidden:YES];
            [self.navigationView.rightItem setHidden:YES];
        }
    }
}


-(void)addSubViews:(BOOL)subview
{
    
}


-(XHNetWorkConfig*)netWorkConfig
{
    if (!_netWorkConfig)
    {
        _netWorkConfig = [[XHNetWorkConfig alloc]init];
    }
    return _netWorkConfig;
}



/**
 根据孩子列表数据数组，是否显示向下箭头
 @param array 孩子列表数组
 */
-(void)setChildListArry:(NSArray*)array
{
    if ([array count] > 1)
    {
        XHChildListModel *model = [array firstObject];
        [self setItemContentType:NavigationIconAndTitle withItemType:NavigationItemRightype withIconName:@"ico-dorpdown" withTitle:[model studentName]];
    }
    
}




#pragma mark - Getter /  Setter
-(NSMutableArray *)dataArray
{
    if (_dataArray == nil)
    {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}


-(BaseTableView *)mainTableView
{
    if (!_mainTableView)
    {
        _mainTableView = [[BaseTableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        [_mainTableView setTipType:TipTitleAndTipImage withTipTitle:@"暂无数据" withTipImage:@"pic_nothing"];
    }
    return _mainTableView;
}












@end
