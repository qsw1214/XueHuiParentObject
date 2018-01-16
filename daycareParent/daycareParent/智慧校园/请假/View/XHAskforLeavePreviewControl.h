//
//  XHAskforLeavePreviewControl.h
//  daycareParent
//
//  Created by Git on 2017/12/7.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "BaseControl.h"

@protocol XHAskforLeavePreviewControlDeletage <NSObject>

-(void)askforLeavePreviewControlAction:(UIImage*)image;


@end

@interface XHAskforLeavePreviewControl : BaseControl

+ (instancetype)sharedObject;
-(void)showWithImage:(UIImage*)image withDeletage:(id<XHAskforLeavePreviewControlDeletage>)deletage;
-(void)dismiss;


@end
