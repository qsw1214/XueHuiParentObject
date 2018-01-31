//
//  XHLiveFrame.m
//  daycareParent
//
//  Created by Git on 2018/1/10.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHLiveFrame.h"

@implementation XHLiveFrame


-(void)setModel:(XHLiveModel *)model
{
    _model = model;
    
    switch (model.contentType)
    {
        case XHLiveAdvertType:
        {
            [self setItemFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH/2.0)];
            [self setCellHeight:self.itemFrame.size.height];
        }
            break;
        case XHLiveItemType:
        {
            [self setItemFrame:CGRectMake(10, 10, SCREEN_WIDTH-20.0, 100.0)];
            [self setCellHeight:(self.itemFrame.size.height+10)];
        }
            break;
    }
    
    
    
}



@end
