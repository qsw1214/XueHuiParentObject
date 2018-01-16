//
//  BaseDynamicLabel.h
//  ZhongBangShop
//
//  Created by XueHui on 2017/10/21.
//  Copyright © 2017年 Object. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MarqueeLabel.h"
@interface BaseDynamicLabel : UIControl



@property (nonatomic,strong) MarqueeLabel *marqueeLabel;

-(void)resetFrame:(CGRect)frame;

-(void)setTitle:(NSString*)title;
-(void)setTitleFont:(UIFont*)font;
-(void)setTitleColor:(UIColor*)color;



/**
 设置文本标签的具体位置
 */
-(void)setTitleEdgeFrame:(CGRect)edgeInset;



@end
