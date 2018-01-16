//
//  XHFunctionMenuCell.m
//  daycareParent
//
//  Created by Git on 2017/11/28.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHFunctionMenuCell.h"
#import "BaseButtonControl.h"


@interface XHFunctionMenuCell ()

@property (nonatomic,strong) UIImageView *imageView; //!< 图片视图
@property (nonatomic,strong) UILabel *titleLabel; //!< 标题


@end

@implementation XHFunctionMenuCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setBackgroundColor:RGB(247.0, 247.0, 247.0)];
        [self.contentView addSubview:self.imageView];
        [self.contentView addSubview:self.titleLabel];
    }
    return self;
}


#pragma mark - Getter / Setter

-(void)setItemFrame:(XHFunctionMenuFrame *)itemFrame
{
     _itemFrame = itemFrame;
    switch (itemFrame.model.modelType)
    {
        case AdvertisementType:
        {
            //根据类型进行控件设置Frame
            [self.imageView setFrame:CGRectMake(0, 0, itemFrame.itemSize.width, itemFrame.itemSize.height)];
            [self.imageView sd_setImageWithURL:[NSURL URLWithString:itemFrame.model.iconName]];
        }
            break;
        case FunctionMenuType:
        {
            //根据类型进行控件设置Frame
            //根据类型进行控件设置Frame
            [self.imageView setFrame:CGRectMake((itemFrame.itemSize.width-(itemFrame.itemSize.width-50.0))/2.0, 20, (itemFrame.itemSize.width-50.0), (itemFrame.itemSize.width-50.0))];
            [self.titleLabel setFrame:CGRectMake(0, 25+(itemFrame.itemSize.width-50.0), itemFrame.itemSize.width, (itemFrame.itemSize.width-(25+(itemFrame.itemSize.width-50.0))))];
            [self.contentView.layer setBorderWidth:0.5];
            [self.contentView.layer setBorderColor:[LineViewColor CGColor]];
            
            
            //赋值
            [self.titleLabel setText:itemFrame.model.title];
            [self.imageView setImage:[UIImage imageNamed:itemFrame.model.iconName]];
        }
            break;
    }
    
    
   

    
}



-(UIImageView *)imageView
{
    if (_imageView == nil)
    {
        _imageView = [[UIImageView alloc]init];
        [_imageView setContentMode:UIViewContentModeScaleAspectFit];
    }
    return _imageView;
}

-(UILabel *)titleLabel
{
    if (_titleLabel == nil)
    {
        _titleLabel = [[UILabel alloc]init];
        [_titleLabel setFont:FontLevel3];
        [_titleLabel setTextAlignment:NSTextAlignmentCenter];
    }
    return _titleLabel;
}
@end
