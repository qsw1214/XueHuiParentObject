//
//  XHCookBookCell.m
//  daycareParent
//
//  Created by Git on 2017/12/5.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHCookBookCell.h"
#import "XHInfiniteRotationControl.h"




@interface XHCookBookCell ()

@property (nonatomic,strong) UILabel *titleLabel; //!< 标题标签
@property (nonatomic,strong) UILabel *contentLabel; //!< 标题标签
@property (nonatomic,strong) XHInfiniteRotationControl *infiniteRotationControl; //!< 选中视图背景颜色


@end



@implementation XHCookBookCell



- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self.contentView addSubview:self.infiniteRotationControl];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.contentLabel];
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
            [self.infiniteRotationControl resetFrame:CGRectMake(0, 0, itemFrame.itemSize.width, itemFrame.itemSize.height)];
            [self.titleLabel setFrame:CGRectMake(10.0, (self.infiniteRotationControl.bottom-20.0), self.infiniteRotationControl.width-20.0, 20.0)];
            [self.contentLabel setFrame:CGRectMake(self.titleLabel.left, (self.titleLabel.bottom+5.0),itemFrame.contentSize.width , itemFrame.contentSize.height)];
            
            
            //!< 赋值
            [self.titleLabel setText:itemFrame.model.title];
            [self.contentLabel setText:itemFrame.model.content];
            [self.infiniteRotationControl setInfiniteRotationItemArray:itemFrame.model.infiniteRotationArray];
            [self.infiniteRotationControl setPageItemArray:itemFrame.model.pageArray];
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


-(XHInfiniteRotationControl *)infiniteRotationControl
{
    if (!_infiniteRotationControl)
    {
        _infiniteRotationControl = [[XHInfiniteRotationControl alloc]init];
        [_infiniteRotationControl setType:XHInfiniteRotationBottomType];
    }
    return _infiniteRotationControl;
}




-(void)setItemColor:(BOOL)color
{
    if (color)
    {
        [self.titleLabel setBackgroundColor:[UIColor redColor]];
        [self.contentLabel setBackgroundColor:[UIColor greenColor]];
        [self.infiniteRotationControl setBackgroundColor:[UIColor grayColor]];
        [self.contentView setBackgroundColor:[UIColor orangeColor]];
    }
}




@end
