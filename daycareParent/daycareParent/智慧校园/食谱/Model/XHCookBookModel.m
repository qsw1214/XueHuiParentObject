//
//  XHCookBookModel.m
//  daycareParent
//
//  Created by Git on 2017/12/5.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHCookBookModel.h"

@implementation XHCookBookModel



-(NSMutableArray *)contentArray
{
    if (_contentArray == nil)
    {
        _contentArray = [NSMutableArray array];
    }
    return _contentArray;
}


-(void)setDate:(NSString *)date
{
    NSArray *dateArray = [date componentsSeparatedByString:@"-"];
    if (dateArray)
    {
        [self setWeekAndDate:[NSString stringWithFormat:@"%@（%@）",[XHHelper weekdayWithDate:date],date]];
        
        if ([dateArray count]>=3)
        {
            _date = [NSString stringWithFormat:@"%@-%@",[dateArray objectAtIndex:1],[dateArray objectAtIndex:2]];
        }
        else
        {
            _date = date;
        }
    }
    else
    {
        _date = date;
    }
}

-(void)setItemObject:(NSDictionary *)object
{
    [self setTitle:[object objectItemKey:@"title"]];
    [self setPreviewUrl:[object objectItemKey:@"picUrl"]];
    [self setContent:[object objectItemKey:@"content"]];
    [self setObjectID:[object objectItemKey:@"id"]];
    [self setContent:[object objectItemKey:@"demo"]];
}




-(void)setPreviewUrl:(NSString *)previewUrl
{
    _previewUrl = ALGetFileImageThumbnail(previewUrl);
    
    
    [self.previewModel setPreviewUrl:_previewUrl];
    [self.previewModel setPreviewPic:previewUrl];
}


-(XHPreviewModel *)previewModel
{
    if (!_previewModel)
    {
        _previewModel = [[XHPreviewModel alloc]init];
    }
    return _previewModel;
}





@end
