//
//  NSObject+Category.m
//  daycareParent
//
//  Created by Git on 2017/11/27.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "NSObject+Category.h"
#import "NSString+Category.h"

@implementation NSObject (Category)

// 判断密码
+(BOOL)verifyPassword:(NSString *)pass
{
    // 判断长度大于6位后再接着判断是否同时包含数字和字符
    NSString * regex = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,12}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:pass];
}


//判断手机号
+(BOOL)verifyPhone:(NSString*)phone
{
    NSString *phoneRegex = @"^((13[0-9])|(17[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:phone];
}



#pragma mark --- 验证是否是数字符合规则
/**
 验证码是否符合规则
 */
+(BOOL)verifyNumberMatch:(id)phoneNumber
{
    //11位点化号码
    NSString *regex = @"^[0-9]{1,100}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES%@", regex];
    BOOL isMatch = [pred evaluateWithObject:phoneNumber];
    
    return isMatch;
}



#pragma mark --- 验证是否是数字和字母符合规则
/**
 验证是否是数字和字母符合规则
 */
+(BOOL)verifyIDentityMatch:(id)phoneNumber
{
    //验证身份证，数字或者数字+字母
    NSString *regex = @"^[A-Za-z0-9]+$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES%@", regex];
    BOOL isMatch = [pred evaluateWithObject:phoneNumber];
    
    return isMatch;
}

#pragma mark --- 验证码是否符合规则
/**
 验证码是否符合规则
 */
+(BOOL)verifyCodeMatch:(id)phoneNumber
{
    //11位点化号码
    NSString *regex = @"^[0-9]{4,6}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES%@", regex];
    BOOL isMatch = [pred evaluateWithObject:phoneNumber];
    
    return isMatch;
}



#pragma mark --- 验证电话号码是否符合规则
/**
 验证电话号码是否符合规则
 */
+(BOOL)verifyPhoneNumberMatch:(id)phoneNumber
{
    //11位点化号码
    NSString *regex = @"^[0-9]{11}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES%@", regex];
    BOOL isMatch = [pred evaluateWithObject:phoneNumber];
    
    return isMatch;
}



#pragma mark --- 验证密码是否符合规则
/**
 验证密码是否符合规则
 */
+(BOOL)verifyPasswordMatch:(id)password
{
    //11位点化号码
    NSString *regex = @"[a-zA-Z0-9_]{6,30}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES%@", regex];
    BOOL isMatch = [pred evaluateWithObject:password];
    
    return isMatch;
}



+ (BOOL)empty:(NSObject *)o
{
    if (o==nil)
    {
        return YES;
    }
    if (o==NULL)
    {
        return YES;
    }
    if (o==[NSNull new])
    {
        return YES;
    }
    
    if ([o isKindOfClass:[NSString class]])
    {
        return [NSString isBlankString:(NSString *)o];
    }
    
    if ([o isKindOfClass:[NSData class]])
    {
        return [((NSData *)o) length]<=0;
    }
    
    if ([o isKindOfClass:[NSDictionary class]])
    {
        return [((NSDictionary *)o) count] <= 0;
    }
    
    if ([o isKindOfClass:[NSArray class]])
    {
        return [((NSArray *)o) count] <= 0;
    }
    
    if ([o isKindOfClass:[NSSet class]])
    {
        return [((NSSet *)o) count]<=0;
    }
    return NO;
}



#pragma mark 计算文本的宽度和高度
-(CGSize)contentSizeWithTitle:(NSString*)content withFontOfSize:(UIFont*)font withWidth:(CGFloat)maxWidth
{
    //=========得到content的内容高度===========
    NSDictionary *AttriButes = @{NSFontAttributeName: font};
    CGSize ContentSize = [content boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT)
                                               options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                            attributes:AttriButes
                                               context:nil].size;
    //译文本高度
    return ContentSize;
}

#pragma mark 计算文本的宽度和高度
+(CGSize)contentSizeWithTitle:(NSString*)content withFontOfSize:(UIFont*)font withWidth:(CGFloat)maxWidth
{
    //=========得到content的内容高度===========
    NSDictionary *AttriButes = @{NSFontAttributeName: font};
    CGSize ContentSize = [content boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT)
                                               options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                            attributes:AttriButes
                                               context:nil].size;
    //译文本高度
    return ContentSize;
}


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
+(NSAttributedString *)attributedWithString:(NSString *)string WithLineSpace:(CGFloat)lineSpace kern:(CGFloat)kern font:(UIFont *)font
{
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    //调整行间距
    [paragraphStyle setLineSpacing:lineSpace];
    [paragraphStyle setAlignment:NSTextAlignmentCenter];
    NSDictionary *attriDict = @{NSParagraphStyleAttributeName:paragraphStyle,NSKernAttributeName:@(kern),
                                NSFontAttributeName:font};
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:string attributes:attriDict];
    return attributedString;
}
#pragma mark--给UILabel设置行间距和字间距
-(void)setLabelSpace:(UILabel*)label withValue:(NSString*)str withFont:(UIFont*)font withlineSpacing:(CGFloat)lineSpacing withAttributeNameFont:(NSNumber *)attributeNameFont
{
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.alignment = NSTextAlignmentLeft;
    paraStyle.lineSpacing = lineSpacing; //设置行间距
    paraStyle.hyphenationFactor = 1.0;
    paraStyle.firstLineHeadIndent = 0.0;
    paraStyle.paragraphSpacingBefore = 0.0;
    paraStyle.headIndent = 0;
    paraStyle.tailIndent = 0;
    //设置字间距 NSKernAttributeName:@1.5f
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:attributeNameFont
                          };
    
    NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:str attributes:dic];
    label.attributedText = attributeStr;
}
#pragma mark--计算UILabel的高度(带有行间距的情况)
-(CGFloat)getSpaceLabelHeight:(NSString*)str withFont:(UIFont*)font withWidth:(CGFloat)width withlineSpacing:(CGFloat)lineSpacing withAttributeNameFont:(NSNumber *)attributeNameFont
{
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.alignment = NSTextAlignmentLeft;
    paraStyle.lineSpacing = lineSpacing;//行高
    paraStyle.hyphenationFactor = 1.0;
    paraStyle.firstLineHeadIndent = 0.0;
    paraStyle.paragraphSpacingBefore = 0.0;
    paraStyle.headIndent = 0;
    paraStyle.tailIndent = 0;
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:attributeNameFont//字体间距
                          };
    
    CGSize size = [str boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingTruncatesLastVisibleLine |  NSStringDrawingUsesFontLeading attributes:dic context:nil].size;
    return size.height;
}


@end
