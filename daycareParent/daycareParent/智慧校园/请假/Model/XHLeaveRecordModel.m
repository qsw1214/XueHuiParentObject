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
    [self setStudentBaseId:[object objectItemKey:@"studentBaseId"]];
    [self setObjectID:[object objectItemKey:@"id"]];
    [self setStudentName:[object objectItemKey:@"studentName"]];
    [self setBizcnt:[object objectItemKey:@"bizcnt"]];
    [self setScheduleflg:[object objectItemKey:@"scheduleflg"]];
    NSArray *dateArray = [self.beginTime componentsSeparatedByString:@" "];
    
    if (dateArray)
    {
        NSString *firstDate = [dateArray firstObject];
        NSArray *yearArray = [firstDate componentsSeparatedByString:@"-"];
        if (yearArray)
        {
            NSString *year = [yearArray objectAtIndex:0];
            NSString *month = [yearArray objectAtIndex:1];
            NSString *day = [yearArray objectAtIndex:2];
            
            [self setTitle:[NSString stringWithFormat:@"%@于%@年%@月%@日请假，请假%@节",self.studentName,year,month,day,self.bizcnt]];
        }
        else
        {
            [self setTitle:[NSString stringWithFormat:@"%@请假,请假%@节",self.studentName,self.bizcnt]];
        }
       
    }
    else
    {
        [self setTitle:[NSString stringWithFormat:@"%@请假,请假%@节",self.studentName,self.bizcnt]];
    }
    
    if ([self.scheduleflg isEqualToString:@"0"])
    {
        [self setTitle:[NSString stringWithFormat:@"%@ (未录入课程表)",self.title]];
    }
}



@end
