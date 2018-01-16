//
//  BaseMenuCell.m
//  daycareParent
//
//  Created by Git on 2017/12/6.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "BaseMenuCell.h"


@interface BaseMenuCell ()

@property (nonatomic,strong) UILabel *titleLabel; //!< 标题标签
@property (nonatomic,strong) UIView *markView; //!< 选中条

@end


@implementation BaseMenuCell


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.markView];
        
        [self.titleLabel setFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    }
    return self;
}

-(void)setModel:(BaseMenuModel *)model
{
    _model = model;
    [self.titleLabel setText:model.title];
    
    switch (model.selectType)
    {
        case BaseMenuNormalType:
        {
            [self.titleLabel setTextColor:RGB(4, 4, 4)];
            [self.markView setHidden:YES];
        }
            break;
        case BaseMenuSelectType:
        {
            [self.markView setHidden:NO];
            [self.titleLabel setTextColor:MainColor];
        }
            break;
    }
    
    
    switch (model.markLineType)
    {
        case BaseMenuTopLineType:
        {
            [self.markView setFrame:CGRectMake(0, 0, self.width, 2.0)];
        }
            break;
        case BaseMenuBottomLineType:
        {
            [self.markView setFrame:CGRectMake(0, self.height-2.0, self.width, 2.0)];
        }
            break;
    }
}



#pragma mark - Getter / Setter
-(UILabel *)titleLabel
{
    if (_titleLabel == nil)
    {
        _titleLabel = [[UILabel alloc]init];
        [_titleLabel setTextAlignment:NSTextAlignmentCenter];
        [_titleLabel setFont:FontLevel3];
    }
    return _titleLabel;
}

-(UIView *)markView
{
    if (_markView == nil)
    {
        _markView = [[UIView alloc]init];
        [_markView setBackgroundColor:MainColor];
        [_markView setHidden:YES];
    }
    return _markView;
}
@end
