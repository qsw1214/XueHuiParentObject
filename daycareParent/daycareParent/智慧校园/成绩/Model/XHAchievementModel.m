//
//  XHAchievementModel.m
//  daycareParent
//
//  Created by Git on 2017/12/6.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHAchievementModel.h"

@implementation XHAchievementModel

-(void)setItemObject:(NSDictionary *)object
{
    
    if (self.contentType==XHAchievementTitleType) {
        [self setScore:[object objectItemKey:@"numbers"]];
    }
    else
    {
        CGFloat tempScore = [[object objectItemKey:@"numbers"] floatValue];
        [self setScore:[NSString stringWithFormat:@"%.1f",tempScore]];
    }
    [self setSubject:[object objectItemKey:@"subjectName"]];
    [self setBatch:[object objectItemKey:@"batchName"]];
    
}

@end
