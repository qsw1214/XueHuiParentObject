//
//  XHCookBookModel.m
//  daycareParent
//
//  Created by Git on 2017/12/5.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHCookBookModel.h"

@implementation XHCookBookModel






-(void)setDate:(NSString *)date
{
    NSArray *dateArray = [date componentsSeparatedByString:@"-"];
    if (dateArray)
    {
        [self setWeekAndDate:[NSString stringWithFormat:@"%@（%@）",[XHHelper weekdayWithDate:date],date]];
        [self setTitle:[NSString stringWithFormat:@"%@",[XHHelper weekdayWithDate:date]]];
        
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
    [self setObjectID:[object objectItemKey:@"id"]];
    [self setContent:[object objectItemKey:@"content"]];
    
    NSString *picUrl = [NSString safeString:[object objectItemKey:@"picUrl"]];
    NSArray *imageUrlArray = [picUrl componentsSeparatedByString:@","];
    @WeakObj(self);
    [NSArray enumerateObjectsWithArray:imageUrlArray usingBlock:^(NSString *obj, NSUInteger idx, BOOL *stop)
    {
        @StrongObj(self);
        XHInfiniteRotationModel *rotaionModel = [[XHInfiniteRotationModel alloc]init];
        [rotaionModel setImageUrl:obj];
        XHPageModel *pageModel = [[XHPageModel alloc]init];
        [pageModel setSize:YES];
        [pageModel setType:XHPageModelNormalType];
        [self.pageArray addObject:pageModel];
        [self.infiniteRotationArray addObject:rotaionModel];
    }];
    
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


-(NSMutableArray *)contentArray
{
    if (_contentArray == nil)
    {
        _contentArray = [NSMutableArray array];
    }
    return _contentArray;
}

-(NSMutableArray *)infiniteRotationArray
{
    if (_infiniteRotationArray == nil)
    {
        _infiniteRotationArray = [NSMutableArray array];
    }
    return _infiniteRotationArray;
}

-(NSMutableArray *)pageArray
{
    if (_pageArray == nil)
    {
        _pageArray = [NSMutableArray array];
    }
    return _pageArray;
}






@end
