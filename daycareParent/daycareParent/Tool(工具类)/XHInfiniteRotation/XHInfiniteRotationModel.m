//
//  XHInfiniteRotationModel.m
//  daycareParent
//
//  Created by mac on 2018/3/20.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHInfiniteRotationModel.h"

@implementation XHInfiniteRotationModel

-(void)setImageUrl:(NSString *)imageUrl
{
    _imageUrl = ALGetFileImageOriginal(imageUrl);
    [self setItemSize:CGSizeMake(SCREEN_WIDTH, 270.0)];
}



@end
