//
//  XHEducationCloudContentView.h
//  daycareParent
//
//  Created by Git on 2017/12/11.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#pragma mark 浩学云承载视图



#import "BaseControl.h"
#import "BaseScrollView.h"



@interface XHEducationCloudContentView : BaseScrollView



-(instancetype)initWithDeletage:(id)deletage;


-(void)resetFrame:(CGRect)frame;

/**
 设置轮播图片url地址的数组

 @param array 轮播图片的url地址数组
 */
-(void)setImageUrlArray:(NSMutableArray*)array;

/**
 设置六宫格菜单数组
 
 @param array 六宫格菜单数据数组
 */
-(void)setMenuItemArray:(NSMutableArray*)array;

/**
 设置切换菜单数据数组

 @param array 设置切换菜单数据源数组
 */
-(void)setSwitchMenuItemArray:(NSMutableArray*)array;


/**
 添加数据

 @param model 是否添加数据
 */
-(void)addSwitchModel:(BOOL)model;







@end
