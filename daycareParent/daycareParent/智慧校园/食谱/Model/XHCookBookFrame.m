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
    CGSize contentItemSize = [NSObject contentSizeWithTitle:model.content withFontOfSize:FontLevel2 withWidth:(SCREEN_WIDTH-20.0)];
    [self setContentSize:contentItemSize];
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
            [self setItemSize:CGSizeMake(SCREEN_WIDTH, 300.0)];
            [self setItemFrame:CGRectMake(0, 0, SCREEN_WIDTH, 300.0+self.contentSize.height+(5.0/**与标题间距*/+10.0/*与下面间距*/))];
        }
            break;
    }
    
    [self setCellHeight:self.itemFrame.size.height];

}

@end
