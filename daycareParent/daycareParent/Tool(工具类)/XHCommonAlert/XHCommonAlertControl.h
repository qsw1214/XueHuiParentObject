//
//  XHCommonAlertControl.h
//  daycareParent
//
//  Created by mac on 2018/3/26.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "BaseControl.h"
#import "XHCommonAlertBoardControl.h"


typedef NS_ENUM(NSInteger,XHCommonAlertControlType)
{
    XHCommonAlertNormalType = 1,
    XHCommonAlertAppStore = 2,
};



@protocol XHCommonAlertControlDelegate <NSObject>

-(void)alertBoardAction:(BaseButtonControl*)sender;

@end


@interface XHCommonAlertControl : BaseControl
@property (nonatomic,strong) XHCommonAlertBoardControl *alertBoard;


-(instancetype)initWithTitle:(nullable NSString *)title message:(nullable NSString *)message delegate:(nullable id)delegate cancelButtonTitle:(nullable NSString *)cancelButtonTitle otherButtonTitle:(nullable NSString *)otherButtonTitle withType:(XHCommonAlertControlType)type;




-(void)show;

@end
