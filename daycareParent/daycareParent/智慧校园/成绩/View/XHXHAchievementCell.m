//
//  XHXHAchievementCell.m
//  daycareParent
//
//  Created by Git on 2017/12/6.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHXHAchievementCell.h"



@interface XHXHAchievementCell ()




@end


@implementation XHXHAchievementCell

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



-(void)setItemFrame:(XHAchievementFrame*)frame
{
    [self.cellContentView setItemFrame:frame];
}


#pragma mark - Getter / Setter
-(XHAchievementCellContentView *)cellContentView
{
    if (_cellContentView == nil)
    {
        _cellContentView = [[XHAchievementCellContentView alloc]init];
        [_cellContentView setBackgroundColor:[UIColor whiteColor]];
        [_cellContentView setTextColor:RGB(41, 41, 41)];
        [_cellContentView setFont:FontLevel3];
    }
    return _cellContentView;
}

@end
