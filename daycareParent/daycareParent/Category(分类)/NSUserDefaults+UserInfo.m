//
//  NSUserDefaults+UserInfo.m
//  ZhongBangShop
//
//  Created by Git on 2017/10/31.
//  Copyright © 2017年 Object. All rights reserved.
//

#import "NSUserDefaults+UserInfo.h"

@implementation NSUserDefaults (UserInfo)

#pragma mark 获取对应key值的内容
+(NSString*)objectItemForKey:(id)object
{
    return [NSString safeString:[[NSUserDefaults standardUserDefaults] objectForKey:object]];
}


+(void)setItemObject:(id)object forKey:(NSString*)forkey
{
    [[NSUserDefaults standardUserDefaults] setObject:object forKey:forkey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}
+(void)saveLocalObject:(id)object forKey:(NSString*)forkey
{
    [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:object] forKey:AutoLogin];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}
+ (XHLoginModel *)getLoginModel
{
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:AutoLogin];
    if (data == nil)
    {
        return nil;
    }
    XHLoginModel *model = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    return model;
}
+(void)removeObjectItemForKey:(NSString*)key
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
