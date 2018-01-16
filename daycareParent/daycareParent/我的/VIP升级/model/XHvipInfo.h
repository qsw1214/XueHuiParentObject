//
//  XHvipInfo.h
//  daycareParent
//
//  Created by 钧泰科技 on 2017/12/18.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XHvipInfo : NSObject
@property(copy,nonatomic)NSString *isBuy,*unit,*unitName,*level,*price,*name,*ID,*isActive;
-(id)initWithDic:(NSDictionary *)dic;
@end
