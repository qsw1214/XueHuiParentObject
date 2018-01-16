//
//  XHNoticeListViewController.m
//  daycareParent
//
//  Created by Git on 2017/11/30.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHNoticeListViewController.h"
#import "XHNoticeDetailViewController.h" //!< 家庭作业详情


@interface XHNoticeListViewController () <XHHomeWorkContentViewDeletage>

@property (nonatomic,strong) XHNoticeContentView *contentView;

@end

@implementation XHNoticeListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setNavtionTitle:@"学校通知"];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refresh) name:@"noticeName" object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

-(void)addSubViews:(BOOL)subview
{
    if (subview)
    {
        [self.view addSubview:self.contentView];
        [self.contentView resetFrame:CGRectMake(0, self.navigationView.bottom, SCREEN_WIDTH, SCREEN_HEIGHT-self.navigationView.height)];
        
    }
}




#pragma mark - Deletage Method
#pragma mark  XHHomeWorkContentViewDeletage
-(void)didSelectAtIndex:(XHNoticeFrame *)object
{
    XHNoticeDetailViewController *noticeDetail = [[XHNoticeDetailViewController alloc]init];
    [noticeDetail setItemObjet:object];
    [self.navigationController pushViewController:noticeDetail animated:YES];
    noticeDetail.refeshBlock = ^(BOOL isRefesh)
    {
        if (isRefesh)
        {
            [self.contentView.tableView beginRefreshing];
            self.isRefresh(YES);
        }
        
    };
}


#pragma mark - Getter / Setter
-(XHNoticeContentView *)contentView
{
    if (_contentView == nil)
    {
        _contentView = [[XHNoticeContentView alloc]initWithDeletage:self];
    }
    return _contentView;
}
-(void)refresh
{
    [self.contentView.tableView beginRefreshing];
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
