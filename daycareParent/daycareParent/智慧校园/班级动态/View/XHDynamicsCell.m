//
//  XHDynamicsCell.m
//  daycareParent
//
//  Created by Git on 2017/12/14.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHDynamicsCell.h"



@interface XHDynamicsCell ()

@property (nonatomic,strong) XHDynamicsCellContentView *cellContentView; //!< 单元格内容视图



@end

@implementation XHDynamicsCell



- (instancetype)initWithDeletage:(id)deletage
{
    self = [super init];
    if (self)
    {
        
        [self.contentView addSubview:self.cellContentView];
        [self.cellContentView setDeletage:deletage];
        
    }
    return self;
}



-(void)setItemFrame:(XHDynamicsFrame*)frame withIndexPath:(NSIndexPath*)index
{
    [frame.model setTage:index.row];
    [self.cellContentView resetFrame:frame.itemFrame];
    [self.cellContentView setItemFrame:frame withIndexPath:index];
}




#pragma mark - Getter / Setter
-(XHDynamicsCellContentView *)cellContentView
{
    if (!_cellContentView)
    {
        _cellContentView = [[XHDynamicsCellContentView alloc]init];
    }
    return _cellContentView;
}




@end
