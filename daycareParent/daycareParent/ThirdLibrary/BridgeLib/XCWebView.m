//
//  XCWebView.m
//  BridgeIOS
//
//  Created by 钧泰科技 on 16/6/7.
//  Copyright © 2016年 wxc. All rights reserved.
//

#import "XCWebView.h"
#import <WebKit/WebKit.h>

@interface XCWebView ()<UIWebViewDelegate,WKNavigationDelegate,WKUIDelegate,XCWebViewProgressDelegate>
{
    XCWebViewProgress *_webViewProgress;
}
@end

@implementation XCWebView
- (instancetype)initWithFrame:(CGRect)frame
{
    return [self initWithFrame:frame usingUIWebView:NO];
}
- (instancetype)initWithFrame:(CGRect)frame usingUIWebView:(BOOL)usingUIWebView
{
    self = [super initWithFrame:frame];
    if (self) {
        _usingUIWebView = usingUIWebView;
        [self initView];
    }
    return self;
}
- (void)initView
{
    Class wkWebView = NSClassFromString(@"WKWebView");
    if (wkWebView && self.usingUIWebView == NO)         //使用WK
    {
#if (__MAC_OS_X_VERSION_MAX_ALLOWED > __MAC_10_9 || __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0)
        [self initWKWebView];
        _usingUIWebView = NO;
#endif
    }
    else        //使用UI
    {
        [self initUIWebView];
        _usingUIWebView = YES;
    }
    
    [self.realWebView setFrame:self.bounds];
    [self.realWebView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
    [self addSubview:self.realWebView];
}
#if (__MAC_OS_X_VERSION_MAX_ALLOWED > __MAC_10_9 || __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0)
- (void)initWKWebView
{
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    configuration.userContentController = [WKUserContentController new];
    
    WKPreferences* preferences = [[WKPreferences alloc] init];
    preferences.javaScriptCanOpenWindowsAutomatically = YES;
    configuration.preferences = preferences;
    
    WKWebView* webView = [[WKWebView alloc] initWithFrame:self.bounds configuration:configuration];
    webView.UIDelegate = self;
    webView.navigationDelegate = self;
    
    [webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    [webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    _realWebView = webView;
}
- (void)observeValueForKeyPath:(NSString*)keyPath ofObject:(id)object change:(NSDictionary*)change context:(void*)context
{
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        _estimatedProgress = [change[NSKeyValueChangeNewKey] doubleValue];
        if ([self.delegate respondsToSelector:@selector(webViewProgress:updateProgress:)])
        {
            [self.delegate webViewProgress:self updateProgress:_estimatedProgress];
        }
    }
    else if ([keyPath isEqualToString:@"title"]) {
        _title = change[NSKeyValueChangeNewKey];
    }
    else {
        [self willChangeValueForKey:keyPath];
        [self didChangeValueForKey:keyPath];
    }
}
#endif
- (void)initUIWebView
{
    UIWebView* webView = [[UIWebView alloc] initWithFrame:self.bounds];
    _realWebView = webView;
    
    _webViewProgress = [[XCWebViewProgress alloc] init];
    webView.delegate = _webViewProgress;
    _webViewProgress.webViewProxyDelegate = self;
    _webViewProgress.progressDelegate = self;
    
    _realWebView = webView;
}
- (void)webViewProgress:(XCWebViewProgress *)webViewProgress updateProgress:(float)progress
{
    if ([self.delegate respondsToSelector:@selector(webViewProgress:updateProgress:)])
    {
        [self.delegate webViewProgress:self updateProgress:progress];
    }
}
#pragma mark - UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return [self callback_webViewShouldStartLoadWithRequest:request navigationType:navigationType];
}
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [self callback_webViewDidStartLoad];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    _title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    
    [self callback_webViewDidFinishLoad];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [self callback_webViewDidFailLoadWithError:error];
}
#pragma end

#pragma mark - WKNavigationDelegate
- (nullable WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures
{
    if (!navigationAction.targetFrame.isMainFrame) {
        [webView loadRequest:navigationAction.request];
        
    }
    return nil;
}

- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
    // js 里面的alert实现，如果不实现，网页的alert函数无效
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:message
                                                                             message:nil
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定"
                                                        style:UIAlertActionStyleCancel
                                                      handler:^(UIAlertAction *action) {
                                                          completionHandler();
                                                      }]];
}

- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler {
    //  js 里面的alert实现，如果不实现，网页的alert函数无效  ,
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:message
                                                                             message:nil
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定"
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction *action) {
                                                          completionHandler(YES);
                                                      }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消"
                                                        style:UIAlertActionStyleCancel
                                                      handler:^(UIAlertAction *action){
                                                          completionHandler(NO);
                                                      }]];
}

- (void)webView:(WKWebView*)webView decidePolicyForNavigationAction:(WKNavigationAction*)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    NSURL *URL = navigationAction.request.URL;
    NSString *scheme = [URL scheme];
    UIApplication *app = [UIApplication sharedApplication];
    // 打电话
    if ([scheme isEqualToString:@"tel"]) {
        if ([app canOpenURL:URL]) {
            [app openURL:URL];
            // 一定要加上这句,否则会打开新页面
            decisionHandler(WKNavigationActionPolicyCancel);
            return;
        }
    }
    // 打开appstore
    if ([URL.absoluteString containsString:@"ituns.apple.com"]) {
        if ([app canOpenURL:URL]) {
            [app openURL:URL];
            decisionHandler(WKNavigationActionPolicyCancel);
            return;
        }
    }
    
    
    BOOL resultBOOL = [self callback_webViewShouldStartLoadWithRequest:navigationAction.request navigationType:navigationAction.navigationType];
    if (resultBOOL)
    {
         decisionHandler(WKNavigationActionPolicyAllow);
    }
    else
    {
         decisionHandler(WKNavigationActionPolicyCancel);
    }
}
- (void)webView:(WKWebView*)webView didStartProvisionalNavigation:(WKNavigation*)navigation
{
    [self callback_webViewDidStartLoad];
}
- (void)webView:(WKWebView*)webView didFinishNavigation:(WKNavigation*)navigation
{
    [self callback_webViewDidFinishLoad];
}
- (void)webView:(WKWebView*)webView didFailProvisionalNavigation:(WKNavigation*)navigation withError:(NSError*)error
{
    [self callback_webViewDidFailLoadWithError:error];
}
- (void)webView:(WKWebView*)webView didFailNavigation:(WKNavigation*)navigation withError:(NSError*)error
{
    [self callback_webViewDidFailLoadWithError:error];
}
#pragma end



#pragma mark - XCDelegate
- (void)callback_webViewDidFinishLoad
{
    if ([self.delegate respondsToSelector:@selector(webViewDidFinishLoad:)])
    {
        [self.delegate webViewDidFinishLoad:self];
    }
}
- (void)callback_webViewDidStartLoad
{
    if ([self.delegate respondsToSelector:@selector(webViewDidStartLoad:)])
    {
        [self.delegate webViewDidStartLoad:self];
    }
}
- (void)callback_webViewDidFailLoadWithError:(NSError*)error
{
    if ([self.delegate respondsToSelector:@selector(webView:didFailLoadWithError:)])
    {
        [self.delegate webView:self didFailLoadWithError:error];
    }
}
- (BOOL)callback_webViewShouldStartLoadWithRequest:(NSURLRequest*)request navigationType:(NSInteger)navigationType
{
    BOOL resultBOOL = YES;
    if ([self.delegate respondsToSelector:@selector(webView:shouldStartLoadWithRequest:navigationType:)])
    {
        if (navigationType == -1)
        {
            navigationType = UIWebViewNavigationTypeOther;
        }
        resultBOOL = [self.delegate webView:self shouldStartLoadWithRequest:request navigationType:navigationType];
    }
    return resultBOOL;
}
- (void)callback_webViewProgress:(XCWebView *)webView updateProgress:(float)progress
{
    if ([self.delegate respondsToSelector:@selector(webViewProgress:updateProgress:)])
    {
        [self.delegate webViewProgress:self updateProgress:progress];
    }
}
#pragma end



///back 层数
- (NSInteger)countOfHistory
{
    if (_usingUIWebView)
    {
        UIWebView* webView = self.realWebView;
        int count = [[webView stringByEvaluatingJavaScriptFromString:@"window.history.length"] intValue];
        if (count)
        {
            return count;
        }
        else
        {
            return 1;
        }
    }
    else
    {
        WKWebView *webView = self.realWebView;
        return webView.backForwardList.backList.count;
    }
}

- (UIScrollView*)scrollView
{
    return [(id)self.realWebView scrollView];
}

- (id)loadRequest:(NSURLRequest*)request
{
    if (_usingUIWebView)
    {
        [(UIWebView*)self.realWebView loadRequest:request];
        return nil;
    }
    else
    {
        return [(WKWebView*)self.realWebView loadRequest:request];
    }
}
- (id)loadHTMLString:(NSString*)string baseURL:(NSURL*)baseURL
{
    if (_usingUIWebView)
    {
        [(UIWebView*)self.realWebView loadHTMLString:string baseURL:baseURL];
        return nil;
    }
    else
    {
        return [(WKWebView*)self.realWebView loadHTMLString:string baseURL:baseURL];
    }
}

- (NSURL *)URL
{
    if (_usingUIWebView)
    {
        return [(UIWebView*)self.realWebView request].URL;
    }
    else
    {
        return [(WKWebView*)self.realWebView URL];
    }
}
- (BOOL)isLoading
{
    return [self.realWebView isLoading];
}
- (BOOL)canGoBack
{
    return [self.realWebView canGoBack];
}
- (BOOL)canGoForward
{
    return [self.realWebView canGoForward];
}
- (id)goBack
{
    if (_usingUIWebView)
    {
        [(UIWebView*)self.realWebView goBack];
        return nil;
    }
    else
    {
        return [(WKWebView*)self.realWebView goBack];
    }
}
- (id)goForward
{
    if (_usingUIWebView) {
        [(UIWebView*)self.realWebView goForward];
        return nil;
    }
    else {
        return [(WKWebView*)self.realWebView goForward];
    }
}
- (id)reload
{
    if (_usingUIWebView)
    {
        [(UIWebView*)self.realWebView reload];
        return nil;
    }
    else
    {
        return [(WKWebView*)self.realWebView reload];
    }
}
- (void)stopLoading
{
    [self.realWebView stopLoading];
}

- (void)evaluateJavaScript:(NSString*)javaScriptString completionHandler:(void (^)(id, NSError*))completionHandler
{
    if (_usingUIWebView)
    {
        NSString *result = [(UIWebView *)self.realWebView stringByEvaluatingJavaScriptFromString:javaScriptString];
        if (completionHandler)
        {
            completionHandler(result, nil);
        }
    }
    else
    {
        return [(WKWebView *)self.realWebView evaluateJavaScript:javaScriptString completionHandler:completionHandler];
    }
}

- (void)dealloc
{
    if (_usingUIWebView)
    {
        UIWebView *webView = _realWebView;
        webView.delegate = nil;
    }
    else
    {
        WKWebView *webView = _realWebView;
        webView.UIDelegate = nil;
        webView.navigationDelegate = nil;
        
        [webView removeObserver:self forKeyPath:@"estimatedProgress"];
        [webView removeObserver:self forKeyPath:@"title"];
    }
    
    [_realWebView scrollView].delegate = nil;
    [_realWebView stopLoading];
    [(UIWebView*)_realWebView loadHTMLString:@"" baseURL:nil];
    [_realWebView stopLoading];
    [_realWebView removeFromSuperview];
    _realWebView = nil;
}
@end

NSString *completeRPCURL = @"webviewprogressproxy:///complete";

const float XCInitialProgressValue = 0.1f;
const float XCInteractiveProgressValue = 0.5f;
const float XCFinalProgressValue = 0.9f;

@implementation XCWebViewProgress
{
    NSUInteger _loadingCount;
    NSUInteger _maxLoadCount;
    NSURL *_currentURL;
    BOOL _interactive;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        _maxLoadCount = _loadingCount = 0;
        _interactive = NO;
    }
    return self;
}
- (void)startProgress
{
    if (_progress < XCInitialProgressValue)
    {
        [self setProgress:XCInitialProgressValue];
    }
}
- (void)incrementProgress
{
    float progress = self.progress;
    float maxProgress = _interactive ? XCFinalProgressValue : XCInteractiveProgressValue;
    float remainPercent = (float)_loadingCount / (float)_maxLoadCount;
    float increment = (maxProgress - progress) * remainPercent;
    progress += increment;
    progress = fmin(progress, maxProgress);
    [self setProgress:progress];
}
- (void)completeProgress
{
    [self setProgress:1.0];
}
- (void)setProgress:(float)progress
{
    if (progress > _progress || progress == 0)
    {
        _progress = progress;
        if ([_progressDelegate respondsToSelector:@selector(webViewProgress:updateProgress:)])
        {
            [_progressDelegate webViewProgress:self updateProgress:progress];
        }
    }
}
- (void)reset
{
    _maxLoadCount = _loadingCount = 0;
    _interactive = NO;
    [self setProgress:0.0];
}
- (NSString *)getNonFragmentStringWithURL:(NSURL*)url
{
    if (!url)
    {
        return @"";
    }
    if (url.fragment)
    {
        return [url.absoluteString stringByReplacingOccurrencesOfString:[@"#" stringByAppendingString:url.fragment] withString:@""];
    }
    else
    {
        return url.absoluteString;
    }
}

#pragma mark UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    if ([request.URL.absoluteString isEqualToString:completeRPCURL])
    {
        [self completeProgress];
        return NO;
    }
    
    BOOL ret = YES;
    if ([_webViewProxyDelegate respondsToSelector:@selector(webView:shouldStartLoadWithRequest:navigationType:)])
    {
        ret = [_webViewProxyDelegate webView:webView shouldStartLoadWithRequest:request navigationType:navigationType];
    }
    
    BOOL isFragmentJump = NO;
    if (request.URL.fragment)
    {
        NSString *nonFragmentURL = [self getNonFragmentStringWithURL:request.URL];
        isFragmentJump = [nonFragmentURL isEqualToString:webView.request.URL.absoluteString];
    }
    
    NSString* refererURL = [request valueForHTTPHeaderField:@"Referer"];
    BOOL isTopLevelNavigation = (refererURL.length == 0 || [refererURL isEqualToString:request.URL.absoluteString] || [request.mainDocumentURL isEqual:request.URL]);
    
    BOOL isHTTP = [request.URL.scheme isEqualToString:@"http"] || [request.URL.scheme isEqualToString:@"https"];
    if (ret && !isFragmentJump && isHTTP && isTopLevelNavigation)
    {
        _currentURL = request.URL;
        [self reset];
    }
    return ret;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    if ([_webViewProxyDelegate respondsToSelector:@selector(webViewDidStartLoad:)])
    {
        [_webViewProxyDelegate webViewDidStartLoad:webView];
    }
    
    _loadingCount++;
    _maxLoadCount = fmax(_maxLoadCount, _loadingCount);
    
    [self startProgress];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    if ([_webViewProxyDelegate respondsToSelector:@selector(webViewDidFinishLoad:)])
    {
        [_webViewProxyDelegate webViewDidFinishLoad:webView];
    }
    
    _loadingCount--;
    [self incrementProgress];
    
    NSString *readyState = [webView stringByEvaluatingJavaScriptFromString:@"document.readyState"];
    
    BOOL interactive = [readyState isEqualToString:@"interactive"];
    if (interactive)
    {
        _interactive = YES;
        NSString *waitForCompleteJS = [NSString stringWithFormat:@"window.addEventListener('load',function() { var iframe = document.createElement('iframe'); iframe.style.display = 'none'; iframe.src = '%@'; document.body.appendChild(iframe);  }, false);", completeRPCURL];
        [webView stringByEvaluatingJavaScriptFromString:waitForCompleteJS];
    }
    
    BOOL isNotRedirect = YES;
    if (_currentURL && _currentURL.fragment)
    {
        NSString *nonFragmentCurrentURL = [self getNonFragmentStringWithURL:_currentURL];
        NSString *nonFragmentMainDocumentURL = [self getNonFragmentStringWithURL:webView.request.mainDocumentURL];
        isNotRedirect = _currentURL && [nonFragmentCurrentURL isEqual:nonFragmentMainDocumentURL];
    }
    BOOL complete = [readyState isEqualToString:@"complete"];
    if (complete && isNotRedirect)
    {
        [self completeProgress];
    }
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    if ([_webViewProxyDelegate respondsToSelector:@selector(webView:didFailLoadWithError:)])
    {
        [_webViewProxyDelegate webView:webView didFailLoadWithError:error];
    }
    
    _loadingCount--;
    [self incrementProgress];
    
    NSString *readyState = [webView stringByEvaluatingJavaScriptFromString:@"document.readyState"];
    
    BOOL interactive = [readyState isEqualToString:@"interactive"];
    if (interactive)
    {
        _interactive = YES;
        NSString *waitForCompleteJS = [NSString stringWithFormat:@"window.addEventListener('load',function() { var iframe = document.createElement('iframe'); iframe.style.display = 'none'; iframe.src = '%@'; document.body.appendChild(iframe);  }, false);", completeRPCURL];
        [webView stringByEvaluatingJavaScriptFromString:waitForCompleteJS];
    }
    
    BOOL isNotRedirect = YES;
    if (_currentURL && _currentURL.fragment)
    {
        NSString *nonFragmentCurrentURL = [self getNonFragmentStringWithURL:_currentURL];
        NSString *nonFragmentMainDocumentURL = [self getNonFragmentStringWithURL:webView.request.mainDocumentURL];
        isNotRedirect = _currentURL && [nonFragmentCurrentURL isEqual:nonFragmentMainDocumentURL];
    }
    BOOL complete = [readyState isEqualToString:@"complete"];
    if (complete && isNotRedirect)
    {
        [self completeProgress];
    }
}

#pragma end
@end












