//
//  NSObject+Category.h
//  daycareParent
//
//  Created by Git on 2017/11/27.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface NSObject (Category)



#pragma mark 验证密码是否符合格式
/**
 @param pass 密码字符串
 @return BOOL 返回布尔值，是否符合格式
 */
+(BOOL)verifyPassword:(NSString *)pass;


#pragma mark 验证手机号是否符合格式
+(BOOL)verifyPhone:(NSString*)phone;


#pragma mark --- 验证电话号码是否符合规则
/**
 验证电话号码是否符合规则
 */
+(BOOL)verifyPhoneNumberMatch:(id)phoneNumber;

#pragma mark --- 验证是否是数字符合规则
/**
 验证码是否符合规则
 */
+(BOOL)verifyNumberMatch:(id)phoneNumber;



#pragma mark  验证码是否符合规则
/**
 @param codeNumber 验证码字符串
 @return BOOL 返回布尔值 是否符合格式
 */
+(BOOL)verifyCodeMatch:(id)codeNumber;


#pragma mark 验证是否是数字和字母符合规则
/**
 验证是否是数字和字母符合规则
 */
+(BOOL)verifyIDentityMatch:(id)phoneNumber;


#pragma mark --- 验证密码是否符合规则
/**
 验证密码是否符合规则
 */
+(BOOL)verifyPasswordMatch:(id)password;


+ (BOOL)empty:(NSObject *)o;


#pragma mark 计算文本的宽度和高度
-(CGSize)contentSizeWithTitle:(NSString*)content withFontOfSize:(UIFont*)font withWidth:(CGFloat)maxWidth;

#pragma mark 计算文本的宽度和高度
+(CGSize)contentSizeWithTitle:(NSString*)content withFontOfSize:(UIFont*)font withWidth:(CGFloat)maxWidth;

@end
