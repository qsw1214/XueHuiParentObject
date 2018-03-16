//
//  NSDate+dateTool.h
//  daycareParent
//
//  Created by 钧泰科技 on 2018/1/25.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import <Foundation/Foundation.h>

#define YYMMDDHHMM @"yy-MM-dd HH:mm"
#define HH_DEFAULT_TIME_FORM @"HH:mm"
#define MM_DEFAULT_TIME_FORM @"MM-dd"
#define DEFAULT_TIME_FORM @"MM/dd HH:mm"
#define DEFAULT_TIME_FORM1 @"MM-dd HH:mm"
#define YY_DEFAULT_TIME_FORM @"yyyy-MM-dd"
#define YY_DEFAULT_TIME_FORM1 @"yy-MM-dd"
#define ALL_DEFAULT_TIME_FORM @"yyyy-MM-dd HH:mm:ss"
#define ALL_TIME_DEFAULT_TIME_FORM @"yyyy-MM-dd HH:mm"
#define ALL_DEFAULT_TIME_FORM_FFF @"yyyy-MM-dd HH:mm:ss.SSS"

@interface NSDate (dateTool)

/**
 时间date转时间字符串

 @param dateFormatter 时间格式
 @param date 时间
 @return 时间date转时间字符串
 */
+(NSString *)getDateStrWithDateFormatter:(NSString *)dateFormatter Date:(NSDate *)date;

/**
 时间字符串转日期date
 
 @param dateStr 时间字符串
 @param formatter 时间格式
 @return 日期date
 */
+(NSDate *)getDateWithDateStr:(NSString *)dateStr formatter:(NSString *)formatter;

/**
 时间字符串转换为指定时间格式字符串

 @param dateStr 时间字符串
 @param fromFormatter 时间字符串转时间date格式
 @param toFormatter 时间date转时间字符串格式
 @return 时间字符串
 */
+(NSString *)dateStr:(NSString *)dateStr FromFormatter:(NSString *)fromFormatter ToFormatter:(NSString *)toFormatter;
/**
 制定日期几天前日期

 @param date 指定日期
 @param dayBefor 几天
 @return 制定日期几天前日期
 */
+(NSDate *)getDayBeforWithDate:(NSDate *)date dayBefor:(NSInteger )dayBefor;

/**
 制定日期几天后日期

 @param date 指定日期
 @param dayAfter 几天
 @return 制定日期几天后日期
 */
+(NSDate *)getDayAfterWithDate:(NSDate *)date dayAfter:(NSInteger )dayAfter;

/**
 比较两个时间相差多长时间（年、月、日、时、分、秒）

 @param fromeDateStr 第一个时间字符串
 @param toDateStr 第二个时间字符串
 @param formatterStr 时间格式
 @return 时间差
 */
+(NSDateComponents *)howLongFromeDateStr:(NSString *)fromeDateStr toDateStr:(NSString *)toDateStr formatter:(NSString *)formatterStr;

/**
 是否为同一天

 @param firstDate 第一date
 @param twoDate 第二date
 @return 是否同一天
 */
+ (BOOL)isSameDay:(NSDate *)firstDate  twoDate:(NSDate *)twoDate;
/**
 比较某时距离现在多长时间
 @param date 时间格式
 @return 时间判断
 */

+ (NSString *)formateDateNow:(NSDate *)date;

/**
 时间转换格式

 @param date 时间date
 @param formatter 时间格式
 @return 时间date
 */
+(NSDate *)getDate:(NSDate *)date formatter:(NSString *)formatter;
+(long) compareCurrentTime:(NSDate*) compareDate;
@end
