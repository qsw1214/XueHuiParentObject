//
//  XHLeaveRecordModel.h
//  daycareParent
//
//  Created by Git on 2017/12/4.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"

@interface XHLeaveRecordModel : BaseModel

@property (nonatomic,copy) NSString *title; //!< 标题
@property (nonatomic,copy) NSString *studentBaseId; //!< 学生id
@property (nonatomic,copy) NSString *beginTime; //!< 开始时间
@property (nonatomic,copy) NSString *bizcnt; //!< 请假多少节
@property (nonatomic,copy) NSString *studentName; //!< 学生名字
@property (nonatomic,copy) NSString *scheduleflg; //!< 是否录入课程 0：未录入，1：已录入







@end
