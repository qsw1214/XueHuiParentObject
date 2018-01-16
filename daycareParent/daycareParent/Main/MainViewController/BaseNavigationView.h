//
//  BaseNavigationView.h
//  liaotian
//
//  Created by Git on 17/7/10.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseNavigationControlItem.h"



@interface BaseNavigationView : UIView

@property (nonatomic,strong) BaseNavigationControlItem *letfItem;
@property (nonatomic,strong) BaseNavigationControlItem *rightItem;


#pragma mark 设置按钮的样式
-(void)setItemContentType:(BaseNavigationControlItemContentType)contentType withItemType:(BaseNavigationControlItemType)itemType withIconName:(NSString*)iconName withTitle:(NSString*)title;

#pragma mark 设置按钮的隐藏类型
-(void)setItemContentItemHiddenWithType:(BaseNavigationControlItemHiddenType)hiddenType withHidden:(BOOL)hidden;


#pragma mark 设置标题
-(void)setNavtionTitle:(NSString*)title;

#pragma mark 设置标题颜色
-(void)setNavtionTitleColor:(UIColor*)color;

#pragma mark 设置左标题
-(void)setLeftItemTitle:(NSString*)title;
#pragma mark 设置右标题
-(void)setRightItemTitle:(NSString*)title;

#pragma mark 设置左右按钮标题颜色
-(void)setItemTextColor:(UIColor*)color withItemType:(BaseNavigationControlItemType)type;



#pragma mark 设置左图标
-(void)setLeftImageName:(NSString*)imageName;
#pragma mark 设置右图标
-(void)setRightImageName:(NSString*)imageName;

@end

