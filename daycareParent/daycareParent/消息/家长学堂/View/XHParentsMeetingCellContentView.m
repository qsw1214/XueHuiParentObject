//
//  XHParentsMeetingCellContentView.m
//  daycareParent
//
//  Created by Git on 2017/12/4.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHParentsMeetingCellContentView.h"


@interface XHParentsMeetingCellContentView ()

@property (nonatomic,strong) UILabel *titleLabel; //!< 标题标签
@property (nonatomic,strong) UIImageView *imageView; //!< 图片视图
@property (nonatomic,strong) UILabel *contentLabel; //!< 内容标签
@property (nonatomic,strong) BaseButtonControl *moreControl; //!< 更多按钮

@end


@implementation XHParentsMeetingCellContentView



- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self addSubview:self.titleLabel];
        [self addSubview:self.imageView];
        [self addSubview:self.contentLabel];
        [self addSubview:self.moreControl];
        [self setUserInteractionEnabled:NO];
    }
    return self;
}


-(void)resetFrame:(CGRect)frame
{
    [self setFrame:frame];
}



#pragma mark
-(void)setItemFrame:(XHParentsMeetingFrame*)frame
{
    //重置Frame
    [self.titleLabel setFrame:CGRectMake(10.0, 0, (frame.itemFrame.size.width-20.0), 40.0)];
    [self.imageView setFrame:CGRectMake(self.titleLabel.left, self.titleLabel.bottom, self.titleLabel.width, 120.0)];
    [self.contentLabel setFrame:CGRectMake(self.titleLabel.left, self.imageView.bottom+5.0, frame.contentFrame.size.width, frame.contentFrame.size.height)];
    //单独设置“阅读全文”按钮的Frame
    [self.moreControl resetFrame:CGRectMake(self.titleLabel.left, self.contentLabel.bottom+5.0, self.titleLabel.width, 40.0)];
    [self.moreControl setTitleEdgeFrame:CGRectMake(0, 0, self.moreControl.width/2.0, self.moreControl.height) withNumberType:0 withAllType:NO];
    [self.moreControl setImageEdgeFrame:CGRectMake(self.moreControl.width-20.0, ((self.moreControl.height-20.0)/2.0), 20.0, 20.0) withNumberType:0 withAllType:NO];
    [self.moreControl resetLineViewFrame:CGRectMake(0, 0, self.moreControl.width, 0.5) withNumberType:0 withAllType:NO];
    
    
    //赋值
    [self.titleLabel setText:frame.model.title];
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:frame.model.previewUrl]];
    [self.contentLabel setText:frame.model.content];
    
    
}



#pragma mark - Getter / Setter
-(UILabel *)titleLabel
{
    if (_titleLabel == nil)
    {
        _titleLabel = [[UILabel alloc]init];
        [_titleLabel setTextColor:[UIColor blackColor]];
        [_titleLabel setFont:FontLevel2];
    }
    return _titleLabel;
}

-(UIImageView *)imageView
{
    if (_imageView == nil)
    {
        _imageView = [[UIImageView alloc]init];
        [_imageView setContentMode:UIViewContentModeScaleAspectFill];
        [_imageView.layer setMasksToBounds:YES];
    }
    return _imageView;
}

-(UILabel *)contentLabel
{
    if (_contentLabel == nil)
    {
        _contentLabel = [[UILabel alloc]init];
        [_contentLabel setTextColor:RGB(12, 12, 12)];
        [_contentLabel setNumberOfLines:0];
        [_contentLabel setFont:FontLevel3];
        
    }
    return _contentLabel;
}


-(BaseButtonControl *)moreControl
{
    if (_moreControl== nil)
    {
        _moreControl = [[BaseButtonControl alloc]init];
        [_moreControl setNumberLabel:1];
        [_moreControl setNumberImageView:1];
        [_moreControl setNumberLineView:1];
        [_moreControl setTextColor:RGB(12, 12, 12) withTpe:0 withAllType:NO];
        [_moreControl setText:@"阅读全文" withNumberType:0 withAllType:NO];
        [_moreControl setFont:FontLevel3 withNumberType:0 withAllType:NO];
        [_moreControl setImage:@"ico_arrow" withNumberType:0 withAllType:NO];
    }
    return _moreControl;
}



@end
