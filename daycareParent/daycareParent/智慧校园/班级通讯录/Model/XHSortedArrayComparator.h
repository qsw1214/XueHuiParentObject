//
//  XHSortedArrayComparator.h
//  daycareParent
//
//  Created by Git on 2017/12/27.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XHSyllabusFrame.h"
#import "XHAddressBookKey.h"
#import "XHTeacherAddressBookKey.h"


@interface XHSortedArrayComparator : NSObject


/**
 根据通讯录返回的数组内容重新排序，返回重新排序好的数组
 
 @param array 传入的数据源数组
 @return NSArray 返回排好序的数组
 */
+(NSArray*)sortedArrayUsingComparatorWithKeyArray:(NSMutableArray*)array;




/**
 根据通讯录返回的数组内容重新排序，返回重新排序好的数组
 
 @param array 传入的数据源数组
 @return NSArray 返回排好序的数组
 */
+(NSArray*)sortedArrayUsingComparatorWithTeacherAddressBookKeyArray:(NSMutableArray*)array;


/**
 根据课程表返回的数组内容重新排序，返回重新排序好的数组
 
 @param array 传入的数据源数组
 @return NSArray 返回排好序的数组
 */
+(NSArray*)sortedArrayUsingComparatorWithSyllabusKeyArray:(NSMutableArray*)array;

@end
