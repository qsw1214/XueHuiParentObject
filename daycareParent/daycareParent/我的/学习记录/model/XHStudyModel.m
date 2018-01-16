//
//  XHStudyModel.m
//  daycareParent
//
//  Created by mac on 2017/12/7.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHStudyModel.h"

@implementation XHStudyModel
-(id)initWithDic:(NSDictionary *)dic
{
    if (self=[super init]) {
        _record_type=[dic objectItemKey:@"record_type"];
        _resource_type=[dic objectItemKey:@"resource_type"];
        _create_time=[dic objectItemKey:@"create_time"];
        _record_id=[dic objectItemKey:@"record_id"];
        _remark=[dic objectItemKey:@"remark"];
        _resource_id=[dic objectItemKey:@"resource_id"];
        _resource_name=[dic objectItemKey:@"resource_name"];
        _resource_path=[dic objectItemKey:@"resource_path"];
        _resource_thumbnail=[dic objectItemKey:@"resource_thumbnail"];
        _update_time=[dic objectItemKey:@"update_time"];
        _user_id=[dic objectItemKey:@"user_id"];
    }
    return self;
}
@end
