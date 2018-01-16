//
//  XHAskforLeaveArrowCell.m
//  daycareParent
//
//  Created by Git on 2017/12/6.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHAskforLeaveArrowCell.h"


@interface XHAskforLeaveArrowCell ()

@property (nonatomic,strong) UILabel *titleLabel; //!< 标题
@property (nonatomic,strong) UILabel *describeLabel; //!< 描述标题
@property (nonatomic,strong) UIImageView *arrowImageView; //!< 箭头图片视图
@property (nonatomic,strong) UIView *topLineView; //!< 上面的分割线
@property (nonatomic,strong) UIView *bottomLineView; //!< 下面的分割线




@end

@implementation XHAskforLeaveArrowCell



- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self addSubview:self.titleLabel];
        [self addSubview:self.describeLabel];
        [self addSubview:self.arrowImageView];
        [self addSubview:self.topLineView];
        [self addSubview:self.bottomLineView];
    }
    return self;
}


-(void)resetFrame:(CGRect)frame
{
    [self setFrame:frame];
    [self.topLineView setFrame:CGRectMake(0, 0, frame.size.width, 0.5)];
    [self.titleLabel setFrame:CGRectMake(10.0, 0, 130.0, frame.size.height)];
    [self.describeLabel setFrame:CGRectMake(130.0, 0, (frame.size.width-130-35.0), frame.size.height)];
    [self.arrowImageView setFrame:CGRectMake(frame.size.width-30.0, (frame.size.height-20.0)/2.0, 20.0, 20.0)];
    [self.bottomLineView setFrame:CGRectMake(0, frame.size.height-0.5, frame.size.width, 0.5)];
}

-(void)setTitle:(NSString*)title
{
    [self.titleLabel setText:title];
}

/**
 设置图标
 
 @param imageName 图标名称
 */
-(void)setImageName:(NSString*)imageName
{
    [self.arrowImageView setImage:[UIImage imageNamed:imageName]];
}

-(void)setModel:(XHChildListModel *)model
{
    _model = model;
    [self setDescribe:model.studentName];
}



-(void)setDescribe:(NSString*)describe
{
    [self.describeLabel setText:describe];
}

/**
 获取描述标题
 
 @return 描述标题
 */
-(NSString*)describe
{
    return [NSString safeString:self.describeLabel.text];
}



#pragma mark - Getter / Setter
-(UILabel *)titleLabel
{
    if (_titleLabel == nil)
    {
        _titleLabel = [[UILabel alloc]init];
        [_titleLabel setTextColor:RGB(14, 14, 14)];
        [_titleLabel setFont:[UIFont boldSystemFontOfSize:14.0]];
    }
    return _titleLabel;
}

-(UILabel *)describeLabel
{
    if (_describeLabel == nil)
    {
        _describeLabel = [[UILabel alloc]init];
        [_describeLabel setTextColor:RGB(64, 64, 64)];
        [_describeLabel setTextAlignment:NSTextAlignmentRight];
        [_describeLabel setFont:FontLevel3];
    }
    return _describeLabel;
}

-(UIImageView *)arrowImageView
{
    if (_arrowImageView == nil)
    {
        _arrowImageView = [[UIImageView alloc]init];
        [_arrowImageView setContentMode:UIViewContentModeScaleAspectFit];
    }
    return _arrowImageView;
}


-(UIView *)topLineView
{
    if (_topLineView == nil)
    {
        _topLineView = [[UIView alloc]init];
        [_topLineView setBackgroundColor:LineViewColor];
    }
    return _topLineView;
}


-(UIView *)bottomLineView
{
    if (_bottomLineView == nil)
    {
        _bottomLineView = [[UIView alloc]init];
        [_bottomLineView setBackgroundColor:LineViewColor];
    }
    return _bottomLineView;
}

@end
