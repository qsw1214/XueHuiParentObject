//
//  ParentImageView.m
//  daycareParent
//
//  Created by 钧泰科技 on 2018/3/13.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "ParentImageView.h"

@implementation ParentImageView
-(id)init
{
    if (self=[super init])
    {
        [self setContentMode:UIViewContentModeScaleAspectFit];
        self.backgroundColor=[UIColor whiteColor];
    }
    return self;
}
-(id)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame])
    {
        [self setContentMode:UIViewContentModeScaleAspectFit];
         self.backgroundColor=[UIColor whiteColor];
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
