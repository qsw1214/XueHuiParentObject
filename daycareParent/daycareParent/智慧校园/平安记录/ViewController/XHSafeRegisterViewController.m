//
//  XHSafeRegisterViewController.m
//  daycareParent
//
//  Created by Git on 2017/11/29.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHSafeRegisterViewController.h"
#import "XHRegisterContentView.h"
#import "XHChildListModel.h"
@interface XHSafeRegisterViewController ()<XHCustomViewDelegate>

@property (nonatomic,strong) XHRegisterContentView *contentView;
@end

@implementation XHSafeRegisterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setNavtionTitle:@"平安记录"];
    [self.view addSubview:self.contentView];
    [self.contentView resetFrame:CGRectMake(0, self.navigationView.bottom, SCREEN_WIDTH,SCREEN_HEIGHT-self.navigationView.height)];
    [self setChildListArry:[XHUserInfo sharedUserInfo].childListArry];
}
-(void)viewWillAppear:(BOOL)animated
{
    
    if ([XHUserInfo sharedUserInfo].childListArry.count)
    {
        XHChildListModel *childModel=[XHUserInfo sharedUserInfo].childListArry[0];
        [self.contentView getModel:childModel];
    }
    else
    {
        [self.contentView.tableView beginRefreshing];
    }
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


#pragma mark - Getter / Setter
-(XHRegisterContentView *)contentView
{
    if (_contentView == nil)
    {
        _contentView = [[XHRegisterContentView alloc]init];
    }
    return _contentView;
}
-(void)getChildModel:(XHChildListModel *)childModel
{
   
  [self setRightItemTitle:[childModel studentName]];
    [self.contentView getModel:childModel];

}
#pragma mark 右侧按钮相应的方法
-(void)rightItemAction:(BaseNavigationControlItem*)sender
{
    if (self.childListView.isExist==NO) {
        self.childListView.delegate=self;
        [self.view addSubview:self.childListView];
        self.childListView.isExist=YES;
    }
    else
    {
        [self.childListView removeFromSuperview];
        self.childListView.isExist=NO;
    }
}


@end
