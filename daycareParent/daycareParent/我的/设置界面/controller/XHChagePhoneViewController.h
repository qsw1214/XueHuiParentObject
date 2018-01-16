//
//  XHChagePhoneViewController.h
//  daycareParent
//
//  Created by 钧泰科技 on 2017/12/1.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "BaseViewController.h"


#pragma mark ----------设置-----》更改安全电话
@interface XHChagePhoneViewController : BaseViewController
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet XHBaseLabel *warnLabel;
@property (strong, nonatomic) IBOutlet XHBaseBtn *sureBtn;

@end
