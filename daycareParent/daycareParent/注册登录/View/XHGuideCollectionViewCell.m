//
//  XHGuideCollectionViewCell.m
//  daycareParent
//
//  Created by Git on 2017/12/4.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHGuideCollectionViewCell.h"


@interface XHGuideCollectionViewCell ()

@property (nonatomic,strong) UIImageView *imageView;


@end




@implementation XHGuideCollectionViewCell



- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self.contentView addSubview:self.imageView];
        [self.contentView setBackgroundColor:RGB(255, 254, 254)];
        [self.imageView setFrame:CGRectMake(10, 10, (frame.size.width-20.0), (frame.size.height-20.0))];
    }
    return self;
}


-(void)setItemObject:(NSString*)imageName
{
    [self.imageView setImage:[UIImage imageNamed:imageName]];
}




#pragma mark - Getter / Setter
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



@end
