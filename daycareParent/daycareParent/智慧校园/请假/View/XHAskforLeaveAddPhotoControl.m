//
//  XHAskforLeaveAddPhotoControl.m
//  daycareParent
//
//  Created by Git on 2017/12/6.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHAskforLeaveAddPhotoControl.h"


@interface XHAskforLeaveAddPhotoControl ()

@property (nonatomic,strong) UIImageView *imageView;

@end



@implementation XHAskforLeaveAddPhotoControl



- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self addSubview:self.imageView];
    }
    return self;
}


-(void)resetFrame:(CGRect)frame
{
    [self setFrame:frame];
    [self.imageView setFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
}



-(void)setImage:(UIImage *)image
{
    _image = image;
    if (image)
    {
        [self setIsAddImage:YES];
        [self.imageView setImage:image];
    }
    else
    {
        [self setIsAddImage:NO];
        [self.imageView setImage:[UIImage imageNamed:@"addpic"]];
    }
    
}


#pragma mark - Getter / Setter
-(UIImageView *)imageView
{
    if (_imageView == nil)
    {
        _imageView = [[UIImageView alloc]init];
        [_imageView setContentMode:UIViewContentModeScaleAspectFill];
        [_imageView setImage:[UIImage imageNamed:@"addpic"]];
        [_imageView.layer setMasksToBounds:YES];
    }
    return _imageView;
}



@end
