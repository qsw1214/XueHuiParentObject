//
//  XHLocationModel.m
//  daycareParent
//
//  Created by 钧泰科技 on 2017/12/22.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHLocationModel.h"
@implementation XHLocationModel
-(id)initWithDic:(NSDictionary *)dic
{
    if (self=[super init]) {
        _DeviceId=[dic objectItemKey:@"DeviceId"];
        _DeviceName=[dic objectItemKey:@"DeviceName"];
        _Latitude=[[dic objectItemKey:@"Latitude"] doubleValue];
        _Longitude=[[dic objectItemKey:@"Longitude"] doubleValue];
        _OLat=[[dic objectItemKey:@"OLat"] doubleValue];
        _OLng=[[dic objectItemKey:@"OLng"] doubleValue];
    }
    return self;
}
@end
