//
//  XHFamilyModel.m
//  daycareParent
//
//  Created by 钧泰科技 on 2017/12/15.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHFamilyModel.h"

@implementation XHFamilyModel

-(id)initWithDic:(NSDictionary *)Dic
{
    if (self=[super init]) {
        NSDictionary *dic=[Dic objectItemKey:@"propValue"];
        _familyId=[dic objectItemKey:@"familyId"];
        _guardianId=[dic objectItemKey:@"guardianId"];
        _guardianName=[dic objectItemKey:@"guardianName"];
        _headPic=[dic objectItemKey:@"headPic"];
        _ID=[dic objectItemKey:@"id"];
        _sex=[dic objectItemKey:@"sex"];
        if ([_sex integerValue]==0) {
            _sexName=@"女";
        }
        else
            {
                _sexName=@"男";
            }
        _type=[dic objectItemKey:@"type"];
        _typeName=FAMILY_TIES[[_type integerValue] -1];
        _isMajor=[dic objectItemKey:@"isMajor"];
    }
    return self;
}
@end
