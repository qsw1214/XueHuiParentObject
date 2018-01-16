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



#import <Foundation/Foundation.h>

@interface XHChildListModel : NSObject

@property(copy,nonatomic)NSString *age,*archiveId,*birthdate,*clazzId,*clazzName,*familyId,*gradeId,*gradeName,*headPic,*ID,*latitude,*longitude,*propValue_studentId,*schoolAddress,*schoolId,*schoolName,*sex,*sexName,*studentBaseId,*studentId,*studentName;


@property (nonatomic,assign) ChildListMarkType markType;

-(id)initWithDic:(NSDictionary *)Dic;
@end
