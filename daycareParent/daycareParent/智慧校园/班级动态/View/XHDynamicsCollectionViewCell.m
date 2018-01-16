//
//  XHDynamicsCollectionViewCell.m
//  daycareParent
//
//  Created by Git on 2017/12/14.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHDynamicsCollectionViewCell.h"

@interface XHDynamicsCollectionViewCell ()


@property (nonatomic,strong) UIImageView *imageView; //!< 图片视图






@end


@implementation XHDynamicsCollectionViewCell



- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self.contentView setBackgroundColor:[UIColor redColor]];
        [self.contentView addSubview:self.imageView];
        [self.imageView setFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    }
    return self;
}

-(void)setItemObject:(XHPreviewModel*)object
{
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:object.previewUrl]];
}



#pragma mark - Getter / Setter
-(UIImageView *)imageView
{
    if (!_imageView)
    {
        _imageView = [[UIImageView alloc]init];
        [_imageView setContentMode:UIViewContentModeScaleAspectFill];
        [_imageView.layer setMasksToBounds:YES];
    }
    return _imageView;
}

@end
