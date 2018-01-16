//
//  XHTeacherAddressBookViewController.h
//  daycareParent
//
//  Created by Git on 2017/12/13.
//  Copyright © 2017年 XueHui. All rights reserved.
//




#pragma mark 智慧校园->班级通讯录->老师通讯录列表（请假中使用）

#import "BaseViewController.h"
#import "XHTeacherAddressBookContentView.h"


typedef void (^DidSelectItemBack) (XHTeacherAddressBookFrame *itemObject);

@interface XHTeacherAddressBookViewController : BaseViewController

@property (nonatomic,strong) XHChildListModel *model;

@property (nonatomic,copy) DidSelectItemBack didselectBack;

@end
