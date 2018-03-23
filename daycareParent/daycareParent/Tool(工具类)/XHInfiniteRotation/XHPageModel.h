//
//  XHPageModel.h
//  daycareParent
//
//  Created by mac on 2018/3/20.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "BaseModel.h"

typedef NS_ENUM(NSInteger,XHPageModelType)
{
    XHPageModelNormalType = 1,
    XHPageModelSelectType = 2,
};


@interface XHPageModel : BaseModel

@property (nonatomic,assign) CGSize itemSize;
@property (nonatomic,assign) XHPageModelType type; //!< 模型类型

-(void)setSize:(BOOL)setSize;


@end
