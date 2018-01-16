//
//  NSDictionary+Category.h
//  daycareParent
//
//  Created by 钧泰科技 on 2017/12/12.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Category)



/**
 解析字段

 @param aKey key值
 @return 返回解析之后的非空值
 */
-(id)objectItemKey:(id)aKey;


/**
 解析int数值

 @param aKey key 值
 @return 返回解析之后非空值
 */
-(NSInteger)objectItemIntrerKey:(id)aKey;


@end
