//
//  XHLoginModel.m
//  daycareParent
//
//  Created by 钧泰科技 on 2017/12/12.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHLoginModel.h"

@implementation XHLoginModel
//编码器，aCoder在编码的时候，会将对象 对属性进行编码
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    //如何对属性进行编码？
    [aCoder encodeObject:self.loginName forKey:@"loginName"];
    [aCoder encodeObject:self.pwd forKey:@"pwd"];
    [aCoder encodeInteger:self.type forKey:@"type"];
}
//解码器，aDecoder在解码的时候，会将对象 对属性进行解码
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self)
    {
        //Decode解码
        //如何对属性进行解码
        self.loginName = [aDecoder decodeObjectForKey:@"loginName"];
        self.pwd = [aDecoder decodeObjectForKey:@"pwd"];
        self.type=[aDecoder decodeIntegerForKey:@"type"];
      
    }
    return self;
}
@end
