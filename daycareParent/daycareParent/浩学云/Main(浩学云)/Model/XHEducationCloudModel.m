//
//  XHEducationCloudModel.m
//  daycareParent
//
//  Created by Git on 2017/12/11.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHEducationCloudModel.h"

@implementation XHEducationCloudModel



-(NSMutableArray *)dateArray
{
    if (!_dateArray)
    {
        _dateArray = [NSMutableArray array];
    }
    return _dateArray;
}


-(void)setVisitors:(NSString *)visitors
{
    _visitors = [NSString stringWithFormat:@"%@人浏览",visitors];
}



-(void)setItemObject:(NSDictionary *)object
{
    [self setPreviewImage:[object objectItemKey:@"imageUrl"]];
    [self setRedirectUrl:[object objectItemKey:@"redirectUrl"]];
    [self setTitle:[object objectItemKey:@"name"]];
    [self setVisitors:[object objectItemKey:@"countNum"]];
    [self setObjectID:[object objectItemKey:@"id"]];
    [self setDate:[object objectItemKey:@"releaseTime"]];
    NSString *type = [object objectForKey:@"type"];
    if ([type isEqualToString:@"video"])
    {
        [self setModelType:XHEducationCloudCellVideoTpe];
    }
    else if ([type isEqualToString:@"exercise"])
    {
        [self setModelType:XHEducationCloudCellExaminationQuestionsTpe];
    }
}






@end
