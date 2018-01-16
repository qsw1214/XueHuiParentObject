//
//  NSString+Category.h
//  daycareParent
//
//  Created by Git on 2017/11/27.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <CommonCrypto/CommonCrypto.h>
#include <CommonCrypto/CommonDigest.h>
#include <zlib.h>

@interface NSString (Category)


#pragma mark 字符串安全保护，防止字符串为 nil <null> 导致程序崩溃问题
/**
 @param title 传入的对象
 @return NSString 返回“ @"" ”的字符串
 */
+(NSString*)safeString:(NSString*)title;

/**
 防止空字符串调用崩溃问题

 @param aKey 字典key
 @return 返回空字符串
 */
-(id)objectItemKey:(id)aKey;
+(id)objectItemKey:(id)aKey;

#pragma mark 验证字符串是否为空
/**
 @param string 验证的字符串
 @return BOOL 返回布尔值真假
 */
+ (BOOL)isBlankString:(NSString *)string;

#pragma mark 字符串进行md5加密
/**
 @return NSString 加密后的字符串
 */
-(NSString *)md5;

/**
 字符串进行endcoding编码

 @return endcoding编码后的字符串
 */
-(NSString*)encoding;


/**
 获取字符串首字母(传入汉字字符串, 返回大写拼音首字母)

 @return 转换之后的大写首字母
 */
- (NSString *)getFirstLetterFromString;
/**
 设置时间格式转换
 
 @param dateStr 传入的时间格式
 @return 得到时间格式
 */
+(NSString *)dateStr:(NSString *)dateStr;
@end
