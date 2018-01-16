//
//  NSString+Category.m
//  daycareParent
//
//  Created by Git on 2017/11/27.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "NSString+Category.h"
#import "NSObject+Category.h"


@implementation NSString (Category)

#pragma mark 字符串安全保护，防止字符串为 nil <null> 导致程序崩溃问题
/**
 @param title 传入的对象
 @return NSString 返回“ @"" ”的字符串
 */
+(id)safeString:(NSString*)title;
{
    if([title isKindOfClass:[NSNumber class]])
    {
        NSNumber *num = (NSNumber *)title;
        return num.stringValue;
    }
    else if ([title isKindOfClass:[NSDictionary class]])
    {
        return title;
    }
    else if ([title isKindOfClass:[NSArray class]])
    {
        return title;
    }
    else if ([NSObject empty:title] || [title isEqualToString:@"null"] || [title isEqualToString:@"<null>"])
    {
        return @"";
    }
    
    return [NSString stringWithFormat:@"%@", title];
}

-(id)objectItemKey:(id)aKey
{
    if ([self isKindOfClass:[NSString class]])
    {
        return @"";
    }
    else
    {
        return @"";
    }
}
+(id)objectItemKey:(id)aKey
{
    if ([self isKindOfClass:[NSString class]])
    {
        return @"";
    }
    else
    {
        return @"";
    }
}
#pragma mark 验证字符串是否为空
/**
 @param string 验证的字符串
 @return BOOL 返回布尔值真假
 */
+ (BOOL)isBlankString:(NSString *)string
{
    BOOL result = NO;
    
    if (NULL == string || [string isEqual:nil] || [string isEqual:Nil])
    {
        result = YES;
    }
    else if ([string isEqual:[NSNull null]])
    {
        result = YES;
    }
    else if (0 == [string length] || 0 == [[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length])
    {
        result = YES;
    }
    else if([string isEqualToString:@"(null)"] || [string isEqualToString:@"null"] || [string isEqualToString:@"<null>"])
    {
        result = YES;
    }
    
    return result;
}

#pragma mark 字符串进行md5加密
/**
 @return NSString 加密后的字符串
 */
-(NSString *)md5
{
    const char *cStr = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    
    return [[NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ] lowercaseString];
}


-(NSString*)encoding
{
    NSString *transString = [NSString stringWithString:[self stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    transString =[transString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return transString;
    
}


/**
 获取字符串首字母(传入汉字字符串, 返回大写拼音首字母)
 
 @return 转换之后的大写首字母
 */
- (NSString *)getFirstLetterFromString
{
    //转成了可变字符串
    NSMutableString *str = [NSMutableString stringWithString:self];
    //先转换为带声调的拼音
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformMandarinLatin,NO);
    //再转换为不带声调的拼音
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformStripDiacritics,NO);
    //转化为大写拼音
    NSString *strPinYin = [str capitalizedString];
    //获取并返回首字母
    return [strPinYin substringToIndex:1];
}

/**
 设置时间格式转换

 @param dateStr 传入的时间格式
 @return 得到时间格式
 */
+(NSString *)dateStr:(NSString *)dateStr
{
    NSDateFormatter *setDateFormatter = [[NSDateFormatter alloc] init];
    [setDateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date= [setDateFormatter dateFromString:dateStr];
    NSDateFormatter *myDateFormatter = [[NSDateFormatter alloc] init];
    //设置日期格式
    [myDateFormatter setDateFormat:@"MM-dd HH:mm"];
    NSString *String=[myDateFormatter stringFromDate:date];
    return String;
}
@end
