//
//  XHTestView.m
//  daycareParent
//
//  Created by Git on 2017/11/29.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHTestView.h"

@implementation XHTestView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


#pragma mark 绘制圆弧
- (void)drawArc:(CGContextRef)context
{
//1.获取上下文- 当前绘图的设备
//    CGContextRef *context = UIGraphicsGetCurrentContext();
//设置路径
/*
CGContextRef c:上下文
CGFloat x ：x，y圆弧所在圆的中心点坐标
CGFloat y ：x，y圆弧所在圆的中心点坐标
CGFloat radius ：所在圆的半径
 CGFloat startAngle ： 圆弧的开始的角度  单位是弧度  0对应的是最右侧的点；
 CGFloat endAngle  ： 圆弧的结束角度
 int clockwise ： 顺时针（0） 或者 逆时针(1)
 */
    CGContextAddArc(context, 100, 100, 100, -M_PI_4, M_PI_2, 1);
    //绘制圆弧
    CGContextDrawPath(context, kCGPathStroke);
    
}


@end
