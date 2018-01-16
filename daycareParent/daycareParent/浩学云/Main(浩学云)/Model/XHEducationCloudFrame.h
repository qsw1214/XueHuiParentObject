//
//  XHEducationCloudFrame.h
//  daycareParent
//
//  Created by Git on 2017/12/11.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "BaseFrame.h"
#import "XHEducationCloudModel.h"

@interface XHEducationCloudFrame : BaseFrame


@property (nonatomic,assign) CGSize itemSize; //!< 菜单item的大小
@property (nonatomic,strong) XHEducationCloudModel *model; //!< 学会云模型

@end
