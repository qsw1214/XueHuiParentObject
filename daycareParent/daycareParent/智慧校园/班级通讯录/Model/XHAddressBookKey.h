//
//  XHAddressBookKey.h
//  daycareParent
//
//  Created by Git on 2017/12/8.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "BaseModel.h"
#import "XHAddressBookFrame.h"

@interface XHAddressBookKey : BaseModel


@property (nonatomic,copy) NSString *key; //!< 索引的key值
@property (nonatomic,copy) NSMutableArray <XHAddressBookFrame*> *itemArray; //!< 内容数组


@end
