//
//  XHTeacherAddressBookKey.m
//  daycareParent
//
//  Created by Git on 2017/12/13.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHTeacherAddressBookKey.h"

@implementation XHTeacherAddressBookKey

-(NSMutableArray<XHTeacherAddressBookFrame *> *)itemArray
{
    if (!_itemArray)
    {
        _itemArray = [NSMutableArray array];
    }
    return _itemArray;
}

@end
