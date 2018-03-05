//
//  XHAddressModel.h
//  daycareParent
//
//  Created by 钧泰科技 on 2017/12/6.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "BaseModel.h"

@interface XHAddressModel : BaseModel
@property(nonatomic,strong)NSString *addressId,*areaName,*cityId,*cityName,*consignee,*isDefault,*telephone,*provinceId,*addressDetail,*provinceName,*userId,*propValue_createTime,*propValue_updateTime,*propValue_tag,*areaId;
-(id)initWithDic:(NSDictionary *)dic;
@end
