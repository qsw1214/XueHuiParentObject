//
//  XHAddressBookHeader.h
//  daycareParent
//
//  Created by mac on 2018/3/9.
//  Copyright © 2018年 XueHui. All rights reserved.
//


#pragma mark 通讯录头部选择孩子的面板


@protocol XHAddressBookHeaderDelegate <NSObject>


-(void)didSelectItem:(XHChildListModel*)model;


@end

#import "BaseControl.h"

@interface XHAddressBookHeader : BaseControl


@property (nonatomic,weak) id <XHAddressBookHeaderDelegate> delegate;



@end
