//
//  XHRegisterModel.m
//  daycareParent
//
//  Created by Git on 2017/11/29.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHRegisterModel.h"

@implementation XHRegisterModel


-(void)setItemObject:(NSDictionary *)object
{
    [self setTitle:[object objectItemKey:@"week"]];
    [self setDate:[object objectItemKey:@"attendanceDate"]];
    [self setTime:[object objectItemKey:@"attendancetime"]];
    
    NSString *timeType = [NSString safeString:[object objectItemKey:@"timeType"]];
    if ([timeType isEqualToString:@"上午"])
    {
         [self setMarkIcon:@"ico_morning"];
    }
    else if ([timeType isEqualToString:@"下午"])
    {
        [self setMarkIcon:@"ico_afternoon"];
    }
    else if ([timeType isEqualToString:@"晚上"])
    {
         [self setMarkIcon:@"ico_afternoon"];
    }
}




@end
