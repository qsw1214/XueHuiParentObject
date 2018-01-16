//
//  TabBarItem.m
//  ZhongBangShop
//
//  Created by Git on 2017/10/12.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "TabBarItem.h"

@implementation TabBarItem


-(instancetype)initWithTitle:(NSString *)title imageName:(NSString *)image selectedImageName:(NSString *)selectedImage
{
    UIImage *unselectedImageMessage = [UIImage imageNamed:image];
    UIImage *selectedImageMessage = [UIImage imageNamed:selectedImage];
    //显示原图
    unselectedImageMessage = [unselectedImageMessage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    selectedImageMessage = [selectedImageMessage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //初始化
    self = [super initWithTitle:title image:unselectedImageMessage selectedImage:selectedImageMessage];
    if (self)
    {
        [self setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor grayColor],NSForegroundColorAttributeName,[UIFont systemFontOfSize:10.0f],NSFontAttributeName, nil] forState:UIControlStateSelected];
        [self setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:10.0f],NSFontAttributeName, nil] forState:UIControlStateNormal];
    }
    return self;
}



@end
