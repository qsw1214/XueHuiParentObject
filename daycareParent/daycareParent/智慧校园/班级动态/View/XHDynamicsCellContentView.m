//
//  XHDynamicsCellContentView.m
//  daycareParent
//
//  Created by Git on 2017/12/14.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHDynamicsCellContentView.h"
#import "XHDynamicsHeaderControl.h"







@interface XHDynamicsCellContentView ()

@property (nonatomic,strong) XHDynamicsHeaderControl *headerControl; //!< 教师头像图片视图
@property (nonatomic,strong) UIImageView *markImageView; //!< 标题图片视图
@property (nonatomic,strong) UILabel *nameLabel; //!< 教师名称标签
@property (nonatomic,strong) UILabel *dateLabel; //!< 日期标签
@property (nonatomic,strong) UILabel *workUnitLabel; //!< 工作单位
@property (nonatomic,strong) UILabel *contentLabel; //!< 内容标签
@property (nonatomic,strong) XHVideoControl *videoControl;
@property (nonatomic,strong) XHDynamicsCollectionView *imageContentView;




@end



@implementation XHDynamicsCellContentView




- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self setItemColor:NO];
        [self setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:self.headerControl];
        [self addSubview:self.markImageView];
        [self addSubview:self.nameLabel];
        [self addSubview:self.dateLabel];
        [self addSubview:self.workUnitLabel];
        [self addSubview:self.contentLabel];
        [self addSubview:self.imageContentView];
        [self.imageContentView setItemDeletage:self.deletage];
        [self addSubview:self.videoControl];
        
    }
    return self;
}

-(void)resetFrame:(CGRect)frame
{
    [self setFrame:frame];
    
    [self.headerControl resetFrame:CGRectMake(10, 10, 60, 60)];
    [self.nameLabel setFrame:CGRectMake(self.headerControl.right+10.0, self.headerControl.top, (frame.size.width-self.headerControl.right-115), 30.0)];
    [self.dateLabel setFrame:CGRectMake(self.nameLabel.right+5, self.nameLabel.top, (80), self.nameLabel.height)];
    [self.workUnitLabel setFrame:CGRectMake(self.nameLabel.left, self.nameLabel.bottom, (frame.size.width-self.headerControl.right-20.0), self.nameLabel.height)];
    [self.markImageView setFrame:CGRectMake((frame.size.width-40.0), 0, 40.0, 40.0)];
    
    
}



-(void)setItemFrame:(XHDynamicsFrame*)frame withIndexPath:(NSIndexPath*)indexPath
{
    [frame.model setReadHeaderControl:self.headerControl];
    [self.imageContentView setHidden:YES];
    [self.videoControl setHidden:YES];
    [self.contentLabel setFrame:CGRectMake(self.workUnitLabel.left,self.workUnitLabel.bottom+10.0, frame.contenSize.width, frame.contenSize.height)];
    
    switch (frame.model.dynamicskUnreadType)
    {
        case XHDynamicsUnreadType:
        {
            [self.headerControl dotHidden:NO];
        }
            break;
        case XHDynamicsAlreadyReadType:
        {
            [self.headerControl dotHidden:YES];
        }
    }
    switch (frame.model.modelType)
    {
        case XHDynamicsModelTextType:
            break;
        case XHDynamicsModelTextAndImageType:
        {
            [self.imageContentView resetFrame:CGRectMake(self.contentLabel.left, self.contentLabel.bottom+5.0, frame.previewSize.width, frame.previewSize.height)];
            [self.imageContentView setItemArray:frame.model.imageUrlArray];
        }
            break;
        case XHDynamicsModelTextAndVideoType:
        {
            [self.videoControl resetFrame:CGRectMake(0.0, (self.contentLabel.bottom+10.0), (frame.itemFrame.size.width), 200.0)];
            switch (frame.model.playType)
            {
                case XHDynamicsPauseType:
                {
#pragma mark 设置视频展示的Url地址
                    [self.videoControl setObject:frame];
                    [self.videoControl setTag:(indexPath.row+1)];
                   
                }
                    break;
                case XHDynamicsPlayerType:
                    break;
            }
        }
            break;
    }
    
   //!< 赋值
    [self.headerControl sd_setImageWithURL:frame.model.headerUrl placeholderImage:@"addman"];
    [self.nameLabel setText:frame.model.teacherName];
    [self.dateLabel setText:[NSString safeString:[frame.model.dateArray firstObject]]];
    [self.workUnitLabel setText:frame.model.workUnit];
    [self.contentLabel setText:frame.model.content];
    
    
}



#pragma mark - Action Method
-(void)videoControlAction:(XHVideoControl*)sender
{
    if ([self.deletage respondsToSelector:@selector(videoPlayerAction:)])
    {
        [self.deletage videoPlayerAction:sender.object];
    }
}




 #pragma mark - Getter / Setter
 -(XHDynamicsHeaderControl *)headerControl
 {
     if (_headerControl == nil)
     {
         _headerControl = [[XHDynamicsHeaderControl alloc]init];
     }
 return _headerControl;
 }



-(UILabel *)nameLabel
{
    if (!_nameLabel)
    {
        _nameLabel = [[UILabel alloc]init];
        [_nameLabel setFont:FontLevel1];
        [_nameLabel setTextColor:RGB(120.0, 120.0, 120.0)];
    }
    return _nameLabel;
}


-(UILabel *)dateLabel
{
    if (!_dateLabel)
    {
        _dateLabel = [[UILabel alloc]init];
        [_dateLabel setFont:FontLevel3];
        [_dateLabel setTextAlignment:NSTextAlignmentRight];
        [_dateLabel setTextColor:RGB(120.0, 120.0, 120.0)];
    }
    return _dateLabel;
}

-(UILabel *)workUnitLabel
{
    if (!_workUnitLabel)
    {
        _workUnitLabel = [[UILabel alloc]init];
        [_workUnitLabel setFont:FontLevel3];
        [_workUnitLabel setTextColor:RGB(120.0, 120.0, 120.0)];
    }
    return _workUnitLabel;
}


-(UILabel *)contentLabel
{
    if (!_contentLabel)
    {
        _contentLabel = [[UILabel alloc]init];
        [_contentLabel setNumberOfLines:0];
        [_contentLabel setFont:FontLevel3];
        [_contentLabel setTextColor:RGB(120.0, 120.0, 120.0)];
    }
    return _contentLabel;
}





-(UIImageView *)markImageView
{
    if (!_markImageView)
    {
        _markImageView = [[UIImageView alloc]init];
        [_markImageView setContentMode:UIViewContentModeScaleAspectFit];
        [_markImageView setImage:[UIImage imageNamed:@"tag-class"]];
    }
    return _markImageView;
}



-(XHDynamicsCollectionView *)imageContentView
{
    if (!_imageContentView)
    {
        _imageContentView = [[XHDynamicsCollectionView alloc]init];
        _imageContentView.backgroundColor=[UIColor whiteColor];
    }
    return _imageContentView;
}



-(XHVideoControl *)videoControl
{
    if (!_videoControl)
    {
        _videoControl = [[XHVideoControl alloc]init];
        [_videoControl setBackgroundColor:LineViewColor];
        [_videoControl addTarget:self action:@selector(videoControlAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _videoControl;
}


-(void)setItemColor:(BOOL)color
{
    if (color)
    {
        [self setBackgroundColor:[UIColor redColor]];
        [self.nameLabel setBackgroundColor:[UIColor redColor]];
        [self.dateLabel setBackgroundColor:[UIColor yellowColor]];
        [self.workUnitLabel setBackgroundColor:[UIColor greenColor]];
        [self.contentLabel setBackgroundColor:[UIColor blueColor]];
        [self.markImageView setBackgroundColor:[UIColor magentaColor]];
    }
}



@end
