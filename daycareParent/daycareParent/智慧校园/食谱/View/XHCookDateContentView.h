//
//  XHCookDateContentView.h
//  daycareParent
//
//  Created by Git on 2017/12/5.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#pragma mark 智慧校园->食谱->食谱左侧日期承载视图


#import "BaseControl.h"
#import "XHCookBookCell.h"


@protocol XHCookDateContentViewDeletage <NSObject>

-(void)didSelectItemObject:(XHCookBookFrame*)frame;

@end


@interface XHCookDateContentView : BaseControl


- (instancetype)initWithDeletage:(id)deletage;


@end
