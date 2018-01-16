//
//  XHLeaveRecordFrame.h
//  daycareParent
//
//  Created by Git on 2017/12/4.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseFrame.h"
#import "XHLeaveRecordModel.h"


@interface XHLeaveRecordFrame : BaseFrame

@property (nonatomic,assign) CGSize contentSize;
@property (nonatomic,strong) XHLeaveRecordModel *model;


@end
