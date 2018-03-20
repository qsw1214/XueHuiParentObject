//
//  XHPageCollectionViewItemCell.m
//  daycareParent
//
//  Created by mac on 2018/3/20.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHPageCollectionViewItemCell.h"

@interface XHPageCollectionViewItemCell ()

@property (nonatomic,strong) UIImageView *imageView; //!< 图片视图


@end





@implementation XHPageCollectionViewItemCell


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self.contentView addSubview:self.imageView];
        [self.imageView setFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self.contentView setLayerCornerRadius:(frame.size.height/2.0)];
    }
    return self;
}


-(void)setModel:(XHPageModel *)model
{
    _model = model;
    
    [self.imageView setImage:[UIImage imageNamed:model.imageName]];
    switch (model.type)
    {
        case XHPageModelNormalType:
        {
            [self.contentView setBackgroundColor:LineViewColor];
        }
            break;
        case XHPageModelSelectType:
        {
            [self.contentView setBackgroundColor:MainColor];
        }
            break;
    }
}



#pragma mark - Getter /  Setter
-(UIImageView *)imageView
{
    if (!_imageView)
    {
        _imageView = [[UIImageView alloc]init];
        [_imageView setContentMode:UIViewContentModeScaleAspectFill];
    }
    return _imageView;
}




@end
