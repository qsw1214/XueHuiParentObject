//
//  XHIMModel.m
//  daycareParent
//
//  Created by 钧泰科技 on 2018/3/28.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHIMModel.h"

@implementation XHIMModel
-(id)initWithDic:(NSDictionary *)dic
{
    if (self=[super init]) {
        _RCContent=[dic objectItemKey:@"content"];
        _createTime=[dic objectItemKey:@"createTime"];
        _sum=[dic objectItemKey:@"unreadCount"];
    }
    return self;
}

@end
