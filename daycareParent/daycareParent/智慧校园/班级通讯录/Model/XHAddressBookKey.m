//
//  XHAddressBookKey.m
//  daycareParent
//
//  Created by Git on 2017/12/8.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHAddressBookKey.h"

@implementation XHAddressBookKey


-(NSMutableArray<XHAddressBookFrame *> *)itemArray
{
    if (!_itemArray)
    {
        _itemArray = [NSMutableArray array];
    }
    return _itemArray;
}




@end
