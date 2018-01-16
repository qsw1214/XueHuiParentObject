//
//  XHVIPModel.m
//  daycareParent
//
//  Created by 钧泰科技 on 2017/12/14.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHVIPModel.h"
/*
 @property(nonatomic,copy)NSString *level;//!< 会员等级（1：白金会员、2：黄金会员）
 @property(nonatomic,copy)NSString *expireType;//!< （0：未购买、1：已购买未过期、2：已购买已过期）
 @property(nonatomic,copy)NSString *day;//!< 会员剩余天数
 */
@implementation XHVIPModel
-(id)initWithDic:(NSDictionary *)dic
{
    if (self=[super init]) {
        _level=[dic objectItemKey:@"level"];
        _expireType=[dic objectItemKey:@"expireType"];
        _day=[dic objectItemKey:@"day"];
    }
    return self;
}
@end
