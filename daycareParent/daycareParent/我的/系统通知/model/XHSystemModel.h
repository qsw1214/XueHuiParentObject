//
//  XHSystemModel.h
//  daycareParent
//
//  Created by 钧泰科技 on 2018/3/14.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "ParentModel.h"

typedef NS_ENUM(NSInteger,XHSystemModelType)
{
    XHSystemNoticeType=2,//!< 通知类型

    XHSystemOtherType=3,//!< 活动类型

}
;

@interface XHSystemModel : ParentModel
@property(nonatomic,copy)NSString *title;//!< 标题
@property(nonatomic,copy)NSString *date;//!< 时间
@property(nonatomic,copy)NSString *content;//!< 内容
@property(nonatomic,assign)XHSystemModelType modelType;

@end
