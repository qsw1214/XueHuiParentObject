//
//  XHAskforLeaveContentView.h
//  daycareParent
//
//  Created by Git on 2017/12/5.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XHAskforLeaveContentView : UIScrollView


@property (nonatomic,strong) XHNetWorkConfig *netWorkConfig; //!< 网络请求

-(instancetype)initWithObject:(BaseViewController*)object;

-(void)resetFrame:(CGRect)frame;


@end
