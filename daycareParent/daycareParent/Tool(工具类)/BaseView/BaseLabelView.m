//
//  BaseLabelView.m
//  ZhongBangShop
//
//  Created by XueHui on 2017/10/18.
//  Copyright © 2017年 Object. All rights reserved.
//

#import "BaseLabelView.h"

@interface BaseLabelView ()

@property (nonatomic,strong) UILabel *titleLabel; //!< 标题

@end

@implementation BaseLabelView



- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self addSubview:self.titleLabel];
    }
    return self;
}

#pragma mark - Private Method
/**
 重置Frame
 */
-(void)resetFrame:(CGRect)frame withEdgeInset:(UIEdgeInsets)edgeInset
{
    [self setFrame:frame];
    [self.titleLabel setFrame:CGRectMake(edgeInset.left, edgeInset.top, (frame.size.width-(edgeInset.left+edgeInset.right)), (frame.size.height-(edgeInset.top+edgeInset.bottom)))];
}
/**
 设置标题
 */
-(void)settitle:(NSString*)title
{
    [self.titleLabel setText:title];
}
/**
 设置字体大小
 */
-(void)setFont:(UIFont*)font
{
    [self.titleLabel setFont:font];
}
/**
 设置字体大小
 */
-(void)setTextColor:(UIColor*)color
{
    [self.titleLabel setTextColor:color];
}
/**
 设置文字的位置
 */
-(void)setTextAlignment:(NSTextAlignment)alignment
{
    [self.titleLabel setTextAlignment:alignment];
}

#pragma mark - Getter / Setter
-(UILabel *)titleLabel
{
    if (_titleLabel == nil)
    {
        _titleLabel = [[UILabel alloc]init];
    }
    return _titleLabel;
}




@end
