//
//  XCWebViewJavascriptBridge.m
//  BridgeIOS
//
//  Created by 钧泰科技 on 16/6/8.
//  Copyright © 2016年 wxc. All rights reserved.
//

#import "XCWebViewJavascriptBridge.h"

@implementation XCWebViewJavascriptBridge
{
    __weak XCWebView *_webView;
    __weak id _webViewDelegate;
    long _uniqueId;
    WebViewJavascriptBridgeBase *_base;
}

/* API
 *****/

+ (void)enableLogging { [WebViewJavascriptBridgeBase enableLogging]; }
+ (void)setLogMaxLength:(int)length { [WebViewJavascriptBridgeBase setLogMaxLength:length]; }

+ (instancetype)bridgeForWebView:(XCWebView *)webView
{
    XCWebViewJavascriptBridge *bridge = [[self alloc] init];
    [bridge _platformSpecificSetup:webView];
    return bridge;
}
- (void)setWebViewDelegate:(id<XCWebViewDelegate>)webViewDelegate
{
    _webViewDelegate = webViewDelegate;
}
- (void)send:(id)data {
    [self send:data responseCallback:nil];
}

- (void)send:(id)data responseCallback:(WVJBResponseCallback)responseCallback
{
    [_base sendData:data responseCallback:responseCallback handlerName:nil];
}

- (void)callHandler:(NSString *)handlerName
{
    [self callHandler:handlerName data:nil responseCallback:nil];
}

- (void)callHandler:(NSString *)handlerName data:(id)data
{
    [self callHandler:handlerName data:data responseCallback:nil];
}

- (void)callHandler:(NSString *)handlerName data:(id)data responseCallback:(WVJBResponseCallback)responseCallback
{
    [_base sendData:data responseCallback:responseCallback handlerName:handlerName];
}

- (void)registerHandler:(NSString *)handlerName handler:(WVJBHandler)handler
{
    _base.messageHandlers[handlerName] = [handler copy];
}


- (void)dealloc
{
    [self _platformSpecificDealloc];
    _base = nil;
    _webView = nil;
    _webViewDelegate = nil;
}

- (NSString*)_evaluateJavascript:(NSString*)javascriptCommand
{
    [_webView evaluateJavaScript:javascriptCommand completionHandler:nil];
    return nil;
}

- (void)WKFlushMessageQueue {
    [_webView evaluateJavaScript:[_base webViewJavascriptFetchQueyCommand] completionHandler:^(NSString* result, NSError* error) {
        if (error != nil)
        {
            NSLog(@"WebViewJavascriptBridge: WARNING: Error when trying to fetch data from WKWebView: %@", error);
        }
        [_base flushMessageQueue:result];
    }];
}

- (void) _platformSpecificSetup:(XCWebView *)webView
{
    _webView = webView;
    _webView.delegate = self;
    _base = [[WebViewJavascriptBridgeBase alloc] init];
    _base.delegate = self;
}
- (void) _platformSpecificDealloc
{
    _webView.delegate = nil;
}

#pragma mark --- XCWebViewDelegate
- (void)webViewDidStartLoad:(XCWebView *)webView
{
    if (webView != _webView) { return; }
    
    if ([_webViewDelegate respondsToSelector:@selector(webViewDidStartLoad:)])
    {
        [_webViewDelegate webViewDidStartLoad:webView];
    }
}
- (void)webViewDidFinishLoad:(XCWebView *)webView
{
    if (webView != _webView) { return; }
    
    //无论如何页面载入完成都 加载桥接js
    [_base injectJavascriptFile];
    
    if ([_webViewDelegate respondsToSelector:@selector(webViewDidFinishLoad:)])
    {
        [_webViewDelegate webViewDidFinishLoad:webView];
    }
}
- (void)webView:(XCWebView *)webView didFailLoadWithError:(NSError *)error
{if (webView != _webView) { return; }
    
    if ([_webViewDelegate respondsToSelector:@selector(webView:didFailLoadWithError:)])
    {
        [_webViewDelegate webView:webView didFailLoadWithError:error];
    }
    
}
- (BOOL)webView:(XCWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    if (webView != _webView) { return YES; }
    
    NSURL *url = [request URL];
    if ([_base isCorrectProcotocolScheme:url])
    {
        if ([_base isBridgeLoadedURL:url])
        {
            [_base injectJavascriptFile];
        }
        else if ([_base isQueueMessageURL:url])
        {
            [self WKFlushMessageQueue];
        } else
        {
            [_base logUnkownMessage:url];
        }
        
        return NO;
    }
    
    if ([_webViewDelegate respondsToSelector:@selector(webView:shouldStartLoadWithRequest:navigationType:)])
    {
        return [_webViewDelegate webView:webView shouldStartLoadWithRequest:request navigationType:navigationType];
    }
    else
    {
        return YES;
    }
}
- (void)webViewProgress:(XCWebView *)webView updateProgress:(float)progress
{
    if (webView != _webView) { return; }
    
    if ([_webViewDelegate respondsToSelector:@selector(webViewProgress:updateProgress:)])
    {
        [_webViewDelegate webViewProgress:webView updateProgress:progress];
    }
}

#pragma end

@end
