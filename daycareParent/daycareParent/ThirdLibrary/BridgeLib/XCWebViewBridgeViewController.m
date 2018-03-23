//
//  XCWebViewBridgeViewController.m
//  BridgeIOS
//
//  Created by 钧泰科技 on 16/6/8.
//  Copyright © 2016年 wxc. All rights reserved.
//

#import "XCWebViewBridgeViewController.h"
#import "XCWebViewProgressView.h"
@interface XCWebViewBridgeViewController ()
{
    XCWebViewProgressView *_progressView;
}
@end

@implementation XCWebViewBridgeViewController
- (void)dealloc
{
    
}
- (void)viewDidLoad
{
    self.view.backgroundColor = [UIColor whiteColor];
    [super viewDidLoad];
    if (([[[UIDevice currentDevice] systemVersion] doubleValue] >= 7.0 ? YES:NO))
    {
        self.automaticallyAdjustsScrollViewInsets = NO;
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    _progressView = [[XCWebViewProgressView alloc] init];
    _progressView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    
    
    _webView = [[XCWebView alloc] initWithFrame:CGRectMake(0, self.navigationView.bottom, SCREEN_WIDTH, SCREEN_HEIGHT-self.navigationView.bottom) usingUIWebView:self.usingUIWebView];
    _webView.scrollView.bounces = NO;
//    _webView.scrollView.scrollEnabled = NO;
    
    if (self.initLoad)
    {
        self.initLoad(_webView,self);
        self.initLoad = nil;
    }
    
    [self.view addSubview:_webView];
    
    _plugs = [[XCNativePlugs alloc] init:self webView:_webView];
    [_plugs.bridge setWebViewDelegate:self];
   
   @WeakObj(self);
    [_plugs.bridge registerHandler:@"initArguments" handler:^(id data, WVJBResponseCallback responseCallback) {
        @StrongObj(self);
        responseCallback(self.webInitArguments);
    }];
    

}
- (void)rightItemAction:(BaseNavigationControlItem *)sender
{
    //判断是否有上一层H5页面
    if ([self.webView canGoBack]) {
        //如果有则返回
        [self.webView goBack];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (CGRect)getProgressViewFrame
{
    CGFloat progressBarHeight = 2.f;
    CGRect rect = CGRectZero;
    if (self.navigationController && self.navigationController.navigationBarHidden == NO)       //有导航
    {
        CGRect navigationBarBounds = self.navigationController.navigationBar.bounds;
        rect = CGRectMake(0, navigationBarBounds.size.height - progressBarHeight, navigationBarBounds.size.width, progressBarHeight);
    }
    else
    {
        rect = CGRectMake(0, 0, self.view.frame.size.width, progressBarHeight);
    }
    
    return rect;
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _webView.frame = CGRectMake(0, self.navigationView.bottom, SCREEN_WIDTH, SCREEN_HEIGHT-self.navigationView.bottom);
    
    _progressView.frame = [self getProgressViewFrame];
    if (self.navigationController && self.navigationController.navigationBarHidden == NO)       //有导航
    {
        [self.navigationController.navigationBar addSubview:_progressView];
    }
    else
    {
        [self.view addSubview:_progressView];
    }
    
    if (self.barHidden == YES)
    {
        self.navigationController.navigationBarHidden = YES;
    }
    
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_progressView removeFromSuperview];
    if (self.barHidden == YES)
    {
        self.navigationController.navigationBarHidden = NO;
    }
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    _webView.frame = CGRectMake(0, self.navigationView.bottom, SCREEN_WIDTH, SCREEN_HEIGHT-self.navigationView.bottom);
}

#pragma mark ----

- (void)webViewProgress:(XCWebView *)webView updateProgress:(float)progress
{
    [_progressView setProgress:progress animated:YES];
}

#pragma end

@end









