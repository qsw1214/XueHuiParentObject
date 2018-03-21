//
//  XHTeacherAddressBookViewController.h
//  daycareParent
//
//  Created by Git on 2017/12/13.
//  Copyright © 2017年 XueHui. All rights reserved.
//


typedef NS_ENUM(NSInteger,TeacherAddressBookEnterType)
{
    TeacherAddressBookIMType = 1,       //!< 给老师留言
    TeacherAddressBookAskLeaveType = 2, //!< 请假进入
};




#pragma mark 智慧校园->班级通讯录->老师通讯录列表（请假中使用）

#import "BaseViewController.h"
#import "XHTeacherAddressBookContentView.h"













typedef void (^DidSelectItemBack) (XHTeacherAddressBookFrame *itemObject);

@interface XHTeacherAddressBookViewController : BaseViewController

@property (nonatomic,assign) TeacherAddressBookEnterType enterType; //!< 进入类型

@property (nonatomic,copy) DidSelectItemBack didselectBack;

@end
