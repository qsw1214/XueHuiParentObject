//
//  XHAddressModel.m
//  daycareParent
//
//  Created by 钧泰科技 on 2017/12/6.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHAddressModel.h"

@implementation XHAddressModel

-(id)initWithDic:(NSDictionary *)dic
{
    if (self=[super init]) {
        _provinceName=[dic objectItemKey:@"provinceName"];
        _provinceId=[dic objectItemKey:@"provinceId"];
        _cityName=[dic objectItemKey:@"cityName"];
        _cityId=[dic objectItemKey:@"cityId"];
        _areaName=[dic objectItemKey:@"areaName"];
        _areaId=[dic objectItemKey:@"areaId"];
        _addressDetail=[dic objectItemKey:@"addressDetail"];
        _addressId=[dic objectItemKey:@"addressId"];
        _consignee=[dic objectItemKey:@"consignee"];
        _isDefault=[dic objectItemKey:@"isDefault"];
        _telephone=[dic objectItemKey:@"telephone"];
        _userId=[dic objectItemKey:@"userId"];
        _propValue_createTime=[[dic objectItemKey:@"propValue"] objectItemKey:@"createTime"];
        _propValue_tag=[[dic objectItemKey:@"propValue"] objectItemKey:@"tag"];
        _propValue_updateTime=[[dic objectItemKey:@"propValue"] objectItemKey:@"updateTime"];
        
    }
    return self;
}
@end
