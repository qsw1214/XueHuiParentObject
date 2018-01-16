//
//  XHNoticeFrame.m
//  daycareParent
//
//  Created by Git on 2017/11/30.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHNoticeFrame.h"

@implementation XHNoticeFrame


-(void)setModel:(XHNoticeModel *)model
{
    _model = model;
    switch (model.noticeType)
    {
        case NoticeType:
        {
            [self setItemFrame:CGRectMake(0, 0, SCREEN_WIDTH, 80.0)];
            [self setCellHeight:self.itemFrame.size.height];
        }
            break;
        case NoticeDetailsType:
        {
            
            CGSize contentSize = [NSObject contentSizeWithTitle:model.content withFontOfSize:FontLevel2 withWidth:(SCREEN_WIDTH-90.0)];
            [self setContentSize:CGSizeMake((SCREEN_WIDTH-90.0), contentSize.height)];
            
            switch (model.contentType)
            {
                case XHNoticeTextType:
                {
                    [self setItemFrame:CGRectMake(0, 0, SCREEN_WIDTH, (60.0+contentSize.height+10.0))];
                }
                    break;
                case XHNoticeTextAndImageType:
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
                    
                    [self setItemFrame:CGRectMake(0, 0, SCREEN_WIDTH, (60.0+contentSize.height+self.previewSize.height+20.0))];
                    
                }
                    break;
                case XHNoticeTextAndVideoType:
                {
                    [self setItemFrame:CGRectMake(0, 0,SCREEN_WIDTH, 80+contentSize.height+20.0+200.0/*视频预览视图的高度*/)];
                }
                    break;
            }
        }
            break;
    }
    
    
    [self setCellHeight:self.itemFrame.size.height];
    
 
}








@end
