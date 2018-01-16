//
//  XHParentsMeetingFrame.m
//  daycareParent
//
//  Created by Git on 2017/12/4.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHParentsMeetingFrame.h"

@implementation XHParentsMeetingFrame

-(void)setModel:(XHParentsMeetingModel *)model
{
    _model = model;
    
    
    
    
    CGSize contentSize = [NSObject contentSizeWithTitle:model.content withFontOfSize:FontLevel3 withWidth:(SCREEN_WIDTH-40.0)];
    [self setContentFrame:CGRectMake(0, 0, contentSize.width, (contentSize.height>55.0 ? 55.0 : contentSize.height))];
    
    
    [self setItemFrame:CGRectMake(10.0, 0, (SCREEN_WIDTH-20.0), (50.0/*日期高度*/+40/*标题高度*/+120.0/*图片高度*/+5/*图片和内容之间的间隔*/+self.contentFrame.size.height/*内容的高度*/+5/*内容和查看全文间隙*/+40.0))];
    
    //行高
    [self setCellHeight:self.itemFrame.size.height];
    
}

@end
