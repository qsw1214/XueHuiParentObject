//
//  XHStudentDetailViewController.h
//  daycareParent
//
//  Created by 钧泰科技 on 2017/12/16.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "BaseViewController.h"
#import "XHChildListModel.h"

#pragma mark-------------学生详细信息-----------

@interface XHStudentDetailViewController : BaseViewController
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) XHChildListModel *listModel;
@end
