//
//  XHLocationModel.h
//  daycareParent
//
//  Created by 钧泰科技 on 2017/12/22.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XHLocationModel : NSObject
@property (nonatomic, copy) NSString *DeviceId,*DeviceName;
@property (nonatomic, assign) double  Latitude, Longitude, OLat, OLng;
-(id)initWithDic:(NSDictionary *)dic;
@end
