//
//  XHAddressBookHeaderItemCell.m
//  daycareParent
//
//  Created by mac on 2018/3/9.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHAddressBookHeaderItemCell.h"


@interface XHAddressBookHeaderItemCell ()

@property (nonatomic,strong) UIImageView *headerImageView; //!< 头像
@property (nonatomic,strong) UILabel *titleLabel; //!< 主标题标签
@property (nonatomic,strong) UILabel *describeLabel; //!< 副标题标签


@end

@implementation XHAddressBookHeaderItemCell


#pragma mark - Public Method

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self.contentView addSubview:self.headerImageView];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.describeLabel];
        
        //!< 重置Frame
        [self.headerImageView setFrame:CGRectMake(10.0, ((frame.size.height-40.0)/2.0), 40.0, 40.0)];
        [self.headerImageView setLayerCornerRadius:(self.headerImageView.height/2.0)];

        
    }
    return self;
}



-(void)setModel:(XHChildListModel *)model
{
    _model = model;
    
    switch (model.markType)
    {
        case ChildListSelectType:
        {
            //!< 首先重置Frame
            [self.titleLabel setFrame:CGRectMake(self.headerImageView.right+10.0, self.headerImageView.top, 60.0, 20.0)];
            [self.describeLabel setFrame:CGRectMake(self.titleLabel.left, self.titleLabel.bottom, self.titleLabel.width, self.titleLabel.height)];
            
            //!< 设置属性并赋值
            [self.titleLabel setHidden:NO];
            [self.describeLabel setHidden:NO];
            [self.titleLabel setText:model.studentName];
            [self.describeLabel setText:model.clazzName];
        }
            break;
        case ChildListNormalType:
        {
            //!<  重置frame
            [self.titleLabel setFrame:CGRectZero];
            [self.describeLabel setFrame:CGRectZero];
            
            [self.titleLabel setHidden:YES];
            [self.describeLabel setHidden:YES];
        }
            break;
    }
    
    
    [self.headerImageView setImage:[UIImage imageNamed:@"头像3"]];
}







#pragma mark - Getter /  Setter
-(UIImageView *)headerImageView
{
    if (!_headerImageView)
    {
        _headerImageView = [[UIImageView alloc]init];
        [_headerImageView setBackgroundColor:[UIColor redColor]];
    }
    return _headerImageView;
}


-(UILabel *)titleLabel
{
    if (!_titleLabel)
    {
        _titleLabel = [[UILabel alloc]init];
    }
    return _titleLabel;
}


-(UILabel *)describeLabel
{
    if (!_describeLabel)
    {
        _describeLabel = [[UILabel alloc]init];
    }
    return _describeLabel;
}


@end
