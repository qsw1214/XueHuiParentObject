//
//  XHDynamicsModel.h
//  daycareParent
//
//  Created by Git on 2017/12/14.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "BaseModel.h"
#import "XHPreviewModel.h"
#import "ZFPlayerModel.h"
#import "XHDynamicsHeaderControl.h"

typedef NS_ENUM(NSInteger,XHDynamicsModelUnreadType)
{
    XHDynamicsAlreadyReadType = 1, //!< 已读
    XHDynamicsUnreadType = 2,   //!< 未读
};

typedef NS_ENUM(NSInteger,XHDynamicsModelPlayerType)
{
    XHDynamicsPauseType = 0,   //!< 未播放
    XHDynamicsPlayerType = 1, //!< 播放
};




typedef NS_ENUM(NSInteger,XHDynamicsModelType)
{
    XHDynamicsModelTextType = 1, //!< 纯文字类型
    XHDynamicsModelTextAndImageType = 2, //!< 文字和图片类型
    XHDynamicsModelTextAndVideoType = 3, //!< 文字和视频类型
};



@interface XHDynamicsModel : BaseModel



@property (nonatomic,strong) NSString *headerUrl; //!< 头像url地址
@property (nonatomic,strong) NSString *teacherName; //!< 名字
@property (nonatomic,strong) NSString *date; //!< 日期
@property (nonatomic,strong) NSMutableArray *dateArray; //!< 日期分割数组
@property (nonatomic,strong) NSString *workUnit; //!< 工作单位
@property (nonatomic,strong) NSString *content; //!< 内容
@property (nonatomic,strong) NSString *videoUrl; //!< 视频的url地址
@property (nonatomic,strong) NSString *videoPreviewUrl; //!< 视频预览url地址
@property (nonatomic,strong) NSString *noticeActorId; //!< 列表id
//noticeActorId
@property (nonatomic,strong) NSMutableArray <XHPreviewModel*> *imageUrlArray; //!< 图片数组
@property (nonatomic,assign) XHDynamicsModelType modelType; //!< 数据模型类型
@property (nonatomic,strong) ZFPlayerModel *playModel; //!< 播放视频数据模型
@property (nonatomic,assign) XHDynamicsModelUnreadType dynamicskUnreadType; //!< 是否已读取枚举类型
@property (nonatomic,assign) XHDynamicsModelPlayerType playType; //!< 播放状态
@property (nonatomic,strong) XHDynamicsHeaderControl *readHeaderControl; //!< 头像视图



@property (nonatomic,copy) NSString *unreadType; //!< 获取的已读类型
-(void)setItemArray:(NSArray*)array;


@end
