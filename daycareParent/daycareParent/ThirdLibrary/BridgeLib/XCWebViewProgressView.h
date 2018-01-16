//
//  XCWebViewProgressView.h
//  BridgeIOS
//
//  Created by 钧泰科技 on 16/6/8.
//  Copyright © 2016年 wxc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XCWebViewProgressView : UIView
@property (nonatomic) float progress;

@property (nonatomic) UIView *progressBarView;
@property (nonatomic) NSTimeInterval barAnimationDuration; //  0.1
@property (nonatomic) NSTimeInterval fadeAnimationDuration; //  0.27
@property (nonatomic) NSTimeInterval fadeOutDelay; //  0.1

- (void)setProgress:(float)progress animated:(BOOL)animated;
@end
