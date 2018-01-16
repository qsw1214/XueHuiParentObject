//
//  XHNoticeFrame.h
//  daycareParent
//
//  Created by Git on 2017/11/30.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseFrame.h"
#import "XHNoticeModel.h"
#import "XHCGRect.h"


@interface XHNoticeFrame : BaseFrame

@property (nonatomic,strong) XHNoticeModel *model; //!< 数据模型
@property (nonatomic,assign) CGSize contentSize; //!< 内容的宽高
@property (nonatomic,assign) CGSize previewSize; //!< 图片的宽高




@end
