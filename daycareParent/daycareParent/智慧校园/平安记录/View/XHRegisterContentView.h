//
//  XHRegisterContentView.h
//  daycareParent
//
//  Created by Git on 2017/11/29.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseControl.h"
#import "XHRegisterTableViewCell.h"
#import "XHChildListModel.h"

@interface XHRegisterContentView : BaseControl
@property(nonatomic,strong)XHChildListModel *childModel;
-(void)getModel:(XHChildListModel *)model;
@end
