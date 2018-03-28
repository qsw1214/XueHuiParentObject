//
//  XHFunctionMenuFrame.m
//  daycareParent
//
//  Created by Git on 2017/11/29.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHFunctionMenuFrame.h"

@implementation XHFunctionMenuFrame

-(void)setModel:(XHFunctionMenuModel *)model
{
    _model = model;
    
    [self setItemSize:CGSizeMake(((SCREEN_WIDTH-40.0)/3.0), 180.0)];
    
   
    
    
}

@end
