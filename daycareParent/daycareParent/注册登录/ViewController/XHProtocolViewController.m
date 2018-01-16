//
//  XHProtocolViewController.m
//  daycareParent
//
//  Created by 钧泰科技 on 2017/12/13.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHProtocolViewController.h"

@interface XHProtocolViewController ()

@end

@implementation XHProtocolViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavtionTitle:@"学汇家长用户协议"];
    UIWebView *webView=[[UIWebView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    webView.scrollView.bounces = NO;
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://admin.ixuehui.cn/app_ua.html"]]];
    [self.view addSubview:webView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
