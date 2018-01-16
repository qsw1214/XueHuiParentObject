//
//  XHAskforLeaveChargeTeacherControl.m
//  daycareParent
//
//  Created by Git on 2017/12/6.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHAskforLeaveChargeTeacherControl.h"


@interface XHAskforLeaveChargeTeacherControl ()

@property (nonatomic,strong) UILabel *titleLabel; //!< 标题标签

@property (nonatomic,strong) UIImageView *imageView; //!< 头像

@end



@implementation XHAskforLeaveChargeTeacherControl



- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self setItemColor:NO];
        [self addSubview:self.titleLabel];
        [self addSubview:self.imageView];
        [self addSubview:self.describeLabel];
    }
    return self;
}


-(void)reset
{
    [self setTeacherAddressBook:nil];
    [self.describeLabel setText:@""];
    [self.imageView setImage:[UIImage imageNamed:@"addman"]];
}



-(void)resetFrame:(CGRect)frame
{
    [self setFrame:frame];
    [self.titleLabel setFrame:CGRectMake(0, 0, frame.size.width, 25.0)];
    [self.imageView setFrame:CGRectMake((frame.size.width-(frame.size.width-self.titleLabel.height))/2.0, self.titleLabel.bottom, (frame.size.width-25.0), (frame.size.height-50.0))];
    [self.imageView setLayerCornerRadius:(self.imageView.height/2.0)];
    [self.describeLabel setFrame:CGRectMake(0, self.imageView.bottom, frame.size.width, 25.0)];
    
}



-(void)setImaeg:(UIImage *)image
{
    [self.imageView setImage:image];
}

-(void)setTitle:(NSString*)title
{
    [self.titleLabel setText:title];
}


-(void)setTeacherAddressBook:(XHTeacherAddressBookFrame *)teacherAddressBook
{
    _teacherAddressBook = teacherAddressBook;
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:teacherAddressBook.model.headerUrl] placeholderImage:[UIImage imageNamed:@"addman"]];
    [self.describeLabel setText:teacherAddressBook.model.teacherName];
}




#pragma mark - Getter / Setter
-(UILabel *)titleLabel
{
    if (_titleLabel == nil)
    {
        _titleLabel = [[UILabel alloc]init];
        [_titleLabel setTextAlignment:NSTextAlignmentCenter];
        [_titleLabel setTextColor:RGB(14, 14, 14)];
        [_titleLabel setFont:FontLevel3];
    }
    return _titleLabel;
}

-(UIImageView *)imageView
{
    if (_imageView == nil)
    {
        _imageView = [[UIImageView alloc]init];
    }
    return _imageView;
}


-(UILabel *)describeLabel
{
    if (!_describeLabel)
    {
        _describeLabel = [[UILabel alloc]init];
        [_describeLabel setTextAlignment:NSTextAlignmentCenter];
        [_describeLabel setTextColor:RGB(14, 14, 14)];
        [_describeLabel setFont:FontLevel3];
    }
    return _describeLabel;
}



-(void)setItemColor:(BOOL)color
{
    if (color)
    {
        [self.titleLabel setBackgroundColor:[UIColor greenColor]];
        [self.imageView setBackgroundColor:[UIColor blueColor]];
        [self.describeLabel setBackgroundColor:[UIColor orangeColor]];
    }
}


@end
