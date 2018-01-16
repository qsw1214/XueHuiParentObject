//
//  XHAchievementFrame.m
//  daycareParent
//
//  Created by Git on 2017/12/6.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHAchievementFrame.h"

@implementation XHAchievementFrame

-(void)setModel:(XHAchievementModel *)model
{
    _model = model;
    [self setItemFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60.0)];
    [self setCellHeight:self.itemFrame.size.height];
}


@end
