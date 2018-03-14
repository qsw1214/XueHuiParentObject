//
//  XHRCModel.m
//  daycareParent
//
//  Created by 钧泰科技 on 2018/3/12.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHRCModel.h"

@implementation XHRCModel
-(id)initWithDic:(NSDictionary *)dic
{
    if (self=[super init]) {
        
    }
    return self;
}
-(void)setModelType:(XHRCModelType)modelType
{
    _modelType=modelType;
    switch (modelType) {
        case XHRCnoticeType:
        {
            _CellHeight=85;
        }
            break;
            
        default:
        {
            _CellHeight=70;
        }
            break;
    }
}
@end
