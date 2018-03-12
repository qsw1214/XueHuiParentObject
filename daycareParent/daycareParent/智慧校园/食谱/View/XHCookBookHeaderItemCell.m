//
//  XHCookBookHeaderItemCell.m
//  daycareParent
//
//  Created by mac on 2018/3/12.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHCookBookHeaderItemCell.h"


@interface XHCookBookHeaderItemCell ()


@property (nonatomic,strong) UILabel *titleLael; //!< 标题标签



@end

@implementation XHCookBookHeaderItemCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self.contentView addSubview:self.titleLael];
        [self.titleLael setFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self.contentView setLayerCornerRadius:(frame.size.height/2.0)];
        [self.contentView setLayerBorderWidth:0.5];
    }
    return self;
}







#pragma mark - Getter /  Setter
-(void)setItemFrame:(XHCookBookFrame *)itemFrame
{
    _itemFrame = itemFrame;
    
    
    switch (itemFrame.model.selectType)
    {
        case CookBookSelectType:
        {
            [self.contentView setBorderColor:MainColor];
            [self.contentView setBackgroundColor:MainColor];
            [self.titleLael setTextColor:RGB(254.0, 254.0, 254.0)];
        }
            break;
        case CookBookNormalType:
        {
            [self.contentView setBorderColor:LineViewColor];
            [self.contentView setBackgroundColor:RGB(255,255,255)];
            [self.titleLael setTextColor:RGB(51.0, 51.0, 51.0)];
        }
            break;
    }
    
    
    
    //!< 赋值
    [self.titleLael setText:itemFrame.model.title];
}




-(UILabel *)titleLael
{
    if (!_titleLael)
    {
        _titleLael = [[UILabel alloc]init];
        [_titleLael setTextAlignment:NSTextAlignmentCenter];
        [_titleLael setFont:FontLevel2];
    }
    return _titleLael;
}




@end
