//
//  XHSubjectModel.m
//  daycareParent
//
//  Created by 钧泰科技 on 2018/3/12.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHSubjectModel.h"

@implementation XHSubjectModel
-(instancetype)initWithDic:(NSDictionary *)dic
{
    if (self=[super init])
    {
        _sub=[dic objectItemKey:@"subjectName"];
    }
    return self;
}
@end
