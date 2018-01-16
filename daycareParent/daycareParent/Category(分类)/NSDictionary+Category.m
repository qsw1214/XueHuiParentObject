//
//  NSDictionary+Category.m
//  daycareParent
//
//  Created by 钧泰科技 on 2017/12/12.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "NSDictionary+Category.h"

@implementation NSDictionary (Category)

-(id)objectItemKey:(id)aKey
{
    if ([self isKindOfClass:[NSDictionary class]])
    {
         return [NSString safeString:[self objectForKey:aKey]];
    }
    else if ([self isKindOfClass:[NSString class]])
    {
        return @"";
    }
    else
    {
         return @"";
    }
}

-(NSInteger)objectItemIntrerKey:(id)aKey
{
    if (([self isKindOfClass:[NSDictionary class]]))
    {
        return [[self objectForKey:aKey] integerValue];
    }
    else
    {
        return 0;
    }
    
}


@end
