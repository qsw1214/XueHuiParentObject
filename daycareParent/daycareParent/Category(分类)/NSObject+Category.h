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

#pragma mark - 设置富文本
/*
 *  设置行间距和字间距
 *
 *  @param string    字符串
 *  @param lineSpace 行间距
 *  @param kern      字间距
 *  @param font      字体大小
 *
 *  @return 富文本
 */
+(NSAttributedString *)attributedWithString:(NSString *)string WithLineSpace:(CGFloat)lineSpace kern:(CGFloat)kern font:(UIFont *)font;
#pragma mark--给UILabel设置行间距和字间距
-(void)setLabelSpace:(UILabel*)label withValue:(NSString*)str withFont:(UIFont*)font withlineSpacing:(CGFloat)lineSpacing withAttributeNameFont:(NSNumber *)attributeNameFont;
#pragma mark--计算UILabel的高度(带有行间距的情况)
-(CGFloat)getSpaceLabelHeight:(NSString*)str withFont:(UIFont*)font withWidth:(CGFloat)width withlineSpacing:(CGFloat)lineSpacing withAttributeNameFont:(NSNumber *)attributeNameFont;
@end
