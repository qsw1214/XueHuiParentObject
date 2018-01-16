//
//  XHParentsMeetingModel.h
//  daycareParent
//
//  Created by Git on 2017/12/4.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "BaseModel.h"

@interface XHParentsMeetingModel : BaseModel

@property (nonatomic,copy) NSString *date; //!< 日期
@property (nonatomic,copy) NSString *title; //!< 标题
@property (nonatomic,copy) NSString *previewUrl; //!< 预览Url
@property (nonatomic,copy) NSString *content; //!< 日期



@end
