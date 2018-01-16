//
//  XCNativePlugs.h
//  BridgeIOS
//
//  Created by 钧泰科技 on 16/5/27.
//  Copyright © 2016年 wxc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "XCWebViewJavascriptBridge.h"
#import "XCWebView.h"

@interface XCNativePlugs : NSObject
@property (nonatomic,strong,readonly) XCWebViewJavascriptBridge *bridge;

- (id)init:(UIViewController *)controller webView:(XCWebView *)webView;
@end
