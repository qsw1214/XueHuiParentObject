//
//  XHAddressBookContentView.h
//  daycareParent
//
//  Created by Git on 2017/12/8.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "BaseControl.h"
#import "XHAddressBookCell.h"
#import "XHChildListModel.h"
@interface XHAddressBookContentView : BaseControl
@property(nonatomic,strong)XHChildListModel *childModel;
-(void)getModel:(XHChildListModel *)model;
@end
