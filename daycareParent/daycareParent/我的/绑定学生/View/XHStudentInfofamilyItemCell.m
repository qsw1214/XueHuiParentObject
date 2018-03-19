//
//  XHStudentInfofamilyItemCell.m
//  daycareParent
//
//  Created by mac on 2018/3/19.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHStudentInfofamilyItemCell.h"


@interface XHStudentInfofamilyItemCell ()

@property (nonatomic,strong) UIImageView *headerImageView; //!< 头像
@property (nonatomic,strong) UILabel *titleLabel; //!< 称呼标签
@property (nonatomic,strong) UIImageView *markImageView; //!< 标记图标
@property (nonatomic,strong) UILabel *phoneLabel; //!< 电话标签
@property (nonatomic,strong) UIView *lineView; //!< 电话标签



@end

@implementation XHStudentInfofamilyItemCell


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setItemColor:YES];
        
        [self.contentView addSubview:self.headerImageView];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.markImageView];
        [self.contentView addSubview:self.phoneLabel];
        [self.contentView addSubview:self.lineView];
        [self.contentView setBackgroundColor:[UIColor whiteColor]];
        
        
        [self.headerImageView setFrame:CGRectMake(10.0, 10.0, 40.0, 40.0)];
        [self.headerImageView setLayerCornerRadius:(self.headerImageView.height/2.0)];
        [self.titleLabel setFrame:CGRectMake(self.headerImageView.right+5.0, (frame.size.height-20.0)/2.0, 60.0, 20.0)];
        [self.markImageView setFrame:CGRectMake(self.titleLabel.right, self.titleLabel.top, 20.0, 20.0)];
        [self.phoneLabel setFrame:CGRectMake(self.markImageView.right, self.markImageView.top, frame.size.width-(self.markImageView.right+10.0), self.markImageView.height)];
        
        [self.lineView setFrame:CGRectMake(0, frame.size.height-0.5, frame.size.width, 0.5)];
        [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:@"http://pic2.ooopic.com/12/42/25/02bOOOPIC95_1024.jpg"]];
    }
    return self;
}


-(void)setModel:(XHFamilyListModel *)model
{
    _model = model;
    
    
    [self.titleLabel setText:model.guardianName];
    [self.phoneLabel setText:model.telphoneNumber];
}


#pragma mark - Getter /  Setter
-(UIImageView *)headerImageView
{
    if (!_headerImageView)
    {
        _headerImageView = [[UIImageView alloc]init];
    }
    return _headerImageView;
}

-(UILabel *)titleLabel
{
    if (!_titleLabel)
    {
        _titleLabel = [[UILabel alloc]init];
    }
    return _titleLabel;
}

-(UIImageView *)markImageView
{
    if (!_markImageView)
    {
        _markImageView = [[UIImageView alloc]init];
        [_markImageView setBackgroundColor:MainColor];
    }
    return _markImageView;
}

-(UILabel *)phoneLabel
{
    if (!_phoneLabel)
    {
        _phoneLabel = [[UILabel alloc]init];
        [_phoneLabel setTextAlignment:NSTextAlignmentRight];
    }
    return _phoneLabel;
}


-(UIView *)lineView
{
    if (!_lineView)
    {
        _lineView = [[UIView alloc]init];;
        [_lineView setBackgroundColor:LineViewColor];
    }
    return _lineView;
}


-(void)setItemColor:(BOOL)color
{
    if (color)
    {
        [self.titleLabel setBackgroundColor:[UIColor redColor]];
        [self.markImageView setBackgroundColor:[UIColor orangeColor]];
        [self.phoneLabel setBackgroundColor:[UIColor purpleColor]];
    }
}




@end
