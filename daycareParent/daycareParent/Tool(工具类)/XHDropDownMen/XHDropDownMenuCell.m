//
//  XHDropDownMenuCell.m
//  daycareParent
//
//  Created by Git on 2018/2/27.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHDropDownMenuCell.h"


@interface XHDropDownMenuCell ()


@property (nonatomic,strong) UILabel *titleLabel;



@end

@implementation XHDropDownMenuCell



- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self.contentView addSubview:self.titleLabel];
        [self.titleLabel setFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    }
    return self;
}




-(void)setItemObject:(XHDropDownMenuModel*)object
{
    [self.titleLabel setText:object.title];
}


#pragma mark - Getter / Setter
-(UILabel *)titleLabel
{
    if (!_titleLabel)
    {
        _titleLabel = [[UILabel alloc]init];
        [_titleLabel setFont:[UIFont systemFontOfSize:14.0]];
        [_titleLabel setTextAlignment:NSTextAlignmentCenter];
    }
    return _titleLabel;
}

@end
