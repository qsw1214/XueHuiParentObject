//
//  XHAddressBookCell.m
//  daycareParent
//
//  Created by Git on 2017/12/8.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHAddressBookCell.h"



@interface XHAddressBookCell ()

@property (nonatomic,strong) XHAddressBookSwitchMenuView *switchMenuView;






@end




@implementation XHAddressBookCell


- (instancetype)initWithDeletage:(id)delegate
{
    self = [super init];
    if (self)
    {
        [self.contentView addSubview:self.switchMenuView];
        [self.switchMenuView setSwitchDelegate:delegate];
    }
    return self;
}



-(void)setItemFrame:(XHAddressBookFrame*)frame
{
    [self.switchMenuView resetFrame:CGRectMake(0, 0, frame.itemFrame.size.width, frame.itemFrame.size.height)];
    [self.switchMenuView setAddressBookFrame:frame];
}



-(void)setIndexPath:(NSInteger)indexPath
{
    _indexPath = indexPath;
    [self.switchMenuView setIndexPath:indexPath];
}






#pragma mark - Getter / Setter
-(XHAddressBookSwitchMenuView *)switchMenuView
{
    if (!_switchMenuView)
    {
        _switchMenuView = [[XHAddressBookSwitchMenuView alloc]init];
    }
    return _switchMenuView;
}

@end
