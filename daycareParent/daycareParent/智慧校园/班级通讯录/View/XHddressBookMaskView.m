//
//  XHddressBookMaskView.m
//  daycareParent
//
//  Created by mac on 2018/3/9.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHddressBookMaskView.h"


@interface XHddressBookMaskView ()

@property (nonatomic,strong) UIImageView *headerImageView; //!< 头像视图
@property (nonatomic,strong) UIImageView *markImageView; //!< 附件视图
@property (nonatomic,strong) UILabel *titleLabel; //!< 标题标签
@property (nonatomic,strong) UILabel *describeLabel; //!< 描述标签
@property (nonatomic,strong) UILabel *subjecLabel; //!< 学科标签



@end

@implementation XHddressBookMaskView



- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self addSubview:self.headerImageView];
        [self addSubview:self.titleLabel];
        [self addSubview:self.describeLabel];
        [self addSubview:self.subjecLabel];
        [self addSubview:self.markImageView];
    }
    return self;
}



#pragma mark - Public Method
-(void)resetFrame:(CGRect)frame
{
    [self setFrame:frame];
    [self.headerImageView setFrame:CGRectMake(10.0, (frame.size.height-48.0)/2.0, 48.0, 48.0)];
    [self.subjecLabel setFrame:CGRectMake((self.headerImageView.right+10.0), self.headerImageView.top, 50.0, 24.0)];
    [self.titleLabel setFrame:CGRectMake((self.subjecLabel.right+5.0), self.subjecLabel.top, frame.size.width-(self.subjecLabel.right+5.0+40.0), self.subjecLabel.height)];
    [self.describeLabel setFrame:CGRectMake(self.subjecLabel.left, self.titleLabel.bottom, (self.subjecLabel.left+40.0), self.titleLabel.height)];
    [self.markImageView setFrame:CGRectMake(frame.size.width-30.0, frame.size.height-20.0, 20.0, 20.0)];
}





#pragma mark - Getter /  Setter
-(UIImageView *)headerImageView
{
    if (!_headerImageView)
    {
        _headerImageView = [[UIImageView alloc]init];
        [_headerImageView setImage:[UIImage imageNamed:@"头像3"]];
    }
    return _headerImageView;
}

-(UIImageView *)markImageView
{
    if (!_markImageView)
    {
        _markImageView = [[UIImageView alloc]init];
        [_markImageView setImage:[UIImage imageNamed:@"addressBookMore"]];
    }
    return _markImageView;
}


-(UILabel *)titleLabel
{
    if (!_titleLabel)
    {
        _titleLabel = [[UILabel alloc]init];
        [_titleLabel setText:@"姚立志"];
    }
    return _titleLabel;
}


-(UILabel *)describeLabel
{
    if (!_describeLabel)
    {
        _describeLabel = [[UILabel alloc]init];
        [_describeLabel setText:@"学汇IOS开发负责人"];
    }
    return _describeLabel;
}

-(UILabel *)subjecLabel
{
    if (!_subjecLabel)
    {
        _subjecLabel = [[UILabel alloc]init];
        [_subjecLabel setText:@"数学"];
        [_subjecLabel setTextAlignment:NSTextAlignmentCenter];
    }
    return _subjecLabel;
}









@end
