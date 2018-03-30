//
//  UIImageView+Category.m
//  daycareParent
//
//  Created by mac on 2018/3/29.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "UIImageView+Category.h"

@implementation UIImageView (Category)


-(void)setAnimationImageArray:(NSArray<UIImage *> *)animationImageArray
{
//    [self setImage:[animationImageArray objectAtIndex:0]];
    [self setAnimationImages:animationImageArray];
    
}


-(void)startAnimating:(BOOL)animating
{
    if (animating)
    {
        [self startAnimating];
    }
}

@end
