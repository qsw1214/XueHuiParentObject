//
//  XHRegisterTableViewCell.m
//  daycareParent
//
//  Created by Git on 2017/11/29.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHRegisterTableViewCell.h"
#import "XHRegisterItemControl.h"




#define TIMESOLT  12.0

@interface XHRegisterTableViewCell ()


@property (nonatomic,strong) UIImageView *markImageView; //!< 图片视图
@property (nonatomic,strong) UIView *markLineView; //!< 日期分割线
@property (nonatomic,strong) UIView *lineView; //!< 分割线
@property (nonatomic,strong) UILabel *titleLabel; //!< 主标题标签
@property (nonatomic,strong) UILabel *describeLabel; //!< 描述标签




@end


@implementation XHRegisterTableViewCell




- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self.contentView setBackgroundColor:[UIColor whiteColor]];
        
        [self.contentView addSubview:self.markLineView];
        [self.contentView addSubview:self.markImageView];
        [self.contentView addSubview:self.describeLabel];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.lineView];
        
        [self setItemColor:NO];
        
    }
    return self;
}



-(void)setItemFrame:(XHRegisterFrame *)itemFrame
{
    _itemFrame = itemFrame;
    
    //!< 首先赋值Frame
    [self.markLineView setFrame:CGRectMake(45.0,0.0 , 0.5, itemFrame.itemFrame.size.height)];
    [self.markImageView setFrame:CGRectMake(30.0, 14.0, 27.0, 27.0)];
    [self.markImageView setLayerCornerRadius:(self.markImageView.height/2.0)];
    [self.titleLabel setFrame:CGRectMake(self.markImageView.right+20.0, 16.0, (itemFrame.itemFrame.size.width-(self.markImageView.right+30.0)), 20.0)];
    [self.describeLabel setFrame:CGRectMake(self.titleLabel.left, self.titleLabel.bottom, self.titleLabel.width, self.titleLabel.height)];
    [self.lineView setFrame:CGRectMake(self.markLineView.left, itemFrame.itemFrame.size.height-0.5, (itemFrame.itemFrame.size.width-self.markLineView.left), 0.5)];
    
    
    
    //!< 赋值
    [self.titleLabel setText:itemFrame.model.title];
    [self.describeLabel setText:[NSString stringWithFormat:@"%@ %@",itemFrame.model.date,itemFrame.model.time]];
    [self.markImageView setImage:[UIImage imageNamed:itemFrame.model.markIcon]];
    
    
}


#pragma mark - Getter / Setter
-(UIView *)markLineView
{
    if (!_markLineView)
    {
        _markLineView = [[UIView alloc]init];
        [_markLineView setBackgroundColor:LineViewColor];
    }
    return _markLineView;
}

-(UIImageView *)markImageView
{
    if (!_markImageView)
    {
        _markImageView = [[UIImageView alloc]init];
        [_markImageView setContentMode:UIViewContentModeScaleAspectFit];
        [_markImageView setImage:[UIImage imageNamed:@"ico_night"]];
    }
    return _markImageView;
}



-(UILabel *)titleLabel
{
    if (!_titleLabel)
    {
        _titleLabel = [[UILabel alloc]init];
        [_titleLabel setFont:FontLevel2];
        [_titleLabel setTextColor:RGB(51.0, 51.0, 51.0)];
    }
    return _titleLabel;
}

-(UILabel *)describeLabel
{
    if (!_describeLabel)
    {
        _describeLabel = [[UILabel alloc]init];
        [_describeLabel setFont:FontLevel3];
        [_describeLabel setTextColor:RGB(104.0, 111.0, 121.0)];
    }
    return _describeLabel;
}


-(UIView *)lineView
{
    if (!_lineView)
    {
        _lineView = [[UILabel alloc]init];
        [_lineView setBackgroundColor:LineViewColor];
    }
    return _lineView;
}




-(void)setItemColor:(BOOL)color
{
    if (color)
    {
        [self.markImageView setBackgroundColor:[UIColor greenColor]];
        [self.describeLabel setBackgroundColor:[UIColor orangeColor]];
        [self.titleLabel setBackgroundColor:[UIColor purpleColor]];
    }
}


@end
