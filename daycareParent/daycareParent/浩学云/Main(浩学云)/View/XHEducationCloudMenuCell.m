//
//  XHEducationCloudMenuCell.m
//  daycareParent
//
//  Created by Git on 2017/12/11.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHEducationCloudMenuCell.h"


@interface XHEducationCloudMenuCell ()

@property (nonatomic,strong) UIImageView *imageView; //!< 图片视图
@property (nonatomic,strong) UILabel *titleLabel; //!< 标题标签


@end




@implementation XHEducationCloudMenuCell



- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self.contentView addSubview:self.imageView];
        [self.contentView addSubview:self.titleLabel];
        
        [self.imageView setFrame:CGRectMake((frame.size.width-60.0)/2.0, 10.0, 60.0, 60.0)];
        [self.titleLabel setFrame:CGRectMake(0, 70.0, frame.size.width, 20.0)];

    }
    return self;
}


-(void)setItemFrame:(XHEducationCloudFrame *)itemFrame
{
    _itemFrame = itemFrame;
    
    if (itemFrame.model.modelType==XHEducationCloudCellSix) {
        self.imageView.image=[UIImage imageNamed:itemFrame.model.previewImage];
    }
    else
    {
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:itemFrame.model.previewImage]];
    }
    
   
    [self.titleLabel setText:itemFrame.model.title];
    
}


-(void)setItemColor:(BOOL)color
{
    if (color)
    {
        [self.imageView setBackgroundColor:[UIColor orangeColor]];
        [self.titleLabel setBackgroundColor:[UIColor purpleColor]];
    }
}



#pragma mark - Getter / Setter
-(UIImageView *)imageView
{
    if (!_imageView)
    {
        _imageView = [[UIImageView alloc]init];
        [_imageView.layer setMasksToBounds:YES];
        [_imageView setContentMode:UIViewContentModeScaleAspectFill];
    }
    return _imageView;
}

-(UILabel *)titleLabel
{
    if (!_titleLabel)
    {
        _titleLabel = [[UILabel alloc]init];
        [_titleLabel setTextAlignment:NSTextAlignmentCenter];
        [_titleLabel setTextColor:[UIColor grayColor]];
        [_titleLabel setFont:FontLevel3];
    }
    return _titleLabel;
}




@end
