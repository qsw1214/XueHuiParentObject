//
//  XHPreviewModel.m
//  daycareParent
//
//  Created by Git on 2017/12/14.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHPreviewModel.h"

@implementation XHPreviewModel


-(void)setPreviewUrl:(NSString *)previewUrl
{
    _previewUrl = [NSString safeString:previewUrl];
    [self setItemSize:CGSizeMake(((SCREEN_WIDTH-90.0)/3.0-5.0), 50.0)];
}



@end
