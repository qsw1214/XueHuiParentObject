//
//  XHSmartCampusContentView.h
//  daycareParent
//
//  Created by Git on 2017/11/28.
//  Copyright © 2017年 XueHui. All rights reserved.
//


#pragma mark 智慧校园主页->内容承载视图


#import <UIKit/UIKit.h>
#import "BaseScrollView.h"
#import "XHAdvertisementControl.h"
#import "XHFunctionMenuControl.h"


@interface XHSmartCampusContentView : BaseScrollView


-(instancetype)initWithDeletage:(id)deletage;

-(void)resetFrame:(CGRect)frame;

@end
