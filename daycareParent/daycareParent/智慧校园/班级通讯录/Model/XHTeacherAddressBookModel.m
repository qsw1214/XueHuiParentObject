//
//  XHTeacherAddressBookModel.m
//  daycareParent
//
//  Created by Git on 2017/12/13.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHTeacherAddressBookModel.h"

@implementation XHTeacherAddressBookModel

-(void)setTeacherName:(NSString *)teacherName
{
    _teacherName = teacherName;
    [self setKey:[_teacherName getFirstLetterFromString]];
}


-(void)setItemObject:(NSDictionary *)object
{
    [self setTeacherName:[object objectItemKey:@"teacherName"]];
    [self setHeaderUrl:ALGetFileHeadThumbnail([object objectItemKey:@"headPic"])];
    [self setPhone:[object objectItemKey:@"telphoneNumber"]];
    [self setObjectID:[object objectItemKey:@"teacherId"]];
    [self setMarkType:XHTeacherAddressBookMarkNormalType];
    [self setID:[object objectItemKey:@"id"]];
}

@end
