//
//  XHNoticeModel.h
//  daycareParent
//
//  Created by Git on 2017/11/30.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "BaseModel.h"
#import "XHPreviewModel.h"
#import "ZFPlayerModel.h"


typedef NS_ENUM(NSInteger,XHNoticeContentType)
{
    XHNoticeTextType = 1, //!< 纯文字类型
    XHNoticeTextAndImageType = 2, //!< 文字和图片类型
    XHNoticeTextAndVideoType = 3, //!< 文字和视频类型
};



typedef NS_ENUM(NSInteger,NoticeModelUnreadType)
{
    NoticeAlreadyReadType = 1, //!< 已读
    NoticeUnreadType = 2,   //!< 未读
};



typedef NS_ENUM(NSInteger,NoticeModelType)
{
    NoticeType = 1, //!< 通知
    NoticeDetailsType = 2,   //!< 通知详情
};


@interface XHNoticeModel : BaseModel

@property (nonatomic,copy) NSString *headerUrl; //!< 头像
@property (nonatomic,copy) NSString *userName; //!< 用户名
@property (nonatomic,copy) NSString *content; //!< 作业内容
@property (nonatomic,copy) NSString *releaseDate; //!< 作业发布日期
@property (nonatomic,copy) NSString *unreadType; //!< 获取的已读类型
@property (nonatomic,copy) NSString *noticeActorId; //!< 当前通知的ID
@property (nonatomic,strong) NSString *schoolName; //!< 学校名字
@property (nonatomic,copy) NSString *className; //!< 班级名字
@property (nonatomic,copy) NSString *vedioUrl;  //!< 视频播放url地址
@property (nonatomic,copy) NSString *vedioAllUrl;  //!< 视频播放url地址
@property (nonatomic,copy) NSString *vedioFirstPicUrl; //!< 视频预览图
@property (nonatomic,strong) ZFPlayerModel *playModel; //!< 播放数据模型
@property (nonatomic,strong) NSMutableArray <XHPreviewModel*> *imageUrlArray; //!< 图片的Url数组
@property (nonatomic,assign) NoticeModelUnreadType noticekUnreadType; //!< 是否已读取枚举类型
@property (nonatomic,assign) NoticeModelType noticeType; //!< 数据模型的类型
@property (nonatomic,assign) XHNoticeContentType contentType; //!< 内容类型


@end
