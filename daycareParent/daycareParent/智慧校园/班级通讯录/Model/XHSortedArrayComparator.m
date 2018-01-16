//
//  XHSortedArrayComparator.m
//  daycareParent
//
//  Created by Git on 2017/12/27.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHSortedArrayComparator.h"

@implementation XHSortedArrayComparator

/**
 根据通讯录返回的数组内容重新排序，返回重新排序好的数组
 
 @param array 传入的数据源数组
 @return NSArray 返回排好序的数组
 */
+(NSArray*)sortedArrayUsingComparatorWithKeyArray:(NSMutableArray*)array
{
    //!< 过滤重复的key值
    NSMutableDictionary *keyDictionary = [NSMutableDictionary dictionary];
    [array enumerateObjectsUsingBlock:^(XHAddressBookFrame *obj, NSUInteger idx, BOOL *stop)
     {
         [keyDictionary setObject:obj.model.key forKey:obj.model.key];
     }];
    
    //!< 把相同的key值数据保存在一个“itemkey”的分组中
    NSMutableArray *itemArray = [NSMutableArray array];
    [keyDictionary enumerateKeysAndObjectsUsingBlock:^(id key, NSString *keyobj, BOOL *stop)
     {
         XHAddressBookKey *itemkey = [[XHAddressBookKey alloc]init];
         [itemkey setKey:keyobj];
         [array enumerateObjectsUsingBlock:^(XHAddressBookFrame *obj, NSUInteger idx, BOOL *stop)
          {
              if ([keyobj isEqualToString:obj.model.key])
              {
                  [itemkey.itemArray addObject:obj];
              }
          }];
         [itemArray addObject:itemkey];
     }];
    
    
    //!< 重新排序
    NSArray *comparatorArray = [itemArray sortedArrayUsingComparator:^NSComparisonResult(XHAddressBookKey *obj1, XHAddressBookKey *obj2)
    {
        return [obj1.key compare:obj2.key]; //升序
    }];
    
    return comparatorArray;
}


/**
 根据通讯录返回的数组内容重新排序，返回重新排序好的数组
 
 @param array 传入的数据源数组
 @return NSArray 返回排好序的数组
 */
+(NSArray*)sortedArrayUsingComparatorWithTeacherAddressBookKeyArray:(NSMutableArray*)array
{
    //!< 过滤重复的key值
    NSMutableDictionary *keyDictionary = [NSMutableDictionary dictionary];
    [array enumerateObjectsUsingBlock:^(XHTeacherAddressBookFrame *obj, NSUInteger idx, BOOL *stop)
     {
         [keyDictionary setObject:obj.model.key forKey:obj.model.key];
     }];
    
    //!< 把相同的key值数据保存在一个“itemkey”的分组中
    NSMutableArray *itemArray = [NSMutableArray array];
    [keyDictionary enumerateKeysAndObjectsUsingBlock:^(id key, NSString *keyobj, BOOL *stop)
     {
         XHTeacherAddressBookKey *itemkey = [[XHTeacherAddressBookKey alloc]init];
         [itemkey setKey:keyobj];
         [array enumerateObjectsUsingBlock:^(XHTeacherAddressBookFrame *obj, NSUInteger idx, BOOL *stop)
          {
              if ([keyobj isEqualToString:obj.model.key])
              {
                  [itemkey.itemArray addObject:obj];
              }
          }];
         [itemArray addObject:itemkey];
     }];
    
    //!< 重新排序
    NSArray *comparatorArray = [itemArray sortedArrayUsingComparator:^NSComparisonResult(XHTeacherAddressBookKey *obj1, XHTeacherAddressBookKey *obj2)
    {
        return [obj1.key compare:obj2.key]; //升序
    }];
    
    return comparatorArray;
}


/**
 根据课程表返回的数组内容重新排序，返回重新排序好的数组
 
 @param array 传入的数据源数组
 @return NSArray 返回排好序的数组
 */
+(NSArray*)sortedArrayUsingComparatorWithSyllabusKeyArray:(NSMutableArray*)array
{
    //!< 重新排序
    NSArray *comparatorArray = [array sortedArrayUsingComparator:^NSComparisonResult(XHSyllabusFrame *obj1, XHSyllabusFrame *obj2)
    {
        return [obj1.model.time compare:obj2.model.time]; //倒序
    }];
    return comparatorArray;
}
@end
