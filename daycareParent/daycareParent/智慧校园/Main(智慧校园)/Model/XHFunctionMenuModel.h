//
//  XHFunctionMenuModel.h
//  daycareParent
//
//  Created by Git on 2017/11/28.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#pragma mark 智慧校园主页->内容承载视图->功能视图->数据模型


typedef NS_ENUM(NSInteger,XHFunctionMenuModelType)
{
    FunctionMenuType = 1, //!< 功能菜单类型
    AdvertisementType = 2, //!< 广告类型
};





#import <Foundation/Foundation.h>
#import "BaseModel.h"

@interface XHFunctionMenuModel : BaseModel


@property (nonatomic,copy) NSString *iconName; //!< 图片名称
@property (nonatomic,copy) NSString *title;   //!< 标题
@property (nonatomic,assign) CGFloat sizeForItemWidth;

@property (nonatomic,assign) XHFunctionMenuModelType modelType; //!< 数据模型类型






@end
