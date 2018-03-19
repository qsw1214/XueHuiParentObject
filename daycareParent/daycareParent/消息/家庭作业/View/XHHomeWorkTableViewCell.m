//
//  XHHomeWorkTableViewCell.m
//  daycareParent
//
//  Created by Git on 2017/11/30.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHHomeWorkTableViewCell.h"
#import "XHHomeWorkCellContentView.h"



@interface XHHomeWorkTableViewCell ()

@property (nonatomic,strong) XHHomeWorkCellContentView *contentControl;



@end


@implementation XHHomeWorkTableViewCell


-(instancetype)init
{
    self = [super init];
    if (self)
    {
        [self.contentView addSubview:self.contentControl];
    }
    return self;
}


-(void)setItemFrame:(XHHomeWorkFrame *)itemFrame
{
    _itemFrame = itemFrame;
    //设置当前子单元视图的Frame
    [self.contentControl setItemFrame:itemFrame];
}

#pragma mark - Getter / Setter
-(XHHomeWorkCellContentView *)contentControl
{
    if (_contentControl == nil)
    {
        _contentControl = [[XHHomeWorkCellContentView alloc]init];
    }
    return _contentControl;
}




@end
