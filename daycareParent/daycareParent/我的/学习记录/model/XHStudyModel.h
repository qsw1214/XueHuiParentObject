//
//  XHStudyModel.h
//  daycareParent
//
//  Created by mac on 2017/12/7.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "BaseModel.h"

@interface XHStudyModel : BaseModel
@property(nonatomic,copy)NSString*record_type;//!< 记录类型：1：学习记录；2：收藏记录；3：下载记录

@property(nonatomic,copy)NSString*resource_type;//!< 资源类型 1：视频，2：试题

@property(nonatomic,copy)NSString *create_time,*record_id,*remark,*resource_id,*resource_name,*resource_path,*resource_thumbnail,*update_time,*user_id;
-(id)initWithDic:(NSDictionary *)dic;
@end
