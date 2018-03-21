//
//  XHSyllabusBoardControl.m
//  daycareParent
//
//  Created by mac on 2018/3/21.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHSyllabusBoardControl.h"



@interface XHSyllabusBoardControl ()

@property (nonatomic,strong) UILabel *titleLabel; //!< 时间标签
@property (nonatomic,strong) UILabel *describeLabel; //!< 周一标签

@end

@implementation XHSyllabusBoardControl


- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self addSubview:self.titleLabel];
        [self addSubview:self.describeLabel];
        
        [self setItemColor:YES];
    }
    return self;
}

-(void)resetFrame:(CGRect)frame
{
    [self setFrame:frame];
    [self setHidden:NO];
    [self setLayerBorderWidth:0.5];
    [self setBorderColor:LineViewColor];
    [self.titleLabel setFrame:CGRectMake(0, 0, frame.size.width, frame.size.height/2.0)];
    [self.describeLabel setFrame:CGRectMake(0, self.titleLabel.bottom, self.titleLabel.width, self.titleLabel.height)];
    
}


-(void)setTitleColor:(UIColor*)color
{
    [self.titleLabel setTextColor:color];
}
-(void)setDescribeColor:(UIColor*)color
{
    [self.describeLabel setTextColor:color];
}


-(void)setTitle:(NSString*)title
{
    [self.titleLabel setText:title];
}

-(void)setDescribe:(NSString*)describe
{
    [self.describeLabel setText:describe];
}


#pragma mark - Getter /  Setter
-(UILabel *)titleLabel
{
    if (!_titleLabel)
    {
        _titleLabel = [[UILabel alloc]init];
        [_titleLabel setTextAlignment:NSTextAlignmentCenter];
        [_titleLabel setNumberOfLines:0];
    }
    return _titleLabel;
}


-(UILabel *)describeLabel
{
    if (!_describeLabel)
    {
        _describeLabel = [[UILabel alloc]init];
        [_describeLabel setTextAlignment:NSTextAlignmentCenter];
        [_describeLabel setNumberOfLines:0];
    }
    return _describeLabel;
}


-(void)setItemColor:(BOOL)color
{
    if (color)
    {

        [self.titleLabel setBackgroundColor:[UIColor orangeColor]];
        [self.describeLabel setBackgroundColor:[UIColor purpleColor]];
    }
}
    
@end
