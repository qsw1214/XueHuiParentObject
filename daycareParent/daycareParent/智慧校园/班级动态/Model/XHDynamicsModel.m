//
//  XHDynamicsModel.m
//  daycareParent
//
//  Created by Git on 2017/12/14.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHDynamicsModel.h"

@implementation XHDynamicsModel



-(void)setItemObject:(NSDictionary *)object
{
    NSString *content = [object objectItemKey:@"content"];
    NSString *headPic = [object objectItemKey:@"headPic"];
    NSString *teacherName = [object objectItemKey:@"teacherName"];
    NSString *createTime = [object objectItemKey:@"createTime"];
    NSString *vedioFirstPicUrl = [object objectItemKey:@"vedioFirstPicUrl"]; //!< 视频预览图片地址
    NSString *vedioUrl = [object objectItemKey:@"vedioUrl"]; //!< 视频播放Url地址
    NSString *schoolName = [object objectItemKey:@"schoolName"]; //!< 学会教育
    NSString *noticeActorId = [object objectItemKey:@"noticeActorId"];
    
    [self setDate:createTime];
    [self setContent:content];
    [self setTeacherName:teacherName];
    [self setWorkUnit:schoolName];
    [self setHeaderUrl:ALGetFileHeadThumbnail(headPic)];
    [self setVideoPreviewUrl:ALGetFileImageOriginal(vedioFirstPicUrl)];
    [self setVideoUrl:vedioUrl];
    [self setUnreadType:[object objectItemKey:@"isStatus"]];
    [self setNoticeActorId:noticeActorId];
    [self setPlayType:XHDynamicsPauseType];
    
    
    NSMutableArray <XHPreviewModel*> *imageModelArray = [NSMutableArray array];
    for ( int i = 1; i<= 6; i++)
    {
        XHPreviewModel *imageModel = [[XHPreviewModel alloc]init];
        NSString *picStr=[NSString stringWithFormat:@"picUrl%zd",i];
        [imageModel setPreviewUrl:ALGetFileImageThumbnail([object objectItemKey:picStr])];
        [imageModel setPreviewPic:[object objectItemKey:picStr]];
        [imageModel setNoticeActorId:noticeActorId];
        [imageModel setTage:i];
        [imageModel setIndexTage:self.tage];
        [imageModelArray addObject:imageModel];
    }
    
    [imageModelArray enumerateObjectsUsingBlock:^(XHPreviewModel * _Nonnull obj, NSUInteger idx, BOOL *stop)
     {
         if (![obj.previewPic isEqualToString:@""])
         {
             [self.imageUrlArray addObject:obj];
         }
     }];
   
    //!< 设置数据数组
    [self setItemArray:self.imageUrlArray];
}


-(void)setContent:(NSString *)content
{
    _content = content;
    if (![_content isEqualToString:@""])
    {
        [self setModelType:XHDynamicsModelTextType];
    }
}

-(void)setUnreadType:(NSString *)unreadType
{
    if ([unreadType integerValue] == 0)
    {
        [self setDynamicskUnreadType:XHDynamicsUnreadType];
        [self.readHeaderControl dotHidden:NO];
    }
    else
    {
        [self setDynamicskUnreadType:XHDynamicsAlreadyReadType];
        [self.readHeaderControl dotHidden:YES];
    }
}



/**
 设置视频的url的地址，但是必须后于"内容"设置

 @param videoUrl 视频的url地址
 */
-(void)setVideoUrl:(NSString *)videoUrl
{
    _videoUrl = videoUrl;
    if (![_videoUrl isEqualToString:@""])
    {
        _videoUrl = ALGetFileVedio(videoUrl);
        [self setModelType:XHDynamicsModelTextAndVideoType];
        [self.playModel setVideoURL:[NSURL URLWithString:_videoUrl]];
    }
}





-(void)setItemArray:(NSArray*)array
{
    
    if ([array count])
    {
        [self setModelType:XHDynamicsModelTextAndImageType];
    }
}

-(NSMutableArray *)imageUrlArray
{
    if (!_imageUrlArray)
    {
        _imageUrlArray = [NSMutableArray array];
    }
    return _imageUrlArray;
}


-(void)setDate:(NSString *)date
{
    _date = date;
    NSArray *dataArray = [date componentsSeparatedByString:@" "];
    if (dataArray)
    {
         [self.dateArray setArray:dataArray];
    }
    else
    {
         [self.dateArray addObject:date];
    }
   
}


-(NSMutableArray *)dateArray
{
    if (!_dateArray)
    {
        _dateArray = [NSMutableArray array];
    }
    return _dateArray;
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
