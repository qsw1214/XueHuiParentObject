//
//  XHParentsMeetingViewController.m
//  daycareParent
//
//  Created by Git on 2017/12/4.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHParentsMeetingViewController.h"
#import "XHParentsMeetingContentView.h"
#import "XHIMNoticeViewController.h"
#import "BaseTableView.h"
#import "XHEducationCloudWebViewController.h" //!< 家长学堂详情

@interface XHParentsMeetingViewController () <XHParentsMeetingContentViewDeletage>

{
    BaseTableView *_tableView;
}
@property (nonatomic,strong) XHParentsMeetingContentView *contentView; //!< 内容视图


@end

@implementation XHParentsMeetingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setNavtionTitle:@"家长学堂"];
    [self.contentView.tableView beginRefreshing];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refresh) name:@"noticeName" object:nil];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
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
        [self.contentView resetFrame:CGRectMake(0, self.navigationView.bottom, SCREEN_WIDTH, SCREEN_HEIGHT-self.navigationView.height)];
        [self.contentView.tableView beginRefreshing];
    }
}


#pragma mark - Deletage Method
#pragma mark XHParentsMeetingContentViewDeletage
-(void)didSelectItemObject:(XHParentsMeetingFrame*)frame
{
    NSString * webUrl=[NSString stringWithFormat:@"http://h5.ixuehui.cn/zx/app/?type=par#/detail?id=%@",frame.model.objectID];
    XHEducationCloudWebViewController *webView = [[XHEducationCloudWebViewController alloc]initHiddenWhenPushHidden];
    [webView setWebViewUrl:webUrl];
    [webView setNavtionTitle:@"家长学堂详情"];
    [self.navigationController pushViewController:webView animated:YES];
//    HNShopViewController *shop = [[HNShopViewController alloc] initHiddenWhenPushHidden];
//    shop.initLoad = ^(XCWebView *webView, XCWebViewBridgeViewController *controller) {
//
//       NSString * webUrl=[NSString stringWithFormat:@"http://h5.ixuehui.cn/zx/app/?type=par#/detail?id=%@",frame.model.objectID];
//        [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:webUrl] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0f]];
//
//    };
//    [shop setNavtionTitle:@"家长学堂详情"];
//    [self.navigationController pushViewController:shop animated:YES];
}

#pragma mark - Getter / Setter
-(XHParentsMeetingContentView *)contentView
{
    if (_contentView == nil)
    {
        _contentView = [[XHParentsMeetingContentView alloc]initWithDeletage:self];
    }
    return _contentView;
}

-(void)letfItemAction:(BaseNavigationControlItem *)sender
{
    XHIMNoticeViewController *chat=self.navigationController.viewControllers[0];
    [self.navigationController popToViewController:chat animated:YES];
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
