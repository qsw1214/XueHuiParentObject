//
//  BaseNavigationControlItem.h
//  BaseViewController
//
//  Created by Git on 17/7/10.
//  Copyright © 2017年 Object. All rights reserved.
//






#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,BaseNavigationControlItemContentType)
{
    NavigationTitleType = 0,  //标题类型
    NavigationIconype = 1, //图标类型
    NavigationIconAndTitle = 2, //图标和标题类型
};


typedef NS_ENUM(NSInteger,BaseNavigationControlItemType)
{
    NavigationItemLeftType = 0,  //左侧类型
    NavigationItemRightype = 1, //右侧类型
    NavigationItemLeftAndRightype = 2, //左右侧类型
};



typedef NS_ENUM(NSInteger,BaseNavigationControlItemHiddenType)
{
    NavigationLeftType = 1, //隐藏左侧item
    NavigationRightType = 2, //隐藏右侧item
    NavigationLeftAndRight = 3, //隐藏两侧item
};




@interface BaseNavigationControlItem : UIControl



#pragma mark 设置按钮的样式
-(void)setItemContentType:(BaseNavigationControlItemContentType)contentType withItemType:(BaseNavigationControlItemType)itemType withIconName:(NSString*)iconName withTitle:(NSString*)title;

#pragma mark 设置按钮的隐藏类型
-(void)setItemContentItemHiddenWithType:(BaseNavigationControlItemHiddenType)hiddenType withHidden:(BOOL)hidden;


#pragma mark 设置标题
-(void)setTitle:(NSString*)title;
#pragma mark 设置标题
-(void)setTextColor:(UIColor*)color;
#pragma mark 设置图标名称
-(void)setImageName:(NSString*)imageName;


@end
