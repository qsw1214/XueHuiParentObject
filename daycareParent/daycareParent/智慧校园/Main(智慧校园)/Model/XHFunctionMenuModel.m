//
//  XHFunctionMenuModel.m
//  daycareParent
//
//  Created by Git on 2017/11/28.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHFunctionMenuModel.h"

@implementation XHFunctionMenuModel


-(void)setIconName:(NSString *)iconName
{
    _iconName = iconName;
    
    
    
    
}



-(NSMutableArray *)animatingArray
{
    if (!_animatingArray)
    {
        _animatingArray = [[NSMutableArray alloc]init];
    }
    return _animatingArray;
}

@end
