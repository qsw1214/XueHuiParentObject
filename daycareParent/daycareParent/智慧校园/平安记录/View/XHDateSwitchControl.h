//
//  XHDateSwitchControl.h
//  daycareParent
//
//  Created by mac on 2018/3/15.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "BaseControl.h"


@protocol XHDateSwitchControlDelegate <NSObject>


-(void)dateSwitchAction:(NSString*)date;

@end

@interface XHDateSwitchControl : BaseControl

@property (nonatomic,weak) id <XHDateSwitchControlDelegate> delegate;

#pragma mark 获取当前日期字符串格式
-(NSString*)getNonceDate:(BOOL)nonce;

#pragma mark - 重置日期
-(void)resetDate:(BOOL)nocnce;



@end
