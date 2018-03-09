//
//  XHAddressBookFrame.m
//  daycareParent
//
//  Created by Git on 2017/12/8.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHAddressBookFrame.h"

@implementation XHAddressBookFrame



-(void)setModel:(XHAddressBookModel *)model
{
    _model = model;
    [self setItemFrame:CGRectMake(0, 0, SCREEN_WIDTH, 78.0)];
    [self setCellHeight:self.itemFrame.size.height];
}

@end
