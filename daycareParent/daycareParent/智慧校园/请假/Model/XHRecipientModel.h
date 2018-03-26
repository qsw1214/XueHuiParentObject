//
//  XHRecipientModel.h
//  daycareParent
//
//  Created by 钧泰科技 on 2018/3/13.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "ParentModel.h"

typedef NS_ENUM(NSInteger,XHRecipientModelType)
{
    XHRecipientAddModelType = 1 ,//!< 添加数据模型

    XHRecipientNomalModelType = 2 ,//!<数据模型
};

@interface XHRecipientModel : ParentModel

@property(nonatomic,copy)NSString *name;//!< 接收人名字
@property(nonatomic,copy)NSString *headPic;//!< 接收人头像
@property(nonatomic,copy)NSString *ID;//!< 接收人id
@property(nonatomic,assign)XHRecipientModelType modelType;

@end
