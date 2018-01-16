//
//  XHFamilyListModel.m
//  daycareParent
//
//  Created by 钧泰科技 on 2017/12/16.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHFamilyListModel.h"
@implementation XHFamilyListModel
-(id)initWithDic:(NSDictionary *)dic
{
    if (self=[super init]) {
        _nickName=[dic objectItemKey:@"nickName"];
        _headPic=[dic objectItemKey:@"headPic"];
        _isMajor=[dic objectItemKey:@"isMajor"];
    }
    return self;
}

@end
