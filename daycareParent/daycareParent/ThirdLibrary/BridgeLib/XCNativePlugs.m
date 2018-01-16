//
//  XCNativePlugs.m
//  BridgeIOS
//
//  Created by 钧泰科技 on 16/5/27.
//  Copyright © 2016年 wxc. All rights reserved.
//

#import "XCNativePlugs.h"

@interface XCNativePlugs ()
@property (nonatomic,weak) UIViewController *controller;
@property (nonatomic,weak) XCWebView *webView;
@end

@implementation XCNativePlugs


- (id)init:(UIViewController *)controller webView:(XCWebView *)webView
{
    if (self = [super init])
    {
        self.controller = controller;
        self.webView = webView;
        
        [self initPlugs];
    }
    return self;
}


- (void)initPlugs
{
    _bridge = [XCWebViewJavascriptBridge bridgeForWebView:self.webView];
    
    //确认提示confirm
    [_bridge registerHandler:@"confirm" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSString *title = data[@"title"];
        NSString *msg = data[@"msg"];
//        [UIAlertView bk_showAlertViewWithTitle:title message:msg cancelButtonTitle:@"取消" otherButtonTitles:@[@"确定"] handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
//            if (buttonIndex == 1)
//            {
                responseCallback(@"");
//            }
//        }];
    }];
    
    //提示
    [_bridge registerHandler:@"hud" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSInteger type = [data[@"type"] integerValue];
        NSString *title = data[@"title"];
        
        if (type == 0)
            [XHShowHUD showOKHud:title];
        else if (type == 1)
            [XHShowHUD showNOHud:title];
        else if (type == 2)
            [XHShowHUD showTextHud:title];
        else
            [XHShowHUD hideHud];
    }];
//    
//    [_bridge registerHandler:@"toNative" handler:^(id data, WVJBResponseCallback responseCallback) {
//        NSLog(@"收到网页数据 == %@", data);
//        responseCallback(@"返回的数据（toNative）");
//    }];
//    
//    [_bridge registerHandler:@"toNativeClick" handler:^(id data, WVJBResponseCallback responseCallback) {
//        NSLog(@"收到网页数据 == %@", data);
//        responseCallback(@"返回的数据（toNativeClick）");
//    }];
}

@end
