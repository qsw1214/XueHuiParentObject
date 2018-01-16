//
//  XHRegisterModel.m
//  daycareParent
//
//  Created by Git on 2017/11/29.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHRegisterModel.h"

@implementation XHRegisterModel

-(void)setOneTimeSolt:(NSString *)oneTimeSolt
{
    _oneTimeSolt = oneTimeSolt;
    if ([oneTimeSolt isEqualToString:@""])
    {
        [self setOneTimeSolt:@"未签到"];
        [self setOneTimeSoltTyp:0];
    }
    else
    {
        [self setOneTimeSoltTyp:1];
    }
}


-(void)setTwoTimeSolt:(NSString *)twoTimeSolt
{
    _twoTimeSolt = twoTimeSolt;
    if ([twoTimeSolt isEqualToString:@""])
    {
        [self setTwoTimeSolt:@"未签到"];
        [self setTwoTimeSoltType:0];
    }
    else
    {
        [self setTwoTimeSoltType:1];
    }
}

-(void)setThreeTimeSolt:(NSString *)threeTimeSolt
{
    _threeTimeSolt = threeTimeSolt;
    if ([threeTimeSolt isEqualToString:@""])
    {
        [self setThreeTimeSolt:@"未签到"];
        [self setThreeTimeSoltType:0];
    }
    else
    {
        [self setThreeTimeSoltType:1];
    }
}

-(void)setFourTimeSolt:(NSString *)fourTimeSolt
{
    _fourTimeSolt = fourTimeSolt;
    if ([fourTimeSolt isEqualToString:@""])
    {
        [self setFourTimeSolt:@"未签到"];
        [self setFourTimeSoltType:0];
    }
    else
    {
        [self setFourTimeSoltType:1];
    }
}


@end
