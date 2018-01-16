//
//  XHTeacherAddressBookFrame.m
//  daycareParent
//
//  Created by Git on 2017/12/13.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHTeacherAddressBookFrame.h"

@implementation XHTeacherAddressBookFrame

-(void)setModel:(XHTeacherAddressBookModel *)model
{
    _model = model;
    
    
    [self setItemFrame:CGRectMake(0, 0, SCREEN_WIDTH, 80.0)];
    [self setCellHeight:self.itemFrame.size.height];
    
}

@end
