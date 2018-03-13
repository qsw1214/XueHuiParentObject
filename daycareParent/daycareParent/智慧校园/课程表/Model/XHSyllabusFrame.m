//
//  XHSyllabusFrame.m
//  daycareParent
//
//  Created by Git on 2017/12/6.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHSyllabusFrame.h"

@implementation XHSyllabusFrame


-(void)setModel:(XHSyllabusModel *)model
{
    _model = model;
    switch (model.modelType)
    {
        case SyllabusWeekType:
        {
            [self setItemFrame:CGRectMake(0, 0, SCREEN_WIDTH, 49.0)];
            [self setCellHeight:self.itemFrame.size.height];
        }
            break;
        case SyllabusContentType:
        {
            [self setItemFrame:CGRectMake(0, 0, SCREEN_WIDTH, 57.0)];
            [self setCellHeight:self.itemFrame.size.height];
        }
            break;
    }
    
}

@end
