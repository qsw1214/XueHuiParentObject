//
//  XHAskforLeaveSubmitControl.m
//  daycareParent
//
//  Created by Git on 2017/12/6.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHAskforLeaveSubmitControl.h"


@interface XHAskforLeaveSubmitControl ()

@property (nonatomic,strong) UILabel *titleLabel; //!< 标题


@end

@implementation XHAskforLeaveSubmitControl



- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self addSubview:self.titleLabel];
    }
    return self;
}


-(void)setTitle:(NSString*)title
{
    [self.titleLabel setText:title];
}


-(void)resetFrame:(CGRect)frame
{
    [self setFrame:frame];
    [self.titleLabel setFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    [self setLayerCornerRadius:3.0];
}


#pragma mark - Getter / Setter


-(UILabel *)titleLabel
{
    if (_titleLabel == nil)
    {
        _titleLabel = [[UILabel alloc]init];
        [_titleLabel setTextAlignment:NSTextAlignmentCenter];
        [_titleLabel setTextColor:[UIColor whiteColor]];
        [_titleLabel setFont:FontLevel2];
    }
    return _titleLabel;
}
@end
