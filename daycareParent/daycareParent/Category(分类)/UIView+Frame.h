
//  Created by Caoyq on 16/5/4.
//  Copyright © 2016年 honeycao. All rights reserved.
//

#import <UIKit/UIKit.h>




//以iphone5为基础 坐标都以iphone5为基准 进行代码的适配
//#define ratio         [[UIScreen mainScreen] bounds].size.width/320.0

@interface UIView (Frame)

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGFloat bottom;
@property (nonatomic, assign) CGFloat top;
@property (nonatomic, assign) CGFloat right;
@property (nonatomic, assign) CGFloat left;



#pragma mark 设置layer的弧度
/**
 设置layer的弧度
 @param radius layer的弧度
 */
-(void)setLayerCornerRadius:(CGFloat)radius;

#pragma mark 设置layer的弧度
/**
 设置layer的宽度
 @param width layer宽度
 */
-(void)setLayerBorderWidth:(CGFloat)width;
-(void)setBorderColor:(UIColor*)color;



@end
