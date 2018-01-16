//
//  BaseDynamicLabel.m
//  ZhongBangShop
//
//  Created by XueHui on 2017/10/21.
//  Copyright © 2017年 Object. All rights reserved.
//

#import "BaseDynamicLabel.h"

@implementation BaseDynamicLabel

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self addSubview:self.marqueeLabel];
    }
    return self;
}


-(void)resetFrame:(CGRect)frame
{
    [self setFrame:frame];
    [self.marqueeLabel setFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    
}

-(void)setTitle:(NSString*)title
{
    [self.marqueeLabel setText:title];
}


-(void)setTitleFont:(UIFont*)font
{
    [self.marqueeLabel setFont:font];
}
-(void)setTitleColor:(UIColor*)color
{
    [self.marqueeLabel setTextColor:color];
}
/**
 设置文本标签的具体位置
 */
-(void)setTitleEdgeFrame:(CGRect)edgeInset
{
    [self.marqueeLabel setFrame:edgeInset];
}


#pragma mark - Getter / Setter
-(MarqueeLabel *)marqueeLabel
{
    if (_marqueeLabel == nil)
    {
        _marqueeLabel  = [[MarqueeLabel alloc]initWithFrame:CGRectMake(0, 0, 100, 20.0)];
        [_marqueeLabel setMarqueeType:MLContinuous];
        [_marqueeLabel setScrollDuration:15.0];
        [_marqueeLabel setFadeLength:10.0];
        [_marqueeLabel setTrailingBuffer:30.0];
         _marqueeLabel.animationCurve = UIViewAnimationOptionCurveEaseInOut;
    }
    return _marqueeLabel;
}

@end
