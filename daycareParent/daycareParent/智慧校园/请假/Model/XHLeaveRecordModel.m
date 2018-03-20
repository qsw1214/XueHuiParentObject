//
//  XHLeaveRecordModel.m
//  daycareParent
//
//  Created by Git on 2017/12/4.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHLeaveRecordModel.h"

@implementation XHLeaveRecordModel



-(void)setItemObject:(NSDictionary *)object
{
    
    [self setBeginTime:[object objectItemKey:@"beginTime"]];
    [self setEndTime:[object objectItemKey:@"endTime"]];
    [self setStudentBaseId:[object objectItemKey:@"studentBaseId"]];
    [self setObjectID:[object objectItemKey:@"id"]];
    [self setStudentName:[object objectItemKey:@"studentName"]];
    [self setBizDays:[object objectItemKey:@"bizDays"]];
    [self setScheduleflg:[object objectItemKey:@"scheduleflg"]];
    NSArray *beginArray = [self.beginTime componentsSeparatedByString:@" "];
     NSArray *endArray = [self.endTime componentsSeparatedByString:@" "];
    if (beginArray&&endArray)
    {
        NSString *beginDate = [beginArray firstObject];
        NSArray *begin_yearArray = [beginDate componentsSeparatedByString:@"-"];
        
        NSString *endDate = [endArray firstObject];
        NSArray *end_yearArray = [endDate componentsSeparatedByString:@"-"];
        
        if (begin_yearArray&&endArray)
        {
           // NSString *begin_year = [begin_yearArray objectAtIndex:0];
            NSString *begin_month = [begin_yearArray objectAtIndex:1];
            NSString *begin_day = [begin_yearArray objectAtIndex:2];
            
            //NSString *end_year = [end_yearArray objectAtIndex:0];
            NSString *end_month = [end_yearArray objectAtIndex:1];
            NSString *end_day = [end_yearArray objectAtIndex:2];
            
            [self setTitle:[NSString stringWithFormat:@"%@于%@月%@日至%@月%@日请假，请假%@节",self.studentName,begin_month,begin_day,end_month,end_day,self.bizDays]];
        }
        else
        {
            [self setTitle:[NSString stringWithFormat:@"%@请假,请假%@节",self.studentName,self.bizDays]];
        }
       
    }
    else
    {
        [self setTitle:[NSString stringWithFormat:@"%@请假,请假%@节",self.studentName,self.bizDays]];
    }
    
    if ([self.scheduleflg isEqualToString:@"0"])
    {
        [self setTitle:[NSString stringWithFormat:@"%@ (未录入课程表)",self.title]];
    }
}



@end
