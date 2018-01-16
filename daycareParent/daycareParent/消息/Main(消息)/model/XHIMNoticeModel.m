//
//  XHIMNoticeModel.m
//  daycareParent
//
//  Created by 钧泰科技 on 2017/12/19.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHIMNoticeModel.h"

@implementation XHIMNoticeModel
-(id)initWithDic:(NSDictionary *)dic
{
    if (self=[super init])
    {
        _content=[dic objectItemKey:@"content"];
        _createTime=[dic objectItemKey:@"createTime"];
    }
    return self;
}
@end
