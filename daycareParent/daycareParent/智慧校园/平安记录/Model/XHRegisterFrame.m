//
//  XHRegisterFrame.m
//  daycareParent
//
//  Created by Git on 2017/11/29.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHRegisterFrame.h"

@implementation XHRegisterFrame


-(void)setModel:(XHRegisterModel *)model
{
    _model = model;
    [self setItemFrame:CGRectMake(0, 0, SCREEN_WIDTH, 120.0)];
    [self setCellHeight:self.itemFrame.size.height];
}



@end
