//
//  XHSystemModel.m
//  daycareParent
//
//  Created by 钧泰科技 on 2018/3/14.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHSystemModel.h"
@implementation XHSystemModel
-(instancetype)initWithDic:(NSDictionary *)dic
{
    if (self =[super initWithDic:dic]) {
        
        _content=[dic objectItemKey:@"content"];
        _date=[dic objectItemKey:@"createTime"];
        _title=[dic objectItemKey:@"title"];
        self.itemCellHeight=40+[self contentSizeWithTitle:_content withFontOfSize:kFont(16) withWidth:SCREEN_WIDTH-20].height;
        switch ([[dic objectItemKey:@"type"] integerValue]) {
            case 1:
            {
                _modelType=XHSystemNoticeType;
            }
                break;
                
            case 2:
            {
                _modelType=XHSystemOtherType;
            }
                break;
        }
    }
    return self;
    
}
@end
