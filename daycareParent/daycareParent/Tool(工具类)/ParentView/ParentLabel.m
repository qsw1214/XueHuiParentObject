//
//  ParentLabel.m
//  daycareParent
//
//  Created by 钧泰科技 on 2018/3/13.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "ParentLabel.h"

@implementation ParentLabel
-(instancetype)init
{
    if (self=[super init])
    {
        [self setFont:[UIFont systemFontOfSize:14.0]];
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame])
    {
        [self setFont:[UIFont systemFontOfSize:14.0]];
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
