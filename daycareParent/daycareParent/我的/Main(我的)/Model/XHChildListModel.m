//
//  XHChildListModel.m
//  daycareParent
//
//  Created by 钧泰科技 on 2017/12/14.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHChildListModel.h"
@implementation XHChildListModel
-(id)initWithDic:(NSDictionary *)dic
{
    if (self=[super init]) {
        _age=[dic objectItemKey:@"age"];
        _birthdate=[dic objectItemKey:@"birthdate"];
        _archiveId=[dic objectItemKey:@"archiveId"];
        _ID=[dic objectItemKey:@"id"];
        _clazzId=[dic objectItemKey:@"clazzId"];
        _clazzName=[dic objectItemKey:@"clazzName"];
        _familyId=[dic objectItemKey:@"familyId"];
        _gradeId=[dic objectItemKey:@"gradeId"];
        _gradeName=[dic objectItemKey:@"gradeName"];
        _headPic=[dic objectItemKey:@"headPic"];
        _latitude=[dic objectItemKey:@"latitude"];
        _longitude=[dic objectItemKey:@"longitude"];
        _propValue_studentId=[[dic objectItemKey:@"propValue"] objectItemKey:@"studentId"];
        _schoolAddress=[dic objectItemKey:@"schoolAddress"];
        _schoolName=[dic objectItemKey:@"schoolName"];
        _sex=[dic objectItemKey:@"sex"];
        _sexName=[dic objectItemKey:@"sexName"];
        _studentBaseId=[dic objectItemKey:@"studentBaseId"];
        _studentId=[dic objectItemKey:@"studentId"];
        _studentName=[dic objectItemKey:@"studentName"];
        _schoolId=[dic objectItemKey:@"schoolId"];
    }
    return self;
}

@end
