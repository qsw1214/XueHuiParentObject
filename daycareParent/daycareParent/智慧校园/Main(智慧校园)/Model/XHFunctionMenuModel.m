//
//  XHFunctionMenuModel.m
//  daycareParent
//
//  Created by Git on 2017/11/28.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHFunctionMenuModel.h"

@implementation XHFunctionMenuModel




-(NSMutableArray *)animatingArray
{
    if (!_animatingArray)
    {
        _animatingArray = [[NSMutableArray alloc]init];
//        for (int i=1; i<=21; i++)
//        {
//            NSString *name = [NSString stringWithFormat:@"%@%d",self.describe,i];
//            UIImage *image = [UIImage imageNamed:name];
//            if (image)
//            {
//                [_animatingArray addObject:image];
//            }
//        }
    }
    return _animatingArray;
}

@end
