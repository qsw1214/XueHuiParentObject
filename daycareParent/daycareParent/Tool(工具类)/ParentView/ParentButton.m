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
@end


@implementation ParentButton

-(void)setNumberLabel:(NSInteger)number
{
    for (int i=0; i<number; i++) {
        UILabel *label=[[UILabel alloc] init];
        [label setTag:i+1];
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









-(NSMutableArray *)numberLabelArry
{
    if (_numberLabelArry==nil) {
        _numberLabelArry=[[NSMutableArray alloc] init];
    }
    return _numberLabelArry;
}





@end
