//
//  XHRegisterFrame.h
//  daycareParent
//
//  Created by Git on 2017/11/29.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XHRegisterModel.h"
#import "BaseFrame.h"

@interface XHRegisterFrame : BaseFrame


@property (nonatomic,strong) XHRegisterModel *model; //!< 数据模型
@property (nonatomic,assign) CGFloat cellHeight; //!< 行高


@end
