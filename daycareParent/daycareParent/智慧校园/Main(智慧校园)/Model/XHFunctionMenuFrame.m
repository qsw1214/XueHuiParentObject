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
    
    switch (model.modelType)
    {
        case AdvertisementType:
        {
             [self setItemSize:CGSizeMake(SCREEN_WIDTH, 150.0)];
        }
            break;
        case FunctionMenuType:
        {
             [self setItemSize:CGSizeMake((SCREEN_WIDTH/3.0), (SCREEN_WIDTH/3.0))];
        }
            break;
    }
    
   
    
    
}

@end
