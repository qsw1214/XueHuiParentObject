//
//  XHHomeWorkModel.h
//  daycareParent
//
//  Created by Git on 2017/11/30.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "BaseModel.h"
#import "XHPreviewModel.h"

typedef NS_ENUM(NSInteger,XHHomeWorkContentType)
{
    XHHomeWorkTextType = 1, //!< 纯文字类型
    XHHomeWorkTextAndImageType = 2, //!< 文字和图片类型
};

typedef NS_ENUM(NSInteger,HomeWorkModelUnreadType)
{
    HomeWorkAlreadyReadType = 1, //!< 已读
    HomeWorkUnreadType = 2,   //!< 未读
};



typedef NS_ENUM(NSInteger,HomeWorkModelType)
{
    HomeWorkType = 1, //!< 家庭作业
    HomeWorkDetailsType = 2,   //!< 家庭作业详情
};


@interface XHHomeWorkModel : BaseModel

@property (nonatomic,copy) NSString *headerUrl; //!< 头像
@property (nonatomic,copy) NSString *userName; //!< 用户名
@property (nonatomic,copy) NSString *subject; //!< 学科
@property (nonatomic,copy) NSString *workContent; //!< 作业内容
@property (nonatomic,copy) NSString *releaseDate; //!< 作业发布日期
@property (nonatomic,copy) NSString *unreadType; //!< 获取的已读类型
@property (nonatomic,copy) NSString *pushInfoId; //!< 作业列表ID
@property (nonatomic,copy) NSString *gradeName;  //!< 年级
@property (nonatomic,copy) NSString *clazzName; //!< 班级
@property (nonatomic,copy) NSString *vedioUrl;  //!< 视频播放url地址
@property (nonatomic,copy) NSString *vedioFirstPicUrl; //!< 视频预览图
@property (nonatomic,strong) NSMutableArray <XHPreviewModel*> *imageUrlArray; //!< 图片的Url数组
@property (nonatomic,strong) UIColor *subjectColor; //!< 学科颜色类型
@property (nonatomic,assign) HomeWorkModelUnreadType homeWorkUnreadType; //!< 是否已读取枚举类型
@property (nonatomic,assign) HomeWorkModelType homeWorkType; //!< 数据模型的类型

@property (nonatomic,assign) XHHomeWorkContentType contentType; //!< 内容类型

#pragma mark 设置家庭作业对象
//!< 设置家庭作业对象
-(void)setItemObject:(NSDictionary *)object;
//#pragma mark 设置通知对象
////!< 设置通知对象
//-(void)setNoticeItemObject:(NSDictionary*)object;


@end
