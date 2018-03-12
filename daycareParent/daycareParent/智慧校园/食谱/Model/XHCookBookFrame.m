//4
//  XHCookBookFrame.m
//  daycareParent
//
//  Created by Git on 2017/12/5.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHCookBookFrame.h"

@implementation XHCookBookFrame


-(void)setModel:(XHCookBookModel *)model
{
    _model = model;
    switch (model.modeType)
    {
        case CookBookWeekType:
        {
            [self setItemFrame:CGRectMake(0, 0, 90.0, 70.0)];
            [self setItemSize:CGSizeMake(50.0, 50.0)];
        }
            break;
        case CookBookDetailsType:
        {
            [self setItemFrame:CGRectMake(0, 0, 90.0, 350.0)];
            [self setItemSize:CGSizeMake(SCREEN_WIDTH, 350.0)];
        }
            break;
    }
    
    [self setCellHeight:self.itemFrame.size.height];

}

@end
