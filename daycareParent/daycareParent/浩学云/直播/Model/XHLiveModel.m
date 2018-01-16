//
//  XHLiveModel.m
//  daycareParent
//
//  Created by Git on 2018/1/10.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHLiveModel.h"

@implementation XHLiveModel


-(void)setLiveMark:(NSString *)liveMark
{
    [self setLiveType:(XHLiveStatusType)[liveMark integerValue]];
}

@end
