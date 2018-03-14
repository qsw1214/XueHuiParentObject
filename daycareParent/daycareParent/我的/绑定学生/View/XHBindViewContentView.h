//
//  XHBindViewContentView.h
//  daycareParent
//
//  Created by mac on 2018/3/14.
//  Copyright © 2018年 XueHui. All rights reserved.
//


#pragma mark 绑定孩子内容视图



@protocol XHBindViewContentViewDelegate <NSObject>

-(void)submitControlAction:(BaseButtonControl*)sender;


@end


#import "BaseScrollView.h"

@interface XHBindViewContentView : BaseScrollView


@property (nonatomic,weak) id <XHBindViewContentViewDelegate> actionDeletgate;



@end
