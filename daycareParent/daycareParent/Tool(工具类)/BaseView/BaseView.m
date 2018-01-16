//
//  BaseView.m
//  daycareParent
//
//  Created by Git on 2017/12/1.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "BaseView.h"

@implementation BaseView

- (instancetype)init
{
    self = [super init];
    if (self)
    {
    }
    return self;
}


-(void)resetFrame:(CGRect)frame
{
    [super setFrame:frame];
    [self setHidden:NO];
}


-(void)setItemColor:(BOOL)color
{
    
}

-(void)setItemFrame:(id)frame
{
    
}

@end
