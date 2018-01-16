//
//  XHFunctionMenuFrame.h
//  daycareParent
//
//  Created by Git on 2017/11/29.
//  Copyright © 2017年 XueHui. All rights reserved.
//


#pragma mark 智慧校园主页->内容承载视图->功能视图->Frame模型

#import <Foundation/Foundation.h>
#import "XHFunctionMenuModel.h"










@interface XHFunctionMenuFrame : NSObject

@property (nonatomic,strong) XHFunctionMenuModel *model;
@property (nonatomic,assign) CGSize itemSize;



@end
