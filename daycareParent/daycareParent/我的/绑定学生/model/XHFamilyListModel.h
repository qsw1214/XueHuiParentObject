//
//  XHFamilyListModel.h
//  daycareParent
//
//  Created by 钧泰科技 on 2017/12/16.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XHFamilyListModel : NSObject
@property(nonatomic,copy)NSString *headPic,*nickName,*isMajor;
-(id)initWithDic:(NSDictionary *)dic;
@end
