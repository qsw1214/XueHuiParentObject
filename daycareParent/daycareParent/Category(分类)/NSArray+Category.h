//
//  NSArray+Category.h
//  daycareParent
//
//  Created by Git on 2018/2/2.
//  Copyright © 2018年 XueHui. All rights reserved.
//

typedef void (^enumerateBlock) (id obj, NSUInteger idx, BOOL *stop);
typedef void (^forceEnumerateBlock) (id obj, NSUInteger idx, BOOL *stop,BOOL forceStop);  // YES 是正常遍历， NO是强制停止

#import <Foundation/Foundation.h>

@interface NSArray (Category)

+(void)enumerateObjectsWithArray:(id)array usingforceBlock:(forceEnumerateBlock)block;

+(void)enumerateObjectsWithArray:(id)array usingBlock:(enumerateBlock)block;

+(void)enumerateObjectsWithArray:(id)array withOptions:(NSEnumerationOptions)options usingBlock:(enumerateBlock)block;

@end
