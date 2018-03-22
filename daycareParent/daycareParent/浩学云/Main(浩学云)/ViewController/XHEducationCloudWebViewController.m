//
//  XHEducationCloudWebViewController.m
//  daycareParent
//
//  Created by Git on 2017/12/26.
//  Copyright © 2017年 XueHui. All rights reserved.
//




#import "XHEducationCloudWebViewController.h"
#import <WebKit/WebKit.h>
@interface XHEducationCloudWebViewController () <UIWebViewDelegate,WKUIDelegate,UINavigationBarDelegate>
@property (nonatomic,strong) UIWebView *webView;
@property (nonatomic,strong) UIProgressView *progressView;
@end

@implementation XHEducationCloudWebViewController

- (void)viewDidLoad
{
   
    [super viewDidLoad];
     //[self clearWebCache];
    [self.view addSubview:self.webView];
    [self.view addSubview:self.progressView];
    self.progressView.progress=0.1;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.0];
    self.progressView.progress=0.7;
    [UIView commitAnimations];
}

-(void)setWebViewUrl:(NSString*)url
{
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
}


#pragma mark - Getter / Setter
-(UIWebView *)webView
{
    if (!_webView)
    {
        
        if ([[XHHelper sharedHelper] isIphoneX]) {
            _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 94, SCREEN_WIDTH, SCREEN_HEIGHT-94)];
        }
        else
        {
            _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
        }
        _webView.scalesPageToFit = YES;
        _webView.delegate=self;
        
    }
    return _webView;
}
-(UIProgressView *)progressView
{
    if (_progressView==nil) {
        _progressView=[[UIProgressView alloc] initWithFrame:CGRectMake(0, self.navigationView.bottom, SCREEN_WIDTH, 100)];
        _progressView.progressViewStyle=UIProgressViewStyleBar;
        _progressView.tintColor=RGB(242, 172, 60);
    }
    return _progressView;
}

-(void)letfItemAction:(BaseNavigationControlItem *)sender
{
    if ([self.webView canGoBack]) {
        [self.webView goBack];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:2.0];
    self.progressView.progress=1.0;
    [UIView commitAnimations];
    [self performSelector:@selector(aaaa) withObject:nil afterDelay:0.5];
 
}
-(void)aaaa
{
    [self.progressView removeFromSuperview];
}

- (void)clearWebCache {
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 9.0) {

        NSSet *websiteDataTypes

        = [NSSet setWithArray:@[
                                WKWebsiteDataTypeDiskCache,

                                //WKWebsiteDataTypeOfflineWebApplicationCache,

                                WKWebsiteDataTypeMemoryCache,

                                //WKWebsiteDataTypeLocalStorage,

                                //WKWebsiteDataTypeCookies,

                                //WKWebsiteDataTypeSessionStorage,

                                //WKWebsiteDataTypeIndexedDBDatabases,

                                //WKWebsiteDataTypeWebSQLDatabases
                                ]];

        //// All kinds of data

        //NSSet *websiteDataTypes = [WKWebsiteDataStore allWebsiteDataTypes];

        //// Date from

        NSDate *dateFrom = [NSDate dateWithTimeIntervalSince1970:0];

        //// Execute

        [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:websiteDataTypes modifiedSince:dateFrom completionHandler:^{

            // Done

        }];
    } else {
        NSString *libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];

        NSString *cookiesFolderPath = [libraryPath stringByAppendingString:@"/Cookies"];

        NSError *errors;

        [[NSFileManager defaultManager] removeItemAtPath:cookiesFolderPath error:&errors];
    }
}

@end
