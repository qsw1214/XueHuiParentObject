//
//  XHHomeWorkFrame.m
//  daycareParent
//
//  Created by Git on 2017/11/30.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHHomeWorkFrame.h"

@implementation XHHomeWorkFrame


-(void)setModel:(XHHomeWorkModel *)model
{
    
    _model = model;
    
    CGSize subjectSize = [NSObject contentSizeWithTitle:model.subject withFontOfSize:FontLevel3 withWidth:100.0];
    [self setSubjectSize:CGSizeMake(subjectSize.width+10.0, subjectSize.height)];
    
    //!< 设置内容的size
    CGSize contentSize = [NSObject contentSizeWithTitle:model.workContent withFontOfSize:FontLevel2 withWidth:(SCREEN_WIDTH-40.0)];
    [self setContentSize:contentSize];
    
    
    switch (model.homeWorkType)
    {
        case HomeWorkType:
        {
            switch (model.contentType)
            {
                case XHHomeWorkTextType:
                {
                    [self setItemFrame:CGRectMake(10.0, 10.0, SCREEN_WIDTH-20.0, 60.0+self.contentSize.height+10.0)];
                    [self setCellHeight:self.itemFrame.size.height+10.0];
                }
                    break;
                case XHHomeWorkTextAndImageType:
                {
                    if ([model.imageUrlArray count])
                    {
                        [model.imageUrlArray enumerateObjectsUsingBlock:^(XHPreviewModel *obj, NSUInteger idx, BOOL * _Nonnull stop)
                         {
                             [obj setItemSize:CGSizeMake(((SCREEN_WIDTH-60.0)/3.0), ((SCREEN_WIDTH-70.0)/3.0))];
                         }];
                        
                        if ([model.imageUrlArray count] > 3)
                        {
                            [self setPreviewSize:CGSizeMake((SCREEN_WIDTH-40.0), ((SCREEN_WIDTH-60.0)/3.0)*2+15.0)];   
                        }
                        else
                        {
                            [self setPreviewSize:CGSizeMake((SCREEN_WIDTH-40.0), ((SCREEN_WIDTH-70.0)/3.0)+10.0)];
                        }
                    }
                    else
                    {
                        [self setPreviewSize:CGSizeMake(0, 0)];
                    }
                    
                    
                    [self setItemFrame:CGRectMake(10.0, 10.0, SCREEN_WIDTH-20.0, (60.0+contentSize.height+self.previewSize.height+10.0))];
                    [self setCellHeight:self.itemFrame.size.height+10.0];
                }
                    break;
            }
        }
            break;
        case NotifyType:
        {
            switch (model.contentType)
            {
                case XHHomeWorkTextType:
                {
                    [self setItemFrame:CGRectMake(10.0, 10.0, SCREEN_WIDTH-20.0, 60.0+self.contentSize.height+10.0)];
                    [self setCellHeight:self.itemFrame.size.height+10.0];
                }
                    break;
                case XHHomeWorkTextAndImageType:
                {
                    if ([model.imageUrlArray count])
                    {
                        [model.imageUrlArray enumerateObjectsUsingBlock:^(XHPreviewModel *obj, NSUInteger idx, BOOL * _Nonnull stop)
                         {
                             [obj setItemSize:CGSizeMake(((SCREEN_WIDTH-60.0)/3.0), ((SCREEN_WIDTH-70.0)/3.0))];
                         }];
                        
                        if ([model.imageUrlArray count] > 3)
                        {
                            [self setPreviewSize:CGSizeMake((SCREEN_WIDTH-40.0), ((SCREEN_WIDTH-60.0)/3.0)*2+15.0)];
                        }
                        else
                        {
                            [self setPreviewSize:CGSizeMake((SCREEN_WIDTH-40.0), ((SCREEN_WIDTH-70.0)/3.0)+10.0)];
                        }
                    }
                    else
                    {
                        [self setPreviewSize:CGSizeMake(0, 0)];
                    }
                    
                    
                    [self setItemFrame:CGRectMake(10.0, 10.0, SCREEN_WIDTH-20.0, (60.0+contentSize.height+self.previewSize.height+10.0))];
                    [self setCellHeight:self.itemFrame.size.height+10.0];
                }
                    break;
            }
        }
            break;
    }
    
    
 
}








@end
