//
//  XHSyllabusCell.m
//  daycareParent
//
//  Created by Git on 2017/12/6.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHSyllabusCell.h"

@interface XHSyllabusCell ()

@property (nonatomic,strong) XHSyllabusCellContentView *cellContentView; //!<  单元格内容视图


@end

@implementation XHSyllabusCell


- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self.contentView addSubview:self.cellContentView];
        [self.contentView setBackgroundColor:[UIColor whiteColor]];
    }
    return self;
}


-(void)setItemFrame:(XHSyllabusFrame*)frame
{
    [self.cellContentView setItemFrame:frame];
}


#pragma mark - Getter / Setter
-(XHSyllabusCellContentView *)cellContentView
{
    if (_cellContentView == nil)
    {
        _cellContentView = [[XHSyllabusCellContentView alloc]init];
        [_cellContentView setTextColor:RGB(41, 41, 41)];
    }
    return _cellContentView;
}

@end
