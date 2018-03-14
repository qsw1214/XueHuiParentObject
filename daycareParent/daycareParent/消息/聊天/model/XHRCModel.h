//
//  XHRCModel.h
//  daycareParent
//
//  Created by 钧泰科技 on 2018/3/12.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import <RongIMKit/RongIMKit.h>


typedef NS_ENUM(NSInteger,XHRCModelType)
{
    XHRCTeacherBookType=1,//!< 给老师留言

    XHRCHomeWorkType=2,//!< 家庭作业

    XHRCnoticeType=3,//!< 通知公告

};

@interface XHRCModel : RCConversationModel
@property(nonatomic,copy)NSString *RCtitle;//!<标题

@property(nonatomic,copy)NSString *RCtitlePic;//!< 头像

@property(nonatomic,copy)NSString *RCContent;//!< 内容

@property(nonatomic,copy)NSString *createTime;//!< 时间

@property(nonatomic,copy)NSString *sum;//!< 未读数字

@property(nonatomic,assign)NSInteger CellHeight;//!< 行高

@property(nonatomic,assign)XHRCModelType modelType;
-(id)initWithDic:(NSDictionary *)dic;
@end
