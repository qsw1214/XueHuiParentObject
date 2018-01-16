//
//  XCWebViewJavascriptBridge.h
//  BridgeIOS
//
//  Created by 钧泰科技 on 16/6/8.
//  Copyright © 2016年 wxc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebViewJavascriptBridgeBase.h"
#import "XCWebView.h"

@interface XCWebViewJavascriptBridge : NSObject<XCWebViewDelegate,WebViewJavascriptBridgeBaseDelegate>

+ (instancetype)bridgeForWebView:(XCWebView *)webView;
+ (void)enableLogging;
+ (void)setLogMaxLength:(int)length;

- (void)registerHandler:(NSString*)handlerName handler:(WVJBHandler)handler;
- (void)callHandler:(NSString*)handlerName;
- (void)callHandler:(NSString*)handlerName data:(id)data;
- (void)callHandler:(NSString*)handlerName data:(id)data responseCallback:(WVJBResponseCallback)responseCallback;
- (void)setWebViewDelegate:(id<XCWebViewDelegate>)webViewDelegate;
@end
