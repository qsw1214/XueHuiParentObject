//
//  XHTeacherAddressBookKey.h
//  daycareParent
//
//  Created by Git on 2017/12/13.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "BaseModel.h"
#import "XHTeacherAddressBookFrame.h"


@interface XHTeacherAddressBookKey : BaseModel
@property (nonatomic,copy) NSString *key; //!< 索引的key值
@property (nonatomic,copy) NSMutableArray <XHTeacherAddressBookFrame*> *itemArray; //!< 内容数组

@end
