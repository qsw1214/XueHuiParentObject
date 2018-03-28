//
//  XHHomeWorkModel.m
//  daycareParent
//
//  Created by Git on 2017/11/30.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHHomeWorkModel.h"

@implementation XHHomeWorkModel




#pragma mark 设置家庭作业对象
//!< 设置家庭作业对象
-(void)setItemObject:(NSDictionary *)object
{
    [self setHeaderUrl:ALGetFileHeadThumbnail([object objectItemKey:@"studentHeadPic"])];
    [self setSubject:[object objectItemKey:@"subjectName"]];
    [self setPushInfoId:[object objectItemKey:@"pushInfoId"]];
    
    NSMutableArray <XHPreviewModel*> *imageModelArray = [NSMutableArray array];
    for ( int i = 1; i<= 6; i++)
    {
        XHPreviewModel *imageModel = [[XHPreviewModel alloc]init];
        NSString *picStr=[NSString stringWithFormat:@"picUrl%d",i];
        [imageModel setPreviewUrl:ALGetFileHeadThumbnail([object objectItemKey:picStr])];
        [imageModel setPreviewPic:[object objectItemKey:picStr]];
        [imageModel setTage:i];
        [imageModelArray addObject:imageModel];
    }
    
    [imageModelArray enumerateObjectsUsingBlock:^(XHPreviewModel *obj, NSUInteger idx, BOOL *stop)
     {
         if (![obj.previewPic isEqualToString:@""])
         {
             [self.imageUrlArray addObject:obj];
         }
     }];
    
    [self setWorkContent:[object objectItemKey:@"content"]];
    [self setUserName:[object objectItemKey:@"studentName"]];
    [self setReleaseDate:[NSString dateStr:[object objectItemKey:@"createTime"]]];
    [self setWorkContent:[object objectItemKey:@"content"]];
    [self setUnreadType:[object objectItemKey:@"isRead"]];
    [self setGradeName:[object objectItemKey:@"gradeName"]];
    [self setClazzName:[object objectItemKey:@"clazzName"]];
    [self setHomeWorkType:HomeWorkType];
    [self setItemArray:self.imageUrlArray];
}


#pragma mark 设置通知对象
//!< 设置通知对象
-(void)setNoticeItemObject:(NSDictionary*)object
{
    [self setHeaderUrl:ALGetFileHeadThumbnail([object objectItemKey:@"headPic"])];
    [self setHeaderPic:[object objectItemKey:@"headPic"]];
    [self setSubject:[object objectItemKey:@"subjectName"]];
    [self setPushInfoId:[object objectItemKey:@"noticeActorId"]];
    
    NSMutableArray <XHPreviewModel*> *imageModelArray = [NSMutableArray array];
    for ( int i = 1; i <= 6; i++)
    {
        XHPreviewModel *imageModel = [[XHPreviewModel alloc]init];
        NSString *picStr = [NSString stringWithFormat:@"picUrl%d",i];
        [imageModel setPreviewUrl:ALGetFileHeadThumbnail([object objectItemKey:picStr])];
        [imageModel setPreviewPic:[object objectItemKey:picStr]];
        [imageModel setTage:i];
        [imageModelArray addObject:imageModel];
    }
    
    [imageModelArray enumerateObjectsUsingBlock:^(XHPreviewModel *obj, NSUInteger idx, BOOL *stop)
     {
         if (![obj.previewPic isEqualToString:@""])
         {
             [self.imageUrlArray addObject:obj];
         }
     }];
    
    [self setWorkContent:[object objectItemKey:@"content"]];
    [self setUserName:[object objectItemKey:@"teacherName"]];
    [self setReleaseDate:[NSString dateStr:[object objectItemKey:@"createTime"]]];
    [self setUnreadType:[object objectItemKey:@"isStatus"]];
    [self setGradeName:[object objectItemKey:@"gradeName"]];
    [self setClazzName:[object objectItemKey:@"clazzName"]];
    [self setHomeWorkType:NotifyType];
    [self setItemArray:self.imageUrlArray];
}







-(void)setUnreadType:(NSString *)unreadType
{
    switch ([unreadType integerValue])
    {
        case 0:
        {
            [self setHomeWorkUnreadType:HomeWorkUnreadType];
        }
            break;
        case 1:
        {
            [self setHomeWorkUnreadType:HomeWorkAlreadyReadType];
        }
            break;
    }
}




-(void)setWorkContent:(NSString *)workContent
{
    _workContent = workContent;
    if (![_workContent isEqualToString:@""])
    {
        [self setContentType:XHHomeWorkTextType];
    }
}

-(void)setItemArray:(NSArray*)array
{
    [self.imageUrlArray setArray:array];
    
    if ([self.imageUrlArray count])
    {
        [self setContentType:XHHomeWorkTextAndImageType];
    }
}



-(NSMutableArray <XHPreviewModel *> *)imageUrlArray
{
    if (_imageUrlArray == nil)
    {
        _imageUrlArray = [NSMutableArray array];
    }
    return _imageUrlArray;
}




@end
