//
//  XHLocationViewController.h
//  TLMessageView
//
//  Created by 郭锐 on 16/8/23.
//  Copyright © 2016年 com.garry.message. All rights reserved.
//


@protocol XHLocationViewControllerDelegate <NSObject>
-(void)locationViewControllerSendMsg:(RCLocationMessage *)msg;
@end

@interface XHLocationViewController : BaseViewController
-(instancetype)initWithDelegate:(id <XHLocationViewControllerDelegate>)delegate;
@property(nonatomic,assign)id <XHLocationViewControllerDelegate> delegate;
@end
