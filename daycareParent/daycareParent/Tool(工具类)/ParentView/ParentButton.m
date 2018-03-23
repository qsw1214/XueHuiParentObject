//
//  ParentButton.m
//  daycareParent
//
//  Created by 钧泰科技 on 2018/3/22.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "ParentButton.h"
@interface ParentButton()
@property(nonatomic,strong)NSMutableArray *numberLabelArry;
@property(nonatomic,strong)NSMutableArray *numberImageViewArry;
@end


@implementation ParentButton
#pragma mark-----UILabel
-(void)setNumberLabel:(NSInteger)number
{
    for (int i=0; i<number; i++) {
        UILabel *label=[[UILabel alloc] init];
        [self addSubview:label];
        [self.numberLabelArry addObject:label];
    }
    
}
-(void)setLabelCGRectMake:(CGRect)rect withNumberIndex:(NSInteger)index
{
    UILabel *label=self.numberLabelArry[index];
    [label setFrame:rect];
}
-(void)setLabelText:(NSString *)text withNumberIndex:(NSInteger)index
{
    UILabel *label=self.numberLabelArry[index];
    [label setText:[NSString safeString:text]];
}
-(void)setLabelTextAlignment:(NSTextAlignment)textAlignment withNumberIndex:(NSInteger)index
{
    UILabel *label=self.numberLabelArry[index];
    [label setTextAlignment:textAlignment];
}

-(void)setLabelFont:(UIFont *)font withNumberIndex:(NSInteger)index
{
    UILabel *label=self.numberLabelArry[index];
    [label setFont:font];
}
-(void)setLabelTextColor:(UIColor *)color withNumberIndex:(NSInteger)index
{
    UILabel *label=self.numberLabelArry[index];
    [label setTextColor:color];
}

-(void)setLabelBackgroundColor:(UIColor *)color withNumberIndex:(NSInteger)index
{
    UILabel *label=self.numberLabelArry[index];
    [label setBackgroundColor:color];
}

-(void)setNumberImageView:(NSInteger)number
{
    for (int i=0; i<number; i++) {
        ParentImageView *imageView=[[ParentImageView alloc] init];
        [self addSubview:imageView];
        [self.numberImageViewArry addObject:imageView];
    }
}

-(void)setImageViewCGRectMake:(CGRect)rect withNumberIndex:(NSInteger)index
{
    ParentImageView *imageView=self.numberImageViewArry[index];
    [imageView setFrame:rect];
}
-(void)setImageViewName:(NSString *)imageName withNumberIndex:(NSInteger)index
{
    ParentImageView *imageView=self.numberImageViewArry[index];
    //[imageView sd_setImageWithURL:[NSURL URLWithString:imageName] placeholderImage:[UIImage imageNamed:imageName]];
    imageView.image=[UIImage imageNamed:imageName];
}
-(void)setImageViewBackgroundColor:(UIColor *)color withNumberIndex:(NSInteger)index
{
    ParentImageView *imageView=self.numberImageViewArry[index];
    [imageView setBackgroundColor:color];
}

-(void)setImageViewCornerRadius:(CGFloat)radius withNumberIndex:(NSInteger)index
{
    ParentImageView *imageView=self.numberImageViewArry[index];
    imageView.layer.cornerRadius=radius;
    imageView.layer.masksToBounds=YES;
}

-(void)setImageViewBorderColor:(UIColor *)borderColor withBorderWidth:(CGFloat)borderWidth withNumberIndex:(NSInteger)index
{
    ParentImageView *imageView=self.numberImageViewArry[index];
    imageView.layer.borderColor=borderColor.CGColor;
    imageView.layer.borderWidth=borderWidth;
    imageView.layer.masksToBounds=YES;
}

-(NSMutableArray *)numberLabelArry
{
    if (_numberLabelArry==nil) {
        _numberLabelArry=[[NSMutableArray alloc] init];
    }
    return _numberLabelArry;
}


-(NSMutableArray *)numberImageViewArry
{
    if (_numberImageViewArry==nil)
    {
        _numberImageViewArry=[[NSMutableArray alloc] init];
    }
    return _numberImageViewArry;
}


@end
