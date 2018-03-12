//
//  XHTeacherAddressBookCell.m
//  daycareParent
//
//  Created by Git on 2017/12/13.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHTeacherAddressBookCell.h"



@interface XHTeacherAddressBookCell ()

@property (nonatomic,strong) UIImageView *headerImageView;//!< 头像
@property (nonatomic,strong) UILabel *titleLabel;//!< 标题
@property (nonatomic,strong) UILabel *describeLabel;//!< 描述
@property (nonatomic,strong) UIView *lineView;//!< 分割线



@end



@implementation XHTeacherAddressBookCell


- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self.contentView setBackgroundColor:[UIColor whiteColor]];
        [self.contentView addSubview:self.headerImageView];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.describeLabel];
        [self.contentView addSubview:self.lineView];
    }
    return self;
}


-(void)setItemFrame:(XHTeacherAddressBookFrame *)itemFrame
{
    _itemFrame = itemFrame;
    
    [self.headerImageView setFrame:CGRectMake(10, 10, 55, 55)];
    [self.headerImageView setLayerCornerRadius:(self.headerImageView.height/2.0)];
    [self.titleLabel setFrame:CGRectMake(self.headerImageView.right+10,20.0, (itemFrame.itemFrame.size.width-self.headerImageView.right-50), 20.0)];
    [self.describeLabel setFrame:CGRectMake(self.titleLabel.left, self.titleLabel.bottom+5.0, self.titleLabel.width, self.titleLabel.height)];
    
    [self.lineView setFrame:CGRectMake(0, itemFrame.itemFrame.size.height-0.5, itemFrame.itemFrame.size.width, 0.5)];
    
    
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:itemFrame.model.headerUrl] placeholderImage:[UIImage imageNamed:@"addman"]];
    [self.titleLabel setText:itemFrame.model.teacherName];
    [self.describeLabel setText:itemFrame.model.phone];

}


#pragma mark - Getter / Setter
-(UIImageView *)headerImageView
{
    if (!_headerImageView)
    {
        _headerImageView = [[UIImageView alloc]init];
    }
    return _headerImageView;
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
        [_describeLabel setFont:FontLevel3];
    }
    return _describeLabel;
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
