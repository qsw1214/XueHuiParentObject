//
//  XHRegisterItemControl.m
//  daycareParent
//
//  Created by Git on 2017/11/30.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHRegisterItemControl.h"

@implementation XHRegisterItemControl

-(void)setTimeSoltImageWithType:(NSInteger)timeSolt withTitle:(NSString*)title withNumber:(NSInteger)number
{
    [self setText:title withNumberType:number withAllType:NO];
    
    switch (timeSolt)
    {
        case 0:
        {
            [self setIconImageViewBackGroundColor:[UIColor redColor] withNumberType:number withAllType:NO];
        }
            break;
        case 1:
        {
            [self setIconImageViewBackGroundColor:[UIColor greenColor] withNumberType:number withAllType:NO];
        }
            break;
    }
}



@end
