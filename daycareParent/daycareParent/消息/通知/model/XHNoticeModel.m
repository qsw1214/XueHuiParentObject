//
//  XHNoticeModel.m
//  daycareParent
//
//  Created by Git on 2017/11/30.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHNoticeModel.h"

@implementation XHNoticeModel



#pragma mark 设置通知对象
//!< 设置通知对象
-(void)setItemObject:(NSDictionary *)object
{
    [self setHeaderUrl:ALGetFileHeadThumbnail([object objectItemKey:@"headPic"])];
    [self setNoticeActorId:[object objectItemKey:@"noticeActorId"]];
    
    NSMutableArray <XHPreviewModel*> *imageModelArray = [NSMutableArray array];
    for ( int i = 1; i<= 6; i++)
    {
        XHPreviewModel *imageModel = [[XHPreviewModel alloc]init];
        NSString *picStr=[NSString stringWithFormat:@"picUrl%zd",i];
        [imageModel setPreviewUrl:ALGetFileImageThumbnail([object objectItemKey:picStr])];
        [imageModel setPreviewPic:[object objectItemKey:picStr]];
        [imageModel setTage:i];
        [imageModelArray addObject:imageModel];
    }
    
    [imageModelArray enumerateObjectsUsingBlock:^(XHPreviewModel * _Nonnull obj, NSUInteger idx, BOOL *stop)
     {
         if (![obj.previewPic isEqualToString:@""])
         {
             [self.imageUrlArray addObject:obj];
         }
     }];
    
    
    [self setSchoolName:[object objectItemKey:@"schoolName"]];
    [self setClassName:[object objectItemKey:@"className"]];
    [self setNoticeActorId:[object objectItemKey:@"noticeActorId"]];
    [self setUserName:[object objectItemKey:@"teacherName"]];
    [self setReleaseDate:[NSString dateStr:[object objectItemKey:@"createTime"]]];
    [self setContent:[object objectItemKey:@"content"]];
    [self setUnreadType:[object objectItemKey:@"isStatus"]];
    [self setVedioUrl:[object objectItemKey:@"vedioUrl"]];
    [self setVedioFirstPicUrl:ALGetFileImageThumbnail([object objectItemKey:@"vedioFirstPicUrl"])]; 
    [self setItemArray:self.imageUrlArray];
    [self setNoticeType:NoticeType];
}







-(void)setUnreadType:(NSString *)unreadType
{
    switch ([unreadType integerValue])
    {
        case 0:
        {
            [self setNoticekUnreadType:NoticeUnreadType];
        }
            break;
        case 1:
        {
            [self setNoticekUnreadType:NoticeAlreadyReadType];
        }
            break;
    }
}





-(void)setContent:(NSString *)content
{
    _content = content;
    if (![_content isEqualToString:@""])
    {
        [self setContentType:XHNoticeTextType];
    }
}





/**
 设置视频的url的地址，但是必须后于"内容"设置
 
 @param vedioUrl 视频的url地址
 */
-(void)setVedioUrl:(NSString *)vedioUrl
{
    _vedioUrl = vedioUrl;
    if (![_vedioUrl isEqualToString:@""])
    {
        _vedioAllUrl = ALGetFileVedio(vedioUrl);
        [self setContentType:XHNoticeTextAndVideoType];
        [self.playModel setVideoURL:[NSURL URLWithString:_vedioAllUrl]];
    }
}

-(void)setItemArray:(NSArray*)array
{
    [self.imageUrlArray setArray:array];
    
    if (![self.vedioUrl isEqualToString:@""])
    {
        [self setContentType:XHNoticeTextAndVideoType];
    }
    else
    {
        if ([self.imageUrlArray count])
        {
            [self setContentType:XHNoticeTextAndImageType];
        }
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



-(ZFPlayerModel *)playModel
{
    if (_playModel == nil)
    {
        _playModel = [[ZFPlayerModel alloc]init];
    }
    return _playModel;
    
}

@end
