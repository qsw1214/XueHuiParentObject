//
//  XHGuardianInfo.h
//  daycareParent
//
//  Created by 钧泰科技 on 2017/12/13.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XHGuardianInfo : NSObject
@property(nonatomic,copy)NSString *age,*birthDate;
@property(nonatomic,copy)NSString *familyId;//!< 家庭ID
@property(nonatomic,copy)NSString *guardianId;//!< 家长ID
@property(nonatomic,copy)NSString *guardianName;//!< 家长姓名
@property(nonatomic,copy)NSString *ID;//!< 监护人id
@property(nonatomic,copy)NSString *isMajor;//!< 是否为主要监护人,0不是,1是
@property(nonatomic,copy)NSString *isNeedMsg;//!< 是否接受通知推送
@property(nonatomic,copy)NSString *propValue_id;//!< id
@property(nonatomic,copy)NSString *sex;//!< 性别
@property(nonatomic,copy)NSString *sexName;//!< 性别
@property(nonatomic,copy)NSString *telphoneNumber;//!< 电话号码
@property(nonatomic,copy)NSString *type;//!< 和学生的关系(1:爸爸 2:妈妈 3:爷爷 4:奶奶 5:外公 6:外婆 7:其他)
@property(nonatomic,copy)NSString *typeName;//!< 和学生的关系

-(id)initWithDic:(NSDictionary *)object;
@end
