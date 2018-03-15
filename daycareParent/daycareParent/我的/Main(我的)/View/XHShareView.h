//
//  XHShareView.h
//  daycareParent
//
//  Created by 钧泰科技 on 2018/3/15.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "ParentView.h"

@protocol  XHShareViewDelagete<NSObject>

-(void)getItemIndex:(NSInteger)index;

@end

@interface XHShareView : ParentView
-(instancetype)initWithDelegate:(id)delegate;
-(void)show;
@end
