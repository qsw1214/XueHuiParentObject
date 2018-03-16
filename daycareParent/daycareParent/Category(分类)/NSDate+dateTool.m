//
//  NSDate+dateTool.m
//  daycareParent
//
//  Created by 钧泰科技 on 2018/1/25.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "NSDate+dateTool.h"

@implementation NSDate (dateTool)

#pragma mark  时间字符串转时间date
+(NSDate *)getDateWithDateStr:(NSString *)dateStr formatter:(NSString *)formatter
{
    NSDateFormatter *setDateFormatter = [[NSDateFormatter alloc] init];
    [setDateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Shanghai"]];
    
    [setDateFormatter setDateFormat:formatter];
    NSDate *date= [setDateFormatter dateFromString:dateStr];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    
    NSInteger interval = [zone secondsFromGMTForDate: date];
    
    NSDate *localeDate = [date  dateByAddingTimeInterval: interval];
    return localeDate;
}
#pragma mark  时间date转字符串
+(NSString *)getDateStrWithDateFormatter:(NSString *)dateFormatter Date:(NSDate *)date
{
    NSDateFormatter *dateFor = [[NSDateFormatter alloc]init];
    dateFor.dateFormat = dateFormatter;
    NSString * dateStr = [dateFor stringFromDate:date];
    return dateStr;
}
#pragma mark  时间字符串转换为指定时间格式字符串
+(NSString *)dateStr:(NSString *)dateStr FromFormatter:(NSString *)fromFormatter ToFormatter:(NSString *)toFormatter
{
    NSDateFormatter *setDateFormatter = [[NSDateFormatter alloc] init];
    [setDateFormatter setDateFormat:fromFormatter];
    NSDate *date= [setDateFormatter dateFromString:dateStr];
    NSDateFormatter *myDateFormatter = [[NSDateFormatter alloc] init];
    //设置日期格式
    [myDateFormatter setDateFormat:toFormatter];
    NSString *String=[myDateFormatter stringFromDate:date];
    return String;
}
#pragma mark  得到指定日期几天前的日期
+(NSDate *)getDayBeforWithDate:(NSDate *)date dayBefor:(NSInteger )dayBefor
{
    NSDate *lastDay = [NSDate dateWithTimeInterval:-24*60*60*dayBefor sinceDate:date];//前几天
    return lastDay;
}
#pragma mark  得到指定日期几天后的日期
+(NSDate *)getDayAfterWithDate:(NSDate *)date dayAfter:(NSInteger )dayAfter
{
     NSDate *nextDat = [NSDate dateWithTimeInterval:24*60*60*dayAfter sinceDate:date];//后一天
    return nextDat;
}
#pragma mark 从某时到某时多长时间
+(NSDateComponents *)howLongFromeDateStr:(NSString *)fromeDateStr toDateStr:(NSString *)toDateStr formatter:(NSString *)formatterStr
{
////    // 1.确定时间
//    NSString *time1 = @"2013-06-23";
//    NSString *time2 = @"2015-06-28";
////
    // 2.将时间转换为date
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = formatterStr;
    NSDate *fromeDate = [formatter dateFromString:fromeDateStr];
    NSDate *toDate = [formatter dateFromString:toDateStr];
    
    // 3.创建日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    
    // 4.利用日历对象比较两个时间的差值
    NSDateComponents *cmps = [calendar components:unit fromDate:fromeDate toDate:toDate options:0];
    // 5.输出结果
    NSLog(@"两个时间相差%ld年%ld月%ld日%ld小时%ld分钟%ld秒", cmps.year, cmps.month, cmps.day, cmps.hour, cmps.minute, cmps.second);
    return cmps;
}
#pragma mark   判断是否是同一天
+ (BOOL)isSameDay:(NSDate *)firstDate  twoDate:(NSDate *)twoDate
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    unsigned unitFlag = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
    NSDateComponents *comp1 = [calendar components:unitFlag fromDate:firstDate];
    NSDateComponents *comp2 = [calendar components:unitFlag fromDate:twoDate];
    return (([comp1 day] == [comp2 day]) && ([comp1 month] == [comp2 month]) && ([comp1 year] == [comp2 year]));
}
#pragma mark  某时距离现在多长时间
+ (NSString *)formateDateNow:(NSDate *)date
{
    NSInteger day = [[self howLongFromeDateStr:[NSDate getDateStrWithDateFormatter:YY_DEFAULT_TIME_FORM Date:date] toDateStr:[NSDate getDateStrWithDateFormatter:YY_DEFAULT_TIME_FORM Date:[NSDate date]] formatter:YY_DEFAULT_TIME_FORM] day];
    
    if (day == 0)
    {
        return @"今天";
    }
    if (day == 1)
    {
        return @"昨天";
    }
    return [self getDateStrWithDateFormatter:YY_DEFAULT_TIME_FORM Date:date];
}
#pragma mark  时间转换格式
+(NSDate *)getDate:(NSDate *)date formatter:(NSString *)formatter
{
    NSString *dateStr=[self getDateStrWithDateFormatter:formatter Date:date];
    NSDate *_date=[NSDate getDateWithDateStr:dateStr formatter:formatter];
    return _date;
}
+(long) compareCurrentTime:(NSDate*) compareDate
{
    NSTimeInterval  timeInterval = [compareDate timeIntervalSinceNow];
    timeInterval = -timeInterval;
    long temp = 0;
    NSString *result;
    if (timeInterval < 60) {
        result = [NSString stringWithFormat:@"刚刚"];
    }
    else if((temp = timeInterval/60) <60){
        result = [NSString stringWithFormat:@"%d分前",temp];
    }
    
    else if((temp = temp/60) <24){
        result = [NSString stringWithFormat:@"%d小前",temp];
    }
    
    else if((temp = temp/24) <30){
        result = [NSString stringWithFormat:@"%d天前",temp];
    }
    
    else if((temp = temp/30) <12){
        result = [NSString stringWithFormat:@"%d月前",temp];
    }
    else{
        temp = temp/12;
        result = [NSString stringWithFormat:@"%d年前",temp];
    }
    return  timeInterval;
}
@end
