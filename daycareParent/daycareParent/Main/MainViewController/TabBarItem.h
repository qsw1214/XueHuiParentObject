//
//  TabBarItem.h
//  ZhongBangShop
//
//  Created by Git on 2017/10/12.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TabBarItem : UITabBarItem



#pragma mark 自定义初始化方法
/**
 title:item的标题
 imageName:未选中时候的图片
 selectedImageName:选中时候的图片
 */
-(instancetype)initWithTitle:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName;


@end
