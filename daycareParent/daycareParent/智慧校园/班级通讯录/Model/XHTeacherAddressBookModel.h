//
//  XHTeacherAddressBookModel.h
//  daycareParent
//
//  Created by Git on 2017/12/13.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "BaseModel.h"


typedef NS_ENUM(NSInteger,XHTeacherAddressBookMarkType)
{
    XHTeacherAddressBookMarkNormalType = 1, //!< 正常状态
    XHTeacherAddressBookMarkSelectedType = 2,//!< 选中状态
};





@interface XHTeacherAddressBookModel : BaseModel

@property (nonatomic,copy) NSString *key; //!< 索引的key值
@property (nonatomic,copy) NSString *headerUrl; //!< 头像
@property (nonatomic,copy) NSString *teacherName; //!< 头像
@property (nonatomic,copy) NSString *phone; //!< 头像
@property (nonatomic,copy) NSString *ID; //!< id

@property (nonatomic,assign) XHTeacherAddressBookMarkType markType; //!< 选中状态

@end
