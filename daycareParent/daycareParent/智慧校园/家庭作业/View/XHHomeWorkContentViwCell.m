//
//  XHHomeWorkContentViwCell.m
//  daycareParent
//
//  Created by Git on 2017/12/1.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHHomeWorkContentViwCell.h"


@interface XHHomeWorkContentViwCell ()

@property (nonatomic,strong) UIImageView *imageView;


@end


@implementation XHHomeWorkContentViwCell


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




-(void)setItemObject:(XHPreviewModel*)object
{
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:object.previewUrl]];
}





#pragma mark - Getter / Setter
-(UIImageView *)imageView
{
    if (_imageView == nil)
    {
        _imageView = [[UIImageView alloc]init];
        //[_imageView setBackgroundColor:[UIColor redColor]];
        [_imageView setContentMode:UIViewContentModeScaleAspectFit];
        [_imageView.layer setMasksToBounds:YES];
    }
    return _imageView;
}

@end
