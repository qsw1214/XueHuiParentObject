//
//  TLChatInputView.h
//  TLMessageView
//
//  Created by 郭锐 on 16/8/18.
//  Copyright © 2016年 com.garry.message. All rights reserved.
//

#import "XHChatViewController.h"


@interface TLChatInputView : UIView
-(instancetype)initWithChatVc:(XHChatViewController *)vc;
@property(nonatomic,copy)void (^sendMsgAction)(RCMessageContent *x);
@end
