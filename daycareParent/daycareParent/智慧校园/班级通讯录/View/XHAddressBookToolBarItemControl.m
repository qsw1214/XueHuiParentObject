//
//  XHAddressBookToolBarItemControl.m
//  daycareParent
//
//  Created by Git on 2017/12/8.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHAddressBookToolBarItemControl.h"


@interface XHAddressBookToolBarItemControl ()

@property (nonatomic,strong) UIImageView *imageView; //!< 图标视图
@property (nonatomic,strong) UILabel *titleLabel; //!< 标题标签



@end



@implementation XHAddressBookToolBarItemControl


- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self addSubview:self.imageView];
        [self addSubview:self.titleLabel];
        
        [self setItemColor:NO];
    }
    return self;
}


-(void)resetFrame:(CGRect)frame
{
    [super resetFrame:frame];
    
    [self.imageView setFrame:CGRectMake(((frame.size.width-30.0)/2.0),15.0, 30.0, 30.0)];
    [self.titleLabel setFrame:CGRectMake(0, self.imageView.bottom, frame.size.width, (frame.size.height-45.0))];
}

#pragma mark 设置图片
/**
 设置图片名称
 
 @param imageName 图片名称
 */
-(void)setImageName:(NSString*)imageName
{
    [self.imageView setImage:[UIImage imageNamed:imageName]];
}


#pragma mark 设置标题
/**
 设置标题
 
 @param title 标题
 */
-(void)setTitle:(NSString*)title
{
    [self.titleLabel setText:title];
}






#pragma mark - Getter / Setter
-(UIImageView *)imageView
{
    if (_imageView == nil)
    {
        _imageView = [[UIImageView alloc]init];
        [_imageView setContentMode:UIViewContentModeScaleAspectFit];
    }
    return _imageView;
}



-(UILabel *)titleLabel
{
    if (_titleLabel == nil)
    {
        _titleLabel = [[UILabel alloc]init];
        [_titleLabel setFont:FontLevel4];
        [_titleLabel setTextColor:MainColor];
        [_titleLabel setTextAlignment:NSTextAlignmentCenter];
    }
    return _titleLabel;
}



-(void)setItemColor:(BOOL)color
{
    if (color)
    {
        [self.titleLabel setBackgroundColor:[UIColor orangeColor]];
        [self.imageView setBackgroundColor:[UIColor purpleColor]];
    }
}


@end
