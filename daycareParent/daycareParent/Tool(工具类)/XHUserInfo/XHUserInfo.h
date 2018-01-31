//
//  XHUserInfo.h
//  daycareParent
//
//  Created by Git on 2017/12/12.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XHGuardianInfo.h"
@interface XHUserInfo : NSObject

@property (nonatomic,copy) NSString *age; //!< age
@property (nonatomic,copy) NSString *birthdate;//!< birthdate
@property (nonatomic,copy) NSString *headPic;//!< 头像
@property (nonatomic,copy) NSString *ID;//!< ID
@property (nonatomic,copy) NSString *loginName;//!< 登录名
@property (nonatomic,copy) NSString *nickName;//!<  用户昵称
@property (nonatomic,copy) NSString *selfId;//!< 教师家长表ID
@property (nonatomic,copy) NSString *sessionId;//!< sessionId
@property (nonatomic,copy) NSString *sex;//!< 性别
@property (nonatomic,copy) NSString *sexName;//!< 性别
@property (nonatomic,copy) NSString *signature;//!< 签名
@property (nonatomic,copy) NSString *telphoneNumber;//!< 电话
@property (nonatomic,copy) NSString *token; //!<token
@property (nonatomic,copy) NSString *primaryFamilyId; //!<主监护人家庭ID
@property (nonatomic,strong) XHGuardianInfo *guardianModel; //!<主监护人信息
@property (nonatomic,strong) NSMutableArray <XHChildListModel*> *childListArry; //!<孩子列表信息
/**
 单例初始化方法
 
 @return 单例对象
 */


+ (instancetype)sharedUserInfo;



/**
 给单例赋值数据源

 @param object 传入数据源字典
 */
-(void)setItemObject:(NSDictionary*)object;
@end
