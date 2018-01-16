//
//  XCWebView.h
//  BridgeIOS
//
//  Created by 钧泰科技 on 16/6/7.
//  Copyright © 2016年 wxc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XCWebView;
@protocol XCWebViewDelegate <NSObject>
@optional

- (void)webViewDidStartLoad:(XCWebView *)webView;
- (void)webViewDidFinishLoad:(XCWebView *)webView;
- (void)webView:(XCWebView *)webView didFailLoadWithError:(NSError *)error;
- (BOOL)webView:(XCWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType;
- (void)webViewProgress:(XCWebView *)webView updateProgress:(float)progress;
@end


@interface XCWebView : UIView
@property(weak,nonatomic)id<XCWebViewDelegate> delegate;
//是否正在使用 UIWebView
@property (nonatomic, readonly) BOOL usingUIWebView;
//内部使用的webView
@property (nonatomic, readonly) id realWebView;
//预估网页加载进度
@property (nonatomic, readonly) double estimatedProgress;
//网页title
@property (nonatomic,readonly) NSString *title;


//使用UIWebView usingUIWebView为yes强制使用UIWebView
- (instancetype)initWithFrame:(CGRect)frame usingUIWebView:(BOOL)usingUIWebView;

//back 层数
- (NSInteger)countOfHistory;

@property (nonatomic, readonly) UIScrollView *scrollView;

- (id)loadRequest:(NSURLRequest *)request;
- (id)loadHTMLString:(NSString *)string baseURL:(NSURL *)baseURL;

@property (nonatomic, readonly) NSURL *URL;

@property (nonatomic, readonly, getter=isLoading) BOOL loading;
@property (nonatomic, readonly) BOOL canGoBack;
@property (nonatomic, readonly) BOOL canGoForward;

- (id)goBack;
- (id)goForward;
- (id)reload;
- (void)stopLoading;

- (void)evaluateJavaScript:(NSString*)javaScriptString completionHandler:(void (^)(id, NSError*))completionHandler;
@end


extern const float XCInitialProgressValue;
extern const float XCInteractiveProgressValue;
extern const float XCFinalProgressValue;

@class XCWebViewProgress;
@protocol XCWebViewProgressDelegate <NSObject>
- (void)webViewProgress:(XCWebViewProgress *)webViewProgress updateProgress:(float)progress;
@end
@interface XCWebViewProgress : NSObject<UIWebViewDelegate>
@property (nonatomic, weak) id<XCWebViewProgressDelegate> progressDelegate;
@property (nonatomic, weak) id<UIWebViewDelegate> webViewProxyDelegate;
@property (nonatomic, readonly) float progress; // 0.0..1.0

- (void)reset;
@end








