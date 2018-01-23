//
//  XHLiveModel.h
//  daycareParent
//
//  Created by Git on 2018/1/10.
//  Copyright © 2018年 XueHui. All rights reserved.
//

typedef NS_ENUM(NSInteger,XHLiveContentType)
{
    XHLiveAdvertType = 1, //!< 广告类型
    XHLiveItemType = 2, //!< 内容类型
};

typedef NS_ENUM(NSInteger,XHLiveStatusType)
{
    XHLiveNormalType = 0, //!< 没有状态
    XHLiveingType = 1, //!< 正在播放
    XHLiveEndType = 2, //!< 已经结束
};







#import "BaseModel.h"

@interface XHLiveModel : BaseModel


@property (nonatomic,copy) NSString *imageUrl; //!< 图片的url地址或图片的名字
@property (nonatomic,copy) NSString *title; //!< 标题
@property (nonatomic,copy) NSString *date; //!< 日期
@property (nonatomic,copy) NSString *liveMark; //!< 播放状态
@property (nonatomic,copy) NSString *lectureTeacher; //!< 主讲老师
@property (nonatomic,copy) NSString *pull_stream_add; //!< 拉流地址
@property (nonatomic,copy) NSString *chatroom_id; //!< 聊天室id
@property (nonatomic,assign) XHLiveStatusType liveType; //!< 播放状态
@property (nonatomic,assign) XHLiveContentType contentType;


@end
