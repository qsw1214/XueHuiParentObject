//
//  XHCGRect.m
//  daycareParent
//
//  Created by Git on 2017/12/1.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHCGRect.h"



@implementation XHCGRect



-(void)setRect:(CGRect)rect
{
    _rect = rect;
    
    
    [self setLeft:self.rect.origin.x];
    [self setRight:(self.rect.origin.x+self.rect.size.width)];
    [self setTop:self.rect.origin.y];
    [self setBottom:(self.rect.origin.x+self.rect.size.height)];
    [self setWidth:self.rect.size.width];
    [self setHeight:self.rect.size.height];
}




-(CGFloat)left
{
    return self.rect.origin.x;
}

-(CGFloat)right
{
    return (self.rect.origin.x+self.rect.size.width);
}

-(CGFloat)top
{
    return self.rect.origin.y;
}

-(CGFloat)bottom
{
    return (self.rect.origin.x+self.rect.size.height);
}


-(CGFloat)width
{
    return self.rect.size.width;
}

-(CGFloat)height
{
    return self.rect.size.height;
}




@end
