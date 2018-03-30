//
//  UIImageView+Category.h
//  daycareParent
//
//  Created by mac on 2018/3/29.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (Category)

-(void)setAnimationImageArray:(NSArray<UIImage *> *)animationImageArray;

-(void)startAnimating:(BOOL)animating;

@end
