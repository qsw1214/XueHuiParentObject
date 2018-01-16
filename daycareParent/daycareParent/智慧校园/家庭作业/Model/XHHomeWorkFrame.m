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
    switch (model.homeWorkType)
    {
        case HomeWorkType:
        {
            [self setItemFrame:CGRectMake(0, 0, SCREEN_WIDTH, 80.0)];
            [self setCellHeight:self.itemFrame.size.height];
        }
            break;
        case HomeWorkDetailsType:
        {
            CGSize contentSize = [NSObject contentSizeWithTitle:model.workContent withFontOfSize:FontLevel2 withWidth:(SCREEN_WIDTH-90.0)];
            [self setContentSize:CGSizeMake((SCREEN_WIDTH-90.0), contentSize.height)];
            
            switch (model.contentType)
            {
                case XHHomeWorkTextType:
                {
                    [self setItemFrame:CGRectMake(0, 0, SCREEN_WIDTH, (60.0+contentSize.height+20.0))];
                    [self setCellHeight:self.itemFrame.size.height];
                }
                    break;
                case XHHomeWorkTextAndImageType:
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
                    [self setCellHeight:self.itemFrame.size.height];
                }
                    break;
            }
        }
            break;
    }
    
    
 
}








@end
