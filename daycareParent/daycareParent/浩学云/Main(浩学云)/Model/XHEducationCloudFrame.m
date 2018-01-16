//
//  XHEducationCloudFrame.m
//  daycareParent
//
//  Created by Git on 2017/12/11.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHEducationCloudFrame.h"

@implementation XHEducationCloudFrame


-(void)setModel:(XHEducationCloudModel *)model
{
    _model = model;
    [self setItemSize:CGSizeMake(SCREEN_WIDTH, 80.0)];
    switch (model.modelType)
    {
        case XHEducationCloudCellVideoTpe:
        {
            [self setItemFrame:CGRectMake(0, 0, SCREEN_WIDTH, 80.0)];
            [self setCellHeight:(self.itemFrame.size.height)];
        }
            break;
        case XHEducationCloudCellExaminationQuestionsTpe:
        {
            [self setItemFrame:CGRectMake(0, 0, SCREEN_WIDTH, 80.0)];
            [self setCellHeight:(self.itemFrame.size.height)];
        }
            break;
        case XHEducationCloudDefaultType:
            break;
    }
    
    
}
@end
