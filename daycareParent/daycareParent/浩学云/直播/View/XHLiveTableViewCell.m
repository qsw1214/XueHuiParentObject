//
//  XHLiveTableViewCell.m
//  daycareParent
//
//  Created by Git on 2018/1/10.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHLiveTableViewCell.h"


@interface XHLiveTableViewCell ()

@property (nonatomic,strong) XHLiveCellContentControl *contentControl; //!< 内容视图



@end


@implementation XHLiveTableViewCell


- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self.contentView addSubview:self.contentControl];
    }
    return self;
}


-(void)setItemFrame:(id)frame
{
    [self.contentControl setItemFrame:frame];
}


#pragma mark - Getter / Setter
-(XHLiveCellContentControl *)contentControl
{
    if (!_contentControl)
    {
        _contentControl = [[XHLiveCellContentControl alloc]init];
    }
    return _contentControl;
}

@end
