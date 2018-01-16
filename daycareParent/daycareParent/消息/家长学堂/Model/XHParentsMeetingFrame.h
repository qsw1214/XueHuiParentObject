//
//  XHParentsMeetingFrame.h
//  daycareParent
//
//  Created by Git on 2017/12/4.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "BaseFrame.h"
#import "XHParentsMeetingModel.h"

@interface XHParentsMeetingFrame : BaseFrame

@property (nonatomic,strong) XHParentsMeetingModel *model; //!< 数据模型
@property (nonatomic,assign) CGRect contentFrame; //!< 内容的Frame



@end
