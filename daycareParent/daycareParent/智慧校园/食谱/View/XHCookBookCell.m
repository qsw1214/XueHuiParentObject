//
//  XHCookBookCell.m
//  daycareParent
//
//  Created by Git on 2017/12/5.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHCookBookCell.h"



@interface XHCookBookCell ()

@property (nonatomic,strong) UILabel *titleLabel; //!< 标题标签
@property (nonatomic,strong) UILabel *contentLabel; //!< 标题标签
@property (nonatomic,strong) UIImageView *imageViewView; //!< 选中视图背景颜色


@end



@implementation XHCookBookCell



- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.contentLabel];
        [self.contentView addSubview:self.imageViewView];
        [self.contentView setBackgroundColor:[UIColor whiteColor]];

        [self setItemColor:NO];
    }
    return self;
}


-(void)setItemFrame:(XHCookBookFrame *)itemFrame
{
    switch (itemFrame.model.modeType)
    {
        case CookBookWeekType:
            break;
        case CookBookDetailsType:
        {
            [self.imageViewView setFrame:CGRectMake(0, 0, itemFrame.itemSize.width, itemFrame.itemSize.height-70.0)];
            [self.titleLabel setFrame:CGRectMake(10.0, (self.imageViewView.bottom+10.0), self.imageViewView.width-20.0, 20.0)];
            [self.contentLabel setFrame:CGRectMake(self.titleLabel.left, self.titleLabel.bottom, self.titleLabel.width, 30.0)];
            
            
            //!< 赋值
            [self.titleLabel setText:itemFrame.model.title];
            [self.contentLabel setText:itemFrame.model.content];
//            [self.imageViewView sd_setImageWithURL:[NSURL URLWithString:itemFrame.model.previewUrl]];
            [self.imageViewView setImage:[UIImage imageNamed:@"预览.jpg"]];
        }
            break;
    }
}




#pragma mark - Getter / Setter
-(UILabel *)titleLabel
{
    if (_titleLabel == nil)
    {
        _titleLabel = [[UILabel alloc]init];
        [_titleLabel setTextColor:RGB(51,51,51)];
        [_titleLabel setFont:FontLevel1];
    }
    return _titleLabel;
}


-(UILabel *)contentLabel
{
    if (_contentLabel == nil)
    {
        _contentLabel = [[UILabel alloc]init];
        [_contentLabel setTextColor:RGB(104,111,121)];
        [_contentLabel setFont:FontLevel2];
        [_contentLabel setNumberOfLines:0];
    }
    return _contentLabel;
}


-(UIImageView *)imageViewView
{
    if (!_imageViewView)
    {
        _imageViewView = [[UIImageView alloc]init];
        [_imageViewView setContentMode:UIViewContentModeScaleAspectFill];
        [_imageViewView setLayerCornerRadius:0.0];
    }
    return _imageViewView;
}




-(void)setItemColor:(BOOL)color
{
    if (color)
    {
        [self.titleLabel setBackgroundColor:[UIColor redColor]];
        [self.contentLabel setBackgroundColor:[UIColor greenColor]];
        [self.imageViewView setBackgroundColor:[UIColor grayColor]];
    }
}




@end
