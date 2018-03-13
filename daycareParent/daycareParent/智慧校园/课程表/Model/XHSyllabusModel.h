//
//  XHSyllabusModel.h
//  daycareParent
//
//  Created by Git on 2017/12/6.
//  Copyright © 2017年 XueHui. All rights reserved.
//

typedef NS_ENUM(NSInteger,XHSyllabusModelType)
{
    SyllabusWeekType = 1, //!< 星期类型
    SyllabusContentType = 2, //!< 内容类型
};



#import "BaseModel.h"

@interface XHSyllabusModel : BaseModel

@property (nonatomic,copy) NSString *time;    //!< 上课时间
@property (nonatomic,copy) NSString *subject; //!< 学科
@property (nonatomic,copy) NSString *weekday; //!< 课程


@property (nonatomic,assign) XHSyllabusModelType modelType; //!< 数据模型类型

@end
