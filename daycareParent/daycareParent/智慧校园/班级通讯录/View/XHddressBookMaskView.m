//
//  XHddressBookMaskView.m
//  daycareParent
//
//  Created by mac on 2018/3/9.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHddressBookMaskView.h"


@interface XHddressBookMaskView ()

@property (nonatomic,strong) XHHeaderControl *headerImageView; //!< 头像视图
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
        [self setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:self.headerImageView];
        [self addSubview:self.titleLabel];
        [self addSubview:self.describeLabel];
        [self addSubview:self.subjecLabel];
        [self addSubview:self.markImageView];
        
        [self setItemColor:NO];
    }
    return self;
}



#pragma mark - Public Method
-(void)resetFrame:(CGRect)frame
{
    [self setFrame:frame];
    [self.headerImageView resetFrame:CGRectMake(10.0, (frame.size.height-48.0)/2.0, 48.0, 48.0)];
    self.headerImageView.layer.cornerRadius=48/2.0;
    self.headerImageView.layer.masksToBounds=YES;
    [self.subjecLabel setFrame:CGRectMake((self.headerImageView.right+10.0), self.headerImageView.top, 40.0, 24.0)];
    [self.titleLabel setFrame:CGRectMake((self.subjecLabel.right+5.0), self.subjecLabel.top, frame.size.width-(self.subjecLabel.right+5.0+40.0), self.subjecLabel.height)];
    [self.describeLabel setFrame:CGRectMake(self.subjecLabel.left, self.titleLabel.bottom, (frame.size.width-(self.subjecLabel.left+40.0)), self.titleLabel.height)];
    [self.markImageView resetFrame:CGRectMake(frame.size.width-30.0, (frame.size.height-20.0)/2.0, 20.0, 20.0)];
    [self.markImageView setImageEdgeFrame:CGRectMake(0, 0, self.markImageView.width, self.markImageView.width) withNumberType:0 withAllType:NO];
}





#pragma mark - Getter /  Setter
-(void)setItemFrame:(XHAddressBookFrame*)frame
{
    [self.titleLabel setText:frame.model.teacherName];
    [self.describeLabel setText:frame.model.phone];
    [self.subjecLabel setText:frame.model.subject];
    [self.headerImageView setHeadrUrl:frame.model.headPic withName:frame.model.teacherName withType:XHHeaderTeacherType];
    
}

-(XHHeaderControl *)headerImageView
{
    if (!_headerImageView)
    {
        _headerImageView = [[XHHeaderControl alloc]init];
    }
    return _headerImageView;
}

-(BaseButtonControl *)markImageView
{
    if (!_markImageView)
    {
        _markImageView = [[BaseButtonControl alloc]init];
        [_markImageView setNumberImageView:1];
        [_markImageView setImage:@"addressBookMore" withNumberType:0 withAllType:NO];
    }
    return _markImageView;
}


-(UILabel *)titleLabel
{
    if (!_titleLabel)
    {
        _titleLabel = [[UILabel alloc]init];
        [_titleLabel setText:@"姚立志"];
        [_titleLabel setTextColor:RGB(51.0, 51.0, 51.0)];
    }
    return _titleLabel;
}


-(UILabel *)describeLabel
{
    if (!_describeLabel)
    {
        _describeLabel = [[UILabel alloc]init];
        [_describeLabel setTextColor:RGB(104, 112, 111)];
    }
    return _describeLabel;
}

-(UILabel *)subjecLabel
{
    if (!_subjecLabel)
    {
        _subjecLabel = [[UILabel alloc]init];
        [_subjecLabel setFont:FontLevel3];
        [_subjecLabel setTextColor:[UIColor whiteColor]];
        [_subjecLabel setTextAlignment:NSTextAlignmentCenter];
        [_subjecLabel setBackgroundColor:MainColor];
        [_subjecLabel setLayerCornerRadius:5.0];
    }
    return _subjecLabel;
}



-(void)setItemColor:(BOOL)color
{
    if (color)
    {
        [self.headerImageView setBackgroundColor:[UIColor redColor]];
        [self.titleLabel setBackgroundColor:[UIColor orangeColor]];
        [self.describeLabel setBackgroundColor:[UIColor purpleColor]];
        [self.subjecLabel setBackgroundColor:[UIColor darkGrayColor]];
        [self.markImageView setBackgroundColor:[UIColor yellowColor]];
    }
}








@end
