//
//  XHEducationCloudItemCell.m
//  daycareParent
//
//  Created by Git on 2017/12/12.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHEducationCloudItemCell.h"


@interface XHEducationCloudItemCell ()

@property (nonatomic,strong) UIImageView *imageView; //!< 图片视图
@property (nonatomic,strong) UILabel *titleLabel; //!< 标题标签
@property (nonatomic,strong) UILabel *describeLabel; //!< 描述标签
@property (nonatomic,strong) UILabel *dateLabel; //!< 日期标签
@property (nonatomic,strong) UILabel *visitorsLabel; //!< 浏览人数
@property (nonatomic,strong) UIView *lineView; //!< 分割线













@end



@implementation XHEducationCloudItemCell




- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        
        [self setItemColor:NO];
        
        [self.contentView addSubview:self.imageView];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.describeLabel];
        [self.contentView addSubview:self.dateLabel];
        [self.contentView addSubview:self.visitorsLabel];
        [self.contentView addSubview:self.lineView];
        
        
        [self.imageView setFrame:CGRectMake(10.0, 10.0, 90.0, 60.0)];
        [self.titleLabel setFrame:CGRectMake(self.imageView.right+10.0, self.imageView.top, frame.size.width-(self.imageView.right+20.0), 20.0)];
        [self.describeLabel setFrame:CGRectMake(self.titleLabel.left, self.titleLabel.bottom, self.titleLabel.width, self.titleLabel.height)];
        [self.dateLabel setFrame:CGRectMake(self.describeLabel.left, (self.describeLabel.bottom+4.0), self.describeLabel.width/2.0, (self.describeLabel.height-4.0))];
        
        [self.lineView setFrame:CGRectMake(0, 0, frame.size.width, 0.5)];
        
    }
    return self;
}

-(void)setItemFrame:(XHEducationCloudFrame *)itemFrame
{
    _itemFrame = itemFrame;
    
    switch (itemFrame.model.modelType)
    {
        case XHEducationCloudCellVideoTpe:
        {
            [self.imageView sd_setImageWithURL:[NSURL URLWithString:itemFrame.model.previewImage] placeholderImage:[UIImage imageNamed:@"shipinmoren"]];
        }
            break;
        case XHEducationCloudCellExaminationQuestionsTpe:
        {
            [self.imageView sd_setImageWithURL:[NSURL URLWithString:itemFrame.model.previewImage] placeholderImage:[UIImage imageNamed:@"shitimoren"]];
        }
        default:
            break;
    }
    
    
    [self.titleLabel setText:itemFrame.model.title];
    [self.describeLabel setText:itemFrame.model.describe];
    [self.dateLabel setText:itemFrame.model.date];

    [self.visitorsLabel setText:itemFrame.model.visitors];
    
    //因为浏览人数是个根据内容长度来设置长度
    CGSize versionSize = [NSObject contentSizeWithTitle:itemFrame.model.visitors withFontOfSize:FontLevel4 withWidth:self.dateLabel.width];
    versionSize = CGSizeMake(versionSize.width+10.0, versionSize.height);
    [self.visitorsLabel setFrame:CGRectMake(self.describeLabel.right-versionSize.width, self.dateLabel.top, versionSize.width, self.dateLabel.height)];
    [self.visitorsLabel setLayerCornerRadius:(self.visitorsLabel.height/2.0)];
}




-(void)setItemColor:(BOOL)color
{
    if (color)
    {
        [self.titleLabel setBackgroundColor:[UIColor orangeColor]];
        [self.describeLabel setBackgroundColor:[UIColor magentaColor]];
        [self.dateLabel setBackgroundColor:[UIColor purpleColor]];
        [self.visitorsLabel setBackgroundColor:[UIColor brownColor]];
    }
}




#pragma mark - Getter / Setter
-(UIImageView *)imageView
{
    if (!_imageView)
    {
        _imageView = [[UIImageView alloc]init];
    }
    return _imageView;
}

-(UILabel *)titleLabel
{
    if (!_titleLabel)
    {
        _titleLabel = [[UILabel alloc]init];
        [_titleLabel setFont:FontLevel3];
        
    }
    return _titleLabel;
}


-(UILabel *)describeLabel
{
    if (!_describeLabel)
    {
        _describeLabel = [[UILabel alloc]init];
        [_describeLabel setFont:FontLevel4];
    }
    return _describeLabel;
}


-(UILabel *)dateLabel
{
    if (!_dateLabel)
    {
        _dateLabel = [[UILabel alloc]init];
        [_dateLabel setFont:FontLevel4];
    }
    return _dateLabel;
}

-(UILabel *)visitorsLabel
{
    if (!_visitorsLabel)
    {
        _visitorsLabel = [[UILabel alloc]init];
        [_visitorsLabel setTextAlignment:NSTextAlignmentCenter];
        [_visitorsLabel setBackgroundColor:RGB(238.0, 238.0, 238.0)];
        [_visitorsLabel setFont:FontLevel4];
    }
    return _visitorsLabel;
}


-(UIView *)lineView
{
    if (!_lineView)
    {
        _lineView = [[UIView alloc]init];
        [_lineView setBackgroundColor:LineViewColor];
    }
    return _lineView;
}


@end

