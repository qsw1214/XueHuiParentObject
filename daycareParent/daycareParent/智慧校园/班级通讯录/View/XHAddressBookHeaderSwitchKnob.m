//
//  XHAddressBookHeaderSwitchKnob.m
//  daycareParent
//
//  Created by mac on 2018/3/9.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHAddressBookHeaderSwitchKnob.h"


@interface XHAddressBookHeaderSwitchKnob ()

@property (nonatomic,strong) UIImageView *markImageView; //!< 旋转按钮



@end



@implementation XHAddressBookHeaderSwitchKnob




- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self addSubview:self.markImageView];
    }
    return self;
}



-(void)resetFrame:(CGRect)frame
{
    [self setFrame:frame];
    [self.markImageView setFrame:CGRectMake(frame.size.width-40.0, (frame.size.height-30.0)/2.0, 30.0, 30.0)];
}




#pragma mark - Getter /  Setter
-(UIImageView *)markImageView
{
    if (!_markImageView)
    {
        _markImageView = [[UIImageView alloc]init];
        [_markImageView setImage:[UIImage imageNamed:@"addressSwitch"]];
    }
    return _markImageView;
}




@end
