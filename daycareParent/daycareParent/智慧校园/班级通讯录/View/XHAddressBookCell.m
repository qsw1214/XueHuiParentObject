//
//  XHAddressBookCell.m
//  daycareParent
//
//  Created by Git on 2017/12/8.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHAddressBookCell.h"
#import "XHddressBookSwitchMenuView.h"


@interface XHAddressBookCell ()

@property (nonatomic,strong) XHddressBookSwitchMenuView *switchMenuView;






@end




@implementation XHAddressBookCell


- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self.contentView addSubview:self.switchMenuView];
    }
    return self;
}



-(void)setItemFrame:(XHAddressBookFrame*)frame
{
    [self.switchMenuView resetFrame:CGRectMake(0, 0, frame.itemFrame.size.width, frame.itemFrame.size.height)];
}








#pragma mark - Getter / Setter
-(XHddressBookSwitchMenuView *)switchMenuView
{
    if (!_switchMenuView)
    {
        _switchMenuView = [[XHddressBookSwitchMenuView alloc]init];
    }
    return _switchMenuView;
}

@end
