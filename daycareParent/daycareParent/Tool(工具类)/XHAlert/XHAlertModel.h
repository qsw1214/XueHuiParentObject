//
//  XHAlertModel.h
//  daycareParent
//
//  Created by mac on 2018/3/16.
//  Copyright © 2018年 XueHui. All rights reserved.
//



typedef NS_ENUM(NSInteger,XHAlertModelType)
{
    XHAlertNormalType = 1, //!< 未选中状态
    XHAlertSelectType = 2, //!< 选中状态
};

#import "BaseModel.h"

@interface XHAlertModel : BaseModel


@property (nonatomic,copy) NSString *name;
@property (nonatomic,assign) CGSize itemSize;  //!< 每个item的大小
@property (nonatomic,assign) XHAlertModelType modelType; //!< 数据模型的类型

@end
