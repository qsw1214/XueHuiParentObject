//
//  BaseLabelView.h
//  ZhongBangShop
//
//  Created by XueHui on 2017/10/18.
//  Copyright © 2017年 Object. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseLabelView : UIView

/**
 重置Frame
 */
-(void)resetFrame:(CGRect)frame withEdgeInset:(UIEdgeInsets)edgeInset;
/**
 设置标题
 */
-(void)settitle:(NSString*)title;
/**
 设置字体大小
 */
-(void)setFont:(UIFont*)font;
/**
 设置字体大小
 */
-(void)setTextColor:(UIColor*)color;
/**
 设置文字的位置
 */
-(void)setTextAlignment:(NSTextAlignment)alignment;


@end
