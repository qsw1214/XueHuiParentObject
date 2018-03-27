//
//  ParentControl
//  daycareParent
//
//  Created by 钧泰科技 on 2018/3/22.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ParentControl : UIControl

-(void)setNumberLabel:(NSInteger)number;
-(void)setLabelCGRectMake:(CGRect)rect withNumberIndex:(NSInteger)index;
-(void)setLabelText:(NSString *)text withNumberIndex:(NSInteger)index;
-(void)setLabelTextAlignment:(NSTextAlignment)textAlignment withNumberIndex:(NSInteger)index;
-(void)setLabelFont:(UIFont *)font withNumberIndex:(NSInteger)index;
-(void)setLabelTextColor:(UIColor *)color withNumberIndex:(NSInteger)index;
-(void)setLabelBackgroundColor:(UIColor *)color withNumberIndex:(NSInteger)index;

-(void)setNumberImageView:(NSInteger)number;
-(void)setImageViewCGRectMake:(CGRect)rect withNumberIndex:(NSInteger)index;
-(void)setImageViewName:(NSString *)imageName withNumberIndex:(NSInteger)index;
-(void)setImageViewBackgroundColor:(UIColor *)color withNumberIndex:(NSInteger)index;
-(void)setImageViewCornerRadius:(CGFloat)radius withNumberIndex:(NSInteger)index;
-(void)setImageViewAlpha:(CGFloat)alpha withNumberIndex:(NSInteger)index;
-(void)setImageViewBorderColor:(UIColor *)borderColor withBorderWidth:(CGFloat)borderWidth withNumberIndex:(NSInteger)index;
-(void)setHeadPic:(NSString*)pic withName:(NSString*)name withType:(XHHeadType)type;
@end
