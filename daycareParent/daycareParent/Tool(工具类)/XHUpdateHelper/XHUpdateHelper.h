//
//  XHUpdateHelper.h
//  daycareParent
//
//  Created by mac on 2018/3/26.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XHCommonAlertControl.h"

@interface XHUpdateHelper : NSObject <XHCommonAlertControlDelegate>


/**
 版本升级
 */
-(void)updateVersionWithViewController:(UIViewController*)object;


@end
