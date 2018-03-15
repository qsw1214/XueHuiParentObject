//
//  XHChildListModel.h
//  daycareParent
//
//  Created by 钧泰科技 on 2017/12/14.
//  Copyright © 2017年 XueHui. All rights reserved.
//

typedef NS_ENUM(NSInteger,ChildListMarkType)
{
    ChildListNormalType = 0, //!< 未选中状态
    ChildListSelectType = 1, //!< 选中状态
};


typedef NS_ENUM(NSInteger,ChildListShowType)
{
    ChildListEntirelyType = 0, //!< 全部展示
    ChildListAloneType = 1, //!< 单独展示选中状态
};





#import <Foundation/Foundation.h>

@interface XHChildListModel : NSObject

@property(copy,nonatomic)NSString *age,*archiveId,*birthdate,*clazzId,*clazzName,*familyId,*gradeId,*gradeName,*headPic,*ID,*latitude,*longitude,*propValue_studentId,*schoolAddress,*schoolId,*schoolName,*sex,*sexName,*studentBaseId,*studentId,*studentName;


@property (nonatomic,assign) CGSize itemSize; //!< 当前孩子item的大小


@property (nonatomic,assign) ChildListMarkType markType;  //!< 注意必须先给 “showType”赋值
@property (nonatomic,assign) ChildListShowType showType;

-(id)initWithDic:(NSDictionary *)Dic;
@end
