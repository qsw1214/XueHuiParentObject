//
//  XHAlertBoardControl.m
//  daycareParent
//
//  Created by mac on 2018/3/16.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHAlertBoardControl.h"


@interface XHAlertBoardControl ()

@property (nonatomic,strong) UILabel *titleLabel; //!< 标题标签
@property (nonatomic,strong) UIView *lineView; //!< 分割线
@property (nonatomic,strong) BaseButtonControl *cancelControl;  //!< 取消
@property (nonatomic,strong) BaseButtonControl *confirmControl;  //!< 确定





@end

@implementation XHAlertBoardControl






#pragma mark - Getter /  Setter
-(UILabel *)titleLabel
{
    if (!_titleLabel)
    {
        _titleLabel = [[UILabel alloc]init];
    }
    return _titleLabel;
}

-(UIView *)lineView
{
    if (!_lineView)
    {
        _lineView = [[UIView alloc]init];
        [_lineView setBackgroundColor:LineViewColor];
    }
    return _lineView;
}


-(BaseButtonControl *)cancelControl
{
    if (!_cancelControl)
    {
        _cancelControl = [[BaseButtonControl alloc]init];
    }
    return _cancelControl;
}


-(BaseButtonControl *)confirmControl
{
    if (!_confirmControl)
    {
        _confirmControl = [[BaseButtonControl alloc]init];
    }
    return _confirmControl;
}



@end
