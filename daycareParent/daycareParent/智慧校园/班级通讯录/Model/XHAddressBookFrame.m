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
    switch (_model.modelType)
    {
        case XHAddressBookSelectType:
        {
            [self setItemFrame:CGRectMake(10.0, 0, SCREEN_WIDTH-20.0, 55.0/*单元格自己的高度*/+45.0/*工具条的高度*/)];
            
            
            
        }
            break;
        case XHAddressBookModelNormalType:
        {
            
            [self setItemFrame:CGRectMake(10.0, 0, SCREEN_WIDTH-20.0, 60.0)];
            
        }
            break;
    }
    
    [self setCellHeight:self.itemFrame.size.height];
}

@end
