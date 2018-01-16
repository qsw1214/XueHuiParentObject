//
//  XHPreviewModel.h
//  daycareParent
//
//  Created by Git on 2017/12/14.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "BaseModel.h"

@interface XHPreviewModel : BaseModel

@property (nonatomic,copy) NSString *previewUrl; //!< 预览图片的url地址
@property (nonatomic,copy) NSString *previewPic; //!< 预览图片的原地址
@property (nonatomic,strong) NSString *noticeActorId; //!< 通知id
@property (nonatomic,strong) UIImage *previewImage; //!< 预览图片
@property (nonatomic,assign) CGSize itemSize; //!< 动态预览的itemSize
@property (nonatomic,assign) NSInteger indexTage; //!< 当前位置的index的tage值






@end
