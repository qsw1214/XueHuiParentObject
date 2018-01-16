//
//  XHEducationCloudModel.h
//  daycareParent
//
//  Created by Git on 2017/12/11.
//  Copyright © 2017年 XueHui. All rights reserved.
//



typedef NS_ENUM(NSInteger,XHEducationCloudModelType)
{
    XHEducationCloudDefaultType = 0, //!< 头部滚动轮播类型
    XHEducationCloudCellVideoTpe = 1,     //!< 视频类型
    XHEducationCloudCellExaminationQuestionsTpe = 2,     //!< 考试题类型
    XHEducationCloudCellSix = 3,     //!<  六宫格类型
};







#import "BaseModel.h"

@interface XHEducationCloudModel : BaseModel

@property (nonatomic,copy) NSString *previewImage; //!< 预览图片
@property (nonatomic,copy) NSString *redirectUrl;  //!< 视频或者文档地址
@property (nonatomic,copy) NSString *title; //!< 标题
@property (nonatomic,copy) NSString *describe; //!< 描述内容
@property (nonatomic,copy) NSString *date; //!< 时间
@property (nonatomic,copy) NSString *visitors; //!< 浏览数

@property (nonatomic,strong) NSMutableArray  *dateArray; //!< 视频数组

@property (nonatomic,assign) XHEducationCloudModelType modelType;




@end
