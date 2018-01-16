//
//  XHCookBookImageControl.m
//  daycareParent
//
//  Created by Git on 2018/1/10.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHCookBookImageControl.h"

@interface XHCookBookImageControl ()

@property (nonatomic,strong) UIImageView *imageView;



@end


@implementation XHCookBookImageControl



- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self addSubview:self.imageView];
    }
    return self;
}


-(void)setModel:(XHPreviewModel *)model
{
    _model = model;
    [self.imageView sd_setImageWithURL:model.previewUrl];
}

-(void)sd_setImageWithURL:(NSString*)url placeholderImage:(NSString*)imageName
{
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:imageName]];
}

-(void)sd_setImageWithURL:(NSString*)url
{
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:url]];
    
}


-(void)resetFrame:(CGRect)frame
{
    [self setFrame:frame];
    [self.imageView setFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
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
