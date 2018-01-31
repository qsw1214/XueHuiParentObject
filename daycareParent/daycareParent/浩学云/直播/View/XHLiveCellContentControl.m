//
//  XHLiveCellContentControl.m
//  daycareParent
//
//  Created by Git on 2018/1/10.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHLiveCellContentControl.h"


@interface XHLiveCellContentControl ()

@property (nonatomic,strong) UIImageView *imageView;  //!< 图片视图
@property (nonatomic,strong) UILabel *titleLabel; //!< 标题标签
@property (nonatomic,strong) UILabel *dateLabel; //!< 标题标签
@property (nonatomic,strong) UILabel *liveMarkLabel; //!< 播放状态标签
@property (nonatomic,strong) UILabel *lectureTeacherLabel; //!< 主讲老师标签



@end

@implementation XHLiveCellContentControl



- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self addSubview:self.imageView];
        [self addSubview:self.titleLabel];
        [self addSubview:self.dateLabel];
        [self addSubview:self.liveMarkLabel];
        [self addSubview:self.lectureTeacherLabel];
        
        
        [self setBackgroundColor:[UIColor whiteColor]];
    }
    return self;
}


-(void)setItemFrame:(XHLiveFrame*)frame
{
    [self setFrame:frame.itemFrame];
    
    [self.titleLabel setHidden:YES];
    [self.dateLabel setHidden:YES];
    [self.liveMarkLabel setHidden:YES];
    [self.lectureTeacherLabel setHidden:YES];
    
    switch (frame.model.contentType)
    {
        case XHLiveAdvertType:
        {
            [self.imageView setFrame:frame.itemFrame];
            [self.imageView setLayerCornerRadius:0];
            [self.imageView setImage:[UIImage imageNamed:frame.model.imageUrl]];
            
        }
            break;
        case XHLiveItemType:
        {
            
            [self.titleLabel setHidden:NO];
            [self.dateLabel setHidden:NO];
            [self.liveMarkLabel setHidden:NO];
            [self.lectureTeacherLabel setHidden:NO];
            
            
            [self.imageView setFrame:CGRectMake(10, 10, (frame.itemFrame.size.height-20.0), (frame.itemFrame.size.height-20.0))];
            [self.imageView setLayerCornerRadius:(self.imageView.height/2.0)];
            [self.titleLabel setFrame:CGRectMake((self.imageView.right+10.0), self.imageView.top, (frame.itemFrame.size.width-(self.imageView.right+20.0)), 20.)];
            [self.dateLabel setFrame:CGRectMake(self.titleLabel.left, self.titleLabel.bottom+10.0, self.titleLabel.width/2.0, self.titleLabel.height)];
            [self.liveMarkLabel setFrame:CGRectMake(self.dateLabel.right, self.dateLabel.top, self.dateLabel.width, self.dateLabel.height)];
            [self.lectureTeacherLabel setFrame:CGRectMake(self.titleLabel.left, self.dateLabel.bottom+10, self.titleLabel.width, self.titleLabel.height)];
            
            
            
            //!< 赋值
             [self.imageView sd_setImageWithURL:[NSURL URLWithString:frame.model.imageUrl] placeholderImage:[UIImage imageNamed:@"addman"]];
           // [self.imageView setImage:[UIImage imageNamed:frame.model.imageUrl]];
            [self.titleLabel setText:frame.model.title];
            [self.dateLabel setText:frame.model.date];
            [self.lectureTeacherLabel setText:[NSString stringWithFormat:@"主讲：%@",frame.model.lectureTeacher]];
            switch (frame.model.liveType)
            {
                case XHLiveNormalType:
                {
                   // [self.liveMarkLabel setHidden:YES];
                    [self.liveMarkLabel setText:@"未开始"];
                }
                    break;
                case XHLiveingType:
                {
                    [self.liveMarkLabel setText:@"直播中"];
                }
                    break;
                case XHLiveEndType:
                {
                    [self.liveMarkLabel setText:@"已结束"];
                }
                    break;
            }
            
        }
            break;
    }
}


#pragma mark - Getter / Setter
-(UIImageView *)imageView
{
    if (!_imageView)
    {
        _imageView = [[UIImageView alloc]init];
        [_imageView setContentMode:UIViewContentModeScaleAspectFill];
        [_imageView setLayerCornerRadius:0];
    }
    return _imageView;
}


-(UILabel *)titleLabel
{
    if (!_titleLabel)
    {
        _titleLabel = [[UILabel alloc]init];
        [_titleLabel setTextColor:RGB(13, 13, 13)];
        [_titleLabel setFont:FontLevel2];
    }
    return _titleLabel;
    
}


-(UILabel *)dateLabel
{
    if (!_dateLabel)
    {
        _dateLabel = [[UILabel alloc]init];
        [_dateLabel setTextColor:RGB(85, 85, 85)];
        [_dateLabel setFont:FontLevel3];
    }
    return _dateLabel;
    
}


-(UILabel *)liveMarkLabel
{
    if (!_liveMarkLabel)
    {
        _liveMarkLabel = [[UILabel alloc]init];
        [_liveMarkLabel setTextColor:RGB(85, 85, 85)];
        [_liveMarkLabel setFont:FontLevel3];
    }
    return _liveMarkLabel;
    
}

-(UILabel *)lectureTeacherLabel
{
    if (!_lectureTeacherLabel)
    {
        _lectureTeacherLabel = [[UILabel alloc]init];
        [_lectureTeacherLabel setTextColor:RGB(85, 85, 85)];
        [_lectureTeacherLabel setFont:FontLevel3];
    }
    return _lectureTeacherLabel;
}




@end
