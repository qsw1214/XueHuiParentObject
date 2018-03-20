//
//  XHInfiniteRotationItemCell.m
//  daycareParent
//
//  Created by mac on 2018/3/20.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHInfiniteRotationItemCell.h"


@interface XHInfiniteRotationItemCell ()

@property (nonatomic,strong) UIImageView *imageView; //!< 图片视图


@end





@implementation XHInfiniteRotationItemCell


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self.contentView addSubview:self.imageView];
        [self.imageView setFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    }
    return self;
}


-(void)setModel:(XHInfiniteRotationModel *)model
{
    _model = model;
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.imageUrl]];
}




#pragma mark - Getter /  Setter
-(UIImageView *)imageView
{
    if (!_imageView)
    {
        _imageView = [[UIImageView alloc]init];
        [_imageView setContentMode:UIViewContentModeScaleAspectFill];
        [_imageView setLayerCornerRadius:0.0];
    }
    return _imageView;
}

@end
