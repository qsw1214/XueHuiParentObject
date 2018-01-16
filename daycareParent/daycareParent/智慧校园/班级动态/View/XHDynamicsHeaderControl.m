//
//  XHDynamicsHeaderControl.m
//  daycareParent
//
//  Created by Git on 2018/1/9.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHDynamicsHeaderControl.h"


@interface XHDynamicsHeaderControl ()


@property (nonatomic,strong) UIImageView *previewImageView;  //!< 预览图片视图
@property (nonatomic,strong) UIImageView *dotImageView; //!< 红点视图



@end

@implementation XHDynamicsHeaderControl


- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self addSubview:self.previewImageView];
        [self addSubview:self.dotImageView];
    }
    return self;
}

-(void)resetFrame:(CGRect)frame
{
    [self setFrame:frame];
    
    [self.previewImageView setFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    [self.dotImageView setFrame:CGRectMake(50.0, 5.0, 10.0, 10.0)];
    [self.previewImageView setLayerCornerRadius:(self.previewImageView.height/2.0)];
    [self.dotImageView setLayerCornerRadius:(self.dotImageView.height/2.0)];
}

-(void)dotHidden:(BOOL)hidden
{
    [self.dotImageView setHidden:hidden];
}

-(void)sd_setImageWithURL:(NSString*)url placeholderImage:(NSString*)imageName
{
    [self.previewImageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:imageName]];
}


-(UIImageView *)previewImageView
{
    if (!_previewImageView)
    {
        _previewImageView = [[UIImageView alloc]init];
    }
    return _previewImageView;
}

-(UIImageView *)dotImageView
{
    if (!_dotImageView)
    {
        _dotImageView = [[UIImageView alloc]init];
        [_dotImageView setBackgroundColor:[UIColor redColor]];
    }
    return _dotImageView;
}



@end
