//
//  XHSyllabusModel.h
//  daycareParent
//
//  Created by Git on 2017/12/6.
//  Copyright © 2017年 XueHui. All rights reserved.
//


typedef NS_ENUM(NSInteger,XHSyllabusMarkModelType)
{
    XHSyllabusMarkType = 1,  //!< 标记
    XHSyllabusMarkNormalType = 2, //!< 正常
};




#import "BaseModel.h"

@interface XHSyllabusModel : BaseModel

@property (nonatomic,strong) NSString *month; //!< 时间标签
@property (nonatomic,strong) NSString *monthDescribe; //!< 时间标签
@property (nonatomic,strong) NSString *monday; //!< 周一标签
@property (nonatomic,strong) NSString *mondayDescribe; //!< 周一标签
@property (nonatomic,strong) NSString *tuesday; //!< 周二标签
@property (nonatomic,strong) NSString *tuesdayDescribe; //!< 周二标签
@property (nonatomic,strong) NSString *wednesday; //!< 周三标签
@property (nonatomic,strong) NSString *wednesdayDescribe; //!< 周三标签
@property (nonatomic,strong) NSString *thursday; //!< 周四标签
@property (nonatomic,strong) NSString *thursdayDescribe; //!< 周四标签
@property (nonatomic,strong) NSString *friday; //!< 周五标签
@property (nonatomic,strong) NSString *fridayDescribe; //!< 周五标签


@property (nonatomic,assign) NSInteger markType; //!< 周五标签

@end
