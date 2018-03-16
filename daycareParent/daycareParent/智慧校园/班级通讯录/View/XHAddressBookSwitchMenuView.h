//
//  XHAddressBookSwitchMenuView.h
//  daycareParent
//
//  Created by mac on 2018/3/9.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "BaseScrollView.h"
#import "XHAddressBookFrame.h"


@protocol XHAddressBookSwitchMenuViewDelegate <NSObject>


-(void)switchDraggMenuIndexPath:(NSInteger)indexPath;


@end


@interface XHAddressBookSwitchMenuView : BaseScrollView


@property (nonatomic,strong) XHAddressBookFrame *addressBookFrame;
@property (nonatomic,weak) id <XHAddressBookSwitchMenuViewDelegate> switchDelegate;

@property (nonatomic,assign) NSInteger indexPath;


@end
