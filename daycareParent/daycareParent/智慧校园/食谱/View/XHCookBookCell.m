//
//  XHCookBookCell.m
//  daycareParent
//
//  Created by Git on 2017/12/5.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHCookBookCell.h"
#import "XHCookBookImageControl.h"
#import "XHDynamicsPreviewControl.h"



@interface XHCookBookCell ()

@property (nonatomic,strong) XHCookBookImageControl *previewImageView; //!< 图片视图
@property (nonatomic,strong) UILabel *titleLabel; //!< 标题标签
@property (nonatomic,strong) UILabel *contentLabel; //!< 标题标签
@property (nonatomic,strong) UIView *markView; //!< 选中视图背景颜色
@property (nonatomic,strong) UIView *lineView; //!< 分割线


@end



@implementation XHCookBookCell



- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self.contentView addSubview:self.previewImageView];
        [self.contentView addSubview:self.contentLabel];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.markView];
        [self.contentView addSubview:self.lineView];
        [self.contentView setBackgroundColor:[UIColor whiteColor]];

        [self setItemColor:NO];
    }
    return self;
}


-(void)setItemFrame:(XHCookBookFrame *)itemFrame
{
    switch (itemFrame.model.modeType)
    {
#pragma mark case CookBookDate 左侧日期形式
        case CookBookDateType:
        {
            //重置Frame
            [self.markView setFrame:CGRectMake(0, 0, 5, itemFrame.itemFrame.size.height)];
            [self.titleLabel setFrame:CGRectMake(0, 0, itemFrame.itemFrame.size.width, itemFrame.itemFrame.size.height)];
            [self.lineView setFrame:CGRectMake(0, itemFrame.itemFrame.size.height-0.5, self.titleLabel.width, 0.5)];
            
            //设置属性
            [self.titleLabel setTextAlignment:NSTextAlignmentCenter];
            [self.titleLabel setHidden:NO];
            switch (itemFrame.model.selectType)
            {
                case CookBookSelectType:
                {
                    [self.markView setHidden:NO];
                    [self.titleLabel setTextColor:RGB(91, 208, 184)];
                    [self.titleLabel setBackgroundColor:[UIColor whiteColor]];
                }
                    break;
                case CookBookNormalType:
                {
                    [self.markView setHidden:YES];
                    [self.titleLabel setTextColor:RGB(97.0, 97.0, 97.0)];
                    [self.titleLabel setBackgroundColor:RGB(245, 245, 245)];
                }
                    break;
            }
            
            
            //赋值
            [self.titleLabel setText:itemFrame.model.date];
        }
            break;
#pragma mark case CookBookDetailsType 右侧内容形式
        case CookBookDetailsType:
        {
            //重置Frame
            [self.previewImageView resetFrame:CGRectMake(10, 10, 90.0, 70.0)];
            [self.titleLabel setFrame:CGRectMake(self.previewImageView.right+10.0, self.previewImageView.top, itemFrame.itemFrame.size.width-(self.previewImageView.right+20.0), 20.0)];
            [self.contentLabel setFrame:CGRectMake(self.titleLabel.left, self.titleLabel.bottom, self.titleLabel.width, itemFrame.contentFrame.size.height)];
            
            [self.lineView setFrame:CGRectMake(self.previewImageView.left,itemFrame.itemFrame.size.height-0.5, itemFrame.itemFrame.size.width, 0.5)];
            
            //设置属性
            [self.titleLabel setFont:[UIFont boldSystemFontOfSize:14.0]];
            [self.titleLabel setTextAlignment:NSTextAlignmentLeft];
            [self.titleLabel setTextColor:RGB(51.0, 51.0, 51.0)];
            [self.titleLabel setHidden:NO];
            [self.contentLabel setHidden:NO];
            [self.contentLabel setTextColor:RGB(48.0, 48.0, 48.0)];
            [self.previewImageView setHidden:NO];
            
            //赋值
            
            
            if ([itemFrame.model.title isEqualToString:@""] && [itemFrame.model.content isEqualToString:@""])
            {
                [self.titleLabel setText:@""];
                [self.contentLabel setText:@"暂无"];
            }
            else
            {
                [self.titleLabel setText:itemFrame.model.title];
                [self.contentLabel setText:itemFrame.model.content];
            }
             [self.previewImageView setModel:itemFrame.model.previewModel];
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
        [_titleLabel setFont:FontLevel3];
        [_titleLabel setHidden:YES];
    }
    return _titleLabel;
}


-(UILabel *)contentLabel
{
    if (_contentLabel == nil)
    {
        _contentLabel = [[UILabel alloc]init];
        [_contentLabel setHidden:YES];
        [_contentLabel setFont:FontLevel4];
        [_contentLabel setNumberOfLines:0];
    }
    return _contentLabel;
}

-(XHCookBookImageControl *)previewImageView
{
    if (_previewImageView == nil)
    {
        _previewImageView = [[XHCookBookImageControl alloc]init];
        [_previewImageView setHidden:YES];
        [_previewImageView addTarget:self action:@selector(previewAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _previewImageView;
}



-(UIView *)markView
{
    if (_markView == nil)
    {
        _markView = [[UIView alloc]init];
        [_markView setBackgroundColor:RGB(91, 208, 184)];
        [_markView setHidden:YES];
    }
    return _markView;
}


-(UIView *)lineView
{
    if (_lineView == nil)
    {
        _lineView = [[UIView alloc]init];
        [_lineView setBackgroundColor:RGB(224, 224, 224)];
    }
    return _lineView;
}


-(void)setItemColor:(BOOL)color
{
    if (color)
    {
        [self.titleLabel setBackgroundColor:[UIColor redColor]];
        [self.contentLabel setBackgroundColor:[UIColor greenColor]];
        [self.previewImageView setBackgroundColor:[UIColor grayColor]];
    }
}



-(void)previewAction:(XHCookBookImageControl*)sender
{
    NSMutableArray *array = [[NSMutableArray alloc]init];
    [array addObject:sender.model];
    XHDynamicsPreviewControl *previewControl = [[XHDynamicsPreviewControl alloc]init];
    [previewControl setItemArray:array];
    [previewControl show];
}


@end
