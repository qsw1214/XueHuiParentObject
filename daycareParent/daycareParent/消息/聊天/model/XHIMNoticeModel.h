//
//  XHIMNoticeModel.h
//  daycareParent
//
//  Created by 钧泰科技 on 2017/12/19.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XHIMNoticeModel : NSObject
-(id)initWithDic:(NSDictionary *)dic;
@property(nonatomic,copy)NSString *content,*createTime,*sum;
@end
