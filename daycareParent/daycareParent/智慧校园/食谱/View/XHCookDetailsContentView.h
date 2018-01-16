//
//  XHCookDetailsContentView.h
//  daycareParent
//
//  Created by Git on 2017/12/5.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#pragma mark 智慧校园->食谱->食谱右侧食谱详情承载视图


#import "BaseControl.h"
#import "XHCookBookCell.h"


@interface XHCookDetailsContentView : BaseControl

- (instancetype)initWithDeletage:(id)deletage;

-(void)setItemObject:(XHCookBookFrame*)object;

@end
