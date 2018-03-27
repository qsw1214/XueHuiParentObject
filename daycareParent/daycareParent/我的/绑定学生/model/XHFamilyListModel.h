//
//  XHFamilyListModel.h
//  daycareParent
//
//  Created by 钧泰科技 on 2017/12/16.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"

@interface XHFamilyListModel : BaseModel


@property (nonatomic,copy) NSString *guardianType; //!< 监护人类型
@property (nonatomic,copy) NSString *guardianName; //!< 监护人名称
@property (nonatomic,copy) NSString *guardianId; //!< 监护人id
@property (nonatomic,copy) NSString *telphoneNumber;
@property (nonatomic,copy) NSString *headPic;
@property (nonatomic,copy) NSString *headUrl;
@property (nonatomic,copy) NSString *isMajor;



@end
