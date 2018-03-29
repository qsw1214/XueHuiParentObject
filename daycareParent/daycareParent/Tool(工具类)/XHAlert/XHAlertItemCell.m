//
//  XHAlertItemCell.m
//  daycareParent
//
//  Created by mac on 2018/3/16.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHAlertItemCell.h"

@interface XHAlertItemCell ()

@property (nonatomic,strong) UILabel *titleLabel; //!<标题标签
@property (nonatomic,strong) UIView *markView;  //!< 小圆点视图

@end


@implementation XHAlertItemCell


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setItemColor:NO];
        
        [self.contentView addSubview:self.markView];
        [self.contentView addSubview:self.titleLabel];
        
        
    }
    return self;
}


#pragma mark - Getter /  Setter
-(void)setModel:(XHAlertModel *)model
{
    _model = model;
    switch (model.modelType)
    {
        case XHAlertNormalType:
        {
            [self.markView setBorderColor:RGB(104,111,121)];
            [self.markView setBackgroundColor:[UIColor whiteColor]];
        }
            break;
        case XHAlertSelectType:
        {
            [self.markView setBorderColor:MainColor];
            [self.markView setBackgroundColor:MainColor];
        }
            break;
    }
    
    
    [self.markView setFrame:CGRectMake(5.0,(model.itemSize.height-8.0)/2.0 , 8.0, 8.0)];
    [self.markView setLayerCornerRadius:(self.markView.height/2.0)];
    [self.markView setLayerBorderWidth:1.0];
    [self.titleLabel setFrame:CGRectMake((self.markView.right+5.0), 0, model.itemSize.width-(self.markView.right+5.0), model.itemSize.height)];
    
    
    
    [self.titleLabel setText:model.name];
    
}
-(UIView *)markView
{
    if (!_markView)
    {
        _markView = [[UIView alloc]init];
    }
    return _markView;
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


-(void)setItemColor:(BOOL)color
{
    if (color)
    {
        [self.titleLabel setBackgroundColor:[UIColor orangeColor]];
        [self.markView setBackgroundColor:[UIColor purpleColor]];
    }
}




@end
