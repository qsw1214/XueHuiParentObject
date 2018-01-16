//
//  XCWebViewBridgeViewController.h
//  BridgeIOS
//
//  Created by 钧泰科技 on 16/6/8.
//  Copyright © 2016年 wxc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XCWebView.h"
#import "XCNativePlugs.h"
#import "BaseViewController.h"

@class XCWebViewBridgeViewController;

typedef void (^InitLoad)(XCWebView *webView,XCWebViewBridgeViewController *controller);

@interface XCWebViewBridgeViewController : BaseViewController<XCWebViewDelegate>
@property (nonatomic,strong) id webInitArguments;          //web初始化参数
@property (nonatomic,assign) BOOL usingUIWebView;
@property (nonatomic,assign) BOOL barHidden;
@property (nonatomic,readonly) XCWebView *webView;
@property (nonatomic,readonly) XCNativePlugs *plugs;
@property (nonatomic,copy) InitLoad initLoad;
@end
