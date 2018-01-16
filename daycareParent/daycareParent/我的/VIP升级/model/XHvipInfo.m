//
//  XHvipInfo.m
//  daycareParent
//
//  Created by 钧泰科技 on 2017/12/18.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHvipInfo.h"

@implementation XHvipInfo
-(id)initWithDic:(NSDictionary *)dic
{
    if (self=[super init]) {
        _isBuy=[dic objectItemKey:@"isBuy"];
        _unit=[dic objectItemKey:@"unit"];
        _unitName=[dic objectItemKey:@"unitName"];
        _level=[dic objectItemKey:@"level"];
        _price=[dic objectItemKey:@"price"];
        _name=[dic objectItemKey:@"name"];
        _ID=[dic objectItemKey:@"id"];
        _isActive=[dic objectItemKey:@"isActive"];
    }
    return self;
}
@end
