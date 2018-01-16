//
//  XHCookBookModel.h
//  daycareParent
//
//  Created by Git on 2017/12/5.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "BaseModel.h"
#import "XHPreviewModel.h"




typedef NS_ENUM(NSInteger,XHCookBookModelType)
{
    CookBookDateType = 1,
    CookBookDetailsType = 2,
};

typedef NS_ENUM(NSInteger,XHCookBookSelectType)
{
    CookBookNormalType = 0,
    CookBookSelectType = 1,
};


@interface XHCookBookModel : BaseModel

@property (nonatomic,copy) NSString *title; //!< 标题/日期
@property (nonatomic,copy) NSString *content; //!< 食谱内容
@property (nonatomic,copy) NSString *previewUrl; //!< 预览图片Url
@property (nonatomic,copy) NSString *date; //!< 日期
@property (nonatomic,copy) NSString *weekAndDate; //!< 星期和日期
@property (nonatomic,assign) XHCookBookModelType modeType;
@property (nonatomic,assign) XHCookBookSelectType selectType;
@property (nonatomic,strong) XHPreviewModel *previewModel;
@property (nonatomic,strong) NSMutableArray *contentArray; //!< 内容数组


@end
