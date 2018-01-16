//
//  XHAddressBookLecturesCell.m
//  daycareParent
//
//  Created by Git on 2017/12/8.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHAddressBookLecturesCell.h"


@interface XHAddressBookLecturesCell ()

@property (nonatomic,strong) UILabel *titleLabel; //!< 标题标签


@end


@implementation XHAddressBookLecturesCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self.contentView addSubview:self.titleLabel];
        [self.titleLabel setFrame:CGRectMake(10, 0, (frame.size.width-20.0), frame.size.height)];
    }
    return self;
}

-(void)setTitle:(NSString*)title
{
    [self.titleLabel setText:title];
}


#pragma mark - Getter / Setter
-(UILabel *)titleLabel
{
    if (_titleLabel == nil)
    {
        _titleLabel = [[UILabel alloc]init];
        [_titleLabel setFont:FontLevel3];
        [_titleLabel setTextAlignment:NSTextAlignmentCenter];
        [_titleLabel setTextColor:[UIColor blackColor]];
    }
    return _titleLabel;
}

@end
