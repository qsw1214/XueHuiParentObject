//
//  XHHomeWorkCellContentView.m
//  daycareParent
//
//  Created by Git on 2017/12/1.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHNoticeCellContentView.h"
#import "XHNoticeCollectionView.h"




@interface XHNoticeCellContentView ()

@property (nonatomic,strong) XHNoticeCollectionView *collectionView;
@property (nonatomic,strong) BaseButtonControl *headerControl; //!< 头像
@property (nonatomic,strong) BaseButtonControl *gradeControl; //!< 年级的小旗图标
@property (nonatomic,strong) XHVideoControl *videoControl; //!< 视频播放按钮
@property (nonatomic,strong) UILabel *userNameLael; //!< 用户名标签

@property (nonatomic,strong) UILabel *dateLabel; //!< 日期标签
@property (nonatomic,strong) UILabel *contentLabel; //!< 作业标签
@property (nonatomic,strong) UIView *lineView; //!< 分割线


@end



@implementation XHNoticeCellContentView



- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self setItemColor:NO];
        [self addSubview:self.headerControl];
        [self addSubview:self.userNameLael];
        [self addSubview:self.dateLabel];
        [self addSubview:self.contentLabel];
        [self addSubview:self.lineView];
        [self addSubview:self.gradeControl];
        [self addSubview:self.collectionView];
        [self addSubview:self.videoControl];
        
        [self setBackgroundColor:[UIColor whiteColor]];
    }
    return self;
}


-(void)setItemFrame:(XHNoticeFrame*)itemFrame withIndexPath:(NSIndexPath*)indexPath
{
    
    //重置Frame
    [self setFrame:itemFrame.itemFrame];
    
    
    [itemFrame.model setTage:indexPath.row];
    [itemFrame.model.playModel setIndexPath:indexPath];
    [itemFrame.model.playModel setFatherViewTag:indexPath.row];
    [itemFrame.model setPlayModel:itemFrame.model.playModel];
    
    
    switch (itemFrame.model.noticeType)
    {
#pragma mark case HomeWorkType
        case NoticeType:
        {
            [self.headerControl resetFrame:CGRectMake(10.0, 10.0, 60.0, 60.0)];
            //设置用户名
            [self.userNameLael setFrame:CGRectMake(self.headerControl.right+10.0, self.headerControl.top, (itemFrame.itemFrame.size.width-(self.headerControl.right+110)), 30.0)];
            //设置日期
            [self.dateLabel setFrame:CGRectMake(self.userNameLael.right+5, self.userNameLael.top, 90, self.userNameLael.height)];
            //设置内容视图
            [self.contentLabel setFrame:CGRectMake(self.userNameLael.left, self.userNameLael.bottom, (itemFrame.itemFrame.size.width-(self.userNameLael.left+10.0)), 30.0)];
            [self.lineView setFrame:CGRectMake(0, itemFrame.itemFrame.size.height-0.5, itemFrame.itemFrame.size.width, 0.5)];
            
            //设置属性
            [self.contentLabel setNumberOfLines:1];
            
            
            //赋值
            [self.headerControl sd_setImageWithURL:itemFrame.model.headerUrl withPlaceholder:@"addman" withNumberType:0 withAllType:NO];
            [self.userNameLael setText:itemFrame.model.userName];
            [self.dateLabel setText:itemFrame.model.releaseDate];
            [self.contentLabel setText:itemFrame.model.content];
            
            switch (itemFrame.model.noticekUnreadType)
            {
                case NoticeUnreadType:
                {
                    [self.headerControl setIconImageViewBackGroundColor:[UIColor redColor] withNumberType:1 withAllType:NO];
                    [self.userNameLael setFont:[UIFont boldSystemFontOfSize:16.0]];
                    [self.contentLabel setFont:[UIFont boldSystemFontOfSize:16.0]];
                }
                    break;
                case NoticeAlreadyReadType:
                {
                    [self.headerControl setIconImageViewBackGroundColor:[UIColor clearColor] withNumberType:1 withAllType:NO];
                    [self.userNameLael setFont:FontLevel2];
                    [self.contentLabel setFont:FontLevel2];
                }
                    break;
            }
        }
            break;
#pragma mark case HomeWorkDetailsType
        case NoticeDetailsType:
        {
            
            [self.headerControl resetFrame:CGRectMake(10.0, 10.0, 60.0, 60.0)];
            [self.userNameLael setFrame:CGRectMake(self.headerControl.right+10.0, self.headerControl.top, itemFrame.contentSize.width, 30.0)];
            [self.contentLabel setFrame:CGRectMake(self.userNameLael.left, self.userNameLael.bottom, itemFrame.contentSize.width, itemFrame.contentSize.height)];
            [self.collectionView setHidden:YES];
            [self.videoControl setHidden:YES];
            
            
            switch (itemFrame.model.contentType)
            {
#pragma mark 纯文本类型
                case XHNoticeTextType:
                {
                     [self.gradeControl resetFrame:CGRectMake(self.contentLabel.left, (self.contentLabel.bottom+(itemFrame.previewSize.height > 0 ? itemFrame.previewSize.height+10.0 : 5.0) ), self.contentLabel.width/2.0, 20)];
                }
                    break;
#pragma mark 文字和图片类型
                case XHNoticeTextAndImageType:
                {
                    [self.collectionView setHidden:NO];
                     [self.collectionView resetFrame:CGRectMake(self.contentLabel.left, self.contentLabel.bottom+5.0, itemFrame.previewSize.width, itemFrame.previewSize.height)];
                    [self.collectionView setItemArray:itemFrame.model.imageUrlArray];
                    
                    [self.gradeControl resetFrame:CGRectMake(self.contentLabel.left, (self.contentLabel.bottom+(itemFrame.previewSize.height > 0 ? itemFrame.previewSize.height+10.0 : 5.0) ), self.contentLabel.width/2.0, 20)];
                }
                    break;
#pragma mark 文字和视频
                case XHNoticeTextAndVideoType:
                {
                    [self.videoControl resetFrame:CGRectMake(0.0, (self.contentLabel.bottom+20.0), (itemFrame.itemFrame.size.width), 200.0)];
#pragma mark 设置视频展示的Url地址
                    [self.videoControl setNotoceObject:itemFrame];
                    [self.videoControl setTag:(indexPath.row+1)];
                    [itemFrame.model.playModel setIndexPath:indexPath];
                    [itemFrame.model.playModel setFatherViewTag:self.videoControl.tag];
                    [itemFrame.model.playModel setFatherView:self.videoControl];
                    
                     [self.gradeControl resetFrame:CGRectMake(self.contentLabel.left,(self.videoControl.bottom+10.0), self.contentLabel.width/2.0, 20)];
                }
                    break;
            }
           
           
           
            [self.dateLabel setFrame:CGRectMake(self.gradeControl.right+5.0, self.gradeControl.top, (self.contentLabel.width-(self.gradeControl.width+10.0)), self.gradeControl.height)];
            
            //设置属性
            [self.contentLabel setNumberOfLines:0];
            [self.gradeControl setImageEdgeFrame:CGRectMake(0, 0, 20.0, self.gradeControl.height) withNumberType:0 withAllType:NO];
            [self.gradeControl setTitleEdgeFrame:CGRectMake(30.0, 0, self.gradeControl.width-30.0, self.gradeControl.height) withNumberType:0 withAllType:NO];
            
            
            
            //赋值
            [self.headerControl sd_setImageWithURL:itemFrame.model.headerUrl withPlaceholder:@"addman" withNumberType:0 withAllType:NO];
            [self.userNameLael setText:itemFrame.model.userName];
            [self.dateLabel setText:itemFrame.model.releaseDate];
            [self.contentLabel setText:itemFrame.model.content];
            [self.gradeControl setText:itemFrame.model.className withNumberType:0 withAllType:NO];
            
        }
            break;
    }
    
    

   
}






#pragma mark - Getter / Setter
-(BaseButtonControl *)headerControl
{
    if (_headerControl == nil)
    {
        _headerControl = [[BaseButtonControl alloc]init];
        [_headerControl setNumberImageView:2];
        [_headerControl setImageEdgeFrame:CGRectMake(0, 0, 60.0, 60.0) withNumberType:0 withAllType:NO];
        [_headerControl setImageEdgeFrame:CGRectMake(50.0, 5.0, 10.0, 10.0) withNumberType:1 withAllType:NO];
        [_headerControl setImageLayerCornerRadius:30.0 withNumberType:0 withAllType:NO];
        [_headerControl setImageLayerCornerRadius:5.0 withNumberType:1 withAllType:NO];
    }
    return _headerControl;
}


-(BaseButtonControl *)gradeControl
{
    if (_gradeControl == nil)
    {
        _gradeControl = [[BaseButtonControl alloc]init];
        [_gradeControl setNumberLabel:1];
        [_gradeControl setNumberImageView:1];
        [_gradeControl setTextColor:RGB(124, 124, 124) withTpe:0 withAllType:NO];
        [_gradeControl setFont:FontLevel3 withNumberType:0 withAllType:NO];
        [_gradeControl setImage:@"ico_class" withNumberType:0 withAllType:NO];
    }
    return _gradeControl;
}


-(UILabel *)userNameLael
{
    if (_userNameLael == nil)
    {
        _userNameLael = [[UILabel alloc]init];
        [_userNameLael setTextColor:RGB(2, 2, 2)];
        [_userNameLael setFont:FontLevel2];
    }
    return _userNameLael;
}


-(UILabel *)dateLabel
{
    if (_dateLabel == nil)
    {
        _dateLabel = [[UILabel alloc]init];
        [_dateLabel setTextAlignment:NSTextAlignmentRight];
        [_dateLabel setTextColor:RGB(124, 124, 124)];
        [_dateLabel setFont:FontLevel4];
    }
    return _dateLabel;
}

-(UILabel *)contentLabel
{
    if (_contentLabel == nil)
    {
        _contentLabel = [[UILabel alloc]init];
        [_contentLabel setTextColor:RGB(3, 3, 3)];
        [_contentLabel setFont:FontLevel2];
    }
    return _contentLabel;
}

-(UIView *)lineView
{
    if (_lineView == nil)
    {
        _lineView = [[UIView alloc]init];
        [_lineView setBackgroundColor:LineViewColor];
    }
    return _lineView;
}

-(XHNoticeCollectionView *)collectionView
{
    if (_collectionView == nil)
    {
        _collectionView = [[XHNoticeCollectionView alloc]init];
    }
    return _collectionView;
}


-(XHVideoControl *)videoControl
{
    if (_videoControl == nil)
    {
        _videoControl = [[XHVideoControl alloc]init];
        [_videoControl setBackgroundColor:LineViewColor];
        [_videoControl addTarget:self action:@selector(videoControlAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _videoControl;
}


-(void)videoControlAction:(XHVideoControl*)sender
{
    if ([self.deletage respondsToSelector:@selector(videoPlayerAction:)])
    {
        [self.deletage videoPlayerAction:sender.notoceObject];
    }
}




-(void)setItemColor:(BOOL)color
{
    if (color)
    {
        [self.userNameLael setBackgroundColor:[UIColor yellowColor]];
        [self.dateLabel setBackgroundColor:[UIColor darkGrayColor]];
        [self.contentLabel setBackgroundColor:[UIColor purpleColor]];
        [self.headerControl setIconImageViewBackGroundColor:[UIColor redColor] withNumberType:0 withAllType:NO];
        [self.headerControl setIconImageViewBackGroundColor:[UIColor greenColor] withNumberType:1 withAllType:NO];
        [self.gradeControl setBackgroundColor:[UIColor orangeColor]];
    }
}






@end
