//
//  XHDynamicsFrame.m
//  daycareParent
//
//  Created by Git on 2017/12/14.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHDynamicsFrame.h"

@implementation XHDynamicsFrame


-(void)setModel:(XHDynamicsModel *)model
{
    _model = model;
    [self setItemSize:CGSizeMake(60.0, 60.0)];
    
    CGSize contentSize = [NSObject contentSizeWithTitle:model.content withFontOfSize:FontLevel3 withWidth:(SCREEN_WIDTH-90.0)];
    
    [self setContenSize:contentSize];
    
    switch (model.modelType)
    {
        case XHDynamicsModelTextType:
        {
            [self setItemFrame:CGRectMake(0, 0,SCREEN_WIDTH, 80+contentSize.height+15.0)];
        }
            break;
        case XHDynamicsModelTextAndImageType:
        {
            if ([model.imageUrlArray count])
            {
                [model.imageUrlArray enumerateObjectsUsingBlock:^(XHPreviewModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop)
                 {
                     [obj setItemSize:CGSizeMake((SCREEN_WIDTH-90.0-30)/3.0, 50.0)];
                 }];
                
                if ([model.imageUrlArray count] <= 3)
                {
                    [self setPreviewSize:CGSizeMake((SCREEN_WIDTH-90.0), 60.0)];
                }
                else
                {
                    [self setPreviewSize:CGSizeMake((SCREEN_WIDTH-90.0), 115.0)];
                }
            }
            else
            {
                [self setPreviewSize:CGSizeMake(0, 0)];
            }
            
            [self setItemFrame:CGRectMake(0, 0, SCREEN_WIDTH, (80.0+contentSize.height+self.previewSize.height+20.0))];
        }
            break;
        case XHDynamicsModelTextAndVideoType:
        {
            [self setItemFrame:CGRectMake(0, 0,SCREEN_WIDTH, 80+contentSize.height+10.0+200.0/*视频预览视图的高度*/+15.0)];
        }
            break;
    }
    
    [self setCellHeight:(self.itemFrame.size.height+10.0)];
}

@end
