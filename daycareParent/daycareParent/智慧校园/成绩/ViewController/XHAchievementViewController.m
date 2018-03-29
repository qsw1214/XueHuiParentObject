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
    [self.contentView resetFrame:CGRectMake(0, self.navigationView.bottom, SCREEN_WIDTH, SCREEN_HEIGHT-self.navigationView.bottom)];
    [self.contentView setItemArray:self.dataArray];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
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
-(XHAchievementContentView *)contentView
{
    if (_contentView == nil)
    {
        _contentView = [[XHAchievementContentView alloc]init];
    }
    return _contentView;
}
-(void)getChildModel:(XHChildListModel *)childModel
{
    [self setRightItemTitle:[childModel studentName]];
    [self.contentView getModel:childModel];
}


@end
