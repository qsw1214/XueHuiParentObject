//
//  XHLeaveRecordFrame.m
//  daycareParent
//
//  Created by Git on 2017/12/4.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHLeaveRecordFrame.h"

@implementation XHLeaveRecordFrame


-(void)setModel:(XHLeaveRecordModel *)model
{
    _model = model;
    CGSize contentSize = [NSObject contentSizeWithTitle:model.title withFontOfSize:FontLevel3 withWidth:(SCREEN_WIDTH-20.0)];
    [self setContentSize:contentSize];
    [self setItemFrame:CGRectMake(0, 0, SCREEN_WIDTH, (contentSize.height > 30.0 ? contentSize.height : 30.0) + 20.0)];
    [self setCellHeight:self.itemFrame.size.height];
}

@end
