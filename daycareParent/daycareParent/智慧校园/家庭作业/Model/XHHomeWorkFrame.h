//
//  XHHomeWorkFrame.h
//  daycareParent
//
//  Created by Git on 2017/11/30.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseFrame.h"
#import "XHHomeWorkModel.h"
#import "XHCGRect.h"


@interface XHHomeWorkFrame : BaseFrame

@property (nonatomic,strong) XHHomeWorkModel *model; //!< 数据模型
@property (nonatomic,assign) CGSize subjectSize; //!< 学科的宽高
@property (nonatomic,assign) CGSize contentSize; //!< 内容的宽高
@property (nonatomic,assign) CGSize previewSize; //!< 图片的宽高




@end
