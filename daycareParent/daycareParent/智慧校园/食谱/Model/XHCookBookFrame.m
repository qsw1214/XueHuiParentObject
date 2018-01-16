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
        case CookBookDateType:
        {
            [self setItemFrame:CGRectMake(0, 0, 90.0, 70.0)];
        }
            break;
        case CookBookDetailsType:
        {
            CGSize contentSize = [NSObject contentSizeWithTitle:model.content withFontOfSize:FontLevel4 withWidth:(SCREEN_WIDTH-210.0)];
            [self setContentFrame:CGRectMake(0, 0, contentSize.width, (contentSize.height > 50 ? contentSize.height : 50.0))];
            [self setItemFrame:CGRectMake(0, 0,(SCREEN_WIDTH-90.0) , 40.0+self.contentFrame.size.height)];
        }
            break;
    }
    
    
    [self setCellHeight:self.itemFrame.size.height];

}

@end
