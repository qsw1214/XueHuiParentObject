//
//  XHFamilyModel.h
//  daycareParent
//
//  Created by 钧泰科技 on 2017/12/15.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XHFamilyModel : NSObject

@property(copy,nonatomic)NSString*familyId,*guardianId,*guardianName,*headPic,*ID,*sex,*sexName,*type,*typeName,*isMajor;
-(id)initWithDic:(NSDictionary *)Dic;
@end
