//
//  NSUserDefaults+UserInfo.h
//  ZhongBangShop
//
//  Created by Git on 2017/10/31.
//  Copyright © 2017年 Object. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XHLoginModel.h"
@interface NSUserDefaults (UserInfo)

#pragma mark 获取对应key值的内容
+(NSString*)objectItemForKey:(id)object;


#pragma mark 设置内容
+(void)setItemObject:(id)object forKey:(NSString*)forkey;

#pragma 移除内容
+(void)removeObjectItemForKey:(NSString*)key;


/**
 对象序列化保存本地方法
 
 @param object 被序列化对象
 @param forkey 被序列化保存键值
 */
+(void)saveLocalObject:(id)object forKey:(NSString*)forkey;
 /**
  读取对象序列化方法
  @return 读取本地序列化对象
  */
+ (XHLoginModel *)getLoginModel;
@end
