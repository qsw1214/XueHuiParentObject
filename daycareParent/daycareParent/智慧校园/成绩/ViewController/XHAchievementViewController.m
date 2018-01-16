//
//  XHAchievementViewController.m
//  daycareParent
//
//  Created by Git on 2017/12/6.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#pragma mark 智慧校园->成绩



#import "XHAchievementViewController.h"
#import "XHAchievementContentView.h"
#import "XHChildListModel.h"
@interface XHAchievementViewController ()<XHCustomViewDelegate>

@property (nonatomic,strong) XHAchievementContentView *contentView; //!< 内容视图
@end

@implementation XHAchievementViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setNavtionTitle:@"成绩"];
    [self.view addSubview:self.contentView];
    [self.contentView resetFrame:CGRectMake(0, self.navigationView.bottom, SCREEN_WIDTH, SCREEN_HEIGHT-self.navigationView.height)];
    [self.contentView setItemArray:self.dataArray];
    [self setChildListArry:[XHUserInfo sharedUserInfo].childListArry];
}
-(void)viewWillAppear:(BOOL)animated
{
    if ([XHUserInfo sharedUserInfo].childListArry.count) {
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
-(XHAchievementContentView *)contentView
{
    if (_contentView == nil)
    {
        _contentView = [[XHAchievementContentView alloc]init];
    }
    return _contentView;
}
-(void)getChildModel:(XHChildListModel *)childModel {
    
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
