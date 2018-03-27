//
//  XHFunctionMenuCell.m
//  daycareParent
//
//  Created by Git on 2017/11/28.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHFunctionMenuCell.h"
#import "BaseButtonControl.h"


@interface XHFunctionMenuCell ()

@property (nonatomic,strong) UIImageView *markImageView; //!< 图片视图
@property (nonatomic,strong) UIImageView *backGroundImageView; //!< 图片视图
@property (nonatomic,strong) UILabel *titleLabel; //!< 标题
@property (nonatomic,strong) UILabel *describeLabel; //!< 描述标题



@end

@implementation XHFunctionMenuCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        
        [self setItemColor:NO];
        
        [self setBackgroundColor:RGB(255.0, 255.0, 255.0)];
        [self.contentView addSubview:self.markImageView];
        [self.contentView addSubview:self.backGroundImageView];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.describeLabel];
        
    
        [self.layer setCornerRadius:10.0];
        [self.layer  setShadowColor:[RGB(200, 200, 200) CGColor]]; //阴影颜色
        [self.layer setShadowOffset:CGSizeMake(2, 2)];//偏移距离
        [self.layer setShadowOpacity:0.6]; //不透明度
        [self.layer setShadowRadius:2.0]; //半径
    }
    return self;
}


#pragma mark - Getter / Setter

-(void)setItemFrame:(XHFunctionMenuFrame *)itemFrame
{
     _itemFrame = itemFrame;
    
    
    {
        
        //根据类型进行控件设置Frame
        //根据类型进行控件设置Frame
        [self.markImageView setFrame:CGRectMake(((itemFrame.itemSize.width-30.0))/2.0, 10.0, 30.0, 30.0)];
        [self.titleLabel setFrame:CGRectMake(0, (self.backGroundImageView.top+80.0), itemFrame.itemSize.width, (itemFrame.itemSize.width-(25+(itemFrame.itemSize.width-50.0))))];
        [self.backGroundImageView setFrame:CGRectMake(0, self.markImageView.bottom+10.0, (itemFrame.itemSize.width), itemFrame.itemSize.height-(self.markImageView.bottom+10.0))];
        
        
        
        CGSize contentSize = [NSObject contentSizeWithTitle:itemFrame.model.describe withFontOfSize:FontLevel4 withWidth:(itemFrame.itemSize.width-20.0)];
         [self.describeLabel setFrame:CGRectMake(10.0, self.titleLabel.bottom, (itemFrame.itemSize.width-20.0), contentSize.height)];
       
        
        
        
        //赋值
        [self.titleLabel setText:itemFrame.model.title];
        [self.describeLabel setText:itemFrame.model.describe];
        [self.markImageView setImage:[UIImage imageNamed:itemFrame.model.title]];
        [self.backGroundImageView setImage:[UIImage imageNamed:itemFrame.model.iconName]];
    }
    
   

    
}



-(UIImageView *)markImageView
{
    if (_markImageView == nil)
    {
        _markImageView = [[UIImageView alloc]init];
        [_markImageView setContentMode:UIViewContentModeScaleAspectFit];
    }
    return _markImageView;
}


-(UIImageView *)backGroundImageView
{
    if (_backGroundImageView == nil)
    {
        _backGroundImageView = [[UIImageView alloc]init];
        [_backGroundImageView setContentMode:UIViewContentModeScaleToFill];
        [_backGroundImageView.layer setMasksToBounds:YES];
    }
    return _backGroundImageView;
}

-(UILabel *)titleLabel
{
    if (_titleLabel == nil)
    {
        _titleLabel = [[UILabel alloc]init];
        [_titleLabel setFont:FontLevel3];
        [_titleLabel setTextColor:[UIColor whiteColor]];
        [_titleLabel setTextAlignment:NSTextAlignmentCenter];
    }
    return _titleLabel;
}


-(UILabel *)describeLabel
{
    if (_describeLabel == nil)
    {
        _describeLabel = [[UILabel alloc]init];
        [_describeLabel setFont:FontLevel4];
        [_describeLabel setTextColor:[UIColor whiteColor]];
        [_describeLabel setTextAlignment:NSTextAlignmentCenter];
        [_describeLabel setNumberOfLines:0];
    }
    return _describeLabel;
}



-(void)setItemColor:(BOOL)color
{
    if (color)
    {
        [self.titleLabel setBackgroundColor:[UIColor redColor]];
        [self.describeLabel setBackgroundColor:[UIColor grayColor]];
        [self.markImageView setBackgroundColor:[UIColor greenColor]];
        [self.backGroundImageView setBackgroundColor:[UIColor orangeColor]];
    }
}




@end
