//
//  XHAddressBookViewController.m
//  daycareParent
//
//  Created by Git on 2017/12/7.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHAddressBookViewController.h"
#import "XHAddressBookContentView.h"
#import "XHAddressBookKey.h"

@interface XHAddressBookViewController ()<XHCustomViewDelegate>
@property (nonatomic,strong) XHAddressBookContentView *contentView; //!< 内容视图

@end

@implementation XHAddressBookViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [XHHelper sharedHelper].currentVC=self;
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

-(void)addSubViews:(BOOL)subview
{
    if (subview)
    {
        [self.view addSubview:self.contentView];
        [self.contentView resetFrame:CGRectMake(0, self.navigationView.bottom, SCREEN_WIDTH, (SCREEN_HEIGHT-self.navigationView.height))];
        [self setChildListArry:[XHUserInfo sharedUserInfo].childListArry];
    }
}

-(void)getChildModel:(XHChildListModel *)childModel
{
    [self setRightItemTitle:[childModel studentName]];
    [self.contentView getModel:childModel];
    
}
#pragma mark 右侧按钮相应的方法
-(void)rightItemAction:(BaseNavigationControlItem*)sender
{
    if (self.childListView.isExist==NO)
    {
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

#pragma mark - Getter / Setter
-(XHAddressBookContentView *)contentView
{
    if (_contentView == nil)
    {
        _contentView = [[XHAddressBookContentView alloc]init];
    }
    return _contentView;
}
@end
