//
//  XHDynamicsFrame.h
//  daycareParent
//
//  Created by Git on 2017/12/14.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "BaseFrame.h"
#import "XHDynamicsModel.h"


@interface XHDynamicsFrame : BaseFrame

@property (nonatomic,assign) CGSize contenSize; //!< 内容size
@property (nonatomic,assign) CGSize itemSize; //!< 每个item的大小
@property (nonatomic,assign) CGSize previewSize; //!< 图片的宽高
@property (nonatomic,strong) XHDynamicsModel *model; //!< 数据模型



@end
