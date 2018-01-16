//
//  XHGuardianInfo.m
//  daycareParent
//
//  Created by 钧泰科技 on 2017/12/13.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHGuardianInfo.h"

@implementation XHGuardianInfo
-(id)initWithDic:(NSDictionary *)object
{
    if (self=[super init]) {
        _age=[object objectItemKey:@"age"];
        _birthDate=[object objectItemKey:@"birthDate"];
        _familyId=[object objectItemKey:@"familyId"];
        _guardianId=[object objectItemKey:@"guardianId"];
        _ID=[object objectItemKey:@"id"];
        _isMajor=[object objectItemKey:@"isMajor"];
        _propValue_id=[[object objectItemKey:@"propValue"] objectItemKey:@"id"];
        _sex=[object objectItemKey:@"sex"];
        _telphoneNumber=[object objectItemKey:@"telphoneNumber"];
        _guardianName=[object objectItemKey:@"guardianName"];
        _type=[object objectItemKey:@"type"];
        if ([_type integerValue]) {
            _typeName=FAMILY_TIES[[_type integerValue]-1];
        }
       
        if ([_sex integerValue]) {
            _sexName=@"男";
        }
        else
            {
                _sexName=@"女";
            }
    }
    return self;
}
@end
