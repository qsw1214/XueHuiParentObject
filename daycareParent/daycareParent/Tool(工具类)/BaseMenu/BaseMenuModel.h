//
//  BaseMenuModel.h
//  daycareParent
//
//  Created by Git on 2017/12/6.
//  Copyright © 2017年 XueHui. All rights reserved.
//


#pragma mark 菜单数据模型



typedef NS_ENUM(NSInteger,BaseMenuModelSelectType)
{
    BaseMenuNormalType = 1, //!< 正常状态
    BaseMenuSelectType = 2, //!< 选中状态
};


typedef NS_ENUM(NSInteger,BaseMenuMarkLineType)
{
    BaseMenuBottomLineType = 0, //!< 选中分割线在下面
    BaseMenuTopLineType = 1, //!< 选中分割线在上面
};


#import <Foundation/Foundation.h>
#import "BaseModel.h"

@interface BaseMenuModel : BaseModel


@property (nonatomic,copy) NSString *title; //!< 当前标题
@property (nonatomic,assign) CGSize itemSize; //!< 单个数据模型的大小
@property (nonatomic,strong) UIFont *font; //!< 单钱数据模型的大小
@property (nonatomic,strong) UIColor *selectColor; //!< 选中状态下字体颜色
@property (nonatomic,strong) UIColor *normalColor; //!< 正常状态下字体颜色

@property (nonatomic,strong) UIColor *markColor; //!< 选中分割线
@property (nonatomic,assign) BaseMenuMarkLineType markLineType; //!< 选中分割线的分布状态
@property (nonatomic,assign) BaseMenuModelSelectType selectType; //!< 是否选中
@property (nonatomic,strong) NSMutableArray *dataArray; //!< 数据源数组






@end
