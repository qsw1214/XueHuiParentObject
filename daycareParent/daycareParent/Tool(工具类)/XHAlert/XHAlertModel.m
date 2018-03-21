//
//  XHAlertModel.m
//  daycareParent
//
//  Created by mac on 2018/3/16.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHAlertModel.h"

@implementation XHAlertModel

-(void)setName:(NSString *)name
{
    _name = name;
    [self setItemSize:CGSizeMake(((SCREEN_WIDTH-140.0)/3.0), 25.0)];
}

@end
