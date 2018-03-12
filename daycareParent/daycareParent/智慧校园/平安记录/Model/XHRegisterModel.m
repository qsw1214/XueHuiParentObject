//
//  XHRegisterModel.m
//  daycareParent
//
//  Created by Git on 2017/11/29.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHRegisterModel.h"

@implementation XHRegisterModel


-(void)setTime:(NSString *)time
{
    _time = time;
    
    NSArray *timeItemArray = [time componentsSeparatedByString:@":"];
    if (timeItemArray)
    {
        NSString *hour = [timeItemArray objectAtIndex:0];
        NSString *minute = [timeItemArray objectAtIndex:1];
        NSString *second = [timeItemArray objectAtIndex:2];;
        NSInteger interHour = [hour integerValue];
        NSInteger interMinute = [minute integerValue];
        NSInteger interSecond = [second integerValue];
        if (interHour >= 0 && interHour <= 12)
        {
            switch (interHour)
            {
#pragma mark - case 0 等于0的时候，如果分大于0就说明已经进入的早上，如果等于0还是处于夜里24点正，秒忽略不计
                case 0:
                {
                    if (interMinute)
                    {
                        [self setMarkIcon:@"ico_morning"];
                    }
                    else
                    {
                        if (interSecond)
                        {
                            [self setMarkIcon:@"ico_morning"];
                        }
                        else
                        {
                            [self setMarkIcon:@"ico_night"];
                        }
                        
                    }
                }
                    break;
#pragma mark - case 12 等于12的时候，如果分大于0就说明已经进入的下午，如果等于0还是早上，秒忽略不计
                case 12:
                {
                    if (interMinute)
                    {
                        [self setMarkIcon:@"ico_afternoon"];
                    }
                    else
                    {
                        if (interSecond)
                        {
                            [self setMarkIcon:@"ico_afternoon"];
                        }
                        else
                        {
                            [self setMarkIcon:@"ico_morning"];
                        }
                    }
                    
                }
                    break;
                default:
                {
                    [self setMarkIcon:@"ico_morning"];
                }
                    break;
            }
        }
        else if (interHour > 12 && interHour <= 18)
        {
            switch (interHour)
            {
                case 18:
                {
                    if (interMinute)
                    {
                        [self setMarkIcon:@"ico_night"];
                    }
                    else
                    {
                        if (interSecond)
                        {
                            [self setMarkIcon:@"ico_night"];
                        }
                        else
                        {
                            [self setMarkIcon:@"ico_afternoon"];
                        }
                    }
                }
                    break;
                default:
                {
                    [self setMarkIcon:@"ico_afternoon"];
                }
                    break;
            }
        }
        else if (interHour > 18 && interHour <= 23 )
        {
            [self setMarkIcon:@"ico_night"];
        }
    }
    else
    {
        [self setMarkIcon:@"ico_afternoon"];
    }
    
    
}




@end
