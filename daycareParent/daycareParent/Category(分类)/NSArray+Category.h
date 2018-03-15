//
//  NSArray+Category.h
//  daycareParent
//
//  Created by Git on 2018/2/2.
//  Copyright © 2018年 XueHui. All rights reserved.
//

typedef void (^enumerateBlock) (id obj, NSUInteger idx, BOOL *stop);

#import <Foundation/Foundation.h>

@interface NSArray (Category)

+(void)enumerateObjectsWithArray:(id)array usingBlock:(enumerateBlock)block;

+(void)enumerateObjectsWithArray:(id)array withOptions:(NSEnumerationOptions)options usingBlock:(enumerateBlock)block;

@end
