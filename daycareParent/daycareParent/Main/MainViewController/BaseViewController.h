//
//  BaseViewController.h
//  liaotian
//
//  Created by Git on 17/7/10.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseNavigationView.h"
#import "XHChildListModel.h"
#import "XHNetWorkConfig.h"
#import "XHCustomView.h"//!< 孩子列表自定义视图







@interface BaseViewController : UIViewController 

@property (nonatomic,assign) BOOL isLogin;  //当前视图控制器是否登录过
@property (nonatomic,strong) BaseNavigationView  *navigationView;
@property (nonatomic,strong) NSMutableArray *dataArray; //!< 数组
@property (nonatomic,strong) XHNetWorkConfig *netWorkConfig;
@property(nonatomic,strong)XHCustomView *childListView;
@property(nonatomic,copy)void(^isRefresh)(BOOL);
#pragma mark 初始化Tabbar自动隐藏
-(instancetype)initHiddenWhenPushHidden;


#pragma mark 设置按钮的样式
/**
 设置按钮的样式
 @param contentType 设置按钮的类型（标题、标题加图片、图片）
 @param itemType  设置那边的按钮 （左边、右边）
 @param iconName 图片的名字
 @param title 标题
 */
-(void)setItemContentType:(BaseNavigationControlItemContentType)contentType withItemType:(BaseNavigationControlItemType)itemType withIconName:(NSString*)iconName withTitle:(NSString*)title;

#pragma mark 设置按钮的隐藏类型
-(void)setItemContentItemHiddenWithType:(BaseNavigationControlItemHiddenType)hiddenType withHidden:(BOOL)hidden;

#pragma mark 设置标题
-(void)setNavtionTitle:(NSString*)title;
#pragma mark 设置标题颜色
-(void)setNavtionTitleColor:(UIColor*)color;
#pragma mark 设置标题颜色
-(void)setNavtionColor:(UIColor*)color;

#pragma mark 设置左标题
-(void)setLeftItemTitle:(NSString*)title;
#pragma mark 设置右标题
-(void)setRightItemTitle:(NSString*)title;
#pragma mark 设置左右标题的颜色
-(void)setItemTextColor:(UIColor*)color withItemType:(BaseNavigationControlItemType)type;

#pragma mark 设置左图标
-(void)setLeftImageName:(NSString*)imageName;
#pragma mark 设置右图标
-(void)setRightImageName:(NSString*)imageName;


#pragma mark 左侧按钮相应的方法
-(void)letfItemAction:(BaseNavigationControlItem*)sender;

#pragma mark 右侧按钮相应的方法
-(void)rightItemAction:(BaseNavigationControlItem*)sender;

#pragma mark 隐藏导航栏
-(void)navtionHidden:(BOOL)hidden;

#pragma mark 隐藏导航看左右按钮
-(void)navtionItemHidden:(BaseNavigationControlItemType)item;


-(void)addSubViews:(BOOL)subview;



/**
根据孩子列表数据数组，是否显示向下箭头
 @param array 孩子列表数组
 */
-(void)setChildListArry:(NSArray*)array;


@end
