//
//  XHCookBookModel.h
//  daycareParent
//
//  Created by Git on 2017/12/5.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "BaseModel.h"
#import "XHPreviewModel.h"
#import "XHPageModel.h"
#import "XHInfiniteRotationModel.h"




typedef NS_ENUM(NSInteger,XHCookBookModelType)
{
    CookBookWeekType = 1,  //!< 星期类型
    CookBookDetailsType = 2, //!< 内容类型
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
@property (nonatomic,strong) NSMutableArray <XHInfiniteRotationModel*> *infiniteRotationArray;
@property (nonatomic,strong) NSMutableArray <XHPageModel*> *pageArray; //!< 分页视图数组


@end
