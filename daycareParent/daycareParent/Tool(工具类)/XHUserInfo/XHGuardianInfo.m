//
//  XHGuardianInfo.m
//  daycareParent
//
//  Created by 钧泰科技 on 2017/12/13.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHGuardianInfo.h"
#import "AppDelegate.h"
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
        _headPic=[object objectItemKey:@"headPic"];
        _type=[object objectItemKey:@"type"];
        if ([_type integerValue]) {
            _typeName=kFamilyList[[_type integerValue]-1];
        }
       
        if ([_sex integerValue]) {
            _sexName=@"男";
        }
        else
            {
                _sexName=@"女";
            }
        [self getSum];
    }
    return self;
}
-(void)getSum
{
    XHNetWorkConfig *net=[XHNetWorkConfig new];
    [net setObject:self.guardianId forKey:@"guardianId"];
    [net postWithUrl:@"zzjt-app-api_smartCampus018" sucess:^(id object, BOOL verifyObject) {
        if (verifyObject) {
            NSDictionary *dic=[object objectItemKey:@"object"];
            
            NSDictionary *schoolWorkDic=[dic objectItemKey:@"schoolWork"];
            
            [XHUserInfo sharedUserInfo].sum=0;
            [XHUserInfo sharedUserInfo].sum=[XHUserInfo sharedUserInfo].sum+[[[schoolWorkDic objectItemKey:@"propValue"] objectItemKey:@"unreadCount"] integerValue];
            [XHUserInfo sharedUserInfo].sum=[XHUserInfo sharedUserInfo].sum+[[dic objectItemKey:@"noticeUnReadNum"] integerValue];
          
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
            [app reloadIMBadge];
        });
    } error:^(NSError *error) {}];
}
@end
