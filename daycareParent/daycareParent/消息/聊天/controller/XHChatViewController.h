//
//  XHChatViewController.h
//  TLMessageView
//
//  Created by 郭锐 on 16/8/18.
//  Copyright © 2016年 com.garry.message. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XHChatViewController : BaseViewController
@property(nonatomic,strong)UITableView *chatTableView;
@property(nonatomic,copy)NSString *targetID;
-(void)scrollToBottom;
@end
