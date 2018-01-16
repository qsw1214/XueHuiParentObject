//
//  XHNoticeTableViewCell.m
//  daycareParent
//
//  Created by Git on 2017/11/30.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHNoticeTableViewCell.h"




@interface XHNoticeTableViewCell ()

@property (nonatomic,strong) XHNoticeCellContentView *contentControl;



@end


@implementation XHNoticeTableViewCell


-(instancetype)initWithDeletage:(id)deletage
{
    self = [super init];
    if (self)
    {
        [self.contentView addSubview:self.contentControl];
        [self.contentControl setDeletage:deletage];
    }
    return self;
}


-(void)setItemFrame:(XHNoticeFrame *)itemFrame withIndexPath:(NSIndexPath*)indexPath
{
    _itemFrame = itemFrame;
    //设置当前子单元视图的Frame
    [self.contentControl setItemFrame:itemFrame withIndexPath:indexPath];
}

#pragma mark - Getter / Setter
-(XHNoticeCellContentView *)contentControl
{
    if (_contentControl == nil)
    {
        _contentControl = [[XHNoticeCellContentView alloc]init];
    }
    return _contentControl;
}




@end
