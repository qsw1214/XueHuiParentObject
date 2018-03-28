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
    CGSize contentSize = [NSObject contentSizeWithTitle:name withFontOfSize:FontLevel2 withWidth:200.0];
    [self setItemSize:CGSizeMake(contentSize.width+25.0, 30.0)];
}

@end
